// index.html 의 JOSA 구간을 추출해 순수 함수만 테스트한다 (opendate.test.js 와 같은 방식).
const fs = require('fs');
const path = require('path');

const html = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');
const m = /\/\/ ── JOSA:START ──.*\r?\n([\s\S]*?)\/\/ ── JOSA:END ──/.exec(html);
if (!m) throw new Error('index.html 에서 JOSA 경계 주석을 못 찾았다 — 지우지 말 것');
const { josaEul } = new Function(m[1] + '\n; return { josaEul };')();

test('받침으로 끝나면 을 — 통합표 185곳 중 170곳이 "…림" 이다', () => {
  eq(josaEul('영인산 자연휴양림'), '영인산 자연휴양림을');
  eq(josaEul('축령산자연휴양림'), '축령산자연휴양림을');
  eq(josaEul('김천숲속야영장'), '김천숲속야영장을');
});

test('받침 없이 끝나면 를 — 실제로 6곳 있다', () => {
  eq(josaEul('양평쉬자파크'), '양평쉬자파크를');
  eq(josaEul('영양에코둥지'), '영양에코둥지를');
  eq(josaEul('대봉캠핑랜드'), '대봉캠핑랜드를');
});

test('괄호로 끝나면 그 앞 한글로 판단한다 — 실제로 2곳 있다', () => {
  eq(josaEul('두타산 자연휴양림(평창)'), '두타산 자연휴양림(평창)을');
  eq(josaEul('금산산림문화타운(남이자연휴양림)'), '금산산림문화타운(남이자연휴양림)을');
});

test('한글이 하나도 없으면 를 로 둔다 (185곳엔 없지만 정의해 둔다)', () => {
  eq(josaEul('ABC'), 'ABC를');
});

test('185곳 전부 을/를 로 끝난다 — "을(를)" 이 화면에 남지 않는다', () => {
  const rows = require('../data/policy-table.json').rows;
  const bad = rows.map(r => josaEul(r.name.trim())).filter(s => !/(을|를)$/.test(s));
  eq(bad, [], '조사가 안 붙은 이름');
});
