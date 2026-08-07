// 주 1회 정책 감시. 숲나들e 예약정책 통합표를 다시 긁어 지난번과 비교한다.
//   node tools/check.js
//
// 바뀐 휴양림은 즉시 rules.active=false 로 내려 '오픈일 확인 중' 이 되게 한다.
// ⚠️ 옛 규칙으로 날짜를 계속 보여주는 것이 가장 나쁜 실패다 (설계서 §3.4).
//    사람이 검토해 다시 active=true 로 올릴 때까지 그 휴양림 날짜는 안 뜬다 — 의도된 동작이다.
//
// 종료코드: 0 변경 없음 · 1 오류(페이지 구조 변경 등) · 2 변경 감지 — 사람 검토 필요
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { withPage } = require('./lib/cdpx');
const { parseRows, POLICY_URL } = require('./lib/parse-policy');

const ROOT = path.join(__dirname, '..');
const SNAP = path.join(ROOT, 'data', 'policy-table.json');

for (const line of fs.readFileSync(path.join(ROOT, '.env.local'), 'utf8').split(/\r?\n/)) {
  const m = /^([A-Z_]+)=(.*)$/.exec(line.trim());
  if (m) process.env[m[1]] = m[2];
}
const SB = process.env.SUPABASE_URL, KEY = process.env.SUPABASE_ANON;
if (!SB || !KEY) { console.error('.env.local 에 SUPABASE_URL / SUPABASE_ANON 이 필요하다'); process.exit(1); }

const api = (p, opt = {}) => fetch(SB + '/rest/v1/' + p, {
  ...opt,
  headers: { apikey: KEY, Authorization: 'Bearer ' + KEY,
             'Content-Type': 'application/json', Prefer: 'return=representation', ...(opt.headers || {}) },
});

const norm = s => (s || '').replace(/\s+/g, ' ').trim();
// 오픈일에 영향을 주는 칸만 본다. 우선예약(priority)·운영현황은 날짜를 바꾸지 않으므로 제외.
const rowKey = r => [r.gubun, r.region, r.sigungu, r.name, r.weekly, r.monthly, r.lottery].map(norm).join('|');
const sha = s => crypto.createHash('sha256').update(s, 'utf8').digest('hex');

(async () => {
  const raw = await withPage(POLICY_URL, async ({ ev }) => JSON.parse(await ev(`(()=>{
    const t=[...document.querySelectorAll('table')].sort((a,b)=>b.rows.length-a.rows.length)[0];
    if(!t) return '[]';
    return JSON.stringify([...t.rows].map(r=>[...r.cells].map(c=>({
      t: c.innerText.replace(/\\u00a0/g,' ').trim(), rs: c.rowSpan, cs: c.colSpan
    }))));
  })()`) || '[]'), { port: 9344 });

  if (raw.length < 100) { console.error('⚠️ 본표를 못 찾았다 (행 ' + raw.length + '). 페이지 구조가 바뀌었을 수 있다.'); process.exit(1); }
  // 헤더가 밀리면 185곳이 통째로 '변경'으로 잡힌다 — 비교 전에 막는다.
  if (raw[0][0].t !== '구분') {
    console.error('⚠️ 헤더가 바뀌었다. 첫 셀=' + JSON.stringify(raw[0][0].t) + ' — 파서 재검토 필요');
    process.exit(1);
  }
  const fresh = parseRows(raw.slice(3));

  const old = JSON.parse(fs.readFileSync(SNAP, 'utf8')).rows;
  const oldByName = {}; for (const r of old) oldByName[norm(r.name)] = r;
  const newByName = {}; for (const r of fresh) newByName[norm(r.name)] = r;

  const changed = [], added = [], removed = [];
  for (const n in newByName) {
    if (!oldByName[n]) { added.push(n); continue; }
    if (rowKey(newByName[n]) !== rowKey(oldByName[n])) changed.push(n);
  }
  for (const n in oldByName) if (!newByName[n]) removed.push(n);

  console.log('=== 정책 감시 ' + new Date().toISOString().slice(0, 10) + ' ===');
  console.log('행수 ' + old.length + ' → ' + fresh.length);
  console.log('변경 ' + changed.length + ' · 신규 ' + added.length + ' · 사라짐 ' + removed.length);

  for (const n of changed) {
    const a = oldByName[n], b = newByName[n];
    console.log('\n--- ' + n);
    for (const k of ['weekly', 'monthly', 'lottery', 'priority', 'sigungu', 'region']) {
      if (norm(a[k]) !== norm(b[k])) console.log('  ' + k + ': ' + JSON.stringify(a[k]) + '  →  ' + JSON.stringify(b[k]));
    }
  }
  if (added.length)   console.log('\n신규: ' + added.join(', '));
  if (removed.length) console.log('사라짐: ' + removed.join(', '));

  // 바뀐 휴양림의 규칙을 즉시 내린다.
  for (const n of changed) {
    const res = await api('forests?name=eq.' + encodeURIComponent(n) + '&select=id');
    const rows = await res.json();
    if (!rows.length) continue;
    await api('rules?forest_id=eq.' + rows[0].id, {
      method: 'PATCH',
      body: JSON.stringify({ active: false, conflict: '통합표 변경 감지 ' + new Date().toISOString().slice(0, 10) + ' — 사람 검토 필요' }),
    });
    console.log('  → active=false 처리: ' + n);
  }

  // 스냅샷 갱신 (다음 주 비교 기준)
  fs.writeFileSync(SNAP, JSON.stringify({
    scraped_at: new Date().toISOString().slice(0, 10), url: POLICY_URL, rows: fresh,
  }, null, 2), 'utf8');

  const body = fresh.map(rowKey).join('\n');
  await api('policy_snapshots?on_conflict=scope', {
    method: 'POST',
    headers: { Prefer: 'resolution=merge-duplicates,return=representation' },
    body: JSON.stringify({ scope: 'policy-table', url: POLICY_URL, body_hash: sha(body),
                           body_text: body.slice(0, 200000), checked_at: new Date().toISOString() }),
  });

  console.log('\n스냅샷 갱신 완료. 변경분은 data/policy-table.json 을 git diff 로도 볼 수 있다.');
  if (changed.length) {
    console.log('⚠️ 검토가 필요하다: 규칙을 확인해 data/rules-verified.json 을 고치고 build-seed 를 다시 돌릴 것.');
    process.exit(2);   // 작업 스케줄러가 "확인 필요"를 구별할 수 있게 종료코드를 나눈다
  }
})().catch(e => { console.error('ERR', e); process.exit(1); });
