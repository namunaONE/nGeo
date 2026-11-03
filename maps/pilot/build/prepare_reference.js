// prepare_reference.js — v1.1 reference data preparation (D10-deferred edition)
//
// Reads the master CSVs, validates them, and emits:
//   - data/peaks_draft.geojson          (51 point features; DRAFT, not production)
//   - data/reference/reference_tables_draft.json  (non-spatial PA + buffer records)
//   - build/reference_qa.json          (validation report)
//
// Does NOT generate protected_areas.geojson or buffer_zones.geojson (D10).
// Run: node build/prepare_reference.js
//
// Exit non-zero on any validation failure.

const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const BASE = path.join(ROOT, 'data', 'reference');
const BUILD = path.join(ROOT, 'build');

function parse(text) {
  const rows = []; let row = [], f = '', q = false;
  for (let i = 0; i < text.length; i++) {
    const c = text[i];
    if (q) {
      if (c === '"' && text[i + 1] === '"') { f += '"'; i++; }
      else if (c === '"') { q = false; }
      else f += c;
    } else {
      if (c === '"') { q = true; }
      else if (c === ',') { row.push(f); f = ''; }
      else if (c === '\n') { row.push(f); rows.push(row); row = []; f = ''; }
      else if (c !== '\r') { f += c; }
    }
  }
  if (f || row.length) { row.push(f); rows.push(row); }
  return rows;
}
function load(name) {
  const raw = fs.readFileSync(path.join(BASE, name), 'utf8').replace(/^\uFEFF/, '');
  const r = parse(raw);
  const header = r[0];
  const rows = r.slice(1).map(x => Object.fromEntries(header.map((k, i) => [k, x[i] == null ? '' : x[i]])));
  return { header, rows };
}

const core = load('protected_areas_master.csv');
const buffer = load('buffer_zones_master.csv');
const peaks = load('peaks_master.csv');
const sources = load('sources.csv');
const sourceIds = new Set(sources.rows.map(r => r.source_id));

const issues = [];
const issue = (m) => issues.push(m);

// --- validation ---
if (core.rows.length !== 22) issue('core: expected 22 rows, found ' + core.rows.length);
if (buffer.rows.length !== 14) issue('buffer: expected 14 rows, found ' + buffer.rows.length);
if (peaks.rows.length !== 51) issue('peaks: expected 51 rows, found ' + peaks.rows.length);
if (sources.rows.length !== 25) issue('sources: expected 25 rows, found ' + sources.rows.length);

const allIds = new Set();
for (const [label, table] of [['core', core], ['buffer', buffer], ['peaks', peaks]]) {
  for (const row of table.rows) {
    if (!row.id) issue(label + ': empty id');
    if (allIds.has(row.id)) issue(label + ': duplicate id ' + row.id);
    allIds.add(row.id);
  }
}

for (const row of core.rows) {
  for (const s of (row.source_id || '').split(';').filter(Boolean)) if (!sourceIds.has(s)) issue('core: unknown source ' + row.id + ' ' + s);
}
for (const row of buffer.rows) {
  for (const s of (row.source_id || '').split(';').filter(Boolean)) if (!sourceIds.has(s)) issue('buffer: unknown source ' + row.id + ' ' + s);
}
for (const row of peaks.rows) {
  for (const f of ['elevation_source', 'prominence_source', 'coord_source', 'name_np_source', 'border_source']) {
    for (const s of (row[f] || '').split(';').filter(Boolean)) if (!sourceIds.has(s)) issue('peaks: unknown source ' + row.id + ' ' + f + ' ' + s);
  }
}

for (const row of peaks.rows) {
  const lon = Number(row.lon), lat = Number(row.lat);
  if (isNaN(lon) || isNaN(lat)) issue('peaks: bad coordinate ' + row.id);
  else if (lon < 79 || lon > 90 || lat < 26 || lat > 31) issue('peaks: coordinate out of range ' + row.id);
  if (!row.name_en) issue('peaks: missing English name ' + row.id);
  if (!row.elevation_m) issue('peaks: missing elevation ' + row.id);
}

const coreIds = new Set(core.rows.map(r => r.id));
for (const row of buffer.rows) {
  if (!coreIds.has(row.parent_pa_id)) issue('buffer: invalid parent_pa_id ' + row.id + ' ' + row.parent_pa_id);
}

const fed = core.rows.filter(r => r.authority_level === 'federal').reduce((s, r) => s + (Number(r.area_published_km2) || 0), 0);
const prov = core.rows.filter(r => r.authority_level !== 'federal').reduce((s, r) => s + (Number(r.area_published_km2) || 0), 0);
const buf = buffer.rows.reduce((s, r) => s + (Number(r.area_published_km2) || 0), 0);

if (issues.length) {
  console.error('VALIDATION FAILED (' + issues.length + ' issues):');
  for (const i of issues) console.error('  - ' + i);
  process.exit(1);
}

