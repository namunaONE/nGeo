#!/usr/bin/env node
// tool/daily_watch/watch.cjs
//
// Daily source & gap watch for the nGeo dataset. Scheduled on GitHub Actions
// at 09:00 Asia/Kathmandu (03:15 UTC); also runnable locally:
//
//     node tool/daily_watch/watch.cjs
//
// What it does, every day:
//   1. Prints and files the complete list of unverified local bodies
//      (uncoded palikas, missing Devanagari names, missing coordinates,
//      missing ward counts, single-source codes) — the gap snapshot.
//   2. Re-fetches every pinned upstream input at its documented URL and
//      compares SHA-256 against data/PROVENANCE.sha256. This closes the
//      "reproducibility gap" noted in data/SOURCES.md: upstream drift is now
//      detected without anyone holding data/_raw/ locally.
//   3. Fetches fresh authoritative cross-check sources and compares:
//        - CBS/NSO geographical codes (opendatanepal CKAN harvest)
//        - geoBoundaries NPL ADM3 metadata (unit count, year represented)
//        - Open Knowledge Nepal LocalBoundaries (palika geometry features)
//        - OpenStreetMap (admin_level 7 palikas, admin_level 9 wards)
//   4. Writes watch/daily-report.md and watch/daily-report.json.
//
// Design rules (the repo's provenance-watch philosophy, kept intact):
//   - ABSENCE IS NOT DRIFT. A source that cannot be fetched is reported as
//     unreachable; nothing else is inferred from it. The daily run must never
//     blame upstream for our own network weather.
//   - REPORT EVERYTHING, FAIL ONLY FOR WHAT NEEDS A HUMAN:
//     exit 1 only when (a) a pinned input no longer matches its SHA-256, or
//     (b) the fresh CBS roster disagrees with our per-district structure, or
//     (c) a previously-uncodable palika becomes uniquely resolvable against
//     the fresh CBS roster (an improvement opportunity, not an error).
//   - The watch never writes the dataset. Resolution happens in the merge
//     pipeline, human-adjudicated, exactly as documented in data/SOURCES.md.
//
// Exit codes: 0 = clean/informational; 1 = actionable drift (workflow files
// an issue); 2 = configuration error (dataset or manifest unreadable).

'use strict';

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.resolve(__dirname, '..', '..');
const OUT_DIR = path.join(ROOT, 'watch');
const USER_AGENT =
  'ngeo-daily-watch/1.0 (https://namunaone.github.io/nGeo/; scheduled source verification)';

// ---------------------------------------------------------------------------
// URL map: every file pinned in data/PROVENANCE.sha256, and where it can be
// re-fetched from. Paths are repo-relative under data/_raw/, exactly as the
// manifest records them. Keep in sync with data/SOURCES.md and
// tool/merge/inventory.dart.
// ---------------------------------------------------------------------------

const CKAN_BASE =
  'https://api.opendatanepal.com/dataset/22870675-146d-4e4f-8848-2216380170de/resource';

