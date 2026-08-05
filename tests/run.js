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
