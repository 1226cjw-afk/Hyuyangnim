// index.html 의 OPENDATE 구간을 추출해 순수 함수만 테스트한다.
// (Our_Budget 선례: 테스트 프레임워크 없이 인라인 JS 를 검증하는 방식)
const fs = require('fs');
const path = require('path');

const html = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');
// ⚠️ START 마커 줄의 **나머지**까지 건너뛰어야 한다. 마커 뒤에 설명 주석이 붙어 있어서
//    `START ──` 바로 뒤부터 캡처하면 그 한국어 주석이 코드로 섞여 SyntaxError 가 난다.
const m = /\/\/ ── OPENDATE:START ──.*\r?\n([\s\S]*?)\/\/ ── OPENDATE:END ──/.exec(html);
if (!m) throw new Error('index.html 에서 OPENDATE 경계 주석을 못 찾았다 — 지우지 말 것');
const api = new Function(m[1] + '\n; return { lastDayOfMonth, nextOpen, dayDiff, humanWhen, formatOpen };')();
const { lastDayOfMonth, nextOpen, dayDiff, humanWhen, formatOpen } = api;

const at = (y, mo, d, h, mi) => new Date(y, mo - 1, d, h || 0, mi || 0, 0, 0);
const monthly = (day, t) => ({ freq: 'monthly', day_of_month: day, weekday: null, open_time: t, active: true });
const weekly  = (wd,  t) => ({ freq: 'weekly',  day_of_month: null, weekday: wd,  open_time: t, active: true });

test('말일 계산', () => {
  eq(lastDayOfMonth(2026, 1), 28);   // 2026-02 (2026 은 윤년이 아니다)
  eq(lastDayOfMonth(2024, 1), 29);   // 2024-02 윤년
  eq(lastDayOfMonth(2026, 0), 31);
  eq(lastDayOfMonth(2026, 3), 30);
});

test('월 단위 — 이번 달 날짜가 아직 안 지났으면 이번 달', () => {
  // 서운산: 매월 3일 14시. 지금은 2026-08-01
  eq(nextOpen(monthly(3, '14:00'), at(2026, 8, 1, 10)).getTime(), at(2026, 8, 3, 14).getTime());
});

test('월 단위 — 오늘이 그 날인데 시각이 지났으면 다음 달', () => {
  eq(nextOpen(monthly(3, '14:00'), at(2026, 8, 3, 14, 1)).getTime(), at(2026, 9, 3, 14).getTime());
});

test('월 단위 — 오늘이 그 날이고 시각 전이면 오늘', () => {
  eq(nextOpen(monthly(3, '14:00'), at(2026, 8, 3, 13, 59)).getTime(), at(2026, 8, 3, 14).getTime());
});

test('⚠️ 말일 클램프 — 매월 31일 규칙이 2월을 만나면 말일로 당긴다', () => {
  // 안 하면 그 달 표시가 조용히 사라진다 (설계서 §4.3)
  eq(nextOpen(monthly(31, '09:00'), at(2026, 2, 1, 10)).getTime(), at(2026, 2, 28, 9).getTime());
  eq(nextOpen(monthly(31, '09:00'), at(2024, 2, 1, 10)).getTime(), at(2024, 2, 29, 9).getTime());
});

test('월 단위 — 12월에서 다음 해로 넘어간다', () => {
  eq(nextOpen(monthly(1, '09:00'), at(2026, 12, 5, 10)).getTime(), at(2027, 1, 1, 9).getTime());
});

test('주 단위 — 영인산 매주 수요일 09시', () => {
  // 2026-08-04 는 화요일 → 다음날 수요일
  eq(nextOpen(weekly(3, '09:00'), at(2026, 8, 4, 10)).getTime(), at(2026, 8, 5, 9).getTime());
});

test('주 단위 — 오늘이 그 요일인데 시각이 지났으면 +7일', () => {
  eq(nextOpen(weekly(3, '09:00'), at(2026, 8, 5, 9, 1)).getTime(), at(2026, 8, 12, 9).getTime());
});

test('주 단위 — 오늘이 그 요일이고 시각 전이면 오늘', () => {
  eq(nextOpen(weekly(3, '09:00'), at(2026, 8, 5, 8, 59)).getTime(), at(2026, 8, 5, 9).getTime());
});

test('active=false 면 날짜를 내주지 않는다 (오픈일 확인 중)', () => {
  const r = monthly(3, '14:00'); r.active = false;
  eq(nextOpen(r, at(2026, 8, 1, 10)), null);
  eq(nextOpen(null, at(2026, 8, 1, 10)), null);
});

test('날짜 차 — 자정 기준으로 센다', () => {
  eq(dayDiff(at(2026, 8, 4, 23, 59), at(2026, 8, 5, 0, 1)), 1);
  eq(dayDiff(at(2026, 8, 4, 0, 1), at(2026, 8, 4, 23, 59)), 0);
});

test('사람이 읽는 문구 — D-3 이 아니라 "N일 뒤"', () => {
  eq(humanWhen(at(2026, 8, 7, 9), at(2026, 8, 3, 10)), '4일 뒤');
  eq(humanWhen(at(2026, 8, 4, 9), at(2026, 8, 3, 10)), '내일 오전 9시');
  eq(humanWhen(at(2026, 8, 3, 9), at(2026, 8, 3, 7)), '오늘 오전 9시!');
  eq(humanWhen(at(2026, 8, 3, 14), at(2026, 8, 3, 7)), '오늘 오후 2시!');
});

test('날짜 표기 — 요일과 오전/오후를 한글로', () => {
  eq(formatOpen(at(2026, 8, 7, 9)), '8월 7일 (금) 오전 9시');
  eq(formatOpen(at(2026, 8, 3, 14)), '8월 3일 (월) 오후 2시');
  eq(formatOpen(at(2026, 8, 3, 0)), '8월 3일 (월) 밤 12시');
});