const PINNED_URL_MAP = {
  'abinrimal': {
    base: 'https://raw.githubusercontent.com/abinrimal/nepal-administrative-divisions-json/main/',
    map: {
      'abinrimal/districts.json': 'districts.json',
      'abinrimal/LICENSE': 'LICENSE',
      'abinrimal/local_level_types.json': 'local_level_types.json',
      'abinrimal/local_levels.json': 'local_levels.json',
      'abinrimal/provinces.json': 'provinces.json',
    },
  },
  'local-states-nepal': {
    base: 'https://raw.githubusercontent.com/sagautam5/local-states-nepal/master/',
    map: {
      'local-states-nepal/dataset_alldataset_en.json': 'dataset/alldataset/en.json',
      'local-states-nepal/dataset_alldataset_np.json': 'dataset/alldataset/np.json',
      'local-states-nepal/dataset_categories_en.json': 'dataset/categories/en.json',
      'local-states-nepal/dataset_categories_np.json': 'dataset/categories/np.json',
      'local-states-nepal/dataset_districts_en.json': 'dataset/districts/en.json',
      'local-states-nepal/dataset_districts_np.json': 'dataset/districts/np.json',
      'local-states-nepal/dataset_municipalities_en.json': 'dataset/municipalities/en.json',
      'local-states-nepal/dataset_municipalities_np.json': 'dataset/municipalities/np.json',
      'local-states-nepal/dataset_provinces_en.json': 'dataset/provinces/en.json',
      'local-states-nepal/dataset_provinces_np.json': 'dataset/provinces/np.json',
      'local-states-nepal/LICENSE': 'LICENSE',
    },
  },
  'nepali-geo-pro-max': {
    base: 'https://raw.githubusercontent.com/l3lackcurtains/nepali-geo-pro-max/main/',
    map: {
      'nepali-geo-pro-max/LICENSE': 'LICENSE',
      'nepali-geo-pro-max/src_data_districts.ts': 'src/data/districts.ts',
      'nepali-geo-pro-max/src_data_legacy-districts.ts': 'src/data/legacy-districts.ts',
      'nepali-geo-pro-max/src_data_local-units.ts': 'src/data/local-units.ts',
      'nepali-geo-pro-max/src_data_postal-codes.ts': 'src/data/postal-codes.ts',
      'nepali-geo-pro-max/src_data_postal-codes-2025.ts': 'src/data/postal-codes-2025.ts',
      'nepali-geo-pro-max/src_data_provinces.ts': 'src/data/provinces.ts',
      'nepali-geo-pro-max/src_data_regions.ts': 'src/data/regions.ts',
      'nepali-geo-pro-max/src_data_zones.ts': 'src/data/zones.ts',
      'nepali-geo-pro-max/src_geo_local-units.geo.ts': 'src/geo/local-units.geo.ts',
    },
  },
  'open-admin-data': {
    base: 'https://raw.githubusercontent.com/open-admin-data/nepal-administrative-divisions/main/',
    map: {
      'open-admin-data/data_all-district.json': 'data/all-district.json',
      'open-admin-data/data_all-local_unit.json': 'data/all-local_unit.json',
      'open-admin-data/data_all-province.json': 'data/all-province.json',
      'open-admin-data/data_schema.json': 'data/schema.json',
      'open-admin-data/LICENSE': 'LICENSE',
    },
  },
  'cbs-codes': {
    base: '',
    map: {
      'cbs-codes/cbs_districts.csv':
        CKAN_BASE + '/de973922-7b56-4521-b6a4-aa3de7f8d8a2/download/cbs_districts.csv',
      'cbs-codes/cbs_local_bodies.csv':
        CKAN_BASE + '/e33aa0f3-72de-4074-a38b-c6a1bf55d9a8/download/cbs_local_bodies.csv',
      'cbs-codes/cbs_states.csv':
        CKAN_BASE + '/37aa60f6-cbbe-43fd-b581-6864b72744ae/download/cbs_states.csv',
    },
  },
  // mofaga/mofaga_all.json has no public URL documented (manual harvest);
  // it is reported as unmapped, never as drift.
};

const CBS_LOCAL_BODIES_URL =
  CKAN_BASE + '/e33aa0f3-72de-4074-a38b-c6a1bf55d9a8/download/cbs_local_bodies.csv';

const GEODOUNDARIES_ADM3_URL =
  'https://www.geoboundaries.org/api/current/gbOpen/NPL/ADM3/';

const LOCALBOUNDARIES_URL =
  'https://raw.githubusercontent.com/openknowledgenp/localboundaries/main/source/municipality.geojson';

const NOMINATIM_URL =
  'https://nominatim.openstreetmap.org/search?q=Nepal&format=jsonv2&limit=1';
const OVERPASS_URL = 'https://overpass-api.de/api/interpreter';

const BASELINE_PATH = path.join(__dirname, 'baseline.json');

// ---------------------------------------------------------------------------
// Small utilities
// ---------------------------------------------------------------------------

async function fetchText(url, timeoutMs) {
  const ctrl = new AbortController();
  const t = setTimeout(() => ctrl.abort(), timeoutMs || 45000);
  try {
    const res = await fetch(url, {
      signal: ctrl.signal,
      headers: { 'User-Agent': USER_AGENT, 'Accept': '*/*' },
      redirect: 'follow',
    });
    if (!res.ok) throw new Error('HTTP ' + res.status);
    const text = await res.text();
    return text;
  } finally {
    clearTimeout(t);
  }
}

function sha256(buf) {
  return crypto.createHash('sha256').update(buf).digest('hex').toUpperCase();
}

