# Hyuyangnim 구현 계획서

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 부모님이 폰에서 한 번 탭해 열면, 즐겨찾기한 자연휴양림의 다음 예약 오픈일이 바로 보이는 모바일 웹을 만든다.

**Architecture:** 단일 `index.html`(CSS·JS 인라인) + Supabase(공유 저장소) + Cloudflare Workers 자동배포. 서버 로직 0 — 다음 오픈일 계산은 전부 브라우저에서 돈다. 데이터는 `tools/` 아래 Node 스크립트가 숲나들e에서 긁어 `data/`에 커밋하고, 사람이 검토한 것만 Supabase `rules`에 `active=true`로 올라간다.

**Tech Stack:** Vanilla HTML/CSS/JS · Supabase JS v2 (CDN) · Node 24 (빌드 아님, 조사·시드 스크립트 전용) · Edge + CDP (`tools/cdp.js`) · Cloudflare Workers(정적 서빙) · GitHub `1226cjw-afk`

---

## 🔥 이 계획을 쓰기 직전에 나온 실측 (2026-08-04) — 설계서보다 우선한다

설계서(`docs/superpowers/specs/2026-08-03-hyuyangnim-design.md`)는 "규칙은 휴양림마다 정책 페이지를
하나씩 사람이 읽어야 한다(170곳 며칠)"를 전제로 쓰였다. **그 전제가 뒤집혔다.**

### 발견 1 — 전 휴양림 예약정책이 **한 페이지 한 표**에 다 있다 ✅

```
https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002
```

`<table>` 하나에 **188행**(헤더 3 + 데이터 185), 국립·공립·사립 전부. 열 구성(실측):

| # | 열 | 예시 |
|---|---|---|
| 0 | 구분 (`rowspan`) | `국립` / `공립` / `사립` |
| 1 | 지역 (`rowspan`) | `서울인천경기` `강원` `충북` `대전충남` `전북` `전남광주` `대구경북` `부산경남` `제주` |
| 2 | 시군 | `남양주시` |
| 3 | 휴양림 | `축령산자연휴양림` |
| 4 | 운영현황-객실 | `O`/`X` |
| 5 | 운영현황-야영장 | `O`/`X` |
| 6 | 운영현황-대기 | `O`/`X` |
| 7 | 선착순-**6주(수요일)** | `O\n09시 오픈` · `O ( 4주 )\n월요일 09시 오픈` · (빈칸) |
| 8 | 선착순-**익월말** | `매월 1일 09시 오픈` · `매월 3일 14시 오픈` · (빈칸) |
| 9 | 추첨제 | `월` · `주말, 성수기, 장애인, 다자녀, 실버` · (빈칸) |
| 10 | 우선예약 | `바우처, 지역주민, 기타` · (빈칸) |

⚠️ **`구분`·`지역` 셀은 그룹 첫 행에만 나온다**(`rowspan` 48 / 6). 파서가 캐리포워드해야 한다.
⚠️ **표 안에 `hmpgId` 링크가 없다** (`table a[href]` = `[]`). 딥링크용 ID는 Task 4에서 따로 모은다.
⚠️ **첨부 `국공사립 휴양림별 예약정책안내.xls`는 `<a href>`가 아니다**(JS 함수 경유) → 표를 긁는다.

### 발견 2 — 관심 4곳 전부 이 표에 있다. **서운산·강씨봉의 "미확인"이 풀렸다** ✅

| 휴양림 | 통합표 실측값 (2026-08-04) | 설계서 §8 상태였던 것 |
|---|---|---|
| 축령산 (공립·서울인천경기·남양주시) | 선착순 **`매월 1일 09시 오픈`**, 추첨제 `월` | 개별 페이지는 **매월 7일** ← ⚠️ 충돌 |
| 영인산 (공립·대전충남·아산시) | 선착순 **6주칸 `O` + `09시 오픈`** (=매주 수요일) | 매주 수요일 09:00 ← ✅ 일치 |
| 서운산 (공립·서울인천경기·안성시) | 선착순 **`매월 3일 14시 오픈`**, 추첨제 `월, 지역주민` | 개별 페이지엔 **오픈 시점 없음** ← ✅ 해결 |
| 강씨봉 (공립·서울인천경기·**가평군**) | 선착순 **`매월 1일 09시 오픈`**, 추첨제 `월` | `hmpgId` 미확인 ← 규칙은 해결, ID는 Task 4 |

⚠️ **설계서 §8의 "`오픈일 확인 중`은 흔한 상태다"는 근거가 약해졌다.** 그 결론은 서운산 개별 정책
페이지에 오픈 시점이 없다는 관측 1건에서 나왔는데, **통합표에는 서운산 규칙이 적혀 있다.**
→ `오픈일 확인 중` 카드는 **여전히 1급 상태로 구현하되**(Task 7), 그 이유가 "규칙을 못 구해서"가
아니라 **"두 공식 소스가 어긋나서 사람이 판정 전"**으로 바뀐다.

### 발견 3 — ⚠️ **축령산에서 공식 소스 두 개가 어긋난다. 이게 이 프로젝트의 최우선 리스크다**

- 통합표(2026-08-04): `매월 1일 09시 오픈`
- 개별 정책 페이지 `ruleId=101`(2026-08-03): `매월 7일 09:00부터 (월추첨 발표 후 잔여분), 다음달 말일까지`
- `CLAUDE.md`에는 "블로그발 6일 오보가 정정됐고 공식은 7일"이 ⚠️로 박혀 있다 — 이제 **1일 vs 7일**이다.

**가설(검증 전, 코드에 넣지 말 것):** `매월 1일`은 월추첨 신청 시작이고 `매월 7일`은 추첨 발표 후
잔여분 선착순 오픈일일 수 있다(축령산·서운산·강씨봉 모두 추첨제 칸에 `월`이 있다).
→ **Task 3에서 사람이 판정하기 전까지 축령산은 `오픈일 확인 중`이다.** 설계서 §3.4의 귀결이다.

### 발견 4 — 숲나들e 커버리지 실측: **186곳**

`자연휴양림안내`(`/pot/is/fs/selectFcltSrchView.do?hmpgId=FRIP&menuId=002001`) 페이지에
`시설정보 1/47 총 186곳`. 설계서의 "170여 개" 추정이 확정됐다. 47페이지 × 4곳.

### 이 계획이 설계서에서 의도적으로 벗어나는 곳 (2건)

1. **`forests.sido` → `forests.region`.** 설계서는 "도별" 드릴다운이지만 통합표의 지역 단위는
   `서울인천경기` 같은 **9개 묶음**이다. 시군(150여 종) → 도 매핑표를 손으로 만드느니
   **숲나들e가 쓰는 9개 묶음을 그대로 쓴다.** 3단 드릴다운·타이핑 0회는 그대로고, 첫 화면이
   9버튼(3×3)이라 부모님께 오히려 낫다. 설계서 §5.2의 정신을 지키면서 노동만 없앤다.
2. **`data.go.kr` 표준데이터(`15013111`)를 이번 범위에서 뺀다.** 사용자가 "숲나들e 크롤링 우선"을
   택했고, 통합표가 이름·구분·지역·시군을 다 준다. 주소·전화가 필요해지면 그때 붙인다
   (설계서 §8의 "표준데이터↔`hmpg_id` 이름 매칭 실패" 걱정이 통째로 사라진다).

---

## Global Constraints

이 절은 **모든 태스크의 요구사항에 암묵적으로 포함된다.**

- **본문 글씨 18px 이상, 날짜 줄 22px 굵게, 터치 타깃 최소 48px, 고대비.** 노안 전제.
- **화면은 2개뿐** — 홈, 추가. 설정 화면·탭바·햄버거 메뉴를 만들지 않는다.
- **타이핑 0회.** 검색창을 넣지 않는다.
- **전문용어 금지.** 화면에 `hmpgId`·`크롤링`·`동기화`·`D-3` 같은 말이 등장하지 않는다.
  `선착순`·`추첨`은 부모님이 아는 말이므로 사용 가능.
- **푸시 알림·서비스워커·VAPID·`.ics`를 만들지 않는다.** 2026-08-03 사용자 결정. 되돌리지 말 것.
- **예약 자동화(매크로) 금지.** 로그인·결제·좌석선점 자동화를 설계에 넣지 않는다.
- **로그인 벽 뒤를 긁지 않는다.** 숲나들e 월추첨신청(`/rep/drlts/month/drltsMain.do`)이 여기 해당.
- **규칙은 사람이 검토한 것만 `active=true`.** 파서가 만든 후보는 전부 `active=false`로 들어간다.
  틀린 날짜 한 번이 앱 신뢰를 통째로 무너뜨린다.
- **크롤링은 주 1회 수준.** 사이트에 부담 주지 않는다.
- 규칙·정책을 코드/데이터에 넣을 땐 **출처 URL + 확인 날짜**를 함께 남긴다.
- 비밀키(`.env.local`, `.mcp.json`)는 **커밋 금지**.
- 한글 든 파일은 **Read 도구**로 본다 (PowerShell `Get-Content`는 깨진다).
- 스크립트는 **Write 도구로 만들고 절대경로로 실행** (bash heredoc이 백슬래시를 잃는다).
- 이 PC에 **Python 없음** → 전부 Node.

### 확정된 상수

```
숲나들e 통합표 URL   https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002
숲나들e 목록 URL     https://www.foresttrip.go.kr/pot/is/fs/selectFcltSrchView.do?hmpgId=FRIP&menuId=002001
딥링크 선착순        https://www.foresttrip.go.kr/rep/or/sssn/fcfsRsrvtPssblGoodsDetls.do?hmpgId=<ID>&menuId=001001
딥링크 월추첨        https://www.foresttrip.go.kr/rep/drlts/month/drltsMain.do?hmpgId=<ID>&menuId=001003002
딥링크 예약정책      https://www.foresttrip.go.kr/pot/rm/ug/selectRsrvtGdncView.do?hmpgId=<ID>&menuId=004001001&ruleId=101
GitHub 계정          1226cjw-afk
Edge 실행 파일       C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
```

---

## File Structure

