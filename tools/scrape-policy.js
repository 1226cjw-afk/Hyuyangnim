// 숲나들e 예약정책 통합표를 통째로 긁어 data/policy-table.json 으로 떨군다.
//   node tools/scrape-policy.js
const fs = require('fs');
const path = require('path');
const { withPage } = require('./lib/cdpx');
const { parseRows, POLICY_URL } = require('./lib/parse-policy');

const OUT = path.join(__dirname, '..', 'data', 'policy-table.json');

(async () => {
  const raw = await withPage(POLICY_URL, async ({ ev }) => {
    // 표가 2개 있다(상단 고정 가이드 UI + 본표). 행이 가장 많은 것이 본표다.
    const json = await ev(`(()=>{
      const t=[...document.querySelectorAll('table')].sort((a,b)=>b.rows.length-a.rows.length)[0];
      if(!t) return '[]';
      return JSON.stringify([...t.rows].map(r=>[...r.cells].map(c=>({
        t: c.innerText.replace(/\\u00a0/g,' ').trim(), rs: c.rowSpan, cs: c.colSpan
      }))));
    })()`);
    return JSON.parse(json || '[]');
  }, { port: 9342 });

  if (raw.length < 100) throw new Error('본표를 못 찾았다 — 행 수 ' + raw.length);

  const header = raw.slice(0, 3);
  if (header[0][0].t !== '구분') {
    throw new Error('헤더가 바뀌었다. 첫 셀=' + JSON.stringify(header[0][0].t) + ' — 파서 재검토 필요');
  }

  const rows = parseRows(raw.slice(3)); // 헤더 3행 제외
  fs.mkdirSync(path.dirname(OUT), { recursive: true });
  fs.writeFileSync(OUT, JSON.stringify({
    scraped_at: new Date().toISOString().slice(0, 10),
    url: POLICY_URL,
    rows,
  }, null, 2), 'utf8');

  console.log('WROTE', OUT, 'rows=', rows.length);
  const byGubun = {};
  for (const r of rows) byGubun[r.gubun] = (byGubun[r.gubun] || 0) + 1;
  console.log('구분별:', byGubun);
})().catch(e => { console.error('ERR', e); process.exit(1); });