function levenshtein(a, b) {
  if (a === b) return 0;
  if (!a.length) return b.length;
  if (!b.length) return a.length;
  let prev = [];
  for (let j = 0; j <= b.length; j++) prev[j] = j;
  for (let i = 1; i <= a.length; i++) {
    const cur = [i];
    for (let j = 1; j <= b.length; j++) {
      cur[j] = Math.min(
        prev[j] + 1,
        cur[j - 1] + 1,
        prev[j - 1] + (a[i - 1] === b[j - 1] ? 0 : 1),
      );
    }
    prev = cur;
  }
  return prev[b.length];
}

const TYPE_SUFFIXES = [
  'metropolitan city', 'submetropolitan city', 'sub-metropolitan city',
  'metropolitan', 'sub-metropolitan', 'municipality', 'rural municipality',
  'nagarpalika', 'gaunpalika', 'gaun palika', 'mun', 'r mun', 'r.mun',
];

function normalizeName(raw) {
  if (!raw) return '';
  let s = String(raw).toLowerCase();
  s = s.replace(/\([^)]*\)/g, ' ');
  for (const suf of TYPE_SUFFIXES) s = s.replace(new RegExp('\\b' + suf.replace(/[-.]/g, '\\$&') + '\\b', 'g'), ' ');
  s = s.replace(/[^a-z0-9\u0900-\u097F]+/g, '');
  return s;
}

function parseCsv(text) {
  const rows = [];
  let row = [], field = '', inQuotes = false;
  for (let i = 0; i < text.length; i++) {
    const c = text[i];
    if (inQuotes) {
      if (c === '"') {
        if (text[i + 1] === '"') { field += '"'; i++; }
        else inQuotes = false;
      } else field += c;
    } else if (c === '"') inQuotes = true;
    else if (c === ',') { row.push(field); field = ''; }
    else if (c === '\n' || c === '\r') {
      if (c === '\r' && text[i + 1] === '\n') i++;
      row.push(field); field = '';
      if (row.length > 1 || row[0] !== '') rows.push(row);
      row = [];
    } else field += c;
  }
  if (field !== '' || row.length) { row.push(field); rows.push(row); }
  return rows;
}

// ---------------------------------------------------------------------------
// 1. Our dataset: flatten + gap snapshot
// ---------------------------------------------------------------------------

function loadDataset() {
  const raw = JSON.parse(
    fs.readFileSync(path.join(ROOT, 'data', 'nepal_local_levels.json'), 'utf8'));
  const rows = [];
  for (const p of raw.provinces) {
    for (const d of p.districts) {
      for (const lb of d.localBodies) {
        rows.push({
          name: lb.name,
          nameNe: lb.nameNe === undefined ? null : lb.nameNe,
          type: lb.type,
          district: d.name,
          districtCode: d.cbsCode,
          province: p.name,
          cbsCode: lb.cbsCode === undefined ? null : lb.cbsCode,
          confidence: lb.cbsCodeConfidence || null,
          lat: lb.lat === undefined ? null : lb.lat,
          lng: lb.lng === undefined ? null : lb.lng,
          wards: lb.wards === undefined ? null : lb.wards,
        });
      }
    }
  }
  return { meta: raw.meta, rows };
}

function gapSnapshot(rows) {
  const pick = (pred) =>
    rows.filter(pred).map(r =>
      `${r.name} [${r.district}, ${r.province}]` +
      (r.cbsCode == null ? '' : ` code=${r.cbsCode}`));
  return {
    totals: {
      localBodies: rows.length,
      coded: rows.filter(r => r.cbsCode != null).length,
      uncoded: rows.filter(r => r.cbsCode == null).length,
      verified: rows.filter(r => r.confidence === 'verified').length,
      singleSource: rows.filter(r => r.confidence === 'singleSource').length,
      nameNeMissing: rows.filter(r => r.nameNe == null).length,
      coordsMissing: rows.filter(r => r.lat == null).length,
      wardsMissing: rows.filter(r => r.wards == null).length,
    },
    uncodedList: pick(r => r.cbsCode == null),
    nameNeMissingList: pick(r => r.nameNe == null),
    coordsMissingList: pick(r => r.lat == null),
    wardsMissingList: pick(r => r.wards == null),
    singleSourceList: pick(r => r.confidence === 'singleSource'),
  };
}