```
index.html                     앱 전체 (홈 + 추가) — CSS/JS 인라인. 유일한 배포 산출물 겸 UI
manifest.json                  홈 화면 아이콘 (PWA 최소 구성 — 서비스워커 없음)
icon-192.png / icon-512.png    홈 화면 아이콘 이미지 (tools/make-icons.js 가 생성)
.gitignore                     .mcp.json / .env.local / scratch 제외

tools/cdp.js                   (기존) 범용 Edge+CDP 렌더러 — 수정하지 않는다
tools/lib/cdpx.js              CDP 세션 헬퍼. 임의 JS 를 평가하고 결과를 돌려준다.
                               scrape-policy / scrape-hmpgid / check / make-icons 가 공유
tools/scrape-policy.js         통합표 → data/policy-table.json  (185행 원본 셀)
tools/lib/parse-policy.js      셀 → forests/rules 후보로 변환하는 순수 함수 (테스트 대상)
tools/scrape-hmpgid.js         목록 47페이지 → data/hmpgid-map.json (이름 ↔ hmpgId)
tools/build-seed.js            위 둘 병합 → data/seed.sql
tools/check.js                 주 1회 정책 감시 (통합표 해시 비교 → 바뀌면 active=false)
tools/make-icons.js            SVG → PNG 아이콘 2종 (CDP 스크린샷, 외부 의존성 0)

data/policy-table.json         스크랩 원본 (커밋 — diff 로 변경 추적)
data/hmpgid-map.json           이름↔hmpgId (커밋)
data/seed.sql                  Supabase 투입용 (커밋)
schema.sql                     테이블 DDL (커밋 — 대시보드에 붙여넣는 원본)

tests/run.js                   의존성 없는 초소형 러너 (assert + 종료코드)
tests/opendate.test.js         다음 오픈일 계산 — index.html 에서 함수 구간을 추출해 테스트
tests/parse-policy.test.js     통합표 파서

PROGRESS.md                    진척 기록 (git 미추적)
```

**왜 `tools/lib/parse-policy.js`를 따로 두나:** 파싱 규칙이 이 프로젝트에서 가장 틀리기 쉬운 곳이고
(rowspan 캐리포워드·요일 기본값), 브라우저를 띄우지 않고 테스트해야 하기 때문. 스크래퍼는 네트워크,
파서는 순수 함수 — 책임이 다르므로 파일을 나눈다.

**왜 계산 함수는 `index.html` 안에 두나:** 배포 산출물을 한 장으로 유지하는 것이 `Our_Budget` 선례고
빌드 단계가 없다. 대신 테스트가 `index.html`에서 경계 주석 사이를 추출해 실행한다
(`Our_Budget/CLAUDE.md`의 "JS 검증 (테스트 프레임워크 없음)" 방식).

---

## 사람이 해야 하는 일 (에이전트가 대신 못 함)

계획 실행 중 아래 3개는 **사용자 본인**이 브라우저에서 해야 한다. 해당 태스크가 여기서 멈춘다.

1. **Task 1** — Cloudflare 대시보드에서 GitHub 리포 연결 (Workers 자동배포)
2. **Task 5** — supabase.com 에서 새 프로젝트 생성 → **Project URL · anon key** 전달
3. **Task 10** — 부모님 폰 두 대에서 홈 화면에 아이콘 추가

---

### Task 1: 배포 파이프라인 먼저 세우기 (걸어다니는 해골)

**왜 이걸 1번으로 하나:** 사용자가 "지금 바로 배포"를 택했다. 껍데기라도 폰에서 열리는 URL이 있으면
이후 모든 태스크를 실기기에서 확인할 수 있다. 설계서가 강조한 "열기 쉬움"이 유일한 안전장치이므로
아이콘·URL이 일찍 손에 있어야 한다.

**Files:**
- Create: `C:\Users\1226c\Projects\Hyuyangnim\.gitignore`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\index.html`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\manifest.json`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tools\make-icons.js`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tools\lib\cdpx.js`

**Interfaces:**
- Produces: `tools/lib/cdpx.js` 가 `withPage(url, fn, opts)` 를 export 한다.
  `fn` 은 `{ ev, send }` 를 받는다 — `ev(expr)` 는 페이지에서 JS 를 평가해 값을 돌려주고,
  `send(method, params)` 는 원시 CDP 명령. Task 2·4·9 가 전부 이걸 쓴다.

- [ ] **Step 1: `.gitignore` 작성**

```gitignore
# Supabase 연결정보 등 로컬 설정 — 커밋 금지
.mcp.json
.env.local

# 로컬 전용 (배포 산출물 아님)
PROGRESS.md
scratch/
tools/edgeprofile/
```

- [ ] **Step 2: CDP 헬퍼 `tools/lib/cdpx.js` 작성**

`tools/cdp.js` 는 "URL 하나를 JSON 으로 떨구는" 고정 도구라 재사용이 안 된다. 세션만 빌려주는
헬퍼를 만들어 Task 2·4·9·make-icons 가 공유한다. `cdp.js` 자체는 건드리지 않는다.

```js
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
```

- [ ] **Step 3: 아이콘 생성기 `tools/make-icons.js` 작성**

⚠️ 이 PC엔 이미지 라이브러리가 없다. SVG 를 담은 `data:` 페이지를 CDP 로 열고 스크린샷을 찍어
PNG 를 얻는다 — 외부 의존성 0.

```js
// SVG 를 CDP 스크린샷으로 렌더해 홈 화면 아이콘 PNG 2종을 만든다.
//   node tools/make-icons.js
const fs = require('fs');
const path = require('path');
const { withPage } = require('./lib/cdpx');

const ROOT = path.join(__dirname, '..');

// 짙은 숲 초록 배경 + 흰 나무. 홈 화면에서 작게 보여도 알아볼 수 있게 단순하게.
const svg = size => `
<svg xmlns="http://www.w3.org/2000/svg" width="${size}" height="${size}" viewBox="0 0 512 512">
  <rect width="512" height="512" rx="112" fill="#1b5e20"/>
  <path d="M256 96 L352 240 H296 L376 356 H136 L216 240 H160 Z" fill="#ffffff"/>
  <rect x="236" y="340" width="40" height="76" rx="12" fill="#ffffff"/>
</svg>`.trim();

(async () => {
  for (const size of [192, 512]) {
    const html = `<!doctype html><meta charset="utf-8">` +
      `<style>html,body{margin:0;padding:0;background:transparent}</style>` + svg(size);
    const url = 'data:text/html;charset=utf-8,' + encodeURIComponent(html);

    const b64 = await withPage(url, async ({ send }) => {
      await send('Emulation.setDeviceMetricsOverride',
        { width: size, height: size, deviceScaleFactor: 1, mobile: false });
      const r = await send('Page.captureScreenshot', { format: 'png' });
      return r.data;
    }, { settleMs: 1200, port: 9341 });

    const out = path.join(ROOT, `icon-${size}.png`);
    fs.writeFileSync(out, Buffer.from(b64, 'base64'));
    console.log('WROTE', out);
  }
})().catch(e => { console.error('ERR', e); process.exit(1); });
```

