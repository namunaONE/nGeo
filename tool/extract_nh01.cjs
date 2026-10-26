// tool/extract_nh01.cjs — one-shot extractor for the H1 overlay:
// NH01 (Mahendra / Hulaki Highway, Kakarbhitta → Bhim Datta) from OSM.
//
// Runs on a GitHub Actions runner (network required; never runs in the
// normal CI gates — the vendored docs/nh01-highway.geojson is the
// committed artifact and this script is its provenance pin: relation
// IDs, exact Overpass query, extract date and license are recorded in
// the file's metadata member). Node 20+, no npm deps.
//
// Usage: node tool/extract_nh01.cjs   (writes docs/nh01-highway.geojson)
// Exit 0 = pass; a wrong-looking extract fails loudly instead of
// shipping: end termini must land in Jhapa (east) and Kanchanpur (west),
// and computed length must fall in the 800–1300 km corridor.
'use strict';
const fs = require('fs');
const path = require('path');

const NEPAL_BBOX = [26.2, 79.8, 30.7, 88.5]; // S, W, N, E — Nepal + Kalapani
const ENDPOINTS = [
  // [lat, lng, radiusDeg, label] — ground truth from the corridor itself.
  [26.68, 88.15, 0.35, 'Kakarbhitta (Jhapa, east end)'],
  [28.96, 80.18, 0.35, 'Bhim Datta (Kanchanpur, west end)'],
];
const LENGTH_MIN_KM = 800;
const LENGTH_MAX_KM = 1300;
const MIN_WAYS = 50;

// World-data mirrors, tried in order (see NOTICE for the ODbL position).
const OVERPASS = [
  'https://overpass-api.de/api/interpreter',
  'https://overpass.kumi.systems/api/interpreter',
  'https://overpass.private.coffee/api/interpreter',
  'https://overpass.osm.jp/api/interpreter',
];

async function overpass(query) {
  for (const base of OVERPASS) {
    try {
      const res = await fetch(base + '?data=' + encodeURIComponent(query), {
        headers: { 'User-Agent': 'namunaONE/nGeo extract_nh01 (one-shot pin refresh)' },
      });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const json = await res.json();
      if (json && Array.isArray(json.elements)) return json;
      throw new Error('unexpected payload shape');
    } catch (err) {
      console.error('overpass mirror failed:', base, String(err.message || err));
    }
  }
  throw new Error('all Overpass mirrors failed');
}

function haversineKm(a, b) {
  const R = 6371.0088;
  const toRad = (d) => (d * Math.PI) / 180;
  const dLat = toRad(b[1] - a[1]);
  const dLng = toRad(b[0] - a[0]);
  const s =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(a[1])) * Math.cos(toRad(b[1])) * Math.sin(dLng / 2) ** 2;
  return 2 * R * Math.asin(Math.sqrt(s));
}