// ---------------------------------------------------------------------------
// 2. Pinned upstream drift (PROVENANCE.sha256 vs. live URLs)
// ---------------------------------------------------------------------------

function readProvenance() {
  const text = fs.readFileSync(path.join(ROOT, 'data', 'PROVENANCE.sha256'), 'utf8');
  const entries = [];
  for (const line of text.split('\n')) {
    const m = line.match(/^([0-9A-Fa-f]{64})\s+(\d+)\s+(.+?)\s*$/);
    if (m) entries.push({ sha: m[1].toUpperCase(), bytes: parseInt(m[2], 10), rel: m[3].trim() });
  }
  return entries;
}

async function checkPinnedDrift(entries) {
  const results = { verified: 0, drifted: [], unreachable: [], unmapped: [] };
  await Promise.all(entries.map(async (e) => {
    let url = null;
    for (const src of Object.values(PINNED_URL_MAP)) {
      if (src.map[e.rel]) { url = src.map[e.rel].startsWith('http') ? src.map[e.rel] : src.base + src.map[e.rel]; break; }
    }
    if (!url) { results.unmapped.push(e.rel); return; }
    try {
      const text = await fetchText(url, 60000);
      const buf = Buffer.from(text, 'utf8');
      const sha = sha256(buf);
      if (sha === e.sha && buf.length === e.bytes) {
        results.verified++;
      } else {
        results.drifted.push({
          rel: e.rel,
          pinned: e.sha.slice(0, 12) + '… (' + e.bytes + ' B)',
          live: sha.slice(0, 12) + '… (' + buf.length + ' B)',
          url,
        });
      }
    } catch (err) {
      results.unreachable.push({ rel: e.rel, error: String(err.message || err) });
    }
  }));
  return results;
}

// ---------------------------------------------------------------------------
// 3. Fresh CBS/NSO roster (opendatanepal CKAN harvest)
// ---------------------------------------------------------------------------

function detectColumns(rows) {
  if (!rows.length) return null;
  const header = rows[0].map(h => String(h || '').trim());
  const body = rows.slice(1);
  const stats = header.map((_, ci) => {
    const vals = body.map(r => String(r[ci] == null ? '' : r[ci]).trim());
    const codeLike = vals.filter(v => /^[1-7]\d{4}$/.test(v)).length;
    const deva = vals.filter(v => /[\u0900-\u097F]/.test(v)).length;
    return { ci, codeLike, deva, nonEmpty: vals.filter(v => v !== '').length };
  });
  const codeCol = stats.filter(s => body.length && s.codeLike >= body.length * 0.9)
    .sort((a, b) => b.codeLike - a.codeLike)[0];
  if (!codeCol) return null;
  const nameCol = stats.filter(s => s.ci !== codeCol.ci && s.deva < body.length * 0.2 && s.nonEmpty >= body.length * 0.9)
    .sort((a, b) => a.ci - b.ci)[0];
  const neCol = stats.filter(s => s.ci !== codeCol.ci && s.deva >= body.length * 0.5)
    .sort((a, b) => b.deva - a.deva)[0];
  return { codeCi: codeCol.ci, nameCi: nameCol ? nameCol.ci : null, neCi: neCol ? neCol.ci : null };
}

