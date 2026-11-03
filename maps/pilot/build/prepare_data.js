/*
 * Build the pilot's authoritative open-data master.
 *
 * Inputs
 *   maps/nepal_local_levels_coded.geojson  753 coded local levels (already merged)
 *   _geo/district_*.geojson                77 district polygons
 *   _geo/province_nepal.geojson            7 province polygons
 *   _geo/suraj_municipality.geojson        protected/special-area polygons
 *
 * Outputs (maps/pilot/data)
 *   local_levels.geojson
 *   districts.geojson
 *   provinces.geojson
 *   protected_areas.geojson
 *   summary.json
 */
'use strict';

const fs = require('fs');
const path = require('path');

const HERE = __dirname;
const ROOT = path.resolve(HERE, '..', '..', '..');
const OUT = path.resolve(HERE, '..', 'data');
fs.mkdirSync(OUT, { recursive: true });

// ---------------------------------------------------------------------------
// Albers equal-area, the same parameters used by the existing atlas.
// ---------------------------------------------------------------------------
const R = 6371.0;
const LON0 = 84.1;
const LAT0 = 28.4;
const SP1 = 27.0;
const SP2 = 30.0;
const N = (Math.sin(SP1 * Math.PI / 180) + Math.sin(SP2 * Math.PI / 180)) / 2;
const C = Math.cos(SP1 * Math.PI / 180) ** 2 + 2 * N * Math.sin(SP1 * Math.PI / 180);
const RHO0 = Math.sqrt(C - 2 * N * Math.sin(LAT0 * Math.PI / 180)) / N;

function albers(lon, lat) {
  const rho = Math.sqrt(C - 2 * N * Math.sin(lat * Math.PI / 180)) / N;
  const theta = N * (lon - LON0) * Math.PI / 180;
  return [R * rho * Math.sin(theta), R * (RHO0 - rho * Math.cos(theta))];
}

function ringArea(ring) {
  let a = 0;
  for (let i = 0; i < ring.length - 1; i++) {
    const [x0, y0] = albers(ring[i][0], ring[i][1]);
    const [x1, y1] = albers(ring[i + 1][0], ring[i + 1][1]);
    a += x0 * y1 - x1 * y0;
  }
  return Math.abs(a / 2);
}

function ringCentroid(ring) {
  let a = 0, cx = 0, cy = 0;
  for (let i = 0; i < ring.length - 1; i++) {
    const [x0, y0] = albers(ring[i][0], ring[i][1]);
    const [x1, y1] = albers(ring[i + 1][0], ring[i + 1][1]);
    const cross = x0 * y1 - x1 * y0;
    a += cross;
    cx += (x0 + x1) * cross;
    cy += (y0 + y1) * cross;
  }
  a *= 0.5;
  if (Math.abs(a) < 1e-12) return albers(ring[0][0], ring[0][1]);
  return [cx / (6 * a), cy / (6 * a)];
}

function pointInRing(lon, lat, ring) {
  let inside = false;
  for (let i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    const xi = ring[i][0], yi = ring[i][1];
    const xj = ring[j][0], yj = ring[j][1];
    if (((yi > lat) !== (yj > lat)) && (lon < (xj - xi) * (lat - yi) / (yj - yi) + xi)) {
      inside = !inside;
    }
  }
  return inside;
}

function polygonsOf(geom) {
  if (!geom) return [];
  if (geom.type === 'Polygon') return [geom.coordinates];
  if (geom.type === 'MultiPolygon') return geom.coordinates;
  return [];
}

function geometryArea(geom) {
  let a = 0;
  for (const poly of polygonsOf(geom)) {
    if (!poly.length) continue;
    a += ringArea(poly[0]);
    for (let i = 1; i < poly.length; i++) a -= ringArea(poly[i]);
  }
  return Math.abs(a);
}

function representativePoint(geom) {
  let best = null;
  for (const poly of polygonsOf(geom)) {
    if (!poly.length || !poly[0].length) continue;
    const area = ringArea(poly[0]);
    if (!best || area > best.area) best = { area, ring: poly[0] };
  }
  if (!best) return null;
  const [x, y] = ringCentroid(best.ring);
  // Invert the Albers projection for the centre point.
  const xr = x / R, yr = y / R;
  const rho = Math.hypot(xr, RHO0 - yr);
  const theta = Math.atan2(xr, RHO0 - yr);
  const lat = Math.asin((C - (rho * N) ** 2) / (2 * N)) * 180 / Math.PI;
  const lon = LON0 + (theta / N) * 180 / Math.PI;
  if (pointInGeometry(lon, lat, geom)) return [lon, lat];
  // Bbox centre fallback.
  const bb = bboxOf(geom);
  const lon2 = (bb[0] + bb[2]) / 2, lat2 = (bb[1] + bb[3]) / 2;
  if (pointInGeometry(lon2, lat2, geom)) return [lon2, lat2];
  return [best.ring[0][0], best.ring[0][1]];
}