- [ ] **Step 4: 아이콘 생성 실행 및 확인**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tools\make-icons.js`
Expected: `WROTE ...icon-192.png` / `WROTE ...icon-512.png` 두 줄.

확인: `node -e "const s=require('fs').statSync('C:/Users/1226c/Projects/Hyuyangnim/icon-512.png');console.log(s.size)"`
Expected: 1000 바이트 이상(빈 파일이 아님). PNG 시그니처 확인:
`node -e "const b=require('fs').readFileSync('C:/Users/1226c/Projects/Hyuyangnim/icon-512.png');console.log(b.slice(1,4).toString())"`
Expected: `PNG`

- [ ] **Step 5: `manifest.json` 작성**

⚠️ `display: standalone` 만 쓴다. 서비스워커를 등록하지 않으므로 오프라인 동작은 없다 — 의도된 것이다.

```json
{
  "name": "휴양림 예약 오픈일",
  "short_name": "휴양림",
  "start_url": "./index.html",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#1b5e20",
  "icons": [
    { "src": "icon-192.png", "sizes": "192x192", "type": "image/png", "purpose": "any maskable" },
    { "src": "icon-512.png", "sizes": "512x512", "type": "image/png", "purpose": "any maskable" }
  ]
}
```

- [ ] **Step 6: `index.html` 뼈대 작성 (배포 확인용 최소본)**

이 단계의 목적은 **URL 이 폰에서 열리는 것**뿐이다. 화면 내용은 Task 7 에서 채운다.

```html
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>휴양림 예약 오픈일</title>
<link rel="manifest" href="manifest.json">
<link rel="apple-touch-icon" href="icon-192.png">
<meta name="theme-color" content="#1b5e20">
<style>
  :root { --fg:#111; --bg:#fff; --green:#1b5e20; }
  * { box-sizing: border-box; -webkit-tap-highlight-color: transparent; }
  body {
    margin:0; background:var(--bg); color:var(--fg);
    font-family: system-ui, -apple-system, "Malgun Gothic", sans-serif;
    font-size:18px; line-height:1.5;
  }
  header { background:var(--green); color:#fff; padding:16px; font-size:20px; font-weight:700; }
  main { padding:16px; }
</style>
</head>
<body>
<header>다음 예약 오픈</header>
<main id="app">준비 중입니다.</main>
</body>
</html>
```

- [ ] **Step 7: 로컬에서 열어 확인**

Run: `node -e "const h=require('fs').readFileSync('C:/Users/1226c/Projects/Hyuyangnim/index.html','utf8');console.log(h.includes('manifest.json')&&h.includes('viewport')?'OK':'MISSING')"`
Expected: `OK`

- [ ] **Step 8: git 초기화 및 첫 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git init -b main
git add .gitignore index.html manifest.json icon-192.png icon-512.png tools/ docs/ CLAUDE.md BRAINSTORM.md
git commit -m "chore: 리포 초기화 — 배포 뼈대(index.html·manifest·아이콘)와 CDP 헬퍼"
```

- [ ] **Step 9: GitHub public 리포 생성 및 푸시**

⚠️ `Our_Photo` 와 달리 이 프로젝트엔 개인 사진·위치가 없으므로 public 관례를 따른다.
즐겨찾기 목록만이 개인 데이터고 그건 Supabase 에 있다(리포에 없다).

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
gh repo create Hyuyangnim --public --source=. --remote=origin --push
gh repo view --json url --jq .url
```

Expected: `https://github.com/1226cjw-afk/Hyuyangnim`

- [ ] **Step 10: 🙋 사용자에게 Cloudflare 연결 요청 (여기서 멈춘다)**

에이전트가 대신 할 수 없다. 사용자에게 아래를 그대로 안내하고 배포 URL 을 받는다.

```
1. https://dash.cloudflare.com → Workers & Pages → Create → Workers → Import a repository
2. 리포 1226cjw-afk/Hyuyangnim 선택, 브랜치 main
3. 빌드 명령 비움 / 출력 디렉터리 비움 (정적 파일 그대로 서빙)
4. 배포 후 나오는 URL (예: https://hyuyangnim.1226cjw.workers.dev/) 을 알려주세요
```

⚠️ 설계서 §4.1 — **`worker.js` 를 미리 만들지 말 것.** `Our_Budget` 은 리포에 Worker 코드가 없고
대시보드 연동만으로 정적 서빙이 된다. 정말 안 되는 것을 확인한 뒤에만 추가한다.

- [ ] **Step 11: 배포 확인 후 URL 기록**

배포 URL 을 받으면 `CLAUDE.md` 상단 현황에 추가하고 커밋한다.

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add CLAUDE.md
git commit -m "docs: 배포 URL 기록"
git push
```

---

### Task 2: 예약정책 통합표 스크래퍼

**Files:**
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tools\lib\parse-policy.js`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tests\run.js`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tests\parse-policy.test.js`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tools\scrape-policy.js`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\data\policy-table.json` (스크립트가 생성)

**Interfaces:**
- Consumes: `tools/lib/cdpx.js` 의 `withPage` (Task 1)
- Produces:
  - `parse-policy.js` → `{ parseRows(rawRows), toRule(row), POLICY_URL }`
    - `parseRows(rawRows: {t,rs,cs}[][]) → Row[]`
      `Row = { gubun, region, sigungu, name, room, camp, wait, weekly, monthly, lottery, priority }` (모두 string)
    - `toRule(row: Row) → Rule | null`
      `Rule = { freq:'monthly'|'weekly', day_of_month:number|null, weekday:number|null, open_time:'HH:MM' }`
  - `data/policy-table.json` → `{ scraped_at, url, rows: Row[] }`

- [ ] **Step 1: 테스트 러너 `tests/run.js` 작성**

의존성 없는 최소 러너. 테스트 파일들을 require 하고 실패 개수로 종료코드를 정한다.

```js
// 의존성 없는 초소형 테스트 러너.  node tests/run.js
const path = require('path');
let pass = 0, fail = 0;
const failures = [];

global.test = (name, fn) => {
  try { fn(); pass++; console.log('  ok   ' + name); }
  catch (e) { fail++; failures.push(name + '\n      ' + e.message); console.log('  FAIL ' + name); }
};
global.eq = (actual, expected, msg) => {
  const a = JSON.stringify(actual), b = JSON.stringify(expected);
  if (a !== b) throw new Error((msg ? msg + ': ' : '') + 'expected ' + b + ' but got ' + a);
};

for (const f of process.argv.slice(2).length ? process.argv.slice(2)
    : ['parse-policy.test.js', 'opendate.test.js']) {
  const p = path.join(__dirname, f);
  if (!require('fs').existsSync(p)) { console.log('(skip ' + f + ' — 아직 없음)'); continue; }
  console.log('\n' + f);
  require(p);
}

console.log('\n' + pass + ' passed, ' + fail + ' failed');
if (fail) { console.log('\n' + failures.join('\n')); process.exit(1); }
```

- [ ] **Step 2: 파서 테스트를 먼저 쓴다 (실패해야 정상)**

`tests/parse-policy.test.js` — 실측한 4곳과 rowspan 캐리포워드를 고정한다.

```js
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
```

- [ ] **Step 3: 테스트를 돌려 실패를 확인한다**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tests\run.js parse-policy.test.js`
Expected: FAIL — `Cannot find module '../tools/lib/parse-policy'`

- [ ] **Step 4: 파서 `tools/lib/parse-policy.js` 구현**

```js
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
```

- [ ] **Step 5: 테스트를 다시 돌려 통과를 확인한다**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tests\run.js parse-policy.test.js`
Expected: `7 passed, 0 failed`

- [ ] **Step 6: 스크래퍼 `tools/scrape-policy.js` 작성**

```js
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
```

- [ ] **Step 7: 스크래퍼 실행**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tools\scrape-policy.js`
Expected: `WROTE ...policy-table.json rows= 185` (±수 행), `구분별: { 국립: 48, 공립: ..., 사립: ... }`

- [ ] **Step 8: 관심 4곳이 실측값과 맞는지 확인**

Run:
```bash
node -e "const d=require('C:/Users/1226c/Projects/Hyuyangnim/data/policy-table.json'); for(const k of ['축령산','영인산','서운산','강씨봉']){const r=d.rows.find(x=>x.name.includes(k)); console.log(k, r?JSON.stringify([r.gubun,r.region,r.sigungu,r.name,r.weekly,r.monthly]):'❌ 없음');}"
```
Expected (2026-08-04 실측 기준):
```
축령산 ["공립","서울인천경기","남양주시","축령산자연휴양림","","매월 1일 09시 오픈"]
영인산 ["공립","대전충남","아산시","영인산 자연휴양림","O\n09시 오픈",""]
서운산 ["공립","서울인천경기","안성시","서운산자연휴양림","","매월 3일 14시 오픈"]
강씨봉 ["공립","서울인천경기","가평군","강씨봉자연휴양림","","매월 1일 09시 오픈"]
```
어긋나면 파서가 아니라 **표가 바뀐 것**일 수 있다. 값을 그대로 기록하고 Task 3 의 대조 대상에 넣는다.

- [ ] **Step 9: 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add tools/lib/parse-policy.js tools/scrape-policy.js tests/ data/policy-table.json
git commit -m "feat: 숲나들e 예약정책 통합표 스크래퍼 + 파서 (185곳 1페이지)"
git push
```

---

### Task 3: 축령산 충돌 판정 — 관심 4곳 규칙 확정

**왜 별도 태스크인가:** 이 프로젝트에서 **틀리면 가장 비싼 곳**이다. 부모님이 화면의 날짜를 믿고
그날 아침에 접속하신다. 공식 소스 두 개가 어긋난 상태(발견 3)를 코드로 얼버무리면 안 된다.

**Files:**
- Create: `C:\Users\1226c\Projects\Hyuyangnim\data\rules-verified.json`
- Modify: `C:\Users\1226c\Projects\Hyuyangnim\CLAUDE.md` (§3 규칙 표를 실측으로 갱신)

**Interfaces:**
- Consumes: `data/policy-table.json` (Task 2), `tools/lib/cdpx.js` (Task 1)
- Produces: `data/rules-verified.json` →
  `{ verified_at, entries: [{ name, hmpg_id, kind, freq, day_of_month, weekday, open_time, note, source_url, active, conflict }] }`
  Task 5 의 `build-seed.js` 가 이 파일만 보고 `active=true` 규칙을 만든다.

- [ ] **Step 1: 관심 4곳의 개별 정책 페이지를 다시 렌더해 통합표와 대조**

`hmpgId` 는 `CLAUDE.md` 실측값을 쓴다(강씨봉은 아직 없으므로 3곳만).

Run:
```bash
node C:/Users/1226c/Projects/Hyuyangnim/tools/cdp.js "https://www.foresttrip.go.kr/pot/rm/ug/selectRsrvtGdncView.do?hmpgId=ID02030050&menuId=004001001&ruleId=101" "C:/Users/1226c/Projects/Hyuyangnim/scratch/chungnyeongsan.json"
```
같은 방식으로 영인산 `ID02030012`, 서운산 `ID02030092` 도 받는다.
(`scratch/` 는 `.gitignore` 에 있다 — 커밋되지 않는다.)

Expected: 각 파일에 `textlen=` 수천 자. 로그인 폼이 나오면 그 페이지는 대상이 아니다.

- [ ] **Step 2: 두 소스의 오픈 시점 문장을 나란히 뽑는다**

Run:
```bash
node -e "for(const f of ['chungnyeongsan','yeoninsan','seounsan']){const d=require('C:/Users/1226c/Projects/Hyuyangnim/scratch/'+f+'.json'); const hits=d.text.split('\n').filter(l=>/매월|매주|요일|오픈|시부터|\d{1,2}시/.test(l)); console.log('=====',f); console.log(hits.join('\n'));}"
```
Expected: 축령산에서 `7일`/`1일` 중 어느 쪽이 나오는지, 그 문장이 **선착순**을 말하는지
**월추첨 신청**을 말하는지가 보인다.

- [ ] **Step 3: 🙋 사람이 판정한다 (여기서 멈춘다)**

에이전트는 두 소스를 나란히 제시하고 **판정을 사용자에게 요청한다.** 자동으로 고르지 않는다.

제시할 형식:
```
축령산자연휴양림
  통합표(2026-08-04)      : 매월 1일 09시 오픈   [선착순-익월말 칸], 추첨제 = 월
  개별 정책(2026-08-03)   : 매월 7일 09:00부터 (월추첨 발표 후 잔여분), 다음달 말일까지
  → 두 날짜가 다릅니다. 어느 쪽을 부모님 화면에 띄울까요?
     (A) 매월 1일  (B) 매월 7일  (C) 확실하지 않음 → '오픈일 확인 중' 으로 두기
     참고: 남양주시 축령산자연휴양림 문의 031-592-0681
```

⚠️ **(C) 도 정상적인 답이다.** 설계서 §3.4 — 틀린 날짜를 띄우느니 '확인 중'이 낫다.

- [ ] **Step 4: 판정 결과를 `data/rules-verified.json` 에 기록**

아래는 **형식 예시**다. `freq`/`day_of_month`/`active` 값은 Step 3 의 판정으로 채운다.
`conflict` 에는 어긋난 소스를 남겨 다음 사람이 다시 조사하지 않게 한다.

```json
{
  "verified_at": "2026-08-04",
  "note": "숲나들e 예약정책 통합표를 1차 소스로, 휴양림별 개별 정책 페이지(ruleId=101)로 대조했다. 어긋나면 active=false.",
  "entries": [
    {
      "name": "축령산자연휴양림",
      "hmpg_id": "ID02030050",
      "kind": "fcfs",
      "freq": "monthly",
      "day_of_month": 1,
      "weekday": null,
      "open_time": "09:00",
      "note": "매월 1일 오전 9시부터",
      "source_url": "https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002",
      "active": false,
      "conflict": "개별 정책 페이지(ruleId=101, 2026-08-03)는 '매월 7일 09:00 (월추첨 발표 후 잔여분)'. 통합표는 '매월 1일 09시'. 판정 전까지 active=false."
    },
    {
      "name": "영인산 자연휴양림",
      "hmpg_id": "ID02030012",
      "kind": "fcfs",
      "freq": "weekly",
      "day_of_month": null,
      "weekday": 3,
      "open_time": "09:00",
      "note": "매주 수요일 오전 9시부터",
      "source_url": "https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002",
      "active": true,
      "conflict": null
    },
    {
      "name": "서운산자연휴양림",
      "hmpg_id": "ID02030092",
      "kind": "fcfs",
      "freq": "monthly",
      "day_of_month": 3,
      "weekday": null,
      "open_time": "14:00",
      "note": "매월 3일 오후 2시부터",
      "source_url": "https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002",
      "active": true,
      "conflict": "개별 정책 페이지(ruleId=101)에는 오픈 시점이 없다. 통합표에만 있다. 전화 031-678-2913"
    },
    {
      "name": "강씨봉자연휴양림",
      "hmpg_id": null,
      "kind": "fcfs",
      "freq": "monthly",
      "day_of_month": 1,
      "weekday": null,
      "open_time": "09:00",
      "note": "매월 1일 오전 9시부터",
      "source_url": "https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002",
      "active": true,
      "conflict": "hmpg_id 미확인 — Task 4 에서 채운다. 그전까지 예약 딥링크가 숲나들e 목록으로 간다."
    }
  ]
}
```

- [ ] **Step 5: `CLAUDE.md` 의 규칙 표를 갱신**

`CLAUDE.md` §3 「예약 규칙 — 공식 페이지로 실측 완료」 표를 통합표 실측으로 바꾼다.
⚠️ **기존 ⚠️ 문단을 지우지 말고 "2026-08-04 갱신" 을 덧붙인다** — "블로그 6일 오보" 경위가
축령산 충돌을 이해하는 데 필요하다.

⚠️ `CLAUDE.md` 는 BOM·특수문자가 섞인 한글 파일이다. **Edit 도구가 new_string 의 한글을
`\uXXXX` 로 망가뜨린 전례가 있다**(2026-08-03) → 이 파일은 **Write 로 전체 재작성**한다.
먼저 Read 로 전문을 읽고, 해당 절만 바꾼 전체 내용을 Write 한다.

- [ ] **Step 6: 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add data/rules-verified.json CLAUDE.md
git commit -m "feat: 관심 4곳 규칙 확정 — 통합표와 개별 정책 페이지 대조 결과 기록"
git push
```

---

### Task 4: `hmpgId` 매핑 수집 (강씨봉 미확인 해소)

**왜 필요한가:** 통합표엔 `hmpgId` 링크가 없다(발견 1). `예약하러 가기` 딥링크가 이 ID 로만 만들어진다.

**Files:**
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tools\scrape-hmpgid.js`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\data\hmpgid-map.json` (스크립트가 생성)

**Interfaces:**
- Consumes: `tools/lib/cdpx.js` 의 `withPage`
- Produces: `data/hmpgid-map.json` → `{ scraped_at, map: { "<휴양림 이름>": "<hmpgId>" } }`

- [ ] **Step 1: 목록 1페이지에서 `hmpgId` 가 어디 붙는지 확인**

Run: `node C:/Users/1226c/Projects/Hyuyangnim/tools/cdp.js "https://www.foresttrip.go.kr/pot/is/fs/selectFcltSrchView.do?hmpgId=FRIP&menuId=002001" "C:/Users/1226c/Projects/Hyuyangnim/scratch/fclt1.json"`

Run: `node -e "const d=require('C:/Users/1226c/Projects/Hyuyangnim/scratch/fclt1.json');console.log(JSON.parse(d.links).filter(l=>/hmpgId=ID/.test(l)).slice(0,10).join('\n'))"`
Expected: `홈페이지 바로가기 :: ...hmpgId=ID020300xx...` 형태의 줄들.
⚠️ 안 나오면 링크가 `javascript:` 함수 경유다 → Step 2 의 셀렉터를 `onclick` 속성까지 읽도록 바꾼다.

- [ ] **Step 2: `tools/scrape-hmpgid.js` 작성**

47페이지를 도는 동안 **페이지당 1.5초 이상 쉰다** — 주 1회 크롤링 원칙과 별개로 이 스크립트는
1회성이지만 사이트에 부담을 주지 않는다.

```js
// 숲나들e 자연휴양림안내 목록(총 186곳 / 47페이지)에서 이름 ↔ hmpgId 를 모은다.
// 1회성 스크립트. 새 휴양림이 생기면 다시 돌린다.
//   node tools/scrape-hmpgid.js
const fs = require('fs');
const path = require('path');
const { withPage, sleep } = require('./lib/cdpx');

const LIST_URL =
  'https://www.foresttrip.go.kr/pot/is/fs/selectFcltSrchView.do?hmpgId=FRIP&menuId=002001';
const OUT = path.join(__dirname, '..', 'data', 'hmpgid-map.json');

// 목록 카드에서 (이름, hmpgId) 쌍을 뽑는다. href 와 onclick 양쪽을 본다.
const HARVEST = `(()=>{
  const out = [];
  for (const el of document.querySelectorAll('a[href],[onclick]')) {
    const s = (el.getAttribute('href')||'') + ' ' + (el.getAttribute('onclick')||'');
    const m = /hmpgId=(ID[0-9A-Za-z]+)/.exec(s);
    if (!m) continue;
    // 카드 제목을 찾는다: 가장 가까운 리스트 아이템 안의 첫 제목성 요소
    const box = el.closest('li,div.item,div.card,tr') || el.parentElement;
    const t = box ? (box.querySelector('strong,h3,h4,.tit,.name,a') || box) : el;
    const name = (t.innerText||'').split('\\n')[0].replace(/^(국|공|사)\\s+/,'').replace(/예약.*$/,'').trim();
    if (name) out.push([name, m[1]]);
  }
  return JSON.stringify(out);
})()`;

(async () => {
  const map = {};
  await withPage(LIST_URL, async ({ ev, goto }) => {
    let totalPages = 47;
    const info = await ev(`document.body.innerText.match(/시설정보\\s*\\d+\\/(\\d+)/)?.[1] || ''`);
    if (info) totalPages = Number(info);
    console.log('총 페이지:', totalPages);

    for (let p = 1; p <= totalPages; p++) {
      if (p > 1) {
        // 페이징은 사이트 전역 함수를 쓴다. 함수명이 다르면 아래 한 줄만 고치면 된다.
        await ev(`(typeof fn_search==='function') ? fn_search(${p})
                : (typeof goPage==='function') ? goPage(${p}) : null`);
        await sleep(2500);
      }
      const pairs = JSON.parse(await ev(HARVEST) || '[]');
      for (const [name, id] of pairs) if (!map[name]) map[name] = id;
      console.log('p' + p, '누적', Object.keys(map).length);
      await sleep(1500); // 사이트 부담 방지
    }
  }, { port: 9343 });

  fs.mkdirSync(path.dirname(OUT), { recursive: true });
  fs.writeFileSync(OUT, JSON.stringify({
    scraped_at: new Date().toISOString().slice(0, 10),
    source: LIST_URL,
    map,
  }, null, 2), 'utf8');
  console.log('WROTE', OUT, 'names=', Object.keys(map).length);
})().catch(e => { console.error('ERR', e); process.exit(1); });
```

⚠️ 페이징 함수명(`fn_search`/`goPage`)은 미확인이다. Step 1 에서 페이지 소스를 확인해 실제 이름으로
고친다. 페이징이 끝내 안 되면 **관심 4곳만 개별 검색으로 채우고** 나머지는 `hmpg_id = null` 로 둔다
(설계서 §3.2 — 목록은 전국, 규칙은 확인된 것만. 딥링크 없는 곳은 숲나들e 목록으로 보낸다).

- [ ] **Step 3: 실행**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tools\scrape-hmpgid.js`
Expected: `WROTE ...hmpgid-map.json names= 150` 이상 (186 에 못 미쳐도 진행 가능).

- [ ] **Step 4: 관심 4곳과 기존 실측값 대조**

Run:
```bash
node -e "const m=require('C:/Users/1226c/Projects/Hyuyangnim/data/hmpgid-map.json').map; const want={'축령산':'ID02030050','영인산':'ID02030012','서운산':'ID02030092','강씨봉':null}; for(const k in want){const hit=Object.keys(m).find(n=>n.includes(k)); console.log(k, hit||'❌', m[hit]||'-', want[k]?(m[hit]===want[k]?'✅일치':'⚠️불일치 기대='+want[k]):'(신규)');}"
```
Expected: 축령산·영인산·서운산이 `✅일치`. 강씨봉에 `ID...` 가 새로 찍힌다 — **설계서 §8 미해결 항목 해소.**
불일치가 나오면 기존 `CLAUDE.md` 값이 아니라 **이번 실측을 신뢰하되, 불일치 사실을 기록**한다.

- [ ] **Step 5: 강씨봉 `hmpg_id` 를 `rules-verified.json` 에 반영**

Task 3 에서 `"hmpg_id": null` 로 둔 강씨봉 항목을 Step 4 에서 얻은 ID 로 채우고,
`conflict` 의 "Task 4 에서 채운다" 문장을 지운다.

- [ ] **Step 6: 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add tools/scrape-hmpgid.js data/hmpgid-map.json data/rules-verified.json
git commit -m "feat: 이름↔hmpgId 매핑 수집 — 강씨봉 ID 확보"
git push
```

---

### Task 5: Supabase 스키마 + 시드 투입

**Files:**
- Create: `C:\Users\1226c\Projects\Hyuyangnim\schema.sql`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tools\build-seed.js`
- Create: `C:\Users\1226c\Projects\Hyuyangnim\data\seed.sql` (스크립트가 생성)

**Interfaces:**
- Consumes: `data/policy-table.json` (Task 2), `data/rules-verified.json` (Task 3), `data/hmpgid-map.json` (Task 4)
- Produces: Supabase 테이블 `forests` / `rules` / `favorites` / `policy_snapshots`.
  Task 7·8 의 JS 가 `sb.from('forests')` 등으로 읽는다.

- [ ] **Step 1: 🙋 사용자에게 Supabase 프로젝트 생성 요청 (여기서 멈춘다)**

```
1. https://supabase.com/dashboard → New project
   이름: Hyuyangnim   리전: Northeast Asia (Seoul)
2. 생성 후 Project Settings → API 에서 두 값을 알려주세요:
   - Project URL   (https://xxxxx.supabase.co)
   - anon public key
```

⚠️ anon key 는 `index.html` 에 그대로 들어간다(공개 키이고 RLS 가 열려 있다 — `Our_Budget` 과 동일).
**service_role key 는 절대 받지도 쓰지도 않는다.**

- [ ] **Step 2: `schema.sql` 작성**

설계서 §4.2 에서 두 곳을 바꾼다: `sido` → `region`(숲나들e 9개 묶음), `gubun` 추가(국립/공립/사립).

```sql
-- Hyuyangnim 스키마. Supabase 대시보드 SQL Editor 에 그대로 붙여넣는다.
-- 출처: 숲나들e 휴양림별 예약정책안내 (2026-08-04 실측)
-- RLS 는 전부 열어둔다 — 로그인이 없고 개인정보가 없다(즐겨찾기 목록이 전부). Our_Budget 과 동일.

create table if not exists forests (
  id       serial primary key,
  name     text not null unique,        -- 축령산자연휴양림
  gubun    text not null,               -- 국립 / 공립 / 사립
  region   text not null,               -- 서울인천경기 / 강원 / 충북 / 대전충남 / 전북 / 전남광주 / 대구경북 / 부산경남 / 제주
  sigungu  text not null,               -- 남양주시
  hmpg_id  text,                        -- 숲나들e ID. null 이면 딥링크 대신 목록으로 보낸다
  tel      text
);

create table if not exists rules (
  id            serial primary key,
  forest_id     int  not null references forests(id) on delete cascade,
  kind          text not null check (kind in ('fcfs','lottery')),
  freq          text not null check (freq in ('monthly','weekly')),
  day_of_month  int  check (day_of_month between 1 and 31),
  weekday       int  check (weekday between 0 and 6),
  open_time     time not null default '09:00',
  note          text,                   -- 부모님께 그대로 보여드릴 한 줄
  source_url    text not null,          -- 조례로 바뀌므로 출처 필수
  verified_at   date not null,          -- 사람이 확인한 날
  conflict      text,                   -- 소스 간 불일치 기록 (있으면 active=false 여야 한다)
  active        bool not null default false,   -- ⚠️ 기본 false. 사람이 검토해야 켜진다
  check ( (freq='monthly' and day_of_month is not null)
       or (freq='weekly'  and weekday      is not null) )
);
create index if not exists rules_forest_idx on rules(forest_id);

create table if not exists favorites (
  forest_id int primary key references forests(id) on delete cascade,
  added_at  timestamptz not null default now()
);

create table if not exists policy_snapshots (
  id         serial primary key,
  scope      text not null unique,      -- 'policy-table' — 통합표 한 장을 감시한다
  url        text not null,
  body_hash  text not null,
  body_text  text,                      -- diff 확인용 원문 보관
  checked_at timestamptz not null default now()
);

alter table forests          enable row level security;
alter table rules            enable row level security;
alter table favorites        enable row level security;
alter table policy_snapshots enable row level security;

create policy forests_all   on forests          for all using (true) with check (true);
create policy rules_all     on rules            for all using (true) with check (true);
create policy favorites_all on favorites        for all using (true) with check (true);
create policy snapshots_all on policy_snapshots for all using (true) with check (true);
```

⚠️ 설계서 §4.2 의 `apply_end_day`/`result_day`(추첨 전용)를 **넣지 않는다.** 통합표의 추첨제 칸은
`월`·`주말, 성수기` 같은 **종류**만 알려주고 신청기간·발표일이 없다. 값을 못 채울 컬럼을 미리
만들지 않는다(설계서 "의도적으로 넣지 않은 컬럼" 정신). 추첨 일정을 손으로 등록하게 될 때 추가한다.

- [ ] **Step 3: 🙋 사용자가 `schema.sql` 을 Supabase SQL Editor 에서 실행**

Expected: `Success. No rows returned`

- [ ] **Step 4: `tools/build-seed.js` 작성**

```js
// policy-table.json + hmpgid-map.json + rules-verified.json → data/seed.sql
//   node tools/build-seed.js
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

for (const r of table.rows) {
  const hmpg = verByKey[key(r.name)]?.hmpg_id || idByKey[key(r.name)] || null;
  lines.push(
    `insert into forests (name, gubun, region, sigungu, hmpg_id) values (` +
    [q(r.name), q(r.gubun), q(r.region), q(r.sigungu), q(hmpg)].join(', ') +
    `) on conflict (name) do update set ` +
    `gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, ` +
    `hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);`
  );
}
lines.push('');

// ⚠️ 규칙은 사람이 검토한 것만 active=true. 나머지는 후보로만 넣는다.
for (const r of table.rows) {
  const v = verByKey[key(r.name)];
  const rule = v ? v : toRule(r);
  if (!rule) continue;                       // 규칙을 못 읽음 → 오픈일 확인 중
  const active = v ? !!v.active : false;      // 검토 안 된 것은 전부 false
  lines.push(
    `insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)\n` +
    `select f.id, ${q(v?.kind || 'fcfs')}, ${q(rule.freq)}, ${rule.day_of_month ?? 'null'}, ` +
    `${rule.weekday ?? 'null'}, ${q(rule.open_time)}, ${q(v?.note || null)}, ` +
    `${q(v?.source_url || POLICY_URL)}, ${q(v?.verified_at || verified.verified_at)}, ` +
    `${q(v?.conflict || null)}, ${active}\n` +
    `from forests f where f.name = ${q(r.name)};`
  );
}

fs.writeFileSync(OUT, lines.join('\n') + '\n', 'utf8');
const activeCount = verified.entries.filter(e => e.active).length;
console.log('WROTE', OUT, '| forests=', table.rows.length, '| active 규칙=', activeCount);
```

