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
      if (sel === '#map') return null; // map short-circuits (no Leaflet here)
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
    assert.ok(pageHtml.includes('styles.css?v=15'),
      page + ' bumps the styles cache (v15)');
  }
  const explorerHtml = fs.readFileSync(path.join(ROOT, 'explorer.html'), 'utf8');
  assert.ok(!explorerHtml.includes('role="grid"'),
    'explorer table is a plain table (role="grid" retired)');
  assert.ok(!explorerHtml.includes('role="application"'),
    'map container does not capture screen-reader keys');
  assert.ok(explorerHtml.includes('app.js?v=16'),
    'explorer bumps the app cache (v16)');
  const stylesCss = fs.readFileSync(path.join(ROOT, 'styles.css'), 'utf8');
  assert.ok(stylesCss.includes('[tabindex]:focus-visible'),
    'interactive table rows get a visible focus ring');
  assert.ok(stylesCss.includes('scroll-margin-top'),
    'anchor targets clear the sticky header (WCAG 2.4.11)');
  assert.ok(stylesCss.includes('--color-border-focus'),
    'focus ring rides the border-focus token (>= 3:1 in both themes)');
  assert.ok(appSrc.includes('aria-pressed'),
    'applyTheme syncs the toggle pressed state');
  assert.ok((appSrc.match(/lang="ne"/g) || []).length === 4,
    'bilingual spans carry lang="ne" (2 popups + 2 table paths)');
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
    const rows = (tableBody.innerHTML.match(/<tr/g) || []).length;
  console.log(`SMOKE OK: ${data.length} records, ${rows} rows rendered, no errors`);
})().catch((err) => {
  console.error('SMOKE FAILED:', err && err.message ? err.message : err);
  process.exit(1);
});