function pointInGeometry(lon, lat, geom) {
  for (const poly of polygonsOf(geom)) {
    if (pointInRing(lon, lat, poly[0])) {
      let inHole = false;
      for (let i = 1; i < poly.length; i++) {
        if (pointInRing(lon, lat, poly[i])) { inHole = true; break; }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

function bboxOf(geom) {
  let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;
  for (const poly of polygonsOf(geom)) {
    for (const ring of poly) {
      for (const [x, y] of ring) {
        if (x < minX) minX = x;
        if (y < minY) minY = y;
        if (x > maxX) maxX = x;
        if (y > maxY) maxY = y;
      }
    }
  }
  return [minX, minY, maxX, maxY];
}

// ---------------------------------------------------------------------------
// Controlled vocabularies
// ---------------------------------------------------------------------------
const PROVINCES = {
  1: ['Koshi Province', 'Koshi', 'कोशी प्रदेश', 'koshi'],
  2: ['Madhesh Province', 'Madhesh', 'मधेश प्रदेश', 'madhesh'],
  3: ['Bagmati Province', 'Bagmati', 'बागमती प्रदेश', 'bagmati'],
  4: ['Gandaki Province', 'Gandaki', 'गण्डकी प्रदेश', 'gandaki'],
  5: ['Lumbini Province', 'Lumbini', 'लुम्बिनी प्रदेश', 'lumbini'],
  6: ['Karnali Province', 'Karnali', 'कर्णाली प्रदेश', 'karnali'],
  7: ['Sudurpashchim Province', 'Sudurpashchim', 'सुदूरपश्चिम प्रदेश', 'sudurpashchim'],
};

const DISTRICT_FIX = {
  'Chitawan': 'Chitwan',
  'Dhanusa': 'Dhanusha',
  'Kapilbastu': 'Kapilvastu',
  'Nawalparasi (East)': 'Nawalpur',
  'Nawalparasi (West)': 'Parasi',
  'Rukum (East)': 'Eastern Rukum',
  'Rukum (West)': 'Western Rukum',
  'Tanahu': 'Tanahun',
  'Terhathum': 'Tehrathum',
};

const DISTRICT_RAW_ALIAS = {
  'TERHATHUM': 'Tehrathum',
  'KAPILBASTU': 'Kapilvastu',
  'DHANUSA': 'Dhanusha',
  'TANAHU': 'Tanahun',
  'MAKAWANPUR': 'Makwanpur',
  'NAWALPARASI_E': 'Nawalpur',
  'NAWALPARASI_W': 'Parasi',
  'RUKUM_E': 'Eastern Rukum',
  'RUKUM_W': 'Western Rukum',
};

const DISTRICT_NP = {
  'Taplejung': 'ताप्लेजुङ', 'Panchthar': 'पाँचथर', 'Ilam': 'इलाम', 'Jhapa': 'झापा',
  'Morang': 'मोरङ', 'Sunsari': 'सुनसरी', 'Dhankuta': 'धनकुटा', 'Tehrathum': 'तेह्रथुम',
  'Sankhuwasabha': 'सङ्खुवासभा', 'Bhojpur': 'भोजपुर', 'Solukhumbu': 'सोलुखुम्बु',
  'Okhaldhunga': 'ओखलढुङ्गा', 'Khotang': 'खोटाङ', 'Udayapur': 'उदयपुर',
  'Saptari': 'सप्तरी', 'Siraha': 'सिराहा', 'Dhanusha': 'धनुषा', 'Mahottari': 'महोत्तरी',
  'Sarlahi': 'सर्लाही', 'Rautahat': 'रौतहट', 'Bara': 'बारा', 'Parsa': 'पर्सा',
  'Dolakha': 'दोलखा', 'Sindhupalchok': 'सिन्धुपाल्चोक', 'Rasuwa': 'रसुवा', 'Dhading': 'धादिङ',
  'Nuwakot': 'नुवाकोट', 'Kathmandu': 'काठमाडौं', 'Bhaktapur': 'भक्तपुर', 'Lalitpur': 'ललितपुर',
  'Kavrepalanchok': 'काभ्रेपलाञ्चोक', 'Ramechhap': 'रामेछाप', 'Sindhuli': 'सिन्धुली',
  'Makwanpur': 'मकवानपुर', 'Chitwan': 'चितवन',
  'Gorkha': 'गोरखा', 'Lamjung': 'लामजुङ', 'Tanahun': 'तनहुँ', 'Syangja': 'स्याङ्जा',
  'Kaski': 'कास्की', 'Manang': 'मनाङ', 'Mustang': 'मुस्ताङ', 'Myagdi': 'म्याग्दी',
  'Parbat': 'पर्वत', 'Baglung': 'बागलुङ', 'Nawalpur': 'नवलपुर',
  'Gulmi': 'गुल्मी', 'Palpa': 'पाल्पा', 'Arghakhanchi': 'अर्घाखाँची', 'Kapilvastu': 'कपिलवस्तु',
  'Rupandehi': 'रुपन्देही', 'Dang': 'दाङ', 'Pyuthan': 'प्युठान', 'Rolpa': 'रोल्पा',
  'Eastern Rukum': 'पूर्वी रुकुम', 'Banke': 'बाँके', 'Bardiya': 'बर्दिया', 'Parasi': 'परासी',
  'Western Rukum': 'पश्चिमी रुकुम', 'Salyan': 'सल्यान', 'Dolpa': 'डोल्पा', 'Humla': 'हुम्ला',
  'Jumla': 'जुम्ला', 'Kalikot': 'कालिकोट', 'Mugu': 'मुगु', 'Surkhet': 'सुर्खेत',
  'Dailekh': 'दैलेख', 'Jajarkot': 'जाजरकोट',
  'Bajura': 'बाजुरा', 'Bajhang': 'बझाङ', 'Achham': 'अछाम', 'Doti': 'डोटी',
  'Kailali': 'कैलाली', 'Kanchanpur': 'कञ्चनपुर', 'Dadeldhura': 'डडेल्धुरा',
  'Baitadi': 'बैतडी', 'Darchula': 'दार्चुला',
};

const TYPE_EN_SUFFIX = {
  'Metropolitan City': 'Metropolitan City',
  'Sub-Metropolitan City': 'Sub-Metropolitan City',
  'Urban Municipality': 'Municipality',
  'Rural Municipality': 'Rural Municipality',
};

const TYPE_NP = {
  'Metropolitan City': 'महानगरपालिका',
  'Sub-Metropolitan City': 'उपमहानगरपालिका',
  'Urban Municipality': 'नगरपालिका',
  'Rural Municipality': 'गाउँपालिका',
};

// Pilot-specific spelling corrections. The source table is the authority for
// codes; these corrections align the map labels with current municipal names.
const LOCAL_FIX = {
  '30601': { en: 'Shankharapur Municipality', np: 'शङ्खरापुर नगरपालिका', short: 'Shankharapur' },
  '30602': { en: 'Kageshwori Manohara Municipality', np: 'कागेश्वरी मनोहरा नगरपालिका', short: 'Kageshwori Manohara' },
  '30603': { en: 'Gokarneshwar Municipality', np: 'गोकर्णेश्वर नगरपालिका', short: 'Gokarneshwar' },
  '30604': { en: 'Budhanilkantha Municipality', np: 'बुढानीलकण्ठ नगरपालिका', short: 'Budhanilkantha' },
  '30606': { en: 'Tarakeshwar Municipality', np: 'तारकेश्वर नगरपालिका', short: 'Tarakeshwar' },
  '30607': { en: 'Nagarjun Municipality', np: 'नागार्जुन नगरपालिका', short: 'Nagarjun' },
  '30608': { en: 'Kathmandu Metropolitan City', np: 'काठमाडौं महानगरपालिका', short: 'Kathmandu' },
  '30609': { en: 'Kirtipur Municipality', np: 'कीर्तिपुर नगरपालिका', short: 'Kirtipur' },
};

const SOURCE = {
  boundaries: 'Open Knowledge Nepal, LocalBoundaries (CC BY 4.0)',
  codes: 'Official local-unit code table supplied with the project (1695378470_83.xls)',
  edition: 'Open-data pilot edition',
  date: 'October 2026',
};

function cleanDistrict(name) {
  return DISTRICT_FIX[name] || name;
}

function normalizeKey(s) {
  return String(s || '').toUpperCase().replace(/[^A-Z0-9]/g, '');
}

// ---------------------------------------------------------------------------
// Load coded local levels
// ---------------------------------------------------------------------------
const codedPath = path.join(ROOT, 'maps', 'nepal_local_levels_coded.geojson');
const coded = JSON.parse(fs.readFileSync(codedPath, 'utf8'));
if (coded.features.length !== 753) {
  throw new Error('Expected 753 coded local levels, got ' + coded.features.length);
}

const localFeatures = coded.features.map((f) => {
  const p = f.properties;
  const code = String(p.code);
  const fix = LOCAL_FIX[code] || {};
  const prov = PROVINCES[String(p.province_code)];
  const districtName = cleanDistrict(p.district_name);
  const districtNp = DISTRICT_NP[districtName] || '';
  const geom = f.geometry;
  const labelLon = p.label_lon;
  const labelLat = p.label_lat;
  const labelInside = labelLon != null && labelLat != null && pointInGeometry(labelLon, labelLat, geom);
  const rep = labelInside ? [labelLon, labelLat] : representativePoint(geom);
  return {
    type: 'Feature',
    id: code,
    properties: {
      code,
      name_en: fix.en || `${p.local_unit_short} ${TYPE_EN_SUFFIX[p.unit_type] || ''}`.trim(),
      name_en_short: fix.short || p.local_unit_short,
      name_np: fix.np || p.local_unit_np,
      unit_type: p.unit_type,
      unit_type_np: TYPE_NP[p.unit_type] || '',
      province_code: Number(p.province_code),
      province_name: prov[0],
      province_name_short: prov[1],
      province_name_np: prov[2],
      district_code: Number(p.district_code),
      district_name: districtName,
      district_name_np: districtNp,
      parts: p.parts,
      area_km2: Math.round(geometryArea(geom) * 100) / 100,
      label_lon: rep ? Math.round(rep[0] * 1e6) / 1e6 : null,
      label_lat: rep ? Math.round(rep[1] * 1e6) / 1e6 : null,
      label_source: labelInside ? 'source' : 'derived',
    },
    geometry: geom,
  };
});

// ---------------------------------------------------------------------------
// Districts
// ---------------------------------------------------------------------------
const districtByOldName = new Map();
for (const f of localFeatures) {
  const p = f.properties;
  if (!districtByOldName.has(p.district_code)) {
    districtByOldName.set(p.district_code, {
      code: p.district_code,
      name: p.district_name,
      name_np: p.district_name_np,
      province_code: p.province_code,
      province_name: p.province_name,
      province_name_np: p.province_name_np,
      largest: f,
    });
  } else {
    const d = districtByOldName.get(p.district_code);
    if (p.area_km2 > d.largest.properties.area_km2) d.largest = f;
  }
}
if (districtByOldName.size !== 77) throw new Error('Expected 77 districts, got ' + districtByOldName.size);

const districtsRaw = [];
for (const slug of ['koshi', 'madhesh', 'bagmati', 'gandaki', 'lumbini', 'karnali', 'sudurpashchim']) {
  const p = path.join(ROOT, '_geo', `district_${slug}.geojson`);
  const gj = JSON.parse(fs.readFileSync(p, 'utf8'));
  for (const f of gj.features) {
    const raw = String(f.properties.DISTRICT || '').toUpperCase();
    let fixed = DISTRICT_RAW_ALIAS[raw] || raw.replace(/_E$/, ' East').replace(/_W$/, ' West')
      .replace(/^NAWALPARASI EAST$/, 'Nawalparasi (East)')
      .replace(/^NAWALPARASI WEST$/, 'Nawalparasi (West)')
      .replace(/^RUKUM EAST$/, 'Rukum (East)')
      .replace(/^RUKUM WEST$/, 'Rukum (West)')
      .replace(/^KABHREPALANCHOK$/, 'Kavrepalanchok')
      .replace(/^CHITAWAN$/, 'Chitawan');
    fixed = DISTRICT_RAW_ALIAS[fixed] || fixed;
    const canonical = cleanDistrict(fixed);
    const match = [...districtByOldName.values()].find((d) =>
      normalizeKey(d.name) === normalizeKey(canonical) || normalizeKey(d.name) === normalizeKey(raw));
    if (!match) throw new Error(`Cannot match district ${raw} (${canonical})`);
    districtsRaw.push({ f, match });
  }
}
if (districtsRaw.length !== 77) throw new Error('Expected 77 district polygons, got ' + districtsRaw.length);

const districtFeatures = districtsRaw.map(({ f, match }) => {
  const lp = match.largest.properties;
  return {
    type: 'Feature',
    id: String(match.code),
    properties: {
      district_code: match.code,
      district_name: match.name,
      district_name_np: match.name_np,
      province_code: match.province_code,
      province_name: match.province_name,
      province_name_np: match.province_name_np,
      area_km2: Math.round(geometryArea(f.geometry) * 100) / 100,
      label_lon: lp.label_lon,
      label_lat: lp.label_lat,
      local_count: localFeatures.filter((x) => x.properties.district_code === match.code).length,
    },
    geometry: f.geometry,
  };
});

// ---------------------------------------------------------------------------
// Provinces
// ---------------------------------------------------------------------------
const provRaw = JSON.parse(fs.readFileSync(path.join(ROOT, '_geo', 'province_nepal.geojson'), 'utf8'));
const provinceFeatures = provRaw.features.map((f) => {
  const pcode = Number(f.properties.PROVINCE);
  const prov = PROVINCES[pcode];
  const dlist = districtFeatures.filter((d) => d.properties.province_code === pcode);
  const anchor = representativePoint(f.geometry);
  return {
    type: 'Feature',
    id: String(pcode),
    properties: {
      province_code: pcode,
      province_name: prov[0],
      province_name_short: prov[1],
      province_name_np: prov[2],
      area_km2: Math.round(geometryArea(f.geometry) * 100) / 100,
      district_count: dlist.length,
      local_count: localFeatures.filter((x) => x.properties.province_code === pcode).length,
      label_lon: anchor ? Math.round(anchor[0] * 1e6) / 1e6 : null,
      label_lat: anchor ? Math.round(anchor[1] * 1e6) / 1e6 : null,
    },
    geometry: f.geometry,
  };
});

// ---------------------------------------------------------------------------
// Protected / special areas (overlay only, never administrative holes)
// ---------------------------------------------------------------------------
const rawPath = path.join(ROOT, '_geo', 'suraj_municipality.geojson');
const raw = JSON.parse(fs.readFileSync(rawPath, 'utf8'));
const protectedGroups = new Map();
for (const f of raw.features) {
  const p = f.properties;
  if (p.municipality_code) continue;
  const name = (p.gapa_napa || p.GaPa_NaPa || 'Protected area').trim();
  if (!protectedGroups.has(name)) protectedGroups.set(name, []);
  protectedGroups.get(name).push(...polygonsOf(f.geometry));
}
const protectedFeatures = [...protectedGroups.entries()].map(([name, polys], i) => {
  const geom = { type: 'MultiPolygon', coordinates: polys };
  const rep = representativePoint(geom);
  return {
    type: 'Feature',
    id: `P${String(i + 1).padStart(2, '0')}`,
    properties: {
      name_en: name,
      name_np: '',
      area_km2: Math.round(geometryArea(geom) * 100) / 100,
      label_lon: rep ? rep[0] : null,
      label_lat: rep ? rep[1] : null,
    },
    geometry: geom,
  };
});

// ---------------------------------------------------------------------------
// Summary
// ---------------------------------------------------------------------------
const typeCounts = {};
for (const f of localFeatures) {
  typeCounts[f.properties.unit_type] = (typeCounts[f.properties.unit_type] || 0) + 1;
}
const summary = {
  generated: new Date().toISOString(),
  edition: SOURCE.edition,
  date: SOURCE.date,
  counts: {
    provinces: provinceFeatures.length,
    districts: districtFeatures.length,
    local_levels: localFeatures.length,
    protected_areas: protectedFeatures.length,
    types: typeCounts,
  },
  provinces: provinceFeatures.map((p) => ({
    code: p.properties.province_code,
    name: p.properties.province_name,
    name_np: p.properties.province_name_np,
    districts: p.properties.district_count,
    local_levels: p.properties.local_count,
    area_km2: p.properties.area_km2,
  })),
  sources: SOURCE,
  accuracy_note: 'Open-data geometry. Not survey-grade and not a legal boundary determination.',
};
if (summary.counts.local_levels !== 753) throw new Error('Local level count mismatch');
if (summary.counts.districts !== 77) throw new Error('District count mismatch');
if (summary.counts.provinces !== 7) throw new Error('Province count mismatch');

function write(name, obj) {
  const p = path.join(OUT, name);
  fs.writeFileSync(p, JSON.stringify(obj));
  console.log('wrote', p, (fs.statSync(p).size / 1024).toFixed(1) + ' KB');
}
write('local_levels.geojson', { type: 'FeatureCollection', name: 'Nepal local levels (753)', features: localFeatures });
write('districts.geojson', { type: 'FeatureCollection', name: 'Nepal districts (77)', features: districtFeatures });
write('provinces.geojson', { type: 'FeatureCollection', name: 'Nepal provinces (7)', features: provinceFeatures });
write('protected_areas.geojson', { type: 'FeatureCollection', name: 'Protected and special areas', features: protectedFeatures });
fs.writeFileSync(path.join(OUT, 'summary.json'), JSON.stringify(summary, null, 2));
console.log(JSON.stringify(summary.counts, null, 2));