- [ ] **Step 5: 시드 생성 및 검증**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tools\build-seed.js`
Expected: `WROTE ...seed.sql | forests= 185 | active 규칙= 3` (Task 3 판정에 따라 2~4)

⚠️ 안전 확인 — **검토 안 된 규칙이 `true` 로 새지 않았는지** 센다:
Run: `node -e "const s=require('fs').readFileSync('C:/Users/1226c/Projects/Hyuyangnim/data/seed.sql','utf8');console.log('true=',(s.match(/, true;?$/gm)||[]).length,' false=',(s.match(/, false;?$/gm)||[]).length)"`
Expected: `true=` 값이 `rules-verified.json` 의 `active:true` 개수와 **정확히 일치**. 크면 중단하고 원인을 찾는다.

- [ ] **Step 6: 🙋 사용자가 `data/seed.sql` 을 Supabase SQL Editor 에서 실행**

Expected: `Success`. 이어서 SQL Editor 에서 확인:
```sql
select count(*) from forests;                       -- 185 내외
select count(*) from rules where active;            -- rules-verified.json 의 active 개수
select f.name, r.freq, r.day_of_month, r.weekday, r.open_time, r.active
from forests f join rules r on r.forest_id=f.id
where f.name like '%축령산%' or f.name like '%영인산%'
   or f.name like '%서운산%' or f.name like '%강씨봉%';
