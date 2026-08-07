// 배포. 앱 파일 4개만 따로 담아 Cloudflare Workers 로 올린다.
//   node tools/deploy.js
//
// ⚠️ 자동배포(Git 연동)는 없다 — git push 만으로는 부모님 폰에 반영되지 않는다.
// ⚠️ 리포 루트를 통째로 올리지 말 것. 2026-08-05 첫 배포가 그래서
//    https://hyuyangnim.1226cjw.workers.dev/CLAUDE.md 가 열렸다 (2026-08-07 실측).
//    .assetsignore 로 거르는 방법은 wrangler 4.119.0 에서 동작하지 않는다 — 폴더를 나누는 게 답이다.
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { execSync } = require('child_process');

const ROOT = path.join(__dirname, '..');
const STAGE = path.join(ROOT, '.deploy');            // .gitignore 에 있다
const FILES = ['index.html', 'manifest.json', 'icon-192.png', 'icon-512.png'];
const WRANGLER = 'wrangler@4.119.0';                 // ⚠️ 버전 고정 — 무버전은 갓 나온 판을 받다 404 로 죽는다

fs.rmSync(STAGE, { recursive: true, force: true });
fs.mkdirSync(STAGE, { recursive: true });
for (const f of FILES) fs.copyFileSync(path.join(ROOT, f), path.join(STAGE, f));
console.log('스테이징 ' + FILES.length + '개 → ' + STAGE);

// npx 는 Windows 에서 .cmd 라 shell 이 필요하다 → 인자 배열 대신 한 줄 문자열로 넘긴다
execSync(`npx ${WRANGLER} deploy --assets="${STAGE}" --name=hyuyangnim --compatibility-date=2026-08-07`,
  { stdio: 'inherit' });

// ⚠️ "Deployed" 로그는 배포 성공의 증거가 아니다. 실물을 받아 **로컬과 해시까지 대조**한다.
// ⚠️ "supabase 가 들어있고 1만 자 넘으면 OK" 같은 헐거운 검사를 쓰지 말 것 —
//    2026-08-07 에 그 검사가 실물 14877자 ≠ 로컬 15043자 인 배포를 '✅' 로 통과시켰다.
// 배포 직후엔 엣지 캐시가 옛 응답을 잠깐 더 주므로 같아질 때까지 몇 번 다시 받는다.
const sha = b => crypto.createHash('sha256').update(b).digest('hex');
const sleep = ms => new Promise(r => setTimeout(r, ms));

(async () => {
  const local = fs.readFileSync(path.join(ROOT, 'index.html'));
  for (let i = 1; i <= 10; i++) {
    const live = Buffer.from(await (await fetch(
      'https://hyuyangnim.1226cjw.workers.dev/index.html?z=' + Date.now())).arrayBuffer());
    if (sha(live) === sha(local)) {
      console.log('\n✅ 배포 확인 — 실물이 로컬 index.html 과 바이트 단위로 같다 (' + local.length + 'B)');
      console.log('렌더까지 보려면: node scratch/check-live.js');
      return;
    }
    console.log('  (' + i + '/10) 실물 ' + live.length + 'B ≠ 로컬 ' + local.length + 'B — 엣지 캐시일 수 있다, 3초 뒤 다시');
    await sleep(3000);
  }
  console.error('\n❌ 실물이 로컬과 끝내 달랐다. npx wrangler@4.119.0 deployments list --name hyuyangnim 로 버전 확인');
  process.exit(1);
})();
