// policy-table.json + hmpgid-map.json + rules-verified.json → data/seed.sql
//   node tools/build-seed.js
//
// ⚠️ 규칙은 사람이 검토한 것(data/rules-verified.json)만 active=true 로 나간다.
//    나머지 181곳은 후보로만 들어가고 화면에 닿지 않는다 — index.html 이 .eq('active', true) 로 읽는다.
const fs = require('fs');
const path = require('path');
const { toRule, POLICY_URL } = require('./lib/parse-policy');

const D = f => require(path.join(__dirname, '..', 'data', f));
const OUT = path.join(__dirname, '..', 'data', 'seed.sql');
const q = s => s === null || s === undefined ? 'null' : "'" + String(s).replace(/'/g, "''") + "'";

const table = D('policy-table.json');
const idmap = D('hmpgid-map.json').map;
const verified = D('rules-verified.json');

// 이름은 표기가 흔들린다("영인산 자연휴양림" vs "영인산자연휴양림") → 공백을 지우고 맞춘다.
const key = s => (s || '').replace(/\s+/g, '');
const idByKey = {};
for (const n in idmap) idByKey[key(n)] = idmap[n];
const verByKey = {};
for (const e of verified.entries) verByKey[key(e.name)] = e;

const lines = ['-- 자동 생성물. 직접 고치지 말고 tools/build-seed.js 를 고칠 것.',
  '-- 생성일 ' + new Date().toISOString().slice(0, 10),
  '-- 출처 ' + POLICY_URL, ''];

let noId = 0;
for (const r of table.rows) {
  const hmpg = verByKey[key(r.name)]?.hmpg_id || idByKey[key(r.name)] || null;
  if (!hmpg) noId++;
  lines.push(
    `insert into forests (name, gubun, region, sigungu, hmpg_id) values (` +
    [q(r.name), q(r.gubun), q(r.region), q(r.sigungu), q(hmpg)].join(', ') +
    `) on conflict (name) do update set ` +
    `gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, ` +
    `hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);`
  );
}
lines.push('');

// ⚠️ rules 는 전부 이 파일에서 파생된다. 다시 넣기 전에 비워야 seed.sql 을 두 번 돌려도
//    규칙이 중복되지 않는다(rules 에는 unique 제약이 없다). favorites 는 건드리지 않는다.
lines.push('delete from rules;');
lines.push('');

let activeCount = 0;
for (const r of table.rows) {
  const v = verByKey[key(r.name)];
  const rule = v ? v : toRule(r);
  if (!rule) continue;                        // 규칙을 못 읽음 → 오픈일 확인 중
  const active = v ? !!v.active : false;      // 검토 안 된 것은 전부 false
  if (active) activeCount++;
  lines.push(
    `insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)\n` +
    `select f.id, ${q(v?.kind || 'fcfs')}, ${q(rule.freq)}, ${rule.day_of_month ?? 'null'}, ` +
    `${rule.weekday ?? 'null'}, ${q(rule.open_time)}, ${q(v?.note || null)}, ` +
    `${q(v?.source_url || POLICY_URL)}, ${q(v?.verified_at || verified.verified_at)}, ` +
    `${q(v?.conflict || null)}, ${active}\n` +
    `from forests f where f.name = ${q(r.name)};`
  );
}

// 부모님이 처음 여실 때 빈 화면이 아니어야 한다 — 관심 4곳을 미리 담아둔다.
lines.push('');
lines.push('-- 관심 4곳 즐겨찾기 선등록 (이미 있으면 그대로 둔다)');
for (const e of verified.entries) {
  lines.push(`insert into favorites (forest_id) select id from forests where name = ${q(e.name)} ` +
             `on conflict (forest_id) do nothing;`);
}

fs.writeFileSync(OUT, lines.join('\n') + '\n', 'utf8');
console.log('WROTE', OUT, '| forests=', table.rows.length, '| active 규칙=', activeCount,
            '| hmpg_id 없음=', noId);

// ⚠️ 안전 확인 — 검토 안 된 규칙이 true 로 새지 않았는지 여기서 한 번 더 센다.
const expected = verified.entries.filter(e => e.active).length;
if (activeCount !== expected) {
  console.error('❌ active=true 개수가 rules-verified.json 과 다르다: ' + activeCount + ' != ' + expected);
  process.exit(1);
}
console.log('✅ active=true 개수가 rules-verified.json 과 일치한다 (' + expected + ')');