```

- [ ] **Step 7: 관심 4곳을 즐겨찾기에 미리 넣기**

부모님이 처음 여실 때 빈 화면이 아니어야 한다.
```sql
insert into favorites (forest_id)
select id from forests
where name like '%축령산%' or name like '%영인산%'
   or name like '%서운산%' or name like '%강씨봉%'
on conflict do nothing;
```

- [ ] **Step 8: 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add schema.sql tools/build-seed.js data/seed.sql
git commit -m "feat: Supabase 스키마 + 시드 생성기 (185곳 투입, 규칙은 검토분만 active)"
git push
```

---

### Task 6: 다음 오픈일 계산 (TDD)

**Files:**
- Modify: `C:\Users\1226c\Projects\Hyuyangnim\index.html` (`<script>` 안에 계산 구간 추가)
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tests\opendate.test.js`

**Interfaces:**
- Produces (`index.html` 안, 경계 주석 `// ── OPENDATE:START ──` ~ `// ── OPENDATE:END ──` 사이):
  - `lastDayOfMonth(y, m) → number` (m 은 0-11)
  - `nextOpen(rule, now) → Date | null` — `rule = {freq, day_of_month, weekday, open_time:'HH:MM', active}`
  - `dayDiff(from, to) → number` (자정 기준 날짜 차)
  - `humanWhen(open, now) → string` — `"오늘 오전 9시!"` / `"내일 오전 9시"` / `"4일 뒤"`
  - `formatOpen(d) → string` — `"8월 7일 (금) 오전 9시"`

- [ ] **Step 1: 테스트를 먼저 쓴다**

`tests/opendate.test.js` — `index.html` 에서 경계 주석 사이를 추출해 실행한다.
브라우저·Supabase 없이 순수 함수만 검증한다.

```js
// index.html 의 OPENDATE 구간을 추출해 순수 함수만 테스트한다.
// (Our_Budget 선례: 테스트 프레임워크 없이 인라인 JS 를 검증하는 방식)
const fs = require('fs');
const path = require('path');

const html = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');
const m = /\/\/ ── OPENDATE:START ──([\s\S]*?)\/\/ ── OPENDATE:END ──/.exec(html);
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

test('사람이 읽는 문구 — D-3 이 아니라 "3일 뒤"', () => {
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
```

- [ ] **Step 2: 테스트를 돌려 실패를 확인한다**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tests\run.js opendate.test.js`
Expected: FAIL — `index.html 에서 OPENDATE 경계 주석을 못 찾았다`

- [ ] **Step 3: `index.html` 에 계산 구간을 넣는다**

`</body>` 앞에 `<script>` 를 추가하고 그 안에 아래를 넣는다.

```html
<script>
// ── OPENDATE:START ── (tests/opendate.test.js 가 이 구간을 추출한다. 경계 주석을 지우지 말 것)

// 시간대는 폰의 로컬 시간(KST)을 그대로 쓴다. 서버가 없어 UTC 변환이 필요 없다.
function lastDayOfMonth(y, m) {            // m: 0-11
  return new Date(y, m + 1, 0).getDate();
}

function parseHM(t) {
  const p = String(t || '09:00').split(':');
  return [Number(p[0]) || 0, Number(p[1]) || 0];
}

function nextMonthlyOpen(rule, now) {
  const [hh, mi] = parseHM(rule.open_time);
  for (let i = 0; i < 3; i++) {
    const y = now.getFullYear(), m = now.getMonth() + i;
    // ⚠️ 말일 클램프 — '매월 31일' 이 2월을 만나면 말일로 당긴다.
    //    안 하면 그 달 표시가 조용히 사라진다 (설계서 §4.3).
    const day = Math.min(rule.day_of_month, lastDayOfMonth(y, m));
    const d = new Date(y, m, day, hh, mi, 0, 0);
    if (d >= now) return d;
  }
  return null;
}

function nextWeeklyOpen(rule, now) {
  const [hh, mi] = parseHM(rule.open_time);
  for (let i = 0; i < 8; i++) {
    const d = new Date(now.getFullYear(), now.getMonth(), now.getDate() + i, hh, mi, 0, 0);
    if (d.getDay() === rule.weekday && d >= now) return d;
  }
  return null;
}

// 규칙이 없거나 사람이 검토하지 않았으면(active=false) 날짜를 내주지 않는다.
// 옛 규칙으로 날짜를 계속 보여주는 것이 가장 나쁜 실패다 (설계서 §3.4).
function nextOpen(rule, now) {
  if (!rule || rule.active === false) return null;
  if (rule.freq === 'monthly') return rule.day_of_month ? nextMonthlyOpen(rule, now) : null;
  if (rule.freq === 'weekly')  return rule.weekday != null ? nextWeeklyOpen(rule, now) : null;
  return null;
}