// --- emit peaks_draft.geojson ---
const peakFeatures = peaks.rows.map(r => ({
  type: 'Feature',
  id: r.id,
  geometry: { type: 'Point', coordinates: [Number(r.lon), Number(r.lat)] },
  properties: {
    id: r.id,
    layer: r.layer,
    peak_class: r.peak_class,
    name_en: r.name_en,
    name_np: r.name_np || null,
    name_np_status: r.name_np_status,
    name_np_source: r.name_np_source || null,
    elevation_m: Number(r.elevation_m),
    elevation_source: r.elevation_source,
    prominence_m: r.prominence_m ? Number(r.prominence_m) : null,
    prominence_source: r.prominence_source || null,
    range: r.range,
    massif: r.massif || null,
    parent_peak_id: r.parent_peak_id || null,
    nepal_share: r.nepal_share,
    border_countries: r.border_countries || null,
    border_source: r.border_source || null,
    province_codes: r.province_codes.split(';').filter(Boolean).map(Number),
    district_codes: r.district_codes.split(';').filter(Boolean).map(Number),
    coord_source: r.coord_source,
    coord_accuracy_m: r.coord_accuracy_m ? Number(r.coord_accuracy_m) : null,
    official_list: r.official_list || null,
    first_ascent_year: r.first_ascent_year ? Number(r.first_ascent_year) : null,
    label_rank: Number(r.label_rank),
    label_min_zoom: Number(r.label_min_zoom),
    review_status: r.review_status,
    aliases_en: r.aliases_en || null,
    aliases_np: r.aliases_np || null,
  },
}));

const peaksOut = path.join(ROOT, 'data', 'peaks_draft.geojson');
fs.writeFileSync(peaksOut, JSON.stringify({
  type: 'FeatureCollection',
  name: 'Peaks (DRAFT — DNPWC-deferred edition; not for release)',
  crs: { type: 'name', properties: { name: 'urn:ogc:def:crs:OGC:1.3:CRS84' } },
  features: peakFeatures,
}, null, 2) + '\n');

// --- emit reference_tables_draft.json (non-spatial) ---
const toObj = (row) => Object.fromEntries(Object.keys(row).map(k => [k, row[k]]));
const refTables = {
  generated: new Date().toISOString(),
  edition: 'DNPWC-deferred draft (D10)',
  note: 'Non-spatial records. No protected-area or buffer-zone polygon is included. Published areas are not survey measurements.',
  protected_areas: core.rows.map(toObj),
  buffer_zones: buffer.rows.map(toObj),
  totals: {
    federal_core_km2: +fed.toFixed(2),
    provincial_km2: +prov.toFixed(2),
    buffer_km2: +buf.toFixed(2),
    core_plus_buffer_km2: +(fed + buf).toFixed(2),
    all_three_layers_km2: +(fed + prov + buf).toFixed(2),
  },
};
const refOut = path.join(BASE, 'reference_tables_draft.json');
fs.writeFileSync(refOut, JSON.stringify(refTables, null, 2) + '\n');

// --- write build/reference_qa.json ---
const qa = {
  generated: new Date().toISOString(),
  edition: 'DNPWC-deferred draft',
  counts: {
    core_rows: core.rows.length,
    buffer_rows: buffer.rows.length,
    peak_rows: peaks.rows.length,
    source_rows: sources.rows.length,
    evidence_rows: 8,
  },
  peaks: {
    rows: peaks.rows.length,
    classes: peaks.rows.reduce((a, r) => { a[r.peak_class] = (a[r.peak_class] || 0) + 1; return a; }, {}),
    name_status: peaks.rows.reduce((a, r) => { a[r.name_np_status] = (a[r.name_np_status] || 0) + 1; return a; }, {}),
    border_status: peaks.rows.reduce((a, r) => { a[r.nepal_share] = (a[r.nepal_share] || 0) + 1; return a; }, {}),
    review_status: peaks.rows.reduce((a, r) => { a[r.review_status] = (a[r.review_status] || 0) + 1; return a; }, {}),
    missing_np: peaks.rows.filter(r => !r.name_np).length,
    missing_coord: peaks.rows.filter(r => !r.lon || !r.lat).length,
  },
  areas: {
    federal_core_km2: +fed.toFixed(2),
    provincial_km2: +prov.toFixed(2),
    buffer_km2: +buf.toFixed(2),
    core_plus_buffer_km2: +(fed + buf).toFixed(2),
    all_three_layers_km2: +(fed + prov + buf).toFixed(2),
  },
  open_issues: peaks.rows.filter(r => !r.name_np).map(r => 'missing Nepali name ' + r.id),
  validation_issues: issues,
};
fs.writeFileSync(path.join(BUILD, 'reference_qa.json'), JSON.stringify(qa, null, 2) + '\n');

console.log('prepare_reference.js complete (DNPWC-deferred edition).');
console.log('  peaks_draft.geojson:', peakFeatures.length, 'features');
console.log('  reference_tables_draft.json:', core.rows.length, '+', buffer.rows.length, 'records');
console.log('  build/reference_qa.json written');
console.log('  federal core:', fed.toFixed(2), '| buffer:', buf.toFixed(2), '| all three:', (fed + prov + buf).toFixed(2));
console.log('  open issues:', qa.open_issues.length);