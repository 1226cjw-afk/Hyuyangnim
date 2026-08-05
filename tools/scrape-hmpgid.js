// 숲나들e 자연휴양림안내 목록(총 186곳 / 47페이지)에서 이름 ↔ hmpgId 를 모은다.
// 1회성 스크립트. 새 휴양림이 생기면 다시 돌린다.
//   node tools/scrape-hmpgid.js
//
// 출처: https://www.foresttrip.go.kr/pot/is/fs/selectFcltSrchView.do?hmpgId=FRIP&menuId=002001
//
// ⚠️ 2026-08-05 실측 — 계획서의 추측과 세 곳이 달랐다:
//   1) 카드 링크에 `hmpgId=ID...` 가 없다. 프래그먼트다:
//        <a href="#ID02030002"><span class="mr_reg">공</span> <b>가리산 자연휴양림</b></a>
//      그래서 `hmpgId=(ID...)` 정규식은 0건이었다.
//      이름은 <b> 에서 가져온다 — <span class="mr_reg"> 의 국/공/사 글자가 섞이지 않게.
//   2) 페이징 함수는 fn_search 도 goPage 도 아닌 `fn_goPage(pageNum)` 이다.
//        function fn_goPage(pageNum){ $("#nowPage").val(pageNum); fn_goSrch(); }
//   3) ⚠️ 국립은 ID 형식이 다르다. `#ID02030050`(공립·사립) 이 아니라 **4자리 숫자** `#0304` 다.
//      `^#(ID...)$` 로만 읽으면 국립 48곳이 통째로 빠진다(첫 실행에서 137/186 만 나온 원인).
//      그 숫자가 그대로 hmpgId 다 — 사이트 자신의 공지 링크가 `hmpgId=0304` 을 쓴다.
//        홈페이지: http://www.foresttrip.go.kr/0304
//        공지:     /pot/cc/nm/selectNticBbrssDtlView.do?hmpgId=0304&menuId=005001
//      그래서 셀렉터는 "<b> 자식을 가진 #앵커" 로 잡는다 — UI 앵커(#goPage·#addIntrsRcrfr)는
//      <b> 가 없어 자연히 걸러진다.
const fs = require('fs');
const path = require('path');
const { withPage, sleep } = require('./lib/cdpx');

const LIST_URL =
  'https://www.foresttrip.go.kr/pot/is/fs/selectFcltSrchView.do?hmpgId=FRIP&menuId=002001';
const OUT = path.join(__dirname, '..', 'data', 'hmpgid-map.json');

// 목록 카드에서 (이름, hmpgId) 쌍을 뽑는다.
// 카드 제목 앵커만이 <b> 를 품는다: <a href="#0304"><span>국</span> <b>김천숲속야영장</b></a>
const HARVEST = `(()=>{
  const out=[];
  for(const a of document.querySelectorAll('a[href^="#"]')){
    const b=a.querySelector('b');
    if(!b) continue;                                   // UI 앵커(#goPage 등)를 거른다
    const id=(a.getAttribute('href')||'').slice(1);
    if(!/^(ID)?[0-9A-Za-z]+$/.test(id)) continue;
    const name=(b.textContent||'').replace(/\\s+/g,' ').trim();
    if(name) out.push([name,id]);
  }
  return JSON.stringify(out);
})()`;

// "시설정보 3/47" 의 현재 페이지 번호. 페이징이 실제로 넘어갔는지 확인하는 데 쓴다.
const CURPAGE = `(()=>{const m=document.body.innerText.match(/시설정보\\s*(\\d+)\\/(\\d+)/);
  return m?JSON.stringify([Number(m[1]),Number(m[2])]):'null';})()`;

(async () => {
  const map = {};
  const missed = [];

  await withPage(LIST_URL, async ({ ev }) => {
    const first = JSON.parse(await ev(CURPAGE) || 'null');
    if (!first) throw new Error('페이지 표시("시설정보 n/m")를 못 찾았다 — 목록 구조가 바뀌었다');
    const totalPages = first[1];
    const total = Number((await ev(`(document.body.innerText.match(/총\\s*(\\d+)곳/)||[])[1]||'0'`)) || 0);
    console.log('총 ' + total + '곳 / ' + totalPages + '페이지');

    for (let p = 1; p <= totalPages; p++) {
      if (p > 1) {
        await ev(`fn_goPage(${p})`);
        // ⚠️ 고정 대기만 믿으면 안 된다. 페이지 표시가 실제로 바뀔 때까지 확인한다.
        //    안 그러면 같은 페이지를 47번 수확하고도 조용히 성공한 것처럼 보인다.
        let ok = false;
        for (let i = 0; i < 20; i++) {
          await sleep(700);
          const cur = JSON.parse(await ev(CURPAGE) || 'null');
          if (cur && cur[0] === p) { ok = true; break; }
        }
        if (!ok) { missed.push(p); console.log('p' + p + ' ⚠️ 이동 실패 — 건너뜀'); continue; }
      }

      const pairs = JSON.parse(await ev(HARVEST) || '[]');
      for (const [name, id] of pairs) if (!map[name]) map[name] = id;
      console.log('p' + p + ' +' + pairs.length + ' 누적 ' + Object.keys(map).length);
      await sleep(1200); // 사이트 부담 방지
    }
  }, { port: 9343 });

  fs.mkdirSync(path.dirname(OUT), { recursive: true });
  fs.writeFileSync(OUT, JSON.stringify({
    scraped_at: new Date().toISOString().slice(0, 10),
    source: LIST_URL,
    map,
  }, null, 2), 'utf8');
  console.log('WROTE', OUT, 'names=', Object.keys(map).length);
  if (missed.length) console.log('⚠️ 이동 실패 페이지:', missed.join(', '));
})().catch(e => { console.error('ERR', e); process.exit(1); });