function dayDiff(from, to) {               // 자정 기준 날짜 차
  const a = new Date(from.getFullYear(), from.getMonth(), from.getDate());
  const b = new Date(to.getFullYear(), to.getMonth(), to.getDate());
  return Math.round((b - a) / 86400000);
}

function clockText(d) {
  const h = d.getHours(), mi = d.getMinutes();
  const label = h === 0 ? '밤' : h < 12 ? '오전' : '오후';
  const h12 = h % 12 === 0 ? 12 : h % 12;
  return label + ' ' + h12 + '시' + (mi ? ' ' + mi + '분' : '');
}

// 부모님이 읽으실 문구. 'D-3' 같은 표기를 쓰지 않는다 (설계서 §5.1).
function humanWhen(open, now) {
  const n = dayDiff(now, open);
  if (n <= 0) return '오늘 ' + clockText(open) + '!';
  if (n === 1) return '내일 ' + clockText(open);
  return n + '일 뒤';
}

function formatOpen(d) {
  const w = ['일', '월', '화', '수', '목', '금', '토'][d.getDay()];
  return (d.getMonth() + 1) + '월 ' + d.getDate() + '일 (' + w + ') ' + clockText(d);
}
// ── OPENDATE:END ──
</script>
```

- [ ] **Step 4: 테스트를 다시 돌려 통과를 확인한다**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tests\run.js`
Expected: `20 passed, 0 failed` (parse-policy 7 + opendate 13)

- [ ] **Step 5: 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add index.html tests/opendate.test.js
git commit -m "feat: 다음 오픈일 계산 — 말일 클램프·주/월 단위·사람이 읽는 문구 (TDD)"
git push
```

---

### Task 7: 홈 화면 — 열자마자 보이는 즐겨찾기 목록

**Files:**
- Modify: `C:\Users\1226c\Projects\Hyuyangnim\index.html`

**Interfaces:**
- Consumes: Task 6 의 `nextOpen`/`humanWhen`/`formatOpen`, Task 5 의 Supabase 테이블
- Produces: 전역 `state = { forests:[], rules:{}, favorites:[] }`, `loadAll()`, `renderHome()`,
  `removeFavorite(forestId)`, `showToast(msg, undoFn)`, `deepLink(forest, rule)`.
  Task 8 이 `renderAdd()` 에서 `state`·`showToast`·`loadAll` 을 그대로 쓴다.

- [ ] **Step 1: Supabase 연결과 데이터 로드를 넣는다**

`<head>` 에 CDN 을 추가한다 (`Our_Budget` 과 동일한 방식):
```html
<script defer src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
```

`OPENDATE:END` 아래에 이어 붙인다. **`<URL>`·`<ANON>` 은 Task 5 Step 1 에서 받은 값으로 채운다.**

```js
const SUPABASE_URL  = "<URL>";
const SUPABASE_ANON = "<ANON>";
let sb = null;

const state = { forests: [], rules: {}, favorites: [] };

async function loadAll() {
  const [f, r, v] = await Promise.all([
    sb.from('forests').select('id,name,gubun,region,sigungu,hmpg_id'),
    sb.from('rules').select('forest_id,kind,freq,day_of_month,weekday,open_time,note,active').eq('active', true),
    sb.from('favorites').select('forest_id'),
  ]);
  if (f.error || r.error || v.error) throw (f.error || r.error || v.error);
  state.forests = f.data || [];
  state.rules = {};
  for (const x of (r.data || [])) state.rules[x.forest_id] = x;   // 휴양림당 활성 규칙 1개를 가정
  state.favorites = (v.data || []).map(x => x.forest_id);
}
```

⚠️ `rules` 는 `active=true` 만 가져온다. 검토 안 된 후보가 화면에 닿을 경로 자체를 없앤다.

- [ ] **Step 2: 딥링크와 정렬 규칙을 넣는다**

```js
// hmpgId 만 바꾸면 전 휴양림에 통용된다 (2026-08-03 실측).
function deepLink(forest, rule) {
  if (!forest.hmpg_id) {
    // ID 를 아직 못 구한 곳은 숲나들e 목록으로 보낸다. 막다른 길을 만들지 않는다.
    return 'https://www.foresttrip.go.kr/pot/is/fs/selectFcltSrchView.do?hmpgId=FRIP&menuId=002001';
  }
  if (rule && rule.kind === 'lottery') {
    return 'https://www.foresttrip.go.kr/rep/drlts/month/drltsMain.do?hmpgId=' + forest.hmpg_id + '&menuId=001003002';
  }
  return 'https://www.foresttrip.go.kr/rep/or/sssn/fcfsRsrvtPssblGoodsDetls.do?hmpgId=' + forest.hmpg_id + '&menuId=001001';
}