async function checkCbsRoster(rows) {
  const out = { fetched: false, rowCount: null, byDistrict: {}, resolvable: [], structural: [], unreachable: null };
  let text;
  try {
    text = await fetchText(CBS_LOCAL_BODIES_URL, 90000);
  } catch (err) {
    out.unreachable = String(err.message || err);
    return out;
  }
  out.fetched = true;
  const csv = parseCsv(text);
  const cols = detectColumns(csv);
  if (!cols) { out.structural.push('Could not locate the 5-digit PDDPP code column in the CSV — format changed?'); return out; }
  const body = csv.slice(1);
  out.rowCount = body.length;
  const cbsByDistrict = {};
  for (const r of body) {
    const code = String(r[cols.codeCi] || '').trim();
    if (!/^[1-7]\d{4}$/.test(code)) continue;
    const pdd = code.slice(0, 3);
    if (!cbsByDistrict[pdd]) cbsByDistrict[pdd] = [];
    cbsByDistrict[pdd].push({
      code,
      name: cols.nameCi != null ? String(r[cols.nameCi] || '').trim() : '',
      nameNe: cols.neCi != null ? String(r[cols.neCi] || '').trim() : '',
    });
  }
  const oursByDistrictCode = {};
  for (const r of rows) {
    const k = String(r.districtCode);
    if (!oursByDistrictCode[k]) oursByDistrictCode[k] = [];
    oursByDistrictCode[k].push(r);
  }
  // Per-district structural comparison.
  for (const [pdd, cbsRows] of Object.entries(cbsByDistrict)) {
    const ours = oursByDistrictCode[pdd] || [];
    if (cbsRows.length !== ours.length) {
      out.structural.push(
        `District ${pdd}: CBS rows=${cbsRows.length} vs ours=${ours.length}`);
    }
    const ourCodes = new Set(ours.map(r => r.cbsCode).filter(c => c != null));
    const cbsCodes = new Set(cbsRows.map(r => r.code));
    for (const r of ours) {
      if (r.cbsCode != null && !cbsCodes.has(String(r.cbsCode))) {
        out.structural.push(`District ${pdd}: our code ${r.cbsCode} (${r.name}) is absent from the fresh CBS roster`);
      }
    }
    // Previously-uncoded palikas: can the fresh roster name one now?
    const freeCbs = cbsRows.filter(r => !ourCodes.has(r.code));
    for (const r of ours.filter(x => x.cbsCode == null)) {
      let best = null, bestD = 3; // unique-best within distance 2, else refused
      let tie = false;
      for (const c of freeCbs) {
        const d = levenshtein(normalizeName(r.name), normalizeName(c.name));
        if (d < bestD) { bestD = d; best = c; tie = false; }
        else if (d === bestD && best) tie = true;
      }
      if (best && !tie && bestD <= 2) {
        out.resolvable.push({
          palika: r.name, district: r.district,
          candidateCode: best.code, candidateName: best.name,
          distance: bestD,
        });
      }
      if (!best && freeCbs.length === 1) {
        out.resolvable.push({
          palika: r.name, district: r.district,
          candidateCode: freeCbs[0].code, candidateName: freeCbs[0].name,
          distance: null, note: 'forced by elimination: exactly one unclaimed CBS row remains in the district',
        });
      }
    }
  }
  return out;
}

// ---------------------------------------------------------------------------
// 4. Boundary/geometry cross-checks (informational)
// ---------------------------------------------------------------------------

async function checkGeoBoundaries(baseline) {
  try {
    const j = JSON.parse(await fetchText(GEODOUNDARIES_ADM3_URL, 30000));
    return {
      fetched: true,
      admUnitCount: parseInt(j.admUnitCount, 10),
      yearRepresented: j.boundaryYearRepresented || null,
      sourceUpdate: j.sourceDataUpdateDate || null,
      baseline: (baseline.geoBoundaries && baseline.geoBoundaries.adm3UnitCount) || null,
    };
  } catch (err) {
    return { fetched: false, error: String(err.message || err) };
  }
}

async function checkLocalBoundaries(baseline) {
  try {
    const j = JSON.parse(await fetchText(LOCALBOUNDARIES_URL, 120000));
    const features = Array.isArray(j.features) ? j.features : [];
    const names = [];
    for (const f of features) {
      const p = f.properties || {};
      const key = Object.keys(p).find(k => /name/i.test(k));
      if (key && p[key]) names.push(String(p[key]));
    }
    return {
      fetched: true,
      features: features.length,
      namesFound: names.length,
      uniqueNormalized: new Set(names.map(normalizeName)).size,
      baseline: (baseline.localBoundaries && baseline.localBoundaries.features) || null,
    };
  } catch (err) {
    return { fetched: false, error: String(err.message || err) };
  }
}

