/*
 * Build the web prototype's offline data bundle.
 *
 * Inputs (web/data)
 *   local_5.geojson        753 local levels, 5% simplified
 *   districts_web.geojson  77 districts, dissolved from locals
 *   provinces_web.geojson  7 provinces, dissolved from locals
 *
 * Reference inputs (pilot/data)
 *   districts.geojson, provinces.geojson, summary.json
 *
 * Output
 *   web/data/atlas.js  ->  window.ATLAS
 *
 * Geometry stays WGS84 (EPSG:4326) for Leaflet. District and province
 * layers are dissolved from the same simplified local geometry, so the
 * three layers share edges and do not produce slivers.
 */
'use strict';

const fs = require('fs');
const path = require('path');

const HERE = __dirname;
const WEB = path.resolve(HERE, '..', 'web');
const DATA = path.resolve(HERE, '..', 'data');
const OUT = path.join(WEB, 'data', 'atlas.js');

const read = (p) => JSON.parse(fs.readFileSync(p, 'utf8'));

const locals = read(path.join(WEB, 'data', 'local_5.geojson'));
const districts = read(path.join(WEB, 'data', 'districts_web.geojson'));
const provinces = read(path.join(WEB, 'data', 'provinces_web.geojson'));

const masterDistricts = read(path.join(DATA, 'districts.geojson')).features;
const masterProvinces = read(path.join(DATA, 'provinces.geojson')).features;
const summary = read(path.join(DATA, 'summary.json'));

const dByCode = new Map(masterDistricts.map((f) => [String(f.properties.district_code), f.properties]));
const pByCode = new Map(masterProvinces.map((f) => [String(f.properties.province_code), f.properties]));

let merged = 0;
for (const f of districts.features) {
  const p = f.properties;
  const src = dByCode.get(String(p.district_code));
  if (!src) throw new Error('Missing master district ' + p.district_code);
  p.area_km2 = src.area_km2;
  p.local_count = src.local_count;
  p.label_lon = src.label_lon;
  p.label_lat = src.label_lat;
  merged++;
}

for (const f of provinces.features) {
  const p = f.properties;
  const src = pByCode.get(String(p.province_code));
  if (!src) throw new Error('Missing master province ' + p.province_code);
  p.area_km2 = src.area_km2;
  p.district_count = src.district_count;
  p.local_count = src.local_count;
  p.label_lon = src.label_lon;
  p.label_lat = src.label_lat;
}

// Sanity checks so a bad merge cannot silently ship.
const localCodes = new Set(locals.features.map((f) => String(f.properties.code)));
if (locals.features.length !== 753 || localCodes.size !== 753) {
  throw new Error('Local level count/codes mismatch');
}
if (districts.features.length !== 77) throw new Error('District count mismatch');
if (provinces.features.length !== 7) throw new Error('Province count mismatch');

// Some protected areas are outside the local-level geometry. Dissolving the
// province layer leaves them as interior rings. Keep those rings as explicit
// gap features so the web map can mark them as "no local-level data" instead
// of letting the page background read as a highlighted polygon.
const gaps = [];
for (const f of provinces.features) {
  const polys = f.geometry.type === 'Polygon'
    ? [f.geometry.coordinates]
    : f.geometry.type === 'MultiPolygon'
      ? f.geometry.coordinates
      : [];
  for (const poly of polys) {
    for (let h = 1; h < poly.length; h++) {
      gaps.push({
        type: 'Feature',
        properties: {
          province_code: f.properties.province_code,
          province_name: f.properties.province_name,
          name_en: 'No local-level data',
          name_np: 'स्थानीय तह विवरण छैन',
        },
        geometry: { type: 'Polygon', coordinates: [poly[h]] },
      });
    }
  }
}

const provinceStats = provinces.features
  .map((f) => {
    const p = f.properties;
    const districtCodes = districts.features
      .filter((d) => d.properties.province_code === p.province_code)
      .map((d) => String(d.properties.district_code));
    return {
      code: p.province_code,
      name_en: p.province_name,
      name_np: p.province_name_np,
      name_short: p.province_name_short,
      districts: p.district_count,
      locals: p.local_count,
      area_km2: p.area_km2,
      label_lon: p.label_lon,
      label_lat: p.label_lat,
      district_codes: districtCodes,
    };
  })
  .sort((a, b) => a.code - b.code);