// 가까운 오픈일 순. '확인 중'(날짜 없음)은 맨 아래 (설계서 §5.1).
function favoriteCards(now) {
  return state.favorites
    .map(id => {
      const forest = state.forests.find(f => f.id === id);
      if (!forest) return null;
      const rule = state.rules[id] || null;
      return { forest, rule, open: nextOpen(rule, now) };
    })
    .filter(Boolean)
    .sort((a, b) => {
      if (a.open && b.open) return a.open - b.open;
      if (a.open) return -1;
      if (b.open) return 1;
      return a.forest.name.localeCompare(b.forest.name, 'ko');
    });
}
```

- [ ] **Step 3: 홈 화면 렌더와 큰 글씨 CSS 를 넣는다**

`<style>` 에 추가한다. 본문 18px·날짜 22px·터치 타깃 56px·고대비를 여기서 고정한다.

```css
:root { --fg:#111; --bg:#fff; --green:#1b5e20; --muted:#666; --line:#ddd; --warn:#b00020; }
body { font-size:19px; }
header { background:var(--green); color:#fff; padding:18px 16px; font-size:21px; font-weight:700; }
main { padding:12px 16px 96px; max-width:640px; margin:0 auto; }

.card { border:2px solid var(--line); border-radius:14px; padding:16px; margin:14px 0; }
.card .name { font-size:21px; font-weight:700; margin-bottom:6px; }
.card .when { font-size:26px; font-weight:800; line-height:1.3; color:var(--green); }
.card .sub  { font-size:18px; color:var(--muted); margin-top:4px; }
.card .pending { font-size:22px; font-weight:700; color:var(--muted); }

.row { display:flex; gap:10px; margin-top:14px; flex-wrap:wrap; }
.btn {
  min-height:56px; padding:0 20px; border-radius:12px; border:0;
  font-size:19px; font-weight:700; display:inline-flex; align-items:center;
  justify-content:center; text-decoration:none; cursor:pointer;
}
/* 주 버튼은 크고 진하게, '빼기'는 회색 아웃라인 — 오터치 방지를 확인창이 아니라 시각 위계로 한다 */
.btn-primary { background:var(--green); color:#fff; flex:1 1 auto; }
.btn-ghost   { background:#fff; color:var(--muted); border:2px solid var(--line); }
.btn-add {
  width:100%; min-height:64px; font-size:21px; margin-top:20px;
  background:#fff; color:var(--green); border:3px dashed var(--green);
}

#toast {
  position:fixed; left:16px; right:16px; bottom:20px; max-width:608px; margin:0 auto;
  background:#222; color:#fff; padding:16px; border-radius:12px; font-size:19px;
  display:none; align-items:center; justify-content:space-between; gap:12px;
}
#toast button { min-height:48px; padding:0 18px; font-size:19px; font-weight:700;
  border:0; border-radius:10px; background:#fff; color:#111; }
```

렌더 함수:

```js
const el = document.getElementById('app');
const esc = s => String(s).replace(/[&<>"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));

function renderHome() {
  const now = new Date();
  const cards = favoriteCards(now);

  if (!cards.length) {
    el.innerHTML = `<p style="font-size:20px">아직 고른 휴양림이 없어요.</p>
      <button class="btn btn-add" onclick="renderAdd()">＋ 휴양림 추가하기</button>`;
    return;
  }

  el.innerHTML = cards.map(({ forest, rule, open }) => {
    const kindWord = rule && rule.kind === 'lottery' ? '추첨' : '선착순';
    const body = open
      ? `<div class="when">${esc(formatOpen(open))}</div>
         <div class="sub">${esc(humanWhen(open, now))} · ${kindWord}</div>`
      // '오픈일 확인 중'은 예외가 아니라 1급 상태다 (설계서 §8). 경고 문구를 덧붙이지 않는다.
      : `<div class="pending">오픈일 확인 중</div>`;
    return `<div class="card">
      <div class="name">${esc(forest.name)}</div>
      ${body}
      <div class="row">
        <a class="btn btn-primary" href="${esc(deepLink(forest, rule))}" target="_blank" rel="noopener">
          ${open ? '예약하러 가기' : '예약 사이트'}</a>
        <button class="btn btn-ghost" onclick="removeFavorite(${forest.id})">빼기</button>
      </div>
    </div>`;
  }).join('') +
  `<button class="btn btn-add" onclick="renderAdd()">＋ 휴양림 추가하기</button>`;
}
```

- [ ] **Step 4: 빼기 + 되돌리기 토스트를 넣는다**

`<body>` 안 `</main>` 뒤에 토스트 자리를 만든다:
```html
<div id="toast"><span id="toast-msg"></span><button id="toast-undo">되돌리기</button></div>
```

```js
let toastTimer = null;

// 확인창을 겹겹이 두지 않는다. 즉시 삭제하고 8초 되돌리기를 준다 (설계서 §5.1).
function showToast(msg, undoFn) {
  const t = document.getElementById('toast');
  document.getElementById('toast-msg').textContent = msg;
  const btn = document.getElementById('toast-undo');
  btn.onclick = async () => { hideToast(); await undoFn(); };
  t.style.display = 'flex';
  clearTimeout(toastTimer);
  toastTimer = setTimeout(hideToast, 8000);
}
function hideToast() {
  clearTimeout(toastTimer);
  document.getElementById('toast').style.display = 'none';
}

async function removeFavorite(forestId) {
  const forest = state.forests.find(f => f.id === forestId);
  state.favorites = state.favorites.filter(id => id !== forestId);
  renderHome();
  await sb.from('favorites').delete().eq('forest_id', forestId);
  showToast((forest ? forest.name : '휴양림') + ' 을(를) 뺐어요', async () => {
    await sb.from('favorites').insert({ forest_id: forestId });
    await loadAll();
    renderHome();
  });
}
```

- [ ] **Step 5: 부팅 코드를 넣는다**

```js
// CDN 로드 실패 시 흰 화면 대신 알아볼 수 있는 안내를 띄운다 (Our_Budget 선례).
window.addEventListener('DOMContentLoaded', async () => {
  try {
    if (!window.supabase) throw new Error('연결 준비에 실패했어요. 잠시 뒤 다시 열어주세요.');
    sb = supabase.createClient(SUPABASE_URL, SUPABASE_ANON);
    await loadAll();
    renderHome();
  } catch (e) {
    el.innerHTML = `<div class="card"><div class="pending">지금은 열 수 없어요</div>
      <div class="sub">${esc(e.message || e)}</div></div>`;
  }
});
```

⚠️ 당겨서 새로고침 같은 제스처를 넣지 않는다. 앱을 열 때마다 자동 로드된다(설계서 §5.1).

- [ ] **Step 6: 문법 확인**

Run:
```bash
node -e "const h=require('fs').readFileSync('C:/Users/1226c/Projects/Hyuyangnim/index.html','utf8'); const m=[...h.matchAll(/<script(?![^>]*src)[^>]*>([\s\S]*?)<\/script>/g)]; m.forEach((x,i)=>{try{new Function(x[1]);console.log('script'+i+' OK')}catch(e){console.log('script'+i+' SYNTAX ERROR: '+e.message);process.exit(1)}})"
```
Expected: 각 인라인 `<script>` 에 대해 `OK`

- [ ] **Step 7: 계산 테스트가 여전히 통과하는지 확인**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tests\run.js`
Expected: `20 passed, 0 failed` — 경계 주석을 건드리지 않았다는 확인이다.

- [ ] **Step 8: 실기기 확인 (배포)**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add index.html
git commit -m "feat: 홈 화면 — 즐겨찾기 다음 오픈일·되돌리기 토스트·큰 글씨"
git push
```
1~2분 뒤 배포 URL 을 **폰 브라우저**에서 연다. 확인할 것:
- 축령산·영인산·서운산·강씨봉 4장이 보인다
- 날짜가 있는 카드가 위, `오픈일 확인 중` 이 아래
- 글씨가 작지 않다, 버튼이 손가락으로 눌린다
- `빼기` → 토스트 → `되돌리기` 로 복구된다

---

### Task 8: 추가 화면 — 3단 드릴다운 (타이핑 0회)

**Files:**
- Modify: `C:\Users\1226c\Projects\Hyuyangnim\index.html`

**Interfaces:**
- Consumes: Task 7 의 `state`, `loadAll`, `renderHome`, `showToast`, `esc`, `el`
- Produces: `renderAdd()`, `addFavorite(forestId)` — Task 7 의 `＋ 휴양림 추가하기` 버튼이 호출한다

- [ ] **Step 1: 드릴다운 CSS 를 넣는다**

```css
.grid { display:grid; grid-template-columns:1fr 1fr; gap:12px; }
.grid button {
  min-height:72px; font-size:20px; font-weight:700; border-radius:14px;
  border:2px solid var(--line); background:#fff; color:var(--fg); padding:8px; cursor:pointer;
}
.pick { display:block; width:100%; text-align:left; min-height:64px; font-size:20px;
  border-radius:14px; border:2px solid var(--line); background:#fff; color:var(--fg);
  padding:12px 16px; margin:10px 0; cursor:pointer; }
.pick.dim  { color:var(--muted); }         /* 규칙 없는 곳 — 아래로, 회색으로 */
.pick.on   { border-color:var(--green); color:var(--green); font-weight:800; }
.back { min-height:56px; font-size:19px; background:none; border:0; color:var(--green);
  font-weight:700; padding:0 4px; cursor:pointer; }
.step-title { font-size:23px; font-weight:800; margin:8px 0 16px; }
```

- [ ] **Step 2: 드릴다운 렌더를 넣는다**

⚠️ 화면을 새로 만들지 않는다. 같은 `#app` 안에서 단계만 바뀐다(설계서 §5.2).

```js
// 지역 단위는 숲나들e 표기를 그대로 쓴다 (서울인천경기 등 9개).
// 시군→도 매핑을 손으로 만들지 않기 위한 선택 — 부모님께는 오히려 익숙한 묶음이다.
const REGION_LABEL = {
  '서울인천경기': '서울·인천·경기', '강원': '강원', '충북': '충북',
  '대전충남': '대전·충남', '전북': '전북', '전남광주': '광주·전남',
  '대구경북': '대구·경북', '부산경남': '부산·경남', '제주': '제주',
};

let addStep = { region: null, sigungu: null };

function renderAdd() {
  addStep = { region: null, sigungu: null };
  renderAddStep();
}

function renderAddStep() {
  const { region, sigungu } = addStep;

  if (!region) {
    const regions = [...new Set(state.forests.map(f => f.region))]
      .sort((a, b) => Object.keys(REGION_LABEL).indexOf(a) - Object.keys(REGION_LABEL).indexOf(b));
    el.innerHTML =
      `<button class="back" onclick="renderHome()">← 뒤로</button>
       <div class="step-title">어디에 있나요?</div>
       <div class="grid">${regions.map(r =>
         `<button onclick="pickRegion('${esc(r)}')">${esc(REGION_LABEL[r] || r)}</button>`).join('')}</div>`;
    return;
  }

  if (!sigungu) {
    const list = [...new Set(state.forests.filter(f => f.region === region).map(f => f.sigungu))]
      .sort((a, b) => a.localeCompare(b, 'ko'));
    el.innerHTML =
      `<button class="back" onclick="renderAdd()">← 뒤로</button>
       <div class="step-title">${esc(REGION_LABEL[region] || region)} 어디?</div>
       <div class="grid">${list.map(s =>
         `<button onclick="pickSigungu('${esc(s)}')">${esc(s)}</button>`).join('')}</div>`;
    return;
  }

  // 3단: 규칙이 확인된 곳을 위에, '확인 중'은 회색으로 아래에 (설계서 §5.2)
  const items = state.forests
    .filter(f => f.region === region && f.sigungu === sigungu)
    .map(f => ({ f, has: !!state.rules[f.id], on: state.favorites.includes(f.id) }))
    .sort((a, b) => (b.has - a.has) || a.f.name.localeCompare(b.f.name, 'ko'));

  el.innerHTML =
    `<button class="back" onclick="pickRegion('${esc(region)}')">← 뒤로</button>
     <div class="step-title">${esc(sigungu)}</div>` +
    items.map(({ f, has, on }) =>
      `<button class="pick ${has ? '' : 'dim'} ${on ? 'on' : ''}" onclick="toggleFavorite(${f.id})">
         ${on ? '✓ ' : ''}${esc(f.name)}${has ? '' : '<br><span style="font-size:17px">오픈일 확인 중</span>'}
       </button>`).join('');
}

function pickRegion(r)  { addStep = { region: r, sigungu: null }; renderAddStep(); }
function pickSigungu(s) { addStep.sigungu = s; renderAddStep(); }
```

- [ ] **Step 3: 추가/해제 토글을 넣는다**

```js
async function toggleFavorite(forestId) {
  const on = state.favorites.includes(forestId);
  const forest = state.forests.find(f => f.id === forestId);

  if (on) {
    state.favorites = state.favorites.filter(id => id !== forestId);
    renderAddStep();
    await sb.from('favorites').delete().eq('forest_id', forestId);
    showToast(forest.name + ' 을(를) 뺐어요', async () => {
      await sb.from('favorites').insert({ forest_id: forestId });
      await loadAll(); renderAddStep();
    });
  } else {
    state.favorites.push(forestId);
    renderAddStep();
    await sb.from('favorites').insert({ forest_id: forestId });
    showToast(forest.name + ' 을(를) 담았어요', async () => {
      await sb.from('favorites').delete().eq('forest_id', forestId);
      await loadAll(); renderAddStep();
    });
  }
}
```

- [ ] **Step 4: 문법 확인**

Run: (Task 7 Step 6 과 동일한 명령)
Expected: 각 인라인 `<script>` 에 대해 `OK`

- [ ] **Step 5: 검색창이 없는지·타이핑 요소가 없는지 확인**

Run:
```bash
node -e "const h=require('fs').readFileSync('C:/Users/1226c/Projects/Hyuyangnim/index.html','utf8'); const bad=(h.match(/<input|<textarea|contenteditable/gi)||[]); console.log(bad.length?'⚠️ 타이핑 요소 발견: '+bad.join(','):'OK — 타이핑 0회')"
```
Expected: `OK — 타이핑 0회`

- [ ] **Step 6: 배포 및 실기기 확인**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git add index.html
git commit -m "feat: 추가 화면 — 지역·시군·휴양림 3단 드릴다운 (검색창 없음)"
git push
```
폰에서 확인: `＋ 휴양림 추가하기` → 9개 지역 버튼 → 시/군 → 휴양림 목록.
이미 담은 곳에 `✓`. 눌러서 해제되고 토스트로 되돌아온다. **키보드가 한 번도 안 뜬다.**

---

### Task 9: 주 1회 정책 감시 (`check.js`)

**왜 통합표 한 장만 감시하나:** Task 2 에서 전 휴양림 정책이 한 페이지에 있음이 확인됐다.
185개 개별 페이지를 도는 대신 이 한 장의 본문 해시를 비교한다 — 사이트 부담이 1/185 이고
변경 감지 범위는 오히려 넓다.

**Files:**
- Create: `C:\Users\1226c\Projects\Hyuyangnim\tools\check.js`

**Interfaces:**
- Consumes: `tools/lib/cdpx.js`, `tools/lib/parse-policy.js`, Supabase REST
- Produces: 콘솔 리포트 + `policy_snapshots` 갱신 + 바뀐 휴양림의 `rules.active = false`

- [ ] **Step 1: `.env.local` 에 Supabase 접속 정보를 둔다 (커밋 금지)**

`C:\Users\1226c\Projects\Hyuyangnim\.env.local`:
```
SUPABASE_URL=<URL>
SUPABASE_ANON=<ANON>
```
⚠️ `.gitignore` 에 이미 있다(Task 1). `git status` 에 뜨지 않는지 확인할 것.

- [ ] **Step 2: `tools/check.js` 작성**

```js
// 주 1회 정책 감시. 숲나들e 예약정책 통합표를 다시 긁어 지난번과 비교한다.
//   node tools/check.js
//
// 바뀐 휴양림은 즉시 rules.active=false 로 내려 '오픈일 확인 중' 이 되게 한다.
// ⚠️ 옛 규칙으로 날짜를 계속 보여주는 것이 가장 나쁜 실패다 (설계서 §3.4).
//    사람이 검토해 다시 active=true 로 올릴 때까지 그 휴양림 날짜는 안 뜬다 — 의도된 동작이다.
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
```

- [ ] **Step 3: 변경 없는 상태에서 돌려 오탐이 없는지 확인**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tools\check.js`
Expected: `변경 0 · 신규 0 · 사라짐 0`, 종료코드 0.
⚠️ 변경이 0 이 아니면 **파서가 불안정한 것**이다(정렬·공백 흔들림). 사이트 변경으로 결론짓기 전에
`rowKey` 정규화를 먼저 의심할 것.

- [ ] **Step 4: 변경 감지가 실제로 동작하는지 확인 (주입 테스트)**

```bash
node -e "const p='C:/Users/1226c/Projects/Hyuyangnim/data/policy-table.json';const d=require(p);const r=d.rows.find(x=>x.name.includes('영인산'));r.monthly='매월 9일 09시 오픈';require('fs').writeFileSync(p,JSON.stringify(d,null,2),'utf8');console.log('일부러 어긋나게 만들었다')"
node C:\Users\1226c\Projects\Hyuyangnim\tools\check.js
```
Expected: `변경 1`, `--- 영인산 자연휴양림` / `monthly: "매월 9일 09시 오픈" → ""`,
`→ active=false 처리`, 종료코드 2.

이어서 홈 화면을 폰에서 새로고침하면 **영인산이 `오픈일 확인 중`으로 바뀌어 있어야 한다.**
확인 후 되돌린다:
```sql
update rules set active = true, conflict = null
from forests f where rules.forest_id = f.id and f.name like '%영인산%';
```

- [ ] **Step 5: Windows 작업 스케줄러에 주 1회 등록**

```powershell
$act = New-ScheduledTaskAction -Execute "node.exe" `
  -Argument "C:\Users\1226c\Projects\Hyuyangnim\tools\check.js" `
  -WorkingDirectory "C:\Users\1226c\Projects\Hyuyangnim"
$trg = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 8am
Register-ScheduledTask -TaskName "Hyuyangnim 정책감시" -Action $act -Trigger $trg -Description "숲나들e 예약정책 통합표 주 1회 감시"
```

확인: `Get-ScheduledTask -TaskName "Hyuyangnim 정책감시" | Select-Object TaskName, State`
Expected: `State = Ready`

- [ ] **Step 6: 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git status --short    # ⚠️ .env.local 이 목록에 없어야 한다
git add tools/check.js data/policy-table.json
git commit -m "feat: 주 1회 정책 감시 — 통합표 변경 시 해당 휴양림 자동 중단"
git push
```

---

### Task 10: 부모님 폰에 올리기 + 마무리

**Files:**
- Create: `C:\Users\1226c\Projects\Hyuyangnim\PROGRESS.md` (git 미추적)
- Modify: `C:\Users\1226c\Projects\Hyuyangnim\CLAUDE.md`
- Modify: `C:\Users\1226c\Projects\CLAUDE.md` 상위 `README.md` 현황표

- [ ] **Step 1: 전체 테스트와 문법 확인을 한 번에 돌린다**

Run: `node C:\Users\1226c\Projects\Hyuyangnim\tests\run.js`
Expected: `20 passed, 0 failed`

Run: (Task 7 Step 6 의 문법 확인 명령)
Expected: 모든 `<script>` `OK`

Run: (Task 8 Step 5 의 타이핑 요소 확인 명령)
Expected: `OK — 타이핑 0회`

- [ ] **Step 2: 실기기 최종 점검 목록을 직접 확인한다**

폰 브라우저로 배포 URL 을 열고 하나씩:
- [ ] 열자마자 즐겨찾기 4곳의 다음 오픈일이 보인다 (스크롤·탭 없이)
- [ ] 가장 가까운 오픈일이 맨 위, `오픈일 확인 중` 이 맨 아래
- [ ] 날짜 줄이 크고 굵다. 팔을 뻗은 거리에서 읽힌다
- [ ] `예약하러 가기` 가 해당 휴양림 예약 페이지로 간다 (4곳 전부)
- [ ] `빼기` → 8초 토스트 → `되돌리기` 로 복구
- [ ] 추가 화면에서 키보드가 한 번도 안 뜬다
- [ ] 화면이 홈·추가 2개뿐이다 (설정 화면이 없다)

- [ ] **Step 3: 🙋 부모님 폰 두 대에 홈 화면 아이콘 추가 (사용자 작업)**

```
아이폰(Safari):   배포 URL 열기 → 공유 버튼 → '홈 화면에 추가'
안드로이드(Chrome): 배포 URL 열기 → ⋮ → '홈 화면에 추가'
```
⚠️ 알림이 없으므로 **"열기 쉬움"이 유일한 안전장치**다(설계서 §3.1).
아이콘이 첫 화면에 있는지까지 확인할 것.

- [ ] **Step 4: 기기 간 공유가 실제로 되는지 확인**

한쪽 폰에서 휴양림을 하나 추가 → **다른 쪽 폰에서 새로고침** → 같은 휴양림이 보이는지 확인.
설계서 §3.3 의 핵심 요구사항이다. 확인 후 테스트용 항목은 뺀다.

- [ ] **Step 5: `PROGRESS.md` 작성**

남은 일과 판단이 필요했던 곳을 기록한다. 최소한 아래를 담는다:
- 축령산 1일/7일 판정 결과와 근거 (또는 미판정 상태)
- `active=true` 인 휴양림 목록과 `verified_at`
- `hmpg_id` 를 못 구한 휴양림 수
- 다음에 규칙을 채울 후보 (부모님이 즐겨찾기에 담으신 미확인 휴양림)

- [ ] **Step 6: `CLAUDE.md` 현황 갱신**

`## 현황 (2026-08-03) 설계 확정 — 코드 없음` 을 실제 상태로 바꾼다.
배포 URL·Supabase 프로젝트·주요 스크립트 사용법을 담는다.
⚠️ **Write 로 전체 재작성**할 것 (Edit 도구가 한글을 망가뜨린 전례).

- [ ] **Step 7: 상위 `README.md` 현황표에 추가**

`C:\Users\1226c\Projects\README.md` 의 프로젝트 표에 Hyuyangnim 행을 추가/갱신한다
(상위 `CLAUDE.md` 의 PM 규약).

- [ ] **Step 8: 최종 커밋**

```bash
cd "C:/Users/1226c/Projects/Hyuyangnim"
git status --short          # ⚠️ .env.local · .mcp.json · PROGRESS.md 가 없어야 한다
git add CLAUDE.md
git commit -m "docs: 현황을 '배포 완료'로 갱신"
git push
```

---

## Self-Review

**1. 설계서 커버리지**

| 설계서 절 | 담당 태스크 |
|---|---|
| §1 무엇을 만드나 / 경계선 | Global Constraints |
| §2.1 규칙 형태가 휴양림마다 다름 | Task 2 (파서가 monthly/weekly 둘 다), Task 6 (계산 둘 다) |
| §2.2 추첨은 크롤링 불가 | Task 5 (`apply_end_day`/`result_day` 미생성), Global Constraints |
| §2.3 딥링크 | Task 7 Step 2 `deepLink()` |
| §2.4 본문 해시로 변경 감지 | Task 9 (표 셀 기반 `rowKey` 로 더 정밀하게) |
| §3.1 알림 없음 · `manifest.json` | Task 1 Step 5, Task 10 Step 3 |
| §3.2 목록은 전국, 규칙은 확인분만 | Task 5 (`active` 기본 false), Task 7 Step 1 (`.eq('active',true)`) |
| §3.3 즐겨찾기 공유 저장소 | Task 5 (`favorites`), Task 10 Step 4 (기기 간 확인) |
| §3.4 정책 변경 시 자동 중단 | Task 9 Step 2·4 |
| §4.1 산출물 · `worker.js` 미생성 | File Structure, Task 1 Step 10 |
| §4.2 데이터 모델 | Task 5 Step 2 (`sido`→`region`, 추첨 컬럼 보류 — 이유 명기) |
| §4.3 다음 오픈일 계산 · 말일 클램프 | Task 6 (전용 테스트 있음) |
| §5.1 홈 화면 | Task 7 |
| §5.2 3단 드릴다운 · 검색창 없음 | Task 8 (Step 5 에서 기계적으로 검증) |
| §5.3 문구 규칙 | Global Constraints, Task 7·8 의 문구 |
| §6 `check.js` | Task 9 |
| §7 개발 환경 | Global Constraints |
| §8 미확인 6가지 | 강씨봉 ID → Task 4 / 서운산 규칙 → **이미 해결(발견 2)** / 표준데이터 2건 → **범위에서 제외(이유 명기)** / 커버리지 → **186 실측 완료** / 본문 셀렉터 → Task 9 (셀 단위라 셀렉터 문제 자체가 없어짐) |

**미커버 항목:** 없음. 단 설계서 §8 의 `data.go.kr` 관련 2건은 **의도적으로 범위 밖**으로 옮겼고
그 이유를 "이 계획이 설계서에서 벗어나는 곳" 에 적었다. 주소·전화가 필요해지면 별도 계획으로 붙인다.

**2. 플레이스홀더 점검**

`<URL>`·`<ANON>`(Supabase 키)과 Task 3 Step 4 의 판정값은 **의도적으로 비어 있다** — 각각
사용자에게 받아야 하고(Task 5 Step 1), 사람이 판정해야 하는 값이다(Task 3 Step 3).
그 외 TBD·"적절히 처리"·"Task N 과 유사" 없음. 코드가 필요한 단계엔 전부 실제 코드가 있다.

**3. 타입 일관성 확인**

- `Row` 필드명(`gubun/region/sigungu/name/room/camp/wait/weekly/monthly/lottery/priority`)이
  Task 2 파서 → Task 5 `build-seed.js` → Task 9 `rowKey` 에서 동일하다 ✅
- `Rule` 필드명(`freq/day_of_month/weekday/open_time/active/kind`)이 Task 2 `toRule` →
  Task 5 `schema.sql`·`build-seed.js` → Task 6 `nextOpen` → Task 7 `state.rules` 에서 동일하다 ✅
- `withPage(url, fn, opts)` 시그니처가 Task 1 정의 → Task 2·4·9·make-icons 사용처에서 동일하다 ✅
- `showToast(msg, undoFn)` 이 Task 7 정의 → Task 8 사용에서 동일하다 ✅
- `weekday` 는 **0=일요일** 로 일관 (`schema.sql` 주석 · `WEEKDAY` 상수 · `Date.getDay()`) ✅
- `forests.name` 이 `unique` 이고 `build-seed.js` 의 `on conflict (name)` 과 맞는다 ✅
