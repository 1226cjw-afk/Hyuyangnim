const { parseRows, toRule } = require('../tools/lib/parse-policy');

// 실측 표 구조: 구분(rowspan 48) · 지역(rowspan 6) 은 그룹 첫 행에만 나온다.
const c = (t, rs) => ({ t, rs: rs || 1, cs: 1 });

test('rowspan 캐리포워드 — 구분·지역이 다음 행으로 이어진다', () => {
  const rows = parseRows([
    [c('국립', 2), c('서울인천경기', 2), c('가평군'), c('유명산 자연휴양림'),
     c('O'), c('O'), c('O'), c('O\n09시 오픈'), c(''), c('주말, 성수기'), c('바우처')],
    [c('양주시'), c('아세안 자연휴양림'),
     c('O'), c('X'), c('O'), c('O\n09시 오픈'), c(''), c('주말'), c('아세안')],
  ]);
  eq(rows.length, 2);
  eq(rows[0].gubun, '국립');
  eq(rows[1].gubun, '국립', '두 번째 행도 국립을 물려받아야 한다');
  eq(rows[1].region, '서울인천경기');
  eq(rows[1].sigungu, '양주시');
  eq(rows[1].name, '아세안 자연휴양림');
});

test('월 단위 규칙 — 서운산 매월 3일 14시', () => {
  const row = { weekly: '', monthly: '매월 3일 14시 오픈' };
  eq(toRule(row), { freq: 'monthly', day_of_month: 3, weekday: null, open_time: '14:00' });
});

test('월 단위 규칙 — 축령산/강씨봉 매월 1일 09시', () => {
  eq(toRule({ weekly: '', monthly: '매월 1일 09시 오픈' }),
     { freq: 'monthly', day_of_month: 1, weekday: null, open_time: '09:00' });
});

test('주 단위 규칙 — 요일 미기재는 표 헤더의 수요일(3)', () => {
  // 영인산 실측: 6주 칸이 "O" 이고 시각만 적혀 있다. 헤더가 "6주(수요일)".
  eq(toRule({ weekly: 'O\n09시 오픈', monthly: '' }),
     { freq: 'weekly', day_of_month: null, weekday: 3, open_time: '09:00' });
});

test('주 단위 규칙 — 요일이 적혀 있으면 그 요일', () => {
  eq(toRule({ weekly: 'O ( 4주 )\n월요일 09시 오픈', monthly: '' }),
     { freq: 'weekly', day_of_month: null, weekday: 1, open_time: '09:00' });
  eq(toRule({ weekly: 'O ( 2주 )\n일요일 14시 오픈', monthly: '' }),
     { freq: 'weekly', day_of_month: null, weekday: 0, open_time: '14:00' });
});

test('규칙을 못 읽으면 null — 오픈일 확인 중이 된다', () => {
  eq(toRule({ weekly: '', monthly: '' }), null);
  eq(toRule({ weekly: 'X', monthly: '' }), null);
});

test('월 규칙이 주 규칙보다 우선한다 (두 칸이 다 찬 경우는 사람이 볼 문제)', () => {
  eq(toRule({ weekly: 'O\n09시 오픈', monthly: '매월 5일 10시 오픈' }).freq, 'monthly');
});