async function main() {
  // 1) Find the NH01 route relation(s): ref=NH01 is the DoR numbering
  //    carried by OSM mappers; the name variant is a fallback so a
  //    retagged relation is still found.
  const findQuery =
    '[out:json][timeout:120];' +
    '(' +
    'relation["ref"="NH01"](' + NEPAL_BBOX.join(',') + ');' +
    'relation["name"~"[Mm]ahendra",i](' + NEPAL_BBOX.join(',') + ');' +
    ');out tags;';
  const found = await overpass(findQuery);
  const relations = found.elements.filter(
    (e) => e.type === 'relation' && e.tags &&
      ((e.tags.ref === 'NH01' && e.tags.route === 'road') ||
        /mahendra/i.test(e.tags.name || '')));
  if (!relations.length) {
    throw new Error('no NH01 / Mahendra route relation found in Nepal bbox');
  }
  const ids = relations.map((r) => r.id);
  console.log('relations:', ids.join(', '), relations.map((r) => r.tags.name));

  // 2) Member ways with geometry.
  const wayQuery =
    '[out:json][timeout:300];' +
    'relation(id:' + ids.join(',') + ');' +
    'way(r);' +
    'out geom;';
  const ways = await overpass(wayQuery);
  const features = [];
  for (const w of ways.elements) {
    if (w.type !== 'way' || !Array.isArray(w.geometry)) continue;
    // Quantise to 1e-4 degrees (~11 m), the house resolution shared
    // with the palika boundary layer — lossless for map display.
    const coords = w.geometry
      .filter((g) => g && typeof g.lat === 'number' && typeof g.lon === 'number')
      .map((g) => [+g.lon.toFixed(4), +g.lat.toFixed(4)]);
    if (coords.length < 2) continue;
    features.push({
      type: 'Feature',
      properties: {
        osmId: w.id,
        name: w.tags && w.tags.name ? w.tags.name : null,
        ref: w.tags && w.tags.ref ? w.tags.ref : 'NH01',
        highway: w.tags && w.tags.highway ? w.tags.highway : null,
        oneway: w.tags && w.tags.oneway ? w.tags.oneway : null,
      },
      geometry: { type: 'LineString', coordinates: coords },
    });
  }

  // 3) Aggregate + validate: length, termini proximity, way count.
  let lengthKm = 0;
  let nodes = 0;
  let minLng = 180, maxLng = -180, minLat = 90, maxLat = -90;
  for (const f of features) {
    const c = f.geometry.coordinates;
    nodes += c.length;
    for (const p of c) {
      if (p[0] < minLng) minLng = p[0];
      if (p[0] > maxLng) maxLng = p[0];
      if (p[1] < minLat) minLat = p[1];
      if (p[1] > maxLat) maxLat = p[1];
    }
    for (let i = 1; i < c.length; i++) lengthKm += haversineKm(c[i - 1], c[i]);
  }
  lengthKm = Math.round(lengthKm * 10) / 10;
  console.log('ways:', features.length, 'nodes:', nodes,
    'lengthKm:', lengthKm, 'bbox:', [minLng, minLat, maxLng, maxLat].join(','));

  if (features.length < MIN_WAYS) {
    throw new Error('too few member ways: ' + features.length);
  }
  if (lengthKm < LENGTH_MIN_KM || lengthKm > LENGTH_MAX_KM) {
    throw new Error('length out of corridor: ' + lengthKm + ' km');
  }
  for (const [lat, lng, radius, label] of ENDPOINTS) {
    let best = Infinity;
    for (const f of features) {
      for (const p of f.geometry.coordinates) {
        const d = Math.max(Math.abs(p[0] - lng), Math.abs(p[1] - lat));
        if (d < best) best = d;
      }
    }
    if (best > radius) {
      throw new Error('terminus not found near ' + label + ' (best Δ=' + best.toFixed(3) + '°)');
    }
    console.log('terminus ok:', label, 'Δ=' + best.toFixed(3) + '°');
  }

  // 4) Write the artifact with its provenance metadata member.
  const out = {
    type: 'FeatureCollection',
    metadata: {
      id: 'nh01',
      nameEn: 'Mahendra Highway (NH01)',
      route: 'Kakarbhitta (Jhapa) — Bhim Datta (Kanchanpur)',
      source: 'OpenStreetMap',
      license: 'ODbL 1.0 — © OpenStreetMap contributors; https://opendatacommons.org/licenses/odbl/',
      osmRelationIds: ids,
      overpassFindQuery: findQuery,
      overpassWayQuery: wayQuery,
      extractedAt: new Date().toISOString().slice(0, 10),
      wayCount: features.length,
      nodeCount: nodes,
      lengthKm: lengthKm,
      quantisationDeg: 0.0001,
      bbox: [minLng, minLat, maxLng, maxLat],
      generator: 'tool/extract_nh01.cjs',
    },
    features: features,
  };
  const dest = path.join(__dirname, '..', 'docs', 'nh01-highway.geojson');
  fs.writeFileSync(dest, JSON.stringify(out));
  console.log('wrote', dest, (fs.statSync(dest).size / 1024).toFixed(0) + ' KB');
}

main().catch((err) => {
  console.error('EXTRACT FAILED:', err && err.message ? err.message : err);
  process.exit(1);
});