async function checkOsm(baseline) {
  try {
    const nm = JSON.parse(await fetchText(NOMINATIM_URL, 30000));
    const area = nm[0] && nm[0].osm_type === 'relation'
      ? 3600000000 + parseInt(nm[0].osm_id, 10) : null;
    if (!area) return { fetched: false, error: 'Nominatim returned no Nepal relation' };
    const query =
      '[out:json][timeout:120];' +
      `area(${area})->.a;` +
      'rel(area.a)["boundary"="administrative"]["admin_level"="7"];out tags;';
    const res = await fetch(OVERPASS_URL, {
      method: 'POST',
      headers: { 'User-Agent': USER_AGENT, 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'data=' + encodeURIComponent(query),
    });
    if (!res.ok) throw new Error('Overpass HTTP ' + res.status);
    const j = await res.json();
    const rels = (j.elements || []).filter(e => e.type === 'relation');
    return {
      fetched: true,
      adminLevel7: rels.length,
      baseline: (baseline.osm && baseline.osm.adminLevel7) || null,
    };
  } catch (err) {
    return { fetched: false, error: String(err.message || err) };
  }
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

async function main() {
  const startedUtc = new Date().toISOString();
  let dataset;
  try {
    dataset = loadDataset();
  } catch (err) {
    console.error('Could not read data/nepal_local_levels.json: ' + err.message);
    process.exit(2);
  }
  let baseline = {};
  try { baseline = JSON.parse(fs.readFileSync(BASELINE_PATH, 'utf8')); } catch (_) {}
  let provenance = [];
  try { provenance = readProvenance(); } catch (err) {
    console.error('Could not read data/PROVENANCE.sha256: ' + err.message);
    process.exit(2);
  }

  const snap = gapSnapshot(dataset.rows);
  console.log(`Dataset: ${snap.totals.localBodies} local bodies; ` +
    `uncoded=${snap.totals.uncoded}, singleSource=${snap.totals.singleSource}, ` +
    `nameNe missing=${snap.totals.nameNeMissing}, coords missing=${snap.totals.coordsMissing}, ` +
    `wards missing=${snap.totals.wardsMissing}`);

  const [drift, cbs, geob, lb, osm] = await Promise.all([
    checkPinnedDrift(provenance),
    checkCbsRoster(dataset.rows),
    checkGeoBoundaries(baseline),
    checkLocalBoundaries(baseline),
    checkOsm(baseline),
  ]);

  // ---- Assemble the report ------------------------------------------------
  const actionable = [];
  for (const d of drift.drifted) {
    actionable.push(`PINNED SOURCE DRIFT: ${d.rel}\n  pinned=${d.pinned}\n  live=${d.live}\n  url=${d.url}`);
  }
  if (cbs.fetched) {
    for (const s of cbs.structural) actionable.push('CBS ROSTER: ' + s);
    for (const r of cbs.resolvable) {
      actionable.push(
        `RESOLVABLE: ${r.palika} [${r.district}] may now take CBS code ${r.candidateCode}` +
        ` (CBS row "${r.candidateName}"${r.distance != null ? `, Levenshtein ${r.distance}` : ''}` +
        `${r.note ? '; ' + r.note : ''}) — route through the merge pipeline.`);
    }
    if (cbs.rowCount != null && cbs.rowCount !== 753) {
      actionable.push(`CBS ROSTER: local-bodies CSV now has ${cbs.rowCount} rows (expected 753).`);
    }
  }

  const lines = [];
  lines.push('# Daily gap & source watch');
  lines.push('');
  lines.push(`- Run (UTC): ${startedUtc}`);
  lines.push(`- Dataset data-as-of: ${dataset.meta.dataAsOf}`);
  lines.push(`- Result: ${actionable.length ? 'ACTIONABLE — see below' : 'clean (informational only)'}`);
  lines.push('');
  lines.push('## Gap snapshot (unverified local bodies)');
  lines.push('');
  lines.push('Totals: ' + Object.entries(snap.totals).map(([k, v]) => `${k}=${v}`).join(', '));
  lines.push('');
  const section = (title, list, max) => {
    lines.push(`### ${title} (${list.length})`);
    lines.push('');
    for (const item of list.slice(0, max || 200)) lines.push('- ' + item);
    if (list.length > (max || 200)) lines.push(`- … ${list.length - (max || 200)} more`);
    lines.push('');
  };
  section('Palikas with unverified CBS codes', snap.uncodedList);
  section('Palikas missing Devanagari names', snap.nameNeMissingList);
  section('Palikas missing coordinates', snap.coordsMissingList);
  section('Palikas missing ward counts', snap.wardsMissingList);
  section('Palikas with single-source codes (labelled, for joins only)', snap.singleSourceList, 40);

  lines.push('## Pinned upstream inputs (PROVENANCE.sha256 vs. live)');
  lines.push('');
  lines.push(`- verified identical: ${drift.verified}/${provenance.length}`);
  if (drift.drifted.length) {
    lines.push(`- DRIFTED: ${drift.drifted.length}`); lines.push('');
    for (const d of drift.drifted) lines.push(`  - \`${d.rel}\` pinned=${d.pinned} live=${d.live}`);
  }
  if (drift.unreachable.length) {
    lines.push(`- unreachable (not drift): ${drift.unreachable.length}`);
    for (const u of drift.unreachable.slice(0, 10)) lines.push(`  - \`${u.rel}\` — ${u.error}`);
  }
  if (drift.unmapped.length) {
    lines.push(`- no public URL mapped (manual harvest): ${drift.unmapped.map(u => '`' + u + '`').join(', ')}`);
  }
  lines.push('');
  lines.push('## Fresh cross-check sources');
  lines.push('');
  lines.push('### CBS/NSO geographical codes (opendatanepal CKAN)');
  if (cbs.fetched) {
    lines.push(`- fetched: rows=${cbs.rowCount}`);
    if (cbs.structural.length) lines.push('- structural differences:\n' + cbs.structural.map(s => '  - ' + s).join('\n'));
    if (cbs.resolvable.length) lines.push('- resolvable gaps:\n' + cbs.resolvable.map(r => `  - ${r.palika} [${r.district}] ~> ${r.candidateCode} ("${r.candidateName}")`).join('\n'));
    if (!cbs.structural.length && !cbs.resolvable.length) lines.push('- agrees with our per-district structure; no previously-refused pairing became resolvable.');
  } else {
    lines.push(`- UNREACHABLE this run: ${cbs.unreachable}`);
  }
  lines.push('');
  lines.push('### geoBoundaries NPL ADM3 (local-unit geometry, CC-BY-SA)');
  lines.push(geob.fetched
    ? `- admUnitCount=${geob.admUnitCount}${geob.baseline != null ? ` (baseline ${geob.baseline})` : ''}, yearRepresented=${geob.yearRepresented}, sourceUpdate=${geob.sourceUpdate}`
    : `- UNREACHABLE: ${geob.error}`);
  lines.push('');
  lines.push('### Open Knowledge Nepal LocalBoundaries (CC-BY 4.0)');
  lines.push(lb.fetched
    ? `- features=${lb.features}${lb.baseline != null ? ` (baseline ${lb.baseline})` : ''}, unique normalized names=${lb.uniqueNormalized}`
    : `- UNREACHABLE: ${lb.error}`);
  lines.push('');
  lines.push('### OpenStreetMap (admin_level 7 = palikas)');
  lines.push(osm.fetched
    ? `- admin_level 7 relations=${osm.adminLevel7}${osm.baseline != null ? ` (baseline ${osm.baseline})` : ''}`
    : `- UNREACHABLE: ${osm.error}`);
  lines.push('');
  if (actionable.length) {
    lines.push('## Actionable findings');
    lines.push('');
    for (const a of actionable) lines.push('- ' + a.replace(/\n/g, ' '));
  } else {
    lines.push('## Actionable findings');
    lines.push('');
    lines.push('- None. All differences observed this run are informational.');
  }
  lines.push('');

  fs.mkdirSync(OUT_DIR, { recursive: true });
  const md = lines.join('\n');
  fs.writeFileSync(path.join(OUT_DIR, 'daily-report.md'), md);
  fs.writeFileSync(path.join(OUT_DIR, 'daily-report.json'), JSON.stringify({
    startedUtc, dataAsOf: dataset.meta.dataAsOf,
    snapshot: snap, pinnedDrift: {
      verified: drift.verified,
      drifted: drift.drifted,
      unreachable: drift.unreachable,
      unmapped: drift.unmapped,
    },
    cbs, geoBoundaries: geob, localBoundaries: lb, osm,
    actionable,
  }, null, 2));

  console.log('');
  console.log(md);
  console.log('Report written to watch/daily-report.md and watch/daily-report.json');
  process.exit(actionable.length ? 1 : 0);
}

main().catch(err => {
  console.error('daily watch crashed: ' + (err && err.stack ? err.stack : err));
  process.exit(2);
});
