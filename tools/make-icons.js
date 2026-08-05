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
      // ⚠️ svg{display:block} + overflow:hidden 이 없으면 인라인 SVG 의 baseline 여백이
      //    넘쳐 스크롤바가 생기고, 그게 아이콘 가장자리에 회색 띠로 찍힌다 (2026-08-05 실측).
      `<style>html,body{margin:0;padding:0;background:transparent;overflow:hidden}` +
      `svg{display:block}</style>` + svg(size);
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
