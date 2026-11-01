// tool/check_budgets.mjs — Wave 4 performance + accessibility budget gate.
//
// The site's law (design-flagship-plan.md, "Budgets as features"):
// CWV p75 targets — LCP <= 2.5s (aim 1.8), INP <= 200ms (aim 150; in the
// lab we measure its proxy, TBT), CLS <= 0.1 (aim 0.04) — plus zero axe
// failures (Lighthouse's accessibility category is axe-based; a score
// of 100 means every audit passed).
//
// Lighthouse lab numbers on ubuntu runners carry ~10-15% noise, so
// budgets assert at the ceiling with documented headroom below it.
// Thresholds live HERE and nowhere else — one file to tune on
// evidence, never hand-waved per page.
//
// Usage (from the repository root, site already served):
//   node tool/check_budgets.mjs [baseUrl]
// Exit 0 = pass, 1 = fail.

import { execFileSync } from 'node:child_process';

const baseUrl = process.argv[2] || 'http://localhost:4173';

// The budget law. Values: ms for LCP/TBT, unitless for CLS,
// 0-100 for the accessibility category (100 = zero axe failures).
const BUDGETS = {
  lcp: 2500,
  tbt: 200,
  cls: 0.1,
  accessibility: 100,
};

// Aims are printed for context but do not fail the run — the ceiling
// is the gate, the aim is the direction.
const AIMS = { lcp: 1800, tbt: 150, cls: 0.04, accessibility: 100 };

const PAGES = [
  { path: '/', label: 'Home' },
  { path: '/explorer.html', label: 'Explorer' },
  { path: '/api.html', label: 'API' },
  { path: '/brand.html', label: 'Brand' },
];

function metric(report, auditId, fallback) {
  const audit = report.audits && report.audits[auditId];
  return audit && typeof audit.numericValue === 'number'
    ? audit.numericValue
    : fallback;
}

// Evidence, not mystery: when a page busts a budget, the annotations
// must name the failing audits and the LCP element, so the fix starts
// from the report instead of a re-run guessing game.
function failingAudits(report) {
  const cat = report.categories && report.categories.accessibility;
  if (!cat || !cat.auditRefs) return [];
  return cat.auditRefs
    .map((ref) => ref.id)
    .filter((id) => report.audits[id] && report.audits[id].score !== null &&
      report.audits[id].score < 1)
    .map((id) => ({
      id,
      title: report.audits[id].title,
      detail: report.audits[id].displayValue || '',
    }));
}

function lcpElement(report) {
  const audit = report.audits && report.audits['largest-contentful-paint-element'];
  const items = audit && audit.details && audit.details.items;
  const first = items && items[0];
  return first && first.items && first.items[0]
    ? first.items[0].node && (first.items[0].node.snippet || first.items[0].node.selector)
    : 'unknown';
}

const failures = [];
const rows = [];
for (const page of PAGES) {
  const url = baseUrl + page.path;
  const raw = execFileSync('lighthouse', [
    url,
    '--output=json',
    '--output-path=stdout',
    '--quiet',
    '--only-categories=performance,accessibility',
    '--chrome-flags=--headless=new --no-sandbox',
  ], { encoding: 'utf8', maxBuffer: 64 * 1024 * 1024 });
  const report = JSON.parse(raw);

  const lcp = metric(report, 'largest-contentful-paint', Infinity);
  const tbt = metric(report, 'total-blocking-time', Infinity);
  const cls = metric(report, 'cumulative-layout-shift', Infinity);
  const a11y = report.categories && report.categories.accessibility
    ? Math.round(report.categories.accessibility.score * 100)
    : 0;

  const row = {
    page: page.label,
    lcp: Math.round(lcp),
    tbt: Math.round(tbt),
    cls: Number(cls.toFixed(3)),
    a11y,
    lcpOk: lcp <= BUDGETS.lcp,
    tbtOk: tbt <= BUDGETS.tbt,
    clsOk: cls <= BUDGETS.cls,
    a11yOk: a11y >= BUDGETS.accessibility,
  };
  rows.push(row);

  for (const [key, ok, unit] of [
    ['LCP', row.lcpOk, 'ms'],
    ['TBT', row.tbtOk, 'ms'],
    ['CLS', row.clsOk, ''],
    ['a11y', row.a11yOk, '/100'],
  ]) {
    if (!ok) {
      const value = key === 'CLS' ? row.cls : key === 'a11y' ? row.a11y
        : key === 'LCP' ? row.lcp : row.tbt;
      const ceiling = key === 'CLS' ? BUDGETS.cls : key === 'a11y'
        ? BUDGETS.accessibility : key === 'LCP' ? BUDGETS.lcp : BUDGETS.tbt;
      failures.push(
        `${page.label}: ${key} ${value}${unit} exceeds the budget ${ceiling}${unit} (aim ${key === 'CLS' ? AIMS.cls : key === 'a11y' ? AIMS.accessibility : key === 'LCP' ? AIMS.lcp : AIMS.tbt}${unit}).`,
      );
    }
  }

  // Evidence per failure: the axe audits that failed, and the element
  // Lighthouse blames for LCP. Annotations carry it to the PR.
  if (!row.a11yOk) {
    for (const a of failingAudits(report)) {
      console.error(
        `::error::${page.label} a11y audit failed: ${a.id} — ${a.title}${a.detail ? ' (' + a.detail + ')' : ''}`,
      );
    }
  }
  if (!row.lcpOk) {
    console.error(`::error::${page.label} LCP element: ${lcpElement(report)}`);
  }
}

console.log('page       LCP(ms)  TBT(ms)  CLS     a11y');
for (const r of rows) {
  console.log(
    `${r.page.padEnd(10)} ` +
    `${String(r.lcp).padEnd(8)} ${String(r.tbt).padEnd(8)} ` +
    `${String(r.cls).padEnd(7)} ${r.a11y}/100`,
  );
}
console.log(`budgets: LCP <= ${BUDGETS.lcp}ms (aim ${AIMS.lcp}), TBT <= ${BUDGETS.tbt}ms (aim ${AIMS.tbt}), CLS <= ${BUDGETS.cls} (aim ${AIMS.cls}), a11y = ${BUDGETS.accessibility}/100`);

if (failures.length > 0) {
  for (const f of failures) {
    console.error('::error::budget exceeded: ' + f);
  }
  console.error(`${failures.length} budget(s) exceeded.`);
  process.exit(1);
}
console.log('BUDGETS OK: all pages within the law.');