const districtStats = districts.features
  .map((f) => {
    const p = f.properties;
    return {
      code: String(p.district_code),
      name_en: p.district_name,
      name_np: p.district_name_np,
      province_code: p.province_code,
      province_name: p.province_name,
      province_name_short: p.province_name_short,
      locals: p.local_count,
      area_km2: p.area_km2,
      label_lon: p.label_lon,
      label_lat: p.label_lat,
    };
  })
  .sort((a, b) => Number(a.code) - Number(b.code));

const meta = {
  title_en: 'Nepal Local Level Atlas',
  title_np: 'नेपाल स्थानीय तह एटलस',
  subtitle_en: 'Provinces · districts · 753 local levels',
  subtitle_np: 'प्रदेश · जिल्ला · ७५३ स्थानीय तह',
  edition_en: 'Open-data pilot edition',
  edition_np: 'खुला तथ्याङ्क पाइलट संस्करण',
  date_en: 'October 2026',
  date_np: 'अक्टोबर २०२६',
  generated: new Date().toISOString(),
  counts: {
    provinces: provinces.features.length,
    districts: districts.features.length,
    locals: locals.features.length,
    types: summary.counts.types,
  },
  area_km2: Math.round(provinceStats.reduce((a, p) => a + p.area_km2, 0) * 100) / 100,
  sources: {
    boundaries: 'Survey Department of Nepal via HDX COD-AB (edge-matched, CC BY 4.0)',
    codes: 'Official 753-unit code table supplied with the project',
    projection: 'WGS 84 · EPSG:4326',
  },
  disclaimer_en: 'Open-data pilot edition. Boundaries are generalised, are not survey-grade, and are not a legal or cadastral boundary determination. Wards are deferred to Phase 2.',
  disclaimer_np: 'खुला तथ्याङ्क पाइलट संस्करण। सिमानाहरू सामान्यीकृत छन्, सर्वेक्षण-स्तरीय होइनन्, र कानूनी वा क्याडस्ट्रल सिमाना निर्धारण होइनन्। वडाहरू दोस्रो चरणमा समावेश गरिनेछ।',
  sheets: [
    { id: 'national', sheet: '01', title_en: 'National overview', title_np: 'राष्ट्रिय अवलोकन', scope_en: 'A1 · 7 provinces, 77 districts, 753 local levels', scope_np: 'A1 · ७ प्रदेश, ७७ जिल्ला, ७५३ स्थानीय तह', pdf: '../print/01_national.pdf', html: '../print/01_national.html' },
    { id: 'bagmati', sheet: '02', title_en: 'Bagmati Province', title_np: 'बागमती प्रदेश', scope_en: 'A2 · 13 districts, 119 local levels', scope_np: 'A2 · १३ जिल्ला, ११९ स्थानीय तह', pdf: '../print/02_bagmati.pdf', html: '../print/02_bagmati.html' },
    { id: 'kathmandu', sheet: '03', title_en: 'Kathmandu District', title_np: 'काठमाडौं जिल्ला', scope_en: 'A3 · 11 local levels', scope_np: 'A3 · ११ स्थानीय तह', pdf: '../print/03_kathmandu.pdf', html: '../print/03_kathmandu.html' },
  ],
  capital: { name_en: 'Kathmandu', name_np: 'काठमाडौं', lon: 85.3240, lat: 27.7172 },
};

const payload = {
  meta,
  provinces,
  districts,
  locals,
  gaps,
  provinceStats,
  districtStats,
};

fs.writeFileSync(
  OUT,
  '/* Nepal Local Level Atlas — offline data bundle. Generated by build/make_web_data.js. */\n' +
  'window.ATLAS = ' + JSON.stringify(payload) + ';\n'
);

const kb = (fs.statSync(OUT).size / 1024).toFixed(0);
console.log('wrote', OUT, kb + ' KB');
console.log('provinces', provinces.features.length, 'districts', districts.features.length, 'locals', locals.features.length);
console.log('gaps', gaps.length);
console.log('merged district stats', merged);
console.log('area', meta.area_km2, 'km²');
