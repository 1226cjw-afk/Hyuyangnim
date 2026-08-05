// Edge + CDP 로 페이지를 렌더해 innerText / a[href] / table 을 JSON 으로 떨군다.
// puppeteer 불필요 (Node 24 전역 WebSocket 사용). 2026-08-03 숲나들e 에서 동작 확인.
//
//   node tools/cdp.js <URL> <출력.json>
//
// 회수 항목 중 links 가 본문보다 수확이 큰 경우가 많다 —
// 숲나들e 의 ruleId 체계(101/105/107/112)와 딥링크 패턴이 전부 사이드 메뉴 링크에서 나왔다.
// 렌더 결과 text 가 로그인 폼이면 그 페이지는 로그인 벽 뒤다 (수집 대상 아님).

const http = require('http');
const os = require('os');
const path = require('path');
const fs = require('fs');
const { spawn } = require('child_process');

const URL_TARGET = process.argv[2];
const OUT = process.argv[3];
if (!URL_TARGET || !OUT) {
  console.error('usage: node tools/cdp.js <URL> <출력.json>');
  process.exit(1);
}

const PORT = 9333;
const EDGE = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe';
// ⚠️ 프로필은 반드시 리포 밖에. __dirname 을 쓰면 tools/edgeprofile 이 리포를 오염시킨다.
const PROFILE = path.join(os.tmpdir(), 'hyuyangnim-edge-cdp');
const SETTLE_MS = 9000; // 숲나들e 기준 9초면 충분

function get(p) {
  return new Promise((res, rej) => {
    http.get({ host: '127.0.0.1', port: PORT, path: p }, r => {
      const bufs = [];
      r.on('data', d => bufs.push(d));
      // ⚠️ 문자열로 누적하면 청크 경계에서 한글 UTF-8 이 쪼개져 U+FFFD 로 깨진다
      r.on('end', () => res(Buffer.concat(bufs).toString('utf8')));
    }).on('error', rej);
  });
}
const sleep = ms => new Promise(r => setTimeout(r, ms));

(async () => {
  const edge = spawn(EDGE, [
    '--headless=new',
    `--remote-debugging-port=${PORT}`,
    `--user-data-dir=${PROFILE}`,
    '--no-first-run',
    '--no-default-browser-check',
    '--disable-gpu',
    'about:blank',
  ], { stdio: 'ignore' });

  let up = false;
  for (let i = 0; i < 60; i++) {
    try { await get('/json/version'); up = true; break; } catch { await sleep(500); }
  }
  if (!up) { console.error('devtools endpoint never came up'); edge.kill(); process.exit(1); }

  const page = JSON.parse(await get('/json/list')).find(t => t.type === 'page');
  if (!page) { console.error('no page target'); edge.kill(); process.exit(1); }

  const ws = new WebSocket(page.webSocketDebuggerUrl);
  let id = 0;
  const pending = new Map();
  const send = (method, params) => new Promise(res => {
    const mid = ++id;
    pending.set(mid, res);
    ws.send(JSON.stringify({ id: mid, method, params }));
  });

  await new Promise(r => ws.addEventListener('open', r));
  ws.addEventListener('message', ev => {
    const m = JSON.parse(ev.data);
    if (m.id && pending.has(m.id)) { pending.get(m.id)(m.result); pending.delete(m.id); }
  });

  await send('Page.enable', {});
  await send('Runtime.enable', {});
  await send('Page.navigate', { url: URL_TARGET });
  await sleep(SETTLE_MS);

  const ev = async expr =>
    (await send('Runtime.evaluate', { expression: expr, returnByValue: true })).result?.value;

  const out = {
    url: await ev('location.href'),
    title: await ev('document.title'),
    text: await ev('document.body ? document.body.innerText : "(no body)"'),
    tables: await ev(`JSON.stringify([...document.querySelectorAll('table')].map(t=>t.innerText))`),
    links: await ev(
      `JSON.stringify([...document.querySelectorAll('a[href]')].slice(0,80)` +
      `.map(a=>a.textContent.trim()+' :: '+a.getAttribute('href')))`
    ),
  };

  fs.writeFileSync(OUT, JSON.stringify(out, null, 2), 'utf8');
  console.log('WROTE', OUT, 'textlen=', (out.text || '').length);
  ws.close();
  edge.kill();
  process.exit(0);
})().catch(e => { console.error('ERR', e); process.exit(1); });
