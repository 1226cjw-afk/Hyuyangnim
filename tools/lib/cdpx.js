// Edge + CDP 세션 헬퍼. puppeteer 불필요 (Node 24 전역 WebSocket).
// ⚠️ 프로필은 반드시 리포 밖(os.tmpdir())에. __dirname 을 쓰면 리포가 오염된다.
const http = require('http');
const os = require('os');
const path = require('path');
const { spawn } = require('child_process');

const EDGE = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe';
const sleep = ms => new Promise(r => setTimeout(r, ms));

function httpGet(port, p) {
  return new Promise((res, rej) => {
    http.get({ host: '127.0.0.1', port, path: p }, r => {
      const bufs = [];
      r.on('data', d => bufs.push(d));
      // ⚠️ 문자열로 누적하면 청크 경계에서 한글 UTF-8 이 쪼개져 U+FFFD 가 된다
      r.on('end', () => res(Buffer.concat(bufs).toString('utf8')));
    }).on('error', rej);
  });
}

// url 을 열고 fn({ev, send, goto}) 을 실행한 뒤 브라우저를 정리한다.
async function withPage(url, fn, opts = {}) {
  const port = opts.port || 9340;
  const settleMs = opts.settleMs != null ? opts.settleMs : 9000; // 숲나들e 기준 9초면 충분
  const profile = path.join(os.tmpdir(), 'hyuyangnim-cdpx-' + port);

  const edge = spawn(EDGE, [
    '--headless=new',
    '--remote-debugging-port=' + port,
    '--user-data-dir=' + profile,
    '--no-first-run', '--no-default-browser-check', '--disable-gpu',
    'about:blank',
  ], { stdio: 'ignore' });

  try {
    let up = false;
    for (let i = 0; i < 60; i++) {
      try { await httpGet(port, '/json/version'); up = true; break; } catch { await sleep(500); }
    }
    if (!up) throw new Error('devtools endpoint never came up');

    const page = JSON.parse(await httpGet(port, '/json/list')).find(t => t.type === 'page');
    if (!page) throw new Error('no page target');

    const ws = new WebSocket(page.webSocketDebuggerUrl);
    let id = 0;
    const pending = new Map();
    const send = (method, params) => new Promise(res => {
      const mid = ++id;
      pending.set(mid, res);
      ws.send(JSON.stringify({ id: mid, method, params }));
    });
    await new Promise(r => ws.addEventListener('open', r));
    ws.addEventListener('message', e => {
      const m = JSON.parse(e.data);
      if (m.id && pending.has(m.id)) { pending.get(m.id)(m.result); pending.delete(m.id); }
    });

    await send('Page.enable', {});
    await send('Runtime.enable', {});

    const ev = async expr =>
      (await send('Runtime.evaluate', { expression: expr, returnByValue: true })).result?.value;
    const goto = async (u, wait) => {
      await send('Page.navigate', { url: u });
      await sleep(wait != null ? wait : settleMs);
    };

    if (url) await goto(url);
    const out = await fn({ ev, send, goto, sleep });
    ws.close();
    return out;
  } finally {
    edge.kill();
  }
}

module.exports = { withPage, sleep };
