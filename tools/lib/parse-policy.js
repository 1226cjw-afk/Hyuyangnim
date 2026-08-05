// 숲나들e 「휴양림별 예약정책안내」 표를 forests/rules 후보로 옮긴다.
// 출처: https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002
// 표 구조 실측: 2026-08-04 (188행 = 헤더 3 + 데이터 185)
//
// ⚠️ 여기서 나온 규칙은 전부 후보다. 사람이 검토하기 전엔 rules.active = false 로만 들어간다.

const POLICY_URL =
  'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002';

const WEEKDAY = { '일': 0, '월': 1, '화': 2, '수': 3, '목': 4, '금': 5, '토': 6 };

// ⚠️ 구분(rowspan 48) · 지역(rowspan 6) 셀은 그룹의 첫 행에만 존재한다.
// 남은 행 수를 세어 물려주지 않으면 열이 통째로 한 칸씩 밀린다.
function parseRows(rawRows) {
  let gubun = null, region = null, gubunLeft = 0, regionLeft = 0;
  const out = [];

  for (const cells of rawRows) {
    const c = cells.slice();
    if (gubunLeft <= 0)  { const x = c.shift(); gubun  = x.t; gubunLeft  = x.rs || 1; }
    if (regionLeft <= 0) { const x = c.shift(); region = x.t; regionLeft = x.rs || 1; }
    gubunLeft--; regionLeft--;

    const [sigungu, name, room, camp, wait, weekly, monthly, lottery, priority] =
      c.map(x => (x.t || '').trim());

    out.push({
      gubun, region, sigungu, name,
      room: room || '', camp: camp || '', wait: wait || '',
      weekly: weekly || '', monthly: monthly || '',
      lottery: lottery || '', priority: priority || '',
    });
  }
  return out;
}

const hhmm = h => String(h).padStart(2, '0') + ':00';

// 표의 선착순 두 칸에서 오픈 규칙을 읽는다. 읽히지 않으면 null (= 오픈일 확인 중).
function toRule(row) {
  // 선착순-익월말 칸: "매월 3일 14시 오픈"
  const m = /매월\s*(\d{1,2})일\s*(\d{1,2})시/.exec(row.monthly || '');
  if (m) {
    return { freq: 'monthly', day_of_month: Number(m[1]), weekday: null, open_time: hhmm(Number(m[2])) };
  }

  // 선착순-6주 칸: "O\n09시 오픈" · "O ( 4주 )\n월요일 09시 오픈"
  const w = row.weekly || '';
  if (/^O/.test(w)) {
    const t = /(\d{1,2})시/.exec(w);
    if (t) {
      const wd = /([일월화수목금토])요일/.exec(w);
      // 요일이 안 적혀 있으면 표 헤더의 "6주(수요일)" 를 따른다.
      return {
        freq: 'weekly', day_of_month: null,
        weekday: wd ? WEEKDAY[wd[1]] : 3,
        open_time: hhmm(Number(t[1])),
      };
    }
  }
  return null;
}

module.exports = { parseRows, toRule, POLICY_URL, WEEKDAY };
