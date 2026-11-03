// docs/smoke.cjs — explorer smoke test (no browser, no npm deps).
//
// Loads the REAL docs/app.js in Node with minimal browser stubs and runs
// the full explorer flow: fetch → filters → stats → table → pagination.
// Catches ReferenceError/scope bugs that `node --check` (syntax-only)
// cannot catch — e.g. module-scope callers using initExplorer-scoped
// helpers (the `escapeHtml is not defined` outage).
//
// Usage (from repo root): node docs/smoke.cjs
// Exit 0 = pass, 1 = fail. Runs in CI (see .github/workflows/dart.yml).
const fs = require('fs');
const vm = require('vm');
const path = require('path');

const ROOT = __dirname;
const data = JSON.parse(fs.readFileSync(path.join(ROOT, 'data.json'), 'utf8'));
const appSrc = fs.readFileSync(path.join(ROOT, 'app.js'), 'utf8');

function makeEl() {
  const el = {
    children: [],
    dataset: {},
    style: {},
    _text: '',
    _html: '',
    classList: {
      _s: new Set(),
      toggle(c, force) {
        if (force === undefined) {
          if (this._s.has(c)) this._s.delete(c);
          else this._s.add(c);
        } else if (force) this._s.add(c);
        else this._s.delete(c);
      },
      add(c) { this._s.add(c); },
      remove(c) { this._s.delete(c); },
      contains(c) { return this._s.has(c); },
    },
    set textContent(v) {
      this._text = String(v);
      this._html = String(v)
        .replace(/&/g, '&amp;').replace(/</g, '&lt;')
        .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    },
    get textContent() { return this._text; },
    set innerHTML(v) { this._html = String(v); },
    get innerHTML() { return this._html; },
    appendChild(c) { this.children.push(c); return c; },
    addEventListener() {},
    querySelectorAll() { return []; },
    querySelector() { return null; },
    setAttribute() {},
    getAttribute() { return null; },
    scrollIntoView() {},
    blur() {},
  };
  return el;
}

const elements = {
  'search-input': makeEl(),
  'province-filter': makeEl(),
  'district-filter': makeEl(),
  'type-filter': makeEl(),
  'map-status': makeEl(),
  'theme-toggle': null,
  'nav-menu': null,
  'retry-load': null,
};
elements['search-input'].value = '';
elements['province-filter'].value = '';
elements['district-filter'].value = '';
elements['type-filter'].value = '';
const tableBody = makeEl();
const statsEl = makeEl();
const paginationEl = makeEl();

const sandbox = {
  console,
  document: {
    querySelector(sel) {
      if (sel === '.explorer-table') return makeEl();
      if (sel === '.explorer-table tbody') return tableBody;
      if (sel === '.explorer-stats') return statsEl;
      if (sel === '.pagination') return paginationEl;
      if (sel === '.header') return null;
      if (sel === '.toast') return null;
      if (sel === '#map') return null; // map short-circuits (no map engine here)
      if (sel === '.nav-toggle') return null;
      if (sel === '#nav-menu') return null;
      return null;
    },
    querySelectorAll(sel) {
      if (sel === '.nav-link') return [];
      if (sel === 'a[href^="#"]') return [];
      if (sel === 'img[data-logo-light]') return [];
      return [];
    },
    getElementById(id) { return elements[id] || null; },
    createElement() { return makeEl(); },
    addEventListener() {},
    head: makeEl(),
    body: makeEl(),
    documentElement: { classList: makeEl().classList, setAttribute() {} },
  },
  window: {
    location: { search: '', pathname: '/explorer.html' },
    matchMedia: () => ({ matches: false }),
    scrollTo() {},
    addEventListener() {},
  },
  localStorage: {
    _s: {},
    getItem(k) { return this._s[k] ?? null; },
    setItem(k, v) { this._s[k] = v; },
  },
  fetch: () => Promise.resolve({ ok: true, json: () => Promise.resolve(data) }),
  requestAnimationFrame: (fn) => { fn(); return 0; },
  IntersectionObserver: function () { this.observe = () => {}; },
  URLSearchParams,
};
sandbox.globalThis = sandbox;
vm.createContext(sandbox);

(async () => {
  vm.runInContext(appSrc, sandbox, { filename: 'app.js' });
  await new Promise((r) => setTimeout(r, 100));
  const assert = require('assert');
  assert.ok(
    statsEl.innerHTML.includes(`Total: <strong>${data.length}</strong>`),
    'stats rendered, got: ' + statsEl.innerHTML.slice(0, 120));
  assert.ok(
    tableBody.innerHTML.includes('type-badge'),
    'rows rendered with badges');
  assert.ok(
    !tableBody.innerHTML.includes('Failed to load') &&
      !tableBody.innerHTML.includes('failed to render'),
    'no error UI, got: ' + tableBody.innerHTML.slice(0, 200));
  assert.ok(
    tableBody.innerHTML.includes('type-rural'),
    'rural chips use the type-rural class');
  assert.ok(
    Array.isArray(sandbox.MAP_OVERLAYS),
    'MAP_OVERLAYS overlay registry exists');
  assert.ok(
    typeof sandbox.loadOverlay === 'function' &&
      typeof sandbox.setOverlayVisible === 'function' &&
      typeof sandbox.updateOverlayToggles === 'function',
    'overlay loader and toggle API present');
  assert.ok(
    sandbox.MAP_OVERLAYS.some((o) => o.id === 'protected-areas'),
    'protected-areas overlay registered');
  const pa = JSON.parse(fs.readFileSync(path.join(ROOT, 'protected-areas.geojson'), 'utf8'));
  assert.ok(
    Array.isArray(pa.features) && pa.features.length === 20,
    'protected-areas ships 20 core units, got: ' + (pa.features && pa.features.length));
  const expectedPaIds = [
    'chitwan-np', 'bardiya-np', 'banke-np', 'khaptad-np', 'langtang-np',
    'rara-np', 'sagarmatha-np', 'shey-phoksundo-np', 'shivapuri-nagarjun-np',
    'makalu-barun-np', 'parsa-np', 'shuklaphanta-np', 'annapurna-ca',
    'kanchenjunga-ca', 'manaslu-ca', 'gaurishankar-ca', 'api-nampa-ca',
    'krishnasar-ca', 'koshi-tappu-wr', 'dhorpatan-hr',
  ];
  const paIds = new Set(pa.features.map((f) => f.properties && f.properties.id));
  for (const id of expectedPaIds) {
    assert.ok(paIds.has(id), 'protected-areas completeness: missing ' + id);
  }
  for (const f of pa.features) {
    assert.ok(
      f.geometry && Array.isArray(f.geometry.coordinates) && f.geometry.coordinates.length,
      'protected-area feature has geometry: ' + (f.properties && f.properties.id));
  }
  assert.ok(
    sandbox.MAP_OVERLAYS.some((o) => o.id === 'national-outline'),
    'national-outline overlay registered');
  const outline = JSON.parse(fs.readFileSync(path.join(ROOT, 'national-outline.geojson'), 'utf8'));
  const outlineFeature = outline.features && outline.features[0];
  assert.ok(outlineFeature, 'national outline ships a feature');
  const outlineRing = outlineFeature.geometry &&
    outlineFeature.geometry.coordinates && outlineFeature.geometry.coordinates[0];
  assert.ok(
    Array.isArray(outlineRing) && outlineRing.length > 1000,
    'outline ring is high-resolution, got: ' + (outlineRing && outlineRing.length));
  function pointInRing(pt, r) {
    let inside = false;
    const x = pt[0], y = pt[1];
    for (let i = 0, j = r.length - 1; i < r.length; j = i++) {
      const xi = r[i][0], yi = r[i][1], xj = r[j][0], yj = r[j][1];
      if (((yi > y) !== (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) inside = !inside;
    }
    return inside;
  }
  assert.ok(
    pointInRing([81.023, 30.222], outlineRing),
    'outline includes Lipulekh Pass (post-May-2020 map)');
  assert.ok(
    pointInRing([80.95, 30.20], outlineRing),
    'outline includes Kalapani');
  assert.ok(
    pointInRing([85.3240, 27.7172], outlineRing),
    'outline includes Kathmandu');
  assert.ok(
    sandbox.MAP_OVERLAYS.some((o) => o.id === 'nh01-highway'),
    'NH01 highway overlay registered');
  const nh01 = JSON.parse(fs.readFileSync(path.join(ROOT, 'nh01-highway.geojson'), 'utf8'));
  const nh01Meta = nh01.metadata || {};
  assert.ok(
    Array.isArray(nh01.features) && nh01.features.length >= 50,
    'NH01 ships its member ways, got: ' + (nh01.features && nh01.features.length));
  assert.ok(
    nh01Meta.wayCount === nh01.features.length,
    'NH01 metadata.wayCount matches the feature count');
  for (const f of nh01.features) {
    assert.ok(
      f.geometry && f.geometry.type === 'LineString' &&
        Array.isArray(f.geometry.coordinates) && f.geometry.coordinates.length >= 2,
      'NH01 feature is a LineString with geometry');
  }
  assert.ok(/ODbL/.test(nh01Meta.license || ''),
    'NH01 carries the ODbL attribution: ' + nh01Meta.license);
  assert.ok(
    Array.isArray(nh01Meta.osmRelationIds) && nh01Meta.osmRelationIds.length > 0,
    'NH01 records its OSM relation IDs');
  assert.ok(
    nh01Meta.lengthKm >= 800 && nh01Meta.lengthKm <= 1300,
    'NH01 length in corridor, got: ' + nh01Meta.lengthKm);
  // Termini pinned: Kakarbhitta (Jhapa, east) and Bhim Datta (Kanchanpur,
  // west) — a mis-extracted corridor cannot pass.
  function nh01TerminusGap(pt) {
    let best = Infinity;
    for (const f of nh01.features) {
      for (const c of f.geometry.coordinates) {
        best = Math.min(best, Math.max(Math.abs(c[0] - pt[0]), Math.abs(c[1] - pt[1])));
      }
    }
    return best;
  }
  assert.ok(nh01TerminusGap([88.15, 26.68]) <= 0.35, 'NH01 east terminus at Kakarbhitta');
  assert.ok(nh01TerminusGap([80.18, 28.96]) <= 0.35, 'NH01 west terminus at Bhim Datta');
  // High-detail boundary variant (explorer "High detail" toggle).
  assert.ok(
    fs.existsSync(path.join(ROOT, 'palika-boundaries-highres-mid.geojson')),
    'high-detail boundary variant ships');
  const mid = JSON.parse(fs.readFileSync(path.join(ROOT, 'palika-boundaries-highres-mid.geojson'), 'utf8'));
  assert.ok(
    Array.isArray(mid.features) && mid.features.length === 753,
    'high-detail variant has 753 features, got: ' + (mid.features && mid.features.length));
  let midVerts = 0;
  for (const f of mid.features) {
    function c(x) { if (Array.isArray(x) && typeof x[0] === 'number') return 1; let n = 0; for (const y of x) n += c(y); return n; }
    midVerts += c(f.geometry.coordinates);
  }
  assert.ok(midVerts >= 70000,
    'high-detail variant carries >= 70k vertices, got: ' + midVerts);
  for (const f of mid.features) {
    assert.ok(f.properties && f.properties.districtId,
      'high-detail feature has districtId for the explorer join');
  }
  assert.ok(
    fs.readFileSync(path.join(ROOT, 'explorer.html'), 'utf8').includes('boundary-detail-toggle'),
    'explorer exposes the high-detail toggle');
  // Self-hosted fonts (Wave 1.3): no page may reference a third-party
  // font CDN; every page loads the local type stylesheet instead.
  const fontPages = ['index.html', 'explorer.html', 'api.html', 'brand.html'];
  for (const page of fontPages) {
    const pageHtml = fs.readFileSync(path.join(ROOT, page), 'utf8');
    assert.ok(!pageHtml.includes('fonts.googleapis.com'),
      page + " must not load Google Fonts");
    assert.ok(!pageHtml.includes('fonts.gstatic.com'),
      page + " must not preconnect to fonts.gstatic.com");
    assert.ok(pageHtml.includes('fonts.css?v='),
      page + " loads the local fonts stylesheet");
  }
  const fontsCss = fs.readFileSync(path.join(ROOT, 'fonts.css'), 'utf8');
  assert.ok(fontsCss.includes('font-display: swap'),
    "fonts.css declares font-display: swap");
  assert.ok(!fontsCss.includes('http://') && !fontsCss.includes('https://'),
    "fonts.css must reference only local files");
  assert.ok(
    fontsCss.split("@font-face {").length - 1 === 4,
    "fonts.css declares 4 type rules (Inter, Devanagari 400/600, mono)");
  const manifest = fs.readFileSync(path.join(ROOT, "fonts", "fonts.sha256"), "utf8");
  assert.ok(
    manifest.split(String.fromCharCode(10)).filter((l) => l.endsWith(".woff2")).length === 4,
    "fonts.sha256 manifests all 4 woff2 files");
  // Accessibility (Wave 1.4, WCAG 2.2 AA): structural gate — no page may
  // regress the skip link, the pressed-state theme toggle, the visible
  // focus ring or the anchor scroll offset. String asserts, because the
  // stub DOM cannot exercise runtime attributes.
  const a11yPages = ['index.html', 'explorer.html', 'api.html', 'brand.html'];
  for (const page of a11yPages) {
    const pageHtml = fs.readFileSync(path.join(ROOT, page), 'utf8');
    assert.ok(pageHtml.includes('skip-link'), page + ' ships a skip link');
    assert.ok(/theme-toggle[^>]*aria-pressed/.test(pageHtml),
      page + ' theme toggle declares aria-pressed');
    assert.ok(pageHtml.includes('styles.css?v=19'),
      page + ' bumps the styles cache (v19)');
  }
  const explorerHtml = fs.readFileSync(path.join(ROOT, 'explorer.html'), 'utf8');
  assert.ok(!explorerHtml.includes('role="grid"'),
    'explorer table is a plain table (role="grid" retired)');
  assert.ok(!explorerHtml.includes('role="application"'),
    'map container does not capture screen-reader keys');
  assert.ok(explorerHtml.includes('app.js?v=23'),
    'explorer bumps the app cache (v23)');
  // Wave 3 (terrain figure): the explorer gains a district elevation
  // choropleth — GLO-30 bands in a lazy-loaded artifact, elevation-aware
  // popups, and a deep-linkable hero button. The gate interpolates the
  // district count from the artifact itself; no figure is hand-pinned.
  assert.ok(explorerHtml.includes('value="elevation"'),
    'explorer offers the elevation metric');
  assert.ok(explorerHtml.includes('District elevation: Copernicus GLO-30'),
    'explorer attributes the elevation source (GLO-30)');
  assert.ok(appSrc.includes('elevation: {'),
    'app.js defines the elevation metric');
  assert.ok(appSrc.includes("label: 'District mean elevation (GLO-30)'"),
    'the elevation legend names GLO-30');
  assert.ok(appSrc.includes('ensureDistrictElevation'),
    'app.js lazy-loads district-elevation.json (degrades, never errors)');
  assert.ok(appSrc.includes('Copernicus GLO-30)'),
    'popups carry the elevation sentence with attribution');
  const districtElev = JSON.parse(
    fs.readFileSync(path.join(ROOT, 'district-elevation.json'), 'utf8'));
  assert.ok(Array.isArray(districtElev) && districtElev.length === 77,
    'district-elevation.json carries all 77 districts');
  assert.ok(districtElev.every((d) => typeof d.elevMean === 'number' &&
    d.elevMin <= d.elevMean && d.elevMean <= d.elevMax),
    'min <= mean <= max for every district');
  assert.ok(fs.readFileSync(path.join(ROOT, 'index.html'), 'utf8')
    .includes('explorer.html?metric=elevation'),
    'the hero deep-links the elevation view');
  const stylesCss = fs.readFileSync(path.join(ROOT, 'styles.css'), 'utf8');
  assert.ok(stylesCss.includes('[tabindex]:focus-visible'),
    'interactive table rows get a visible focus ring');
  assert.ok(stylesCss.includes('scroll-margin-top'),
    'anchor targets clear the sticky header (WCAG 2.4.11)');
  assert.ok(stylesCss.includes('--color-border-focus'),
    'focus ring rides the border-focus token (>= 3:1 in both themes)');
  assert.ok(appSrc.includes('aria-pressed'),
    'applyTheme syncs the toggle pressed state');
  assert.ok((appSrc.match(/lang="ne"/g) || []).length === 6,
    'bilingual spans carry lang="ne" (palika popup, district tip + popup, 2 table paths)');
  assert.ok(appSrc.includes("toast.setAttribute('role', 'status')"),
    'toast feedback is announced (role=status)');
  assert.ok(appSrc.includes('aria-current'),
    'pagination announces the current page');
  assert.ok((appSrc.match(/prefers-reduced-motion: reduce/g) || []).length === 4,
    'reduced-motion respected (header scroll, flyTo, anchors, count-up)');
  // Bento 2.0 homepage (Wave 2): the features grid is a bento grid —
  // one dominant bilingual cell (2x2), the CBS claim in a wide cell,
  // asymmetric spans on a shared 6-column grid, tactile hover that
  // collapses under reduced motion. Spans are layout truth: assert them.
  const indexHtml = fs.readFileSync(path.join(ROOT, 'index.html'), 'utf8');
  assert.ok((indexHtml.match(/feature-card bento-cell/g) || []).length === 8,
    'all 8 feature cards are bento cells');
  assert.ok(indexHtml.includes('cell-bilingual'),
    'the bilingual cell anchors the bento (dominant cell)');
  assert.ok(indexHtml.includes('cell-wide'),
    'the CBS claim rides the wide cell');
  assert.ok(indexHtml.includes('cell-full'),
    'the pub.dev score settles as the full-width cell');
  const bilingualFirst = indexHtml.indexOf('cell-bilingual');
  const cbsSecond = indexHtml.indexOf('cell-wide');
  assert.ok(bilingualFirst > -1 && bilingualFirst < cbsSecond,
    'DOM order = visual order: bilingual cell first, CBS wide cell second');
  assert.ok(stylesCss.includes('grid-template-columns: repeat(6, 1fr)'),
    'the bento rides a 6-column grid');
  assert.ok(stylesCss.includes('.cell-bilingual { grid-column: span 2; grid-row: span 2; }'),
    'the dominant cell spans 2x2');
  assert.ok(/prefers-reduced-motion: reduce[\s\S]{0,200}\.feature-card:hover \{ transform: none; \}/.test(stylesCss),
    'bento hover lift collapses under reduced motion');
  // Wave 2.5 (visual whoa system): the motion law lives in GENERATED
  // tokens, the count-up and bento reveal are opt-in (no-JS visitors see
  // everything rendered), and reduced-motion collapses all of it.
  const brandTokensCss = fs.readFileSync(path.join(ROOT, 'brand-tokens.css'), 'utf8');
  assert.ok(brandTokensCss.includes('--nb-motion-exit: 180ms') && brandTokensCss.includes('--nb-motion-stagger: 40ms'),
    'exit + stagger durations are generated tokens');
  assert.ok(brandTokensCss.includes('--nb-easing-out') && brandTokensCss.includes('--nb-easing-exit'),
    'easing tokens are generated (entrance ease-out, exit ease-in)');
  assert.ok(appSrc.includes('initCountUp'), 'hero stats count up on viewport entry');
  assert.ok(appSrc.includes('initBentoReveal'), 'bento entrance staggers on viewport entry');
  assert.ok((appSrc.match(/prefers-reduced-motion: reduce/g) || []).length === 4,
    'reduced-motion guards (header, flyTo, anchors, count-up)');
  assert.ok(stylesCss.includes('bento-rise'), 'bento rise keyframes ship');
  assert.ok(stylesCss.includes('prefers-reduced-motion: no-preference'),
    'the reveal is opt-in: hidden cells exist only in the no-preference media block');
  assert.ok(indexHtml.includes('brand-tokens.css?v=2'),
    'brand-tokens cache-bust v2 (regenerated artifact)');
  // GEO quick-win: the dataset is meant to be found, cited, and used by
  // people AND answer engines. robots.txt welcomes the AI crawlers by
  // name, the sitemap lists every public page, and the index JSON-LD
  // carries a freshness date. The exact date is pinned to meta.json's
  // dataAsOf by tool/check_site_truth.dart; here we only assert the
  // signal exists, so this gate never drifts with a release.
  const robotsTxt = fs.readFileSync(path.join(ROOT, 'robots.txt'), 'utf8');
  assert.ok(robotsTxt.includes('User-agent: GPTBot'),
    'GPTBot is explicitly welcomed');
  assert.ok(robotsTxt.includes('User-agent: ClaudeBot'),
    'ClaudeBot is explicitly welcomed');
  assert.ok(robotsTxt.includes('User-agent: PerplexityBot'),
    'PerplexityBot is explicitly welcomed');
  assert.ok(robotsTxt.includes('User-agent: Google-Extended'),
    'Google-Extended is explicitly welcomed');
  assert.ok(robotsTxt.includes('Sitemap: https://namunaone.github.io/nGeo/sitemap.xml'),
    'robots.txt declares the sitemap');
  const sitemapXml = fs.readFileSync(path.join(ROOT, 'sitemap.xml'), 'utf8');
  assert.ok((sitemapXml.match(/<url>/g) || []).length === 4,
    'the sitemap lists all 4 public pages');
  assert.ok(/"dateModified": "\d{4}-\d{2}-\d{2}"/.test(indexHtml),
    'the index JSON-LD carries a dateModified freshness date');
  // Wave 3 PR B (context + honesty): the 77-district layer ships as a
  // same-origin overlay (dashed stone lines, off by default, roster
  // popup + GLO-30 sentence), the table gets a loading skeleton
  // (aria-hidden rows, CSS-only pulse, reduced-motion static) and an
  // empty state that offers a reset. Counts interpolate from the
  // vendored artifact and data.json — nothing is hand-pinned.
  assert.ok(appSrc.includes("id: 'district-boundaries'"),
    'the district boundaries overlay is registered');
  assert.ok(appSrc.includes('district-boundaries.geojson'),
    'the overlay fetches the vendored district geometry');
  assert.ok(appSrc.includes('renderTableSkeleton'),
    'the table renders a loading skeleton while data.json loads');
  assert.ok(appSrc.includes('reset-filters'),
    'the empty state offers a one-click reset');
  const stylesCssB = fs.readFileSync(path.join(ROOT, 'styles.css'), 'utf8');
  assert.ok(stylesCssB.includes('skeleton-pulse'),
    'skeletons pulse via CSS, not JS');
  assert.ok(/prefers-reduced-motion: reduce[\s\S]{0,80}\.skeleton \{ animation: none/.test(stylesCssB),
    'skeletons collapse under reduced motion');
  const districtsFc = JSON.parse(
    fs.readFileSync(path.join(ROOT, 'district-boundaries.geojson'), 'utf8'));
  assert.ok(districtsFc.features.length === 77,
    'district-boundaries.geojson carries all 77 districts');
  const dataDistricts = new Set(data.map((d) => d.district));
  const overlayDistricts =
    new Set(districtsFc.features.map((f) => f.properties && f.properties.nameEn));
  assert.ok(overlayDistricts.size === 77 &&
    [...overlayDistricts].every((d) => dataDistricts.has(d)),
    'overlay district names join 77/77 with data.json');
  // Wave 4 (budgets as features): the performance + accessibility law
  // lives in ONE place (tool/check_budgets.mjs) and CI enforces it via
  // .github/workflows/lighthouse.yml on every PR. Here we only assert
  // the law is declared and wired — thresholds themselves are the
  // budget gate's business, never re-pinned in smoke.
  const budgetsSrc = fs.readFileSync(
    path.join(ROOT, '..', 'tool', 'check_budgets.mjs'), 'utf8');
  assert.ok(budgetsSrc.includes('lcp: 2500') &&
    budgetsSrc.includes('tbt: 200') && budgetsSrc.includes('cls: 0.1') &&
    budgetsSrc.includes('accessibility: 100'),
    'the budget law declares the CWV ceilings in check_budgets.mjs');
  // The law is never lowered: LCP pages not yet at 2500ms are gated by
  // explicit interim ratchet ceilings instead — Home now sits AT the law
  // (measured 2317ms), Explorer stays on an evidence-based interim
  // (re-measured 4789ms post-engine-swap + ~15% LH noise headroom).
  assert.ok(budgetsSrc.includes('const LCP_CEILINGS = {') &&
    budgetsSrc.includes("'/explorer.html': 5500") &&
    budgetsSrc.includes("'/': 2500"),
    'the LCP ratchet declares per-page evidence-based ceilings');
  assert.ok(budgetsSrc.includes('const TBT_CEILINGS = {') &&
    budgetsSrc.includes("'/explorer.html': 1900") &&
    budgetsSrc.includes('tbtOk: m.tbt <= (TBT_CEILINGS[page.path]'),
    'the TBT ratchet declares the R2 post-split Explorer interim (law unchanged elsewhere)');
  assert.ok(budgetsSrc.includes('lcpOk: m.lcp <= (LCP_CEILINGS[page.path]'),
    'the LCP gate asserts against the ratchet ceiling');
  assert.ok(budgetsSrc.includes('RETRY_PASSES') &&
    budgetsSrc.includes('Math.min(m.tbt, next.tbt)'),
    'a bust earns up to RETRY_PASSES backoff passes; the row of record is the per-metric minimum (one-sided host noise) — never a relaxed law');
  // Wave 4 PR B (payload diet): the ~40 MB full-resolution palika boundary
  // source stays in the repo (source-of-truth for the boundaries package
  // and its generators) but never reaches the Pages artifact: the deploy
  // job drops it, a size budget guards the artifact, and a Release
  // workflow publishes it as a one-click download instead.
  const dartYml = fs.readFileSync(
    path.join(ROOT, '..', '.github', 'workflows', 'dart.yml'), 'utf8');
  assert.ok(dartYml.includes('rm -f docs/palika-boundaries-highres.geojson'),
    'deploy-pages keeps the full-resolution source out of the site artifact');
  assert.ok(dartYml.includes('max=$((9*1024*1024))'),
    'deploy-pages enforces the 9 MB site artifact size budget');
  const releaseYml = fs.readFileSync(
    path.join(ROOT, '..', '.github', 'workflows', 'release-geojson.yml'), 'utf8');
  assert.ok(releaseYml.includes('gh release upload') &&
    releaseYml.includes('docs/palika-boundaries-highres.geojson'),
    'the release workflow publishes the full-resolution source as an asset');
  // Track T1 (PMTiles archive): the same boundaries archived as one
  // single-file PMTiles so map renderers can stream tiles without a
  // tile server. Built inside the SAME release job - one notes edit,
  // no racing workflows; the archive uploads to the Release, NEVER to
  // Pages (the payload-diet law stands). Structural pins; the tiler
  // and converter invocations are pinned, thresholds are not.
  assert.ok(releaseYml.includes('tippecanoe=2.79.0') &&
    releaseYml.includes('setup-micromamba@v3') &&
    releaseYml.includes('generate-run-shell: true') &&
    releaseYml.includes('micromamba-shell {0}'),
    'the release workflow pins the tippecanoe AND runs it inside the env');
  assert.ok(releaseYml.includes('protomaps/go-pmtiles') &&
    releaseYml.includes('palika-boundaries.pmtiles'),
    'the release workflow archives the boundaries as PMTiles');
  // Track 3 (COD-AB upstream watch): the pinned HDX COD-AB dataset
  // (data/SOURCES.md source #9, v02 reviewed 2025-10-30, licence
  // CC BY-IGO) can be re-published upstream without notice - the live
  // metadata_modified already read 2026-08-14 at the 2026-10-30
  // review. The watch polls HDX weekly and files an issue on any
  // licence or metadata change; a refresh stays a human decision,
  // never auto. Structural pins only.
  const codAbWatchYml = fs.readFileSync(
    path.join(ROOT, '..', '.github', 'workflows', 'cod-ab-watch.yml'), 'utf8');
  assert.ok(codAbWatchYml.includes('cod-ab-npl') &&
    codAbWatchYml.includes('package_show'),
    'the watch polls the pinned HDX COD-AB dataset');
  assert.ok(codAbWatchYml.includes('cc-by-igo') &&
    codAbWatchYml.includes('2026-08-14'),
    'the watch pins the reviewed licence and the observed metadata state');
  assert.ok(codAbWatchYml.includes('github-script') &&
    codAbWatchYml.includes('issues: write'),
    'drift files an issue, never a silent refresh');
  // RFC 7946 gate: every GeoJSON artifact - the docs/ overlays AND the
  // bindings/geojson public downloads - must speak WGS84 lon/lat with
  // closed rings and no legacy "crs" member. Structural pins only;
  // thresholds are the gate tool's business, never re-pinned here.
  assert.ok(dartYml.includes('dart run tool/check_rfc7946.dart'),
    'dart.yml wires the RFC 7946 conformance gate');
  const rfcTool = fs.readFileSync(
    path.join(ROOT, '..', 'tool', 'check_rfc7946.dart'), 'utf8');
  assert.ok(rfcTool.includes("containsKey('crs')"),
    'the gate bans the legacy "crs" member on GeoJSON objects');
  assert.ok(rfcTool.includes('ring is not closed'),
    'the gate fails unclosed rings (four or more positions)');
  assert.ok(rfcTool.includes('nepalMinLon') && rfcTool.includes('nepalMaxLat'),
    'the gate pins the Nepal band (a lon/lat swap cannot pass)');
  assert.ok(rfcTool.includes('degenerateRings'),
    'the gate reports degenerate rings without failing them');
  assert.ok(rfcTool.includes('--strip-crs'),
    'the gate doubles as the auto-heal: --strip-crs excises the member');
  const sanitizeYml = fs.readFileSync(
    path.join(ROOT, '..', '.github', 'workflows', 'sanitize-crs.yml'), 'utf8');
  assert.ok(sanitizeYml.includes('branches-ignore: [main]') &&
    sanitizeYml.includes('--strip-crs'),
    'the sanitize workflow auto-heals non-main branches, never main');
  // Wave 4 PR C (adaptive & fast): the explorer figure arms at viewport
  // proximity (deep links arm immediately) instead of booting the map engine +
  // boundaries inside the LCP window; Save-Data skips optional prefetch
  // and the count-up; cards adapt via container queries and the page
  // prints like a document.
  assert.ok(appSrc.includes('var _mapArmed = false;') &&
    appSrc.includes("params.get('cbs') || params.get('metric')") &&
    appSrc.includes('renderArmedMap'),
    'the figure arms lazily; deep links arm immediately');
  assert.ok(appSrc.includes('var SAVE_DATA') &&
    appSrc.includes('if (!SAVE_DATA) ensureDistrictElevation();') &&
    appSrc.includes('if (SAVE_DATA) return;'),
    'Save-Data gates the eager elevation prefetch and the count-up');
  const stylesCssC = fs.readFileSync(path.join(ROOT, 'styles.css'), 'utf8');
  assert.ok(stylesCssC.includes('container-type: inline-size') &&
    stylesCssC.includes('@container'),
    'cards adapt via container queries');
  assert.ok(stylesCssC.includes('break-inside: avoid') &&
    stylesCssC.includes('@page { margin: 1.5cm; }'),
    'print styles keep rows and cards unbroken');
  // Wave R1 (the MapLibre leap): the engine swap is pinned and total —
  // MapLibre GL v5.6.0 (the last UMD build; v6 ships ESM-only), native
  // GeoJSON clustering, data-driven choropleth paint. The old engine and
  // its cluster plugin are fully retired from app.js and styles.css.
  assert.ok(appSrc.includes('vendor/maplibre-gl-5.6.0.js') &&
    appSrc.includes('new maplibregl.Map('),
    'the explorer map runs on pinned MapLibre GL v5.6.0, vendored first-party (R3)');
  assert.ok(!appSrc.includes('unpkg.com') &&
    !appSrc.includes('markerClusterGroup'),
    'the map engine is self-hosted — zero unpkg.com references; the old map engine + cluster plugin CDN era is fully retired');
  // R3 (self-host the engine): the vendored dist is a first-party site
  // asset — present in the tree and official (the MapLibre banner + the
  // pinned version). The full byte pin (sha256 re-asserted from the
  // CI-born bot commit on every run) lives in dart.yml; this is the
  // presence check.
  const vendorJs = fs.readFileSync(path.join(ROOT, 'vendor', 'maplibre-gl-5.6.0.js'), 'utf8');
  const vendorCss = fs.readFileSync(path.join(ROOT, 'vendor', 'maplibre-gl-5.6.0.css'), 'utf8');
  assert.ok(vendorJs.slice(0, 80).includes('MapLibre GL JS') &&
    vendorJs.includes('5.6.0'),
    'the vendored engine is the official maplibre-gl@5.6.0 dist');
  assert.ok(vendorCss.includes('.maplibregl'),
    'the vendored engine stylesheet is present');
  assert.ok(appSrc.includes('tile.openstreetmap.org'),
    'the OSM raster basemap stays');
  assert.ok(stylesCssC.includes('.maplibregl-popup-content') &&
    !stylesCssC.includes('.leaflet-'),
    'styles theme MapLibre chrome; old map-engine rules are retired');
  assert.ok(stylesCssC.includes('.map .maplibregl-ctrl-attrib a { text-decoration: underline'),
    'the engine attribution link is underlined (.map scope beats the runtime-loaded engine sheet) — axe link-in-text-block');
  // R2 (arm-chain split, walking the budgets toward the law): the
  // engine half and the data half of the map arm schedule separately —
  // scroll-arms boot the engine in the first idle slot (deep links stay
  // immediate), the boundary half idles once more after the basemap
  // paints, and overlays fetch on first ask instead of preloading
  // ~2.5 MB of off-by-default GeoJSON at engine boot.
  assert.ok(appSrc.includes('function scheduleIdle(') &&
    appSrc.includes('requestIdleCallback'),
    'the idle scheduler exists and is capability-checked (rIC + timeout, setTimeout fallback)');
  assert.ok(appSrc.includes('var _mapArmIdle = false;') &&
    appSrc.includes('function mapEngineReady('),
    'the arm tracks deep-link (immediate) vs scroll (idle) engine boots');
  assert.ok(appSrc.includes('scheduleIdle(() => { ensureMap().then(resolve, resolve); })'),
    'the engine half boots in the first idle slot on a scroll-arm');
  assert.ok(appSrc.includes('scheduleIdle(() => resolve());'),
    'the boundary data half idles once more after the basemap paints');
  assert.ok(appSrc.includes('if (def.enabledByDefault) loadOverlay(def);') &&
    !appSrc.includes('for (const def of MAP_OVERLAYS) loadOverlay(def)'),
    'overlays wire eagerly but load only their enabledByDefault set at boot');
  assert.ok(appSrc.includes('loadOverlay(def, { visible: true })'),
    'the overlay toggle is the loader — the fetch starts on first ask');
  const lighthouseYml = fs.readFileSync(
    path.join(ROOT, '..', '.github', 'workflows', 'lighthouse.yml'), 'utf8');
  assert.ok(lighthouseYml.includes('check_budgets.mjs'),
    'the Lighthouse budget workflow runs the budget gate');
    const rows = (tableBody.innerHTML.match(/<tr/g) || []).length;
  console.log(`SMOKE OK: ${data.length} records, ${rows} rows rendered, no errors`);
})().catch((err) => {
  console.error('SMOKE FAILED:', err && err.message ? err.message : err);
  process.exit(1);
});


