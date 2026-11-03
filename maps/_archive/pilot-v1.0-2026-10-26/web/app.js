/* ==========================================================================
   Nepal Local Level Atlas — web pilot
   Leaflet + inline WGS84 geometry. No external basemap or network requests.
   ========================================================================== */
(() => {
  'use strict';

  const A = window.ATLAS;
  const loading = document.getElementById('loading');
  const loadingTitle = document.getElementById('loading-title');
  const loadingSub = document.getElementById('loading-sub');

  function fatal(message) {
    if (!loading) return;
    loading.classList.remove('hidden');
    loading.classList.add('error');
    if (loadingTitle) loadingTitle.textContent = 'The atlas could not start';
    if (loadingSub) loadingSub.textContent = message;
    document.title = 'Atlas error';
  }

  if (!window.L || !A) {
    fatal(!window.L ? 'Leaflet failed to load.' : 'The data bundle failed to load.');
    return;
  }

  const meta = A.meta;
  const NEP_DIGITS = '०१२३४५६७८९';
  const VALLEY_NAMES = ['Kathmandu', 'Bhaktapur', 'Lalitpur'];

  const PROVINCE_STYLE = {
    1: { fill: '#DCE8D4', line: '#6E8A6C', dark: '#4F6F52' },
    2: { fill: '#F2E2C8', line: '#B08A4E', dark: '#8A6634' },
    3: { fill: '#D7E5F1', line: '#5E8FB5', dark: '#3F6F95' },
    4: { fill: '#E7DDF0', line: '#8B74A8', dark: '#6A5488' },
    5: { fill: '#F3D8D2', line: '#B97A6E', dark: '#95574D' },
    6: { fill: '#E7E1C8', line: '#A89A5E', dark: '#80733F' },
    7: { fill: '#D5EAE6', line: '#5FA39B', dark: '#3F7F78' },
  };

  function provinceColor(code) {
    return PROVINCE_STYLE[Number(code)] || {
      fill: '#E7E2D6', line: '#8C8577', dark: '#4B5563',
    };
  }

  const I18N = {
    en: {
      brandKicker: 'Nepal · Local Level Atlas',
      brandTitle: 'Provinces, districts & local levels',
      searchPlaceholder: 'Search a place, district, or code…',
      searchAria: 'Search provinces, districts and local levels',
      clearSearch: 'Clear search',
      sheetsLink: 'Print sheets',
      accuracyShort: 'Open-data pilot — generalised boundaries, not survey-grade or a legal boundary determination.',
      accuracyDetails: 'Details',
      loadingTitle: 'Preparing the atlas…',
      currentView: 'Current view · open-data pilot',
      atlasTitle: 'Nepal Local Level Atlas',
      intro: 'A bilingual, open-data reference atlas of Nepal’s seven provinces, 77 districts and 753 local levels. Explore the pilot map, then open the print sheets.',
      provinces: 'provinces',
      districts: 'districts',
      localLevels: 'local levels',
      km2: 'km²',
      province: 'province',
      district: 'district',
      localLevel: 'local level',
      districtsShort: 'districts',
      localsShort: 'locals',
      quickViews: 'Quick views',
      qNational: 'National',
      qNationalSub: 'All Nepal · 7 · 77 · 753',
      qBagmati: 'Bagmati',
      qBagmatiSub: '13 districts',
      qValley: 'Kathmandu Valley',
      qValleySub: '3 districts · 21 locals',
      qKathmandu: 'Kathmandu District',
      qKathmanduSub: '11 local levels',
      layers: 'Layers',
      layerProvinces: 'Province fills',
      layerProvincesNote: 'Colour by province',
      layerDistricts: 'District boundaries',
      layerDistrictsNote: 'All 77 districts',
      layerLocals: 'Local levels',
      layerLocalsNote: 'Shown at zoom 9 and above',
      layerLabels: 'Place labels',
      layerLabelsNote: 'Names change with zoom',
      layerGraticule: 'Graticule',
      layerGraticuleNote: 'Latitude and longitude',
      accuracyTitle: 'Accuracy notice',
      notSurvey: 'Pilot · not survey-grade',
      phase2: 'Wards and the full 753-unit atlas follow in Phase 2.',
      printSheets: 'Print sheets',
      printSheetsNote: 'Three pilot sheets, A1–A3, as PDF and HTML.',
      sources: 'Sources',
      sourceBoundaries: 'Boundaries: Open Knowledge Nepal, LocalBoundaries (CC BY 4.0).',
      sourceCodes: 'Codes: official 753-unit table.',
      sourceProjection: 'Projection: WGS 84 · EPSG:4326.',
      offline: 'Offline-ready · no external basemap',
      builtWith: 'Leaflet 1.9.4',
      capital: 'National capital',
      searchHint: 'Search 753 local levels, 77 districts and 7 provinces.',
      searchExamples: 'Try',
      searchNoResults: 'No place found. Try a name or a code.',
      typeProvince: 'Province',
      typeDistrict: 'District',
      typeLocal: 'Local',
      zoomDistrict: 'Zoom to district',
      viewProvince: 'View province',
      zoomProvince: 'Zoom to province',
      codeLabel: 'Code',
      areaLabel: 'Area',
      legendTitle: 'Legend',
      legendProvince: 'Province fill',
      legendDistrict: 'District boundary',
      legendLocal: 'Local-level boundary',
      legendGap: 'No local-level data',
      legendCapital: 'National capital',
      legendNote: 'Open-data geometry · not survey-grade',
      mapBadge: 'Pilot · not survey-grade',
      zoomHintDistricts: 'Zoom in for districts and local levels',
      zoomHintLocals: 'Zoom in for local levels',
      close: 'Close',
      placesLayers: 'Places & layers',
      popupLocalList: 'Local levels in this district',
      popupDistrictList: 'Districts in this province',
      mapAria: 'Interactive map of Nepal',
      loadingSub: '7 provinces · 77 districts · 753 local levels',
      currentViewSub: 'Current view',
    },
    ne: {
      brandKicker: 'नेपाल · स्थानीय तह एटलस',
      brandTitle: 'प्रदेश, जिल्ला र स्थानीय तह',
      searchPlaceholder: 'ठाउँ, जिल्ला वा कोड खोज्नुहोस्…',
      searchAria: 'प्रदेश, जिल्ला र स्थानीय तह खोज्नुहोस्',
      clearSearch: 'खोजी हटाउनुहोस्',
      sheetsLink: 'प्रिन्ट शीट',
      accuracyShort: 'खुला तथ्याङ्क पाइलट — सामान्यीकृत सिमाना, सर्वेक्षण-स्तरीय वा कानूनी सिमाना होइन।',
      accuracyDetails: 'विवरण',
      loadingTitle: 'एटलस तयार हुँदैछ…',
      currentView: 'हालको दृश्य · खुला तथ्याङ्क पाइलट',
      atlasTitle: 'नेपाल स्थानीय तह एटलस',
      intro: 'नेपालका सात प्रदेश, ७७ जिल्ला र ७५३ स्थानीय तहको द्विभाषिक, खुला तथ्याङ्क सन्दर्भ एटलस। नक्सा हेर्नुहोस् र प्रिन्ट शीट खोल्नुहोस्।',
      provinces: 'प्रदेश',
      districts: 'जिल्ला',
      localLevels: 'स्थानीय तह',
      km2: 'किमी²',
      province: 'प्रदेश',
      district: 'जिल्ला',
      localLevel: 'स्थानीय तह',
      districtsShort: 'जिल्ला',
      localsShort: 'स्थानीय तह',
      quickViews: 'छिटो दृश्य',
      qNational: 'राष्ट्रिय',
      qNationalSub: 'सम्पूर्ण नेपाल · ७ · ७७ · ७५३',
      qBagmati: 'बागमती',
      qBagmatiSub: '१३ जिल्ला',
      qValley: 'काठमाडौं उपत्यका',
      qValleySub: '३ जिल्ला · २१ स्थानीय',
      qKathmandu: 'काठमाडौं जिल्ला',
      qKathmanduSub: '११ स्थानीय तह',
      layers: 'तहहरू',
      layerProvinces: 'प्रदेश भरण',
      layerProvincesNote: 'प्रदेश अनुसार रङ',
      layerDistricts: 'जिल्ला सिमाना',
      layerDistrictsNote: 'सबै ७७ जिल्ला',
      layerLocals: 'स्थानीय तह',
      layerLocalsNote: 'जुम ९ माथि देखिन्छ',
      layerLabels: 'नामाङ्कन',
      layerLabelsNote: 'जुम अनुसार नाम',
      layerGraticule: 'ग्रिड',
      layerGraticuleNote: 'अक्षांश र देशान्तर',
      accuracyTitle: 'शुद्धता सूचना',
      notSurvey: 'पाइलट · सर्वेक्षण-स्तरीय होइन',
      phase2: 'वडा तह दोस्रो चरणमा समावेश गरिनेछ।',
      printSheets: 'प्रिन्ट शीट',
      printSheetsNote: 'तीन पाइलट शीट, A1–A3, PDF र HTML मा।',
      sources: 'स्रोत',
      sourceBoundaries: 'सिमाना: Open Knowledge Nepal, LocalBoundaries (CC BY 4.0)।',
      sourceCodes: 'कोड: आधिकारिक ७५३-इकाइ तालिका।',
      sourceProjection: 'प्रक्षेपण: WGS 84 · EPSG:4326।',
      offline: 'अफलाइन तयार · बाह्य नक्सा बेस छैन',
      builtWith: 'Leaflet 1.9.4',
      capital: 'राष्ट्रिय राजधानी',
      searchHint: '७५३ स्थानीय तह, ७७ जिल्ला र ७ प्रदेश खोज्नुहोस्।',
      searchExamples: 'प्रयास गर्नुहोस्',
      searchNoResults: 'कुनै ठाउँ भेटिएन। नाम वा कोड प्रयास गर्नुहोस्।',
      typeProvince: 'प्रदेश',
      typeDistrict: 'जिल्ला',
      typeLocal: 'स्थानीय',
      zoomDistrict: 'जिल्लामा जुम',
      viewProvince: 'प्रदेश हेर्नुहोस्',
      zoomProvince: 'प्रदेशमा जुम',
      codeLabel: 'कोड',
      areaLabel: 'क्षेत्रफल',
      legendTitle: 'संकेत',
      legendProvince: 'प्रदेश भरण',
      legendDistrict: 'जिल्ला सिमाना',
      legendLocal: 'स्थानीय तह सिमाना',
      legendGap: 'स्थानीय तह विवरण छैन',
      legendCapital: 'राष्ट्रिय राजधानी',
      legendNote: 'खुला तथ्याङ्क ज्यामिति · सर्वेक्षण-स्तरीय होइन',
      mapBadge: 'पाइलट · सर्वेक्षण-स्तरीय होइन',
      zoomHintDistricts: 'जिल्ला र स्थानीय तहका लागि जुम गर्नुहोस्',
      zoomHintLocals: 'स्थानीय तहका लागि जुम गर्नुहोस्',
      close: 'बन्द',
      placesLayers: 'ठाउँ र तहहरू',
      popupLocalList: 'यो जिल्लाका स्थानीय तह',
      popupDistrictList: 'यो प्रदेशका जिल्ला',
      mapAria: 'नेपालको अन्तरक्रियात्मक नक्सा',
      loadingSub: '७ प्रदेश · ७७ जिल्ला · ७५३ स्थानीय तह',
      currentViewSub: 'हालको दृश्य',
    },
  };

  function t(key, vars) {
    const table = I18N[state.lang] || I18N.en;
    let s = table[key] ?? I18N.en[key] ?? key;
    if (vars) s = s.replace(/\{(\w+)\}/g, (_, k) => (vars[k] == null ? '' : vars[k]));
    return s;
  }

  const esc = (value) => String(value == null ? '' : value).replace(/[&<>"']/g, (ch) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  }[ch]));

  function formatNum(value, decimals = 0) {
    const n = Number(value);
    if (!Number.isFinite(n)) return String(value);
    let s = n.toLocaleString('en-US', {
      minimumFractionDigits: decimals,
      maximumFractionDigits: decimals,
    });
    if (state.lang === 'ne') s = s.replace(/[0-9]/g, (d) => NEP_DIGITS[Number(d)]);
    return s;
  }

  function npShort(name) {
    return String(name || '')
      .replace(/\s*(उपमहानगरपालिका|महानगरपालिका|नगरपालिका|गाउँपालिका)$/, '')
      .trim();
  }

  function hasDevanagari(s) {
    return /[\u0900-\u097F]/.test(String(s || ''));
  }

  function readPref(key, fallback) {
    try {
      const value = localStorage.getItem(key);
      return value == null ? fallback : value;
    } catch {
      return fallback;
    }
  }

  function writePref(key, value) {
    try { localStorage.setItem(key, value); } catch { /* file:// storage may be disabled */ }
  }

  const state = {
    lang: readPref('atlas.lang', 'en') === 'ne' ? 'ne' : 'en',
    layers: { provinces: true, districts: true, locals: true, labels: true, graticule: false },
    activeProvince: null,
    view: { type: 'national', code: null },
  };

  try {
    const saved = JSON.parse(readPref('atlas.layers', '{}'));
    if (saved && typeof saved === 'object') Object.assign(state.layers, saved);
  } catch { /* keep defaults */ }

  const sidebar = document.getElementById('sidebar');
  const sidebarContent = document.getElementById('sidebar-content');
  const searchWrap = document.getElementById('search-wrap');
  const searchInput = document.getElementById('search-input');
  const searchResults = document.getElementById('search-results');
  const searchClear = document.getElementById('search-clear');
  const mapHint = document.getElementById('map-hint');
  const mapHintText = document.getElementById('map-hint-text');
  const mapBadge = document.getElementById('map-badge');

  let map;
  let provinceLayer;
  let districtLayer;
  let districtOutlineLayer;
  let gapLayer;
  let localLayer;
  let labelLayer;
  let graticuleLayer;
  let capitalMarker;
  let nepalBounds;
  let valleyBounds;
  let labelTimer = null;
  let activeSearchIndex = -1;
  let currentResults = [];

  const provinceByCode = new Map();
  const districtByCode = new Map();
  const localByCode = new Map();
  const localsByDistrict = new Map();
  const layerIndex = { province: new Map(), district: new Map(), local: new Map() };
  const boundsByProvince = new Map();
  const boundsByDistrict = new Map();
  const valleyDistricts = [];

  // -------------------------------------------------------------------------
  // Lookups
  // -------------------------------------------------------------------------
  function buildLookups() {
    for (const f of A.provinces.features) {
      provinceByCode.set(String(f.properties.province_code), f);
    }
    for (const f of A.districts.features) {
      const code = String(f.properties.district_code);
      districtByCode.set(code, f);
      if (VALLEY_NAMES.includes(f.properties.district_name)) valleyDistricts.push(f);
    }
    for (const f of A.locals.features) {
      const p = f.properties;
      const code = String(p.code);
      const dcode = String(p.district_code);
      localByCode.set(code, f);
      if (!localsByDistrict.has(dcode)) localsByDistrict.set(dcode, []);
      localsByDistrict.get(dcode).push(f);
    }
    for (const list of localsByDistrict.values()) {
      list.sort((a, b) => String(a.properties.code).localeCompare(String(b.properties.code)));
    }
  }

  // -------------------------------------------------------------------------
  // Map and base layers
  // -------------------------------------------------------------------------
  function initMap() {
    map = L.map('map', {
      zoomControl: false,
      preferCanvas: true,
      minZoom: 6,
      maxZoom: 14,
      zoomSnap: 0.25,
      zoomDelta: 0.5,
      wheelPxPerZoomLevel: 90,
      attributionControl: false,
      maxBoundsViscosity: 0.65,
      fadeAnimation: true,
    });

    map.createPane('graticulePane').style.zIndex = 300;
    map.createPane('provincePane').style.zIndex = 310;
    map.createPane('districtPane').style.zIndex = 320;
    map.createPane('localPane').style.zIndex = 330;
    map.createPane('districtLinePane').style.zIndex = 335;
    map.createPane('gapPane').style.zIndex = 336;
    map.createPane('capitalPane').style.zIndex = 660;

    L.control.zoom({ position: 'topright' }).addTo(map);
    L.control.scale({ position: 'bottomright', imperial: false, maxWidth: 110 }).addTo(map);
    L.control.attribution({ position: 'bottomright', prefix: false }).addTo(map)
      .addAttribution('Boundaries: Open Knowledge Nepal, LocalBoundaries (CC BY 4.0) · Open-data pilot');

    provinceLayer = L.geoJSON(A.provinces, {
      pane: 'provincePane',
      style: (f) => provinceStyle(f.properties.province_code),
      onEachFeature: (f, layer) => bindFeature('province', f, layer),
    }).addTo(map);

    districtLayer = L.geoJSON(A.districts, {
      pane: 'districtPane',
      style: () => districtStyle(),
      onEachFeature: (f, layer) => bindFeature('district', f, layer),
    }).addTo(map);

    // A non-interactive copy of the district outlines sits above the local
    // boundaries. District lines follow the same edges as local lines, so
    // drawing them below the white local mesh would erase the hierarchy.
    districtOutlineLayer = L.geoJSON(A.districts, {
      pane: 'districtLinePane',
      interactive: false,
      style: () => ({
        pane: 'districtLinePane',
        color: '#4B5563',
        weight: 1.35,
        opacity: 0.88,
        fill: false,
        lineJoin: 'round',
      }),
    }).addTo(map);

    // Protected areas are outside the local-level geometry, which leaves
    // interior rings in the dissolved province layer. Mark those rings as
    // data gaps so they do not read as a highlighted district.
    gapLayer = L.geoJSON(A.gaps || { type: 'FeatureCollection', features: [] }, {
      pane: 'gapPane',
      interactive: false,
      style: () => ({
        pane: 'gapPane',
        color: '#8C8577',
        weight: 0.8,
        opacity: 0.9,
        dashArray: '3 3',
        fillColor: '#EFEADF',
        fillOpacity: 0.96,
        lineJoin: 'round',
      }),
    });

    localLayer = L.geoJSON(A.locals, {
      pane: 'localPane',
      style: (f) => localStyle(f),
      onEachFeature: (f, layer) => bindFeature('local', f, layer),
    });

    nepalBounds = provinceLayer.getBounds();
    map.setMaxBounds(nepalBounds.pad(0.38));

    for (const [code, layer] of layerIndex.province) boundsByProvince.set(code, layer.getBounds());
    for (const [code, layer] of layerIndex.district) boundsByDistrict.set(code, layer.getBounds());

    valleyBounds = L.latLngBounds([]);
    for (const f of valleyDistricts) {
      const b = boundsByDistrict.get(String(f.properties.district_code));
      if (b) valleyBounds.extend(b);
    }

    graticuleLayer = buildGraticule();
    labelLayer = L.layerGroup();

    buildCapitalMarker();

    map.on('zoomend', () => {
      syncLocalLayer();
      updateHint();
      scheduleLabels();
    });
    map.on('moveend', scheduleLabels);
  }

  function provinceStyle(code) {
    const c = provinceColor(code);
    return {
      pane: 'provincePane',
      color: c.line,
      weight: 1.1,
      opacity: 0.9,
      lineJoin: 'round',
      fillColor: c.fill,
      fillOpacity: state.layers.provinces ? 0.92 : 0,
      interactive: true,
    };
  }

  function districtStyle() {
    return {
      pane: 'districtPane',
      color: '#8C8577',
      weight: 0.85,
      opacity: 0.78,
      lineJoin: 'round',
      fillColor: '#8C8577',
      fillOpacity: 0.001,
      interactive: true,
    };
  }

  function localStyle(f) {
    const c = provinceColor(f.properties.province_code);
    return {
      pane: 'localPane',
      color: '#FFFFFF',
      weight: 0.65,
      opacity: 0.9,
      lineJoin: 'round',
      fillColor: c.fill,
      fillOpacity: 0.52,
      interactive: true,
    };
  }

  function bindFeature(kind, feature, layer) {
    const code = kind === 'province'
      ? String(feature.properties.province_code)
      : kind === 'district'
        ? String(feature.properties.district_code)
        : String(feature.properties.code);

    layerIndex[kind].set(code, layer);
    layer.bindPopup(() => buildPopup(kind, code), {
      className: 'atlas-popup',
      maxWidth: 340,
      minWidth: 240,
      autoPanPadding: [24, 24],
      closeButton: true,
    });
    layer.bindTooltip(() => tooltipHtml(kind, code), {
      sticky: true,
      direction: 'top',
      offset: [0, -4],
      opacity: 1,
      className: 'atlas-tooltip',
    });
    layer.on('mouseover', () => {
      if (kind === 'local' && !map.hasLayer(localLayer)) return;
      layer.setStyle(hoverStyle(kind, feature));
    });
    layer.on('mouseout', () => {
      if (kind === 'province') provinceLayer.resetStyle(layer);
      else if (kind === 'district') districtLayer.resetStyle(layer);
      else localLayer.resetStyle(layer);
    });
  }

  function hoverStyle(kind, feature) {
    if (kind === 'province') {
      const c = provinceColor(feature.properties.province_code);
      return { color: c.dark, weight: 1.8, fillOpacity: 0.98 };
    }
    if (kind === 'district') {
      return { color: '#4B5563', weight: 1.45, fillColor: '#8C8577', fillOpacity: 0.1 };
    }
    return { color: '#1F2937', weight: 1.15, fillOpacity: 0.82 };
  }

  function buildCapitalMarker() {
    const icon = L.divIcon({
      className: 'capital-anchor',
      html: '<div class="capital-marker" title="Kathmandu · काठमाडौं"><span>★</span></div>',
      iconSize: [0, 0],
    });
    capitalMarker = L.marker([meta.capital.lat, meta.capital.lon], {
      icon,
      pane: 'capitalPane',
      interactive: true,
      keyboard: true,
      title: 'Kathmandu · काठमाडौं',
      alt: 'Kathmandu',
    }).addTo(map);
    capitalMarker.bindTooltip('Kathmandu · <span class="tt-np">काठमाडौं</span>', {
      direction: 'top',
      offset: [0, -8],
      className: 'atlas-tooltip',
      opacity: 1,
    });
  }

  function buildGraticule() {
    const group = L.layerGroup();
    const lineStyle = {
      pane: 'graticulePane',
      color: '#CFC8B9',
      weight: 0.55,
      opacity: 0.8,
      dashArray: '3 4',
      interactive: false,
    };
    for (let lon = 80; lon <= 89; lon += 1) {
      const pts = [];
      for (let lat = 25.5; lat <= 31.5; lat += 0.1) pts.push([lat, lon]);
      L.polyline(pts, lineStyle).addTo(group);
    }
    for (let lat = 26; lat <= 31; lat += 1) {
      const pts = [];
      for (let lon = 80; lon <= 89; lon += 0.1) pts.push([lat, lon]);
      L.polyline(pts, lineStyle).addTo(group);
    }
    return group;
  }

  // -------------------------------------------------------------------------
  // Layer state
  // -------------------------------------------------------------------------
  function persistLayers() {
    writePref('atlas.layers', JSON.stringify(state.layers));
  }

  function applyLayers() {
    if (!map) return;
    provinceLayer.eachLayer((layer) => {
      layer.setStyle(provinceStyle(layer.feature.properties.province_code));
    });

    if (state.layers.districts) {
      if (!map.hasLayer(districtLayer)) districtLayer.addTo(map);
      if (districtOutlineLayer && !map.hasLayer(districtOutlineLayer)) districtOutlineLayer.addTo(map);
    } else {
      if (map.hasLayer(districtLayer)) {
        districtLayer.removeFrom(map);
        map.closePopup();
      }
      if (districtOutlineLayer && map.hasLayer(districtOutlineLayer)) districtOutlineLayer.removeFrom(map);
    }

    syncLocalLayer();

    if (state.layers.graticule) {
      if (!map.hasLayer(graticuleLayer)) graticuleLayer.addTo(map);
    } else if (map.hasLayer(graticuleLayer)) {
      graticuleLayer.removeFrom(map);
    }

    updateHint();
    scheduleLabels();
  }

  function syncLocalLayer() {
    if (!map || !localLayer) return;
    const shouldShow = state.layers.locals && map.getZoom() >= 9;
    if (shouldShow && !map.hasLayer(localLayer)) {
      localLayer.addTo(map);
    } else if (!shouldShow && map.hasLayer(localLayer)) {
      localLayer.removeFrom(map);
      map.closePopup();
    }

    if (gapLayer) {
      if (shouldShow && !map.hasLayer(gapLayer)) gapLayer.addTo(map);
      else if (!shouldShow && map.hasLayer(gapLayer)) gapLayer.removeFrom(map);
    }
  }

  function scheduleLabels() {
    if (!map) return;
    clearTimeout(labelTimer);
    labelTimer = setTimeout(() => refreshLabels(), 60);
  }

  // -------------------------------------------------------------------------
  // Labels
  // -------------------------------------------------------------------------
  const LABELS = { province: [], district: [], local: [] };
  const LABEL_SIZES = {
    province: { p: 12.5, pw: 700, s: 9.5, sw: 600, pl: 14, sl: 11 },
    district: { p: 11, pw: 700, s: 9, sw: 600, pl: 14, sl: 11 },
    local: { p: 10.5, pw: 700, s: 8.5, sw: 600, pl: 14, sl: 11 },
  };
  const LABEL_SIZES_COMPACT = {
    province: { p: 10.8, pw: 700, s: 8.2, sw: 600, pl: 14, sl: 11 },
    district: { p: 9.8, pw: 700, s: 8, sw: 600, pl: 14, sl: 11 },
    local: { p: 10, pw: 700, s: 8, sw: 600, pl: 14, sl: 11 },
  };
  const measureCanvas = document.createElement('canvas');
  const measureCtx = measureCanvas.getContext('2d');

  function buildLabelData() {
    LABELS.province = A.provinceStats.map((p) => ({
      kind: 'province',
      code: String(p.code),
      ll: [p.label_lat, p.label_lon],
      en: p.name_short,
      np: p.name_np.replace(/\s*प्रदेश$/, ''),
      enFull: p.name_en,
      npFull: p.name_np,
      priority: p.area_km2,
    }));
    LABELS.district = A.districtStats.map((d) => ({
      kind: 'district',
      code: d.code,
      provinceCode: String(d.province_code),
      ll: [d.label_lat, d.label_lon],
      en: d.name_en,
      np: d.name_np,
      // The three valley districts are the pilot's focus; keep them in the
      // first pass when a narrow screen cannot fit every district label.
      priority: d.area_km2 + (['306', '307', '308'].includes(String(d.code)) ? 10000 : 0),
    }));
    LABELS.local = A.locals.features.map((f) => {
      const p = f.properties;
      return {
        kind: 'local',
        code: String(p.code),
        districtCode: String(p.district_code),
        provinceCode: String(p.province_code),
        ll: [p.label_lat, p.label_lon],
        en: p.name_en_short,
        np: npShort(p.name_np),
        priority: p.area_km2,
      };
    });
    for (const key of Object.keys(LABELS)) {
      LABELS[key].sort((a, b) => b.priority - a.priority);
    }
  }

  function labelTexts(item) {
    const primary = state.lang === 'ne' ? item.np : item.en;
    const secondary = state.lang === 'ne' ? item.en : item.np;
    return { primary, secondary };
  }

  function labelFont(text, weight, size) {
    const family = hasDevanagari(text)
      ? '"Nirmala UI","Noto Sans Devanagari",sans-serif'
      : '"Segoe UI",Arial,sans-serif';
    return `${weight} ${size}px ${family}`;
  }

  function labelMetrics(kind, primary, secondary) {
    const table = map.getContainer().classList.contains('compact-labels') ? LABEL_SIZES_COMPACT : LABEL_SIZES;
    const s = table[kind];
    measureCtx.font = labelFont(primary, s.pw, s.p);
    const w1 = measureCtx.measureText(primary).width;
    measureCtx.font = labelFont(secondary, s.sw, s.s);
    const w2 = measureCtx.measureText(secondary).width;
    const extra = kind === 'province' ? 4 : 2;
    return {
      w: Math.min(260, Math.ceil(Math.max(w1, w2)) + 9 + extra),
      h: s.pl + s.sl + 4,
    };
  }

  function overlaps(a, b) {
    return a.x < b.x + b.w && a.x + a.w > b.x && a.y < b.y + b.h && a.y + a.h > b.y;
  }

  function reservedRects(kind) {
    const root = map.getContainer().getBoundingClientRect();
    const rects = [];
    const selectors = [
      '.map-title', '.legend', '.map-badge', '.map-hint',
      '.leaflet-control-zoom', '.leaflet-control-scale', '.leaflet-control-attribution',
    ];
    for (const selector of selectors) {
      const el = document.querySelector(selector);
      if (!el) continue;
      const cs = getComputedStyle(el);
      if (cs.display === 'none' || cs.visibility === 'hidden' || Number(cs.opacity) === 0) continue;
      const r = el.getBoundingClientRect();
      if (r.width < 3 || r.height < 3) continue;
      rects.push({
        x: r.left - root.left - 5,
        y: r.top - root.top - 5,
        w: r.width + 10,
        h: r.height + 10,
      });
    }

    // Keep the capital star clear of province/district labels. Local views
    // put the star inside Kathmandu's own label instead of the marker.
    if (capitalMarker && kind !== 'local') {
      const anchor = capitalMarker.getElement();
      if (anchor) {
        const star = anchor.querySelector('.capital-marker') || anchor;
        const r = star.getBoundingClientRect();
        if (r.width >= 3 && r.height >= 3) {
          rects.push({
            x: r.left - root.left - 4,
            y: r.top - root.top - 4,
            w: r.width + 8,
            h: r.height + 8,
          });
        }
      }
    }
    return rects;
  }

  function refreshLabels() {
    if (!map || !labelLayer) return;
    if (!map.hasLayer(labelLayer)) labelLayer.addTo(map);
    labelLayer.clearLayers();
    if (!state.layers.labels) {
      if (capitalMarker) capitalMarker.setOpacity(1);
      return;
    }

    const z = map.getZoom();
    const viewType = state.view.type;
    let kind;
    if (state.layers.locals && map.hasLayer(localLayer) && (viewType === 'local' || z >= 9.75)) {
      kind = 'local';
    } else if (state.layers.districts && (viewType === 'province' || viewType === 'district' || viewType === 'valley')) {
      kind = 'district';
    } else if (state.layers.districts && z >= 8.2) {
      kind = 'district';
    } else {
      kind = 'province';
    }

    const size = map.getSize();
    map.getContainer().classList.toggle('compact-labels', size.x < 520);
    const occupied = reservedRects(kind);
    const bounds = map.getBounds().pad(0.04);
    const v = state.view || { type: 'national', code: null };
    const valleyCodes = new Set(valleyDistricts.map((f) => String(f.properties.district_code)));
    let items = LABELS[kind];

    // Keep the label set tied to the current sheet. Neighbouring units stay
    // visible as geometry but do not crowd the labels of the selected area.
    if (kind === 'province' && v.type !== 'national') {
      items = [];
    } else if (v.type === 'province') {
      if (kind === 'district') items = items.filter((x) => x.provinceCode === String(v.code));
      else if (kind === 'local') items = items.filter((x) => x.provinceCode === String(v.code));
    } else if (v.type === 'district') {
      if (kind === 'district') items = items.filter((x) => x.code === String(v.code));
      else if (kind === 'local') items = items.filter((x) => x.districtCode === String(v.code));
    } else if (v.type === 'valley') {
      if (kind === 'district') items = items.filter((x) => valleyCodes.has(x.code));
      else if (kind === 'local') items = items.filter((x) => valleyCodes.has(x.districtCode));
    }

    let added = 0;
    let capitalLabelAdded = false;
    for (const item of items) {
      if (kind === 'local' && added >= 90) break;
      if (!bounds.contains(L.latLng(item.ll))) continue;
      const pt = map.latLngToContainerPoint(item.ll);
      const { primary, secondary } = labelTexts(item);
      const m = labelMetrics(kind, primary, secondary);
      const baseX = pt.x - m.w / 2;
      const baseY = pt.y - m.h / 2;
      const offsets = [
        [0, 0],
        [0, -(m.h + 2)],
        [0, m.h + 2],
        [-(m.w * 0.55), 0],
        [m.w * 0.55, 0],
        [-(m.w * 0.35), -(m.h + 1)],
        [m.w * 0.35, -(m.h + 1)],
        [-(m.w * 0.35), m.h + 1],
        [m.w * 0.35, m.h + 1],
      ];

      // Try a small set of cartographic positions before dropping a label.
      // This keeps narrow phone views labelled without letting labels collide.
      let rect = null;
      for (const [dx, dy] of offsets) {
        let x = baseX + dx;
        let y = baseY + dy;
        if (x < 4) x = 4;
        if (y < 4) y = 4;
        if (x + m.w > size.x - 4) x = size.x - 4 - m.w;
        if (y + m.h > size.y - 4) y = size.y - 4 - m.h;
        const candidate = { x, y, w: m.w, h: m.h };
        if (occupied.some((o) => overlaps(candidate, o))) continue;
        rect = candidate;
        break;
      }
      if (!rect) continue;
      occupied.push(rect);
      const anchor = map.containerPointToLatLng([rect.x + rect.w / 2, rect.y + rect.h / 2]);
      addLabel(kind, item, primary, secondary, anchor);
      if (kind === 'local' && item.code === '30608') capitalLabelAdded = true;
      added += 1;
    }

    // When Kathmandu's local label is on the map, the star is drawn as part
    // of that label; otherwise keep the separate capital marker visible.
    if (capitalMarker) capitalMarker.setOpacity(capitalLabelAdded ? 0 : 1);
  }

  function addLabel(kind, item, primary, secondary, anchor) {
    const primaryNp = hasDevanagari(primary) ? ' np' : '';
    const secondaryNp = hasDevanagari(secondary) ? ' np' : '';
    const capitalClass = kind === 'local' && item.code === '30608' ? ' label-capital' : '';
    const html = `<div class="map-label label-${kind}${capitalClass}">` +
      `<span class="lb-primary${primaryNp}">${esc(primary)}</span>` +
      `<span class="lb-secondary${secondaryNp}">${esc(secondary)}</span>` +
      `</div>`;
    const icon = L.divIcon({ className: 'label-anchor', html, iconSize: [0, 0] });
    const marker = L.marker(anchor || item.ll, {
      icon,
      pane: 'markerPane',
      interactive: true,
      keyboard: false,
      riseOnHover: true,
      title: `${primary} · ${secondary}`,
    });
    marker.on('click', (e) => {
      L.DomEvent.stopPropagation(e);
      openPopup(kind, item.code);
    });
    labelLayer.addLayer(marker);
  }

  function updateHint() {
    if (!map) return;
    const z = map.getZoom();
    let key = null;
    if (state.layers.labels) {
      if (z < 8.2) key = 'zoomHintDistricts';
      else if (z < 9.75 && state.layers.locals) key = 'zoomHintLocals';
    }
    mapHint.classList.toggle('hidden', !key);
    if (key) mapHintText.textContent = t(key);
  }

  // -------------------------------------------------------------------------
  // Text helpers for features
  // -------------------------------------------------------------------------
  function featureFor(kind, code) {
    code = String(code);
    if (kind === 'province') return provinceByCode.get(code);
    if (kind === 'district') return districtByCode.get(code);
    return localByCode.get(code);
  }

  function provinceFull(f, lang = state.lang) {
    const p = f.properties;
    return lang === 'ne' ? p.province_name_np : p.province_name;
  }

  function provinceShort(f, lang = state.lang) {
    const p = f.properties;
    return lang === 'ne' ? p.province_name_np : p.province_name_short;
  }

  function districtName(f, lang = state.lang) {
    const p = f.properties;
    return lang === 'ne' ? p.district_name_np : p.district_name;
  }

  function localFull(f, lang = state.lang) {
    const p = f.properties;
    return lang === 'ne' ? p.name_np : p.name_en;
  }

  function localShort(f, lang = state.lang) {
    const p = f.properties;
    return lang === 'ne' ? npShort(p.name_np) : p.name_en_short;
  }

  function unitType(f, lang = state.lang) {
    const p = f.properties;
    return lang === 'ne' ? p.unit_type_np : p.unit_type;
  }

  function tooltipHtml(kind, code) {
    const f = featureFor(kind, code);
    if (!f) return '';
    let primary;
    let secondary;
    if (kind === 'province') {
      primary = state.lang === 'ne' ? f.properties.province_name_np : f.properties.province_name_short;
      secondary = state.lang === 'ne' ? f.properties.province_name_short : f.properties.province_name_np;
    } else if (kind === 'district') {
      primary = districtName(f);
      secondary = districtName(f, state.lang === 'ne' ? 'en' : 'ne');
    } else {
      primary = localShort(f);
      secondary = localShort(f, state.lang === 'ne' ? 'en' : 'ne');
    }
    const cls = hasDevanagari(secondary) ? 'tt-np' : 'tt-en';
    return `<b>${esc(primary)}</b><span class="${cls}">${esc(secondary)}</span>`;
  }

  // -------------------------------------------------------------------------
  // Popups
  // -------------------------------------------------------------------------
  function buildPopup(kind, code) {
    if (kind === 'local') return popupLocal(code);
    if (kind === 'district') return popupDistrict(code);
    return popupProvince(code);
  }

  function popupLocal(code) {
    const f = localByCode.get(String(code));
    if (!f) return '';
    const p = f.properties;
    const d = districtByCode.get(String(p.district_code));
    const prov = provinceByCode.get(String(p.province_code));
    const isCapital = String(p.code) === '30608';
    const primary = state.lang === 'ne' ? p.name_np : p.name_en;
    const secondary = state.lang === 'ne' ? p.name_en : p.name_np;
    const altClass = hasDevanagari(secondary) ? 'np' : '';
    return `<div class="popup">
      <div class="popup-kicker">${esc(t('localLevel'))} · ${esc(p.code)}</div>
      <h3 class="popup-title">${esc(primary)}</h3>
      <div class="popup-alt ${altClass}">${esc(secondary)}</div>
      <div class="popup-meta">${esc(unitType(f))}${d ? ' · ' + esc(districtName(d)) : ''}</div>
      <div class="popup-stats">
        <div><b>${formatNum(p.area_km2, 1)}</b><span>${esc(t('km2'))}</span></div>
        <div><b>${esc(prov ? provinceShort(prov) : '')}</b><span>${esc(t('province'))}</span></div>
      </div>
      ${isCapital ? `<div class="popup-flag">★ <b>${esc(t('capital'))}</b></div>` : ''}
      <div class="popup-actions">
        <button type="button" data-focus-district="${esc(p.district_code)}">${esc(t('zoomDistrict'))}</button>
        <button type="button" class="secondary" data-focus-province="${esc(p.province_code)}">${esc(t('viewProvince'))}</button>
      </div>
    </div>`;
  }

  function popupDistrict(code) {
    const f = districtByCode.get(String(code));
    if (!f) return '';
    const p = f.properties;
    const prov = provinceByCode.get(String(p.province_code));
    const locals = localsByDistrict.get(String(p.district_code)) || [];
    const primary = state.lang === 'ne' ? p.district_name_np : p.district_name;
    const secondary = state.lang === 'ne' ? p.district_name : p.district_name_np;
    const altClass = hasDevanagari(secondary) ? 'np' : '';
    const chips = locals.map((lf) => {
      const lp = lf.properties;
      return `<button type="button" data-focus-local="${esc(lp.code)}">${esc(localShort(lf))}</button>`;
    }).join('');
    return `<div class="popup">
      <div class="popup-kicker">${esc(t('district'))} · ${esc(p.district_code)}</div>
      <h3 class="popup-title">${esc(primary)}</h3>
      <div class="popup-alt ${altClass}">${esc(secondary)}</div>
      <div class="popup-meta">${esc(prov ? provinceFull(prov) : '')}</div>
      <div class="popup-stats">
        <div><b>${formatNum(locals.length)}</b><span>${esc(t('localLevels'))}</span></div>
        <div><b>${formatNum(p.area_km2, 1)}</b><span>${esc(t('km2'))}</span></div>
      </div>
      <div class="popup-list-head">${esc(t('popupLocalList'))}</div>
      <div class="popup-chips">${chips}</div>
      <div class="popup-actions">
        <button type="button" data-focus-district="${esc(p.district_code)}">${esc(t('zoomDistrict'))}</button>
        <button type="button" class="secondary" data-focus-province="${esc(p.province_code)}">${esc(t('viewProvince'))}</button>
      </div>
    </div>`;
  }

  function popupProvince(code) {
    const f = provinceByCode.get(String(code));
    if (!f) return '';
    const p = f.properties;
    const primary = state.lang === 'ne' ? p.province_name_np : p.province_name;
    const secondary = state.lang === 'ne' ? p.province_name : p.province_name_np;
    const altClass = hasDevanagari(secondary) ? 'np' : '';
    const districts = A.districts.features
      .filter((df) => df.properties.province_code === p.province_code)
      .sort((a, b) => String(a.properties.district_name).localeCompare(String(b.properties.district_name)));
    const chips = districts.map((df) => {
      const dp = df.properties;
      return `<button type="button" data-focus-district="${esc(dp.district_code)}">${esc(districtName(df))}</button>`;
    }).join('');
    return `<div class="popup">
      <div class="popup-kicker">${esc(t('province'))} · ${esc(p.province_code)}</div>
      <h3 class="popup-title">${esc(primary)}</h3>
      <div class="popup-alt ${altClass}">${esc(secondary)}</div>
      <div class="popup-meta">${formatNum(p.district_count)} ${esc(t('districts'))} · ${formatNum(p.local_count)} ${esc(t('localLevels'))}</div>
      <div class="popup-stats">
        <div><b>${formatNum(p.local_count)}</b><span>${esc(t('localLevels'))}</span></div>
        <div><b>${formatNum(p.area_km2, 1)}</b><span>${esc(t('km2'))}</span></div>
      </div>
      <div class="popup-list-head">${esc(t('popupDistrictList'))}</div>
      <div class="popup-chips">${chips}</div>
      <div class="popup-actions">
        <button type="button" data-focus-province="${esc(p.province_code)}">${esc(t('zoomProvince'))}</button>
      </div>
    </div>`;
  }

  function openPopup(kind, code) {
    code = String(code);
    const layer = layerIndex[kind].get(code);
    if (layer && map.hasLayer(layer)) {
      layer.openPopup();
      return;
    }
    const f = featureFor(kind, code);
    if (!f) return;
    const p = f.properties;
    const latlng = [p.label_lat, p.label_lon];
    L.popup({
      className: 'atlas-popup',
      maxWidth: 340,
      minWidth: 240,
      autoPanPadding: [24, 24],
    })
      .setLatLng(latlng)
      .setContent(buildPopup(kind, code))
      .openOn(map);
  }

  function afterNextMove(fn, delay = 950) {
    let done = false;
    const run = () => {
      if (done) return;
      done = true;
      map.off('moveend', run);
      fn();
    };
    map.once('moveend', run);
    setTimeout(run, delay);
  }

  // -------------------------------------------------------------------------
  // Search
  // -------------------------------------------------------------------------
  const searchIndex = [];

  function buildSearchIndex() {
    for (const p of A.provinceStats) {
      searchIndex.push({
        type: 'province',
        code: String(p.code),
        en: p.name_en,
        np: p.name_np,
        enDisplay: p.name_en,
        npDisplay: p.name_np,
        enShort: p.name_short,
        npShort: p.name_np,
        contextEn: `${p.districts} districts · ${p.locals} local levels`,
        contextNp: `${formatNum(p.districts)} जिल्ला · ${formatNum(p.locals)} स्थानीय तह`,
        priority: p.area_km2,
      });
    }
    for (const d of A.districtStats) {
      searchIndex.push({
        type: 'district',
        code: String(d.code),
        en: d.name_en,
        np: d.name_np,
        enDisplay: d.name_en,
        npDisplay: d.name_np,
        enShort: d.name_en,
        npShort: d.name_np,
        contextEn: `${d.province_name} · ${d.locals} local levels`,
        contextNp: `${provinceByCode.get(String(d.province_code))?.properties.province_name_np || ''} · ${formatNum(d.locals)} स्थानीय तह`,
        priority: d.area_km2,
      });
    }
    for (const f of A.locals.features) {
      const p = f.properties;
      const d = districtByCode.get(String(p.district_code));
      const prov = provinceByCode.get(String(p.province_code));
      const npShortName = npShort(p.name_np);
      searchIndex.push({
        type: 'local',
        code: String(p.code),
        en: p.name_en,
        np: p.name_np,
        enDisplay: p.name_en_short,
        npDisplay: npShortName,
        enShort: p.name_en_short,
        npShort: npShortName,
        contextEn: `${d ? d.properties.district_name : p.district_name} District · ${prov ? prov.properties.province_name_short : p.province_name_short}`,
        contextNp: `${d ? d.properties.district_name_np : p.district_name_np} जिल्ला · ${prov ? prov.properties.province_name_np : p.province_name_np}`,
        priority: p.area_km2,
      });
    }
  }

  function normalizeSearch(value) {
    return String(value || '')
      .toLowerCase()
      .normalize('NFKD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/\s+/g, ' ')
      .trim();
  }

  function queryCore(raw) {
    let q = normalizeSearch(raw);
    const original = q;
    q = q
      .replace(/\b(province|district|municipality|metropolitan|sub-metropolitan|rural|urban|city|local|level)\b/g, ' ')
      .replace(/(प्रदेश|जिल्ला|नगरपालिका|गाउँपालिका|महानगरपालिका|उपमहानगरपालिका|स्थानीय\s*तह)$/g, ' ')
      .replace(/\s+/g, ' ')
      .trim();
    return q || original;
  }

  function scoreItem(item, q) {
    const code = String(item.code);
    if (code === q) return 100;
    if (code.startsWith(q)) return 90;
    const names = [item.en, item.np, item.enShort, item.npShort]
      .filter(Boolean)
      .map((n) => normalizeSearch(n));
    if (names.some((n) => n === q)) return 80;
    if (names.some((n) => n.startsWith(q))) return 70;
    if (names.some((n) => n.split(/[\s·]+/).some((w) => w.startsWith(q)))) return 60;
    if (names.some((n) => n.includes(q))) return 50;
    return -1;
  }

  function findSearchResults(raw) {
    const q = queryCore(raw);
    if (!q) return [];
    const typeRank = { district: 0, local: 1, province: 2 };
    return searchIndex
      .map((item) => ({ item, score: scoreItem(item, q) }))
      .filter((entry) => entry.score > 0)
      .sort((a, b) => {
        if (b.score !== a.score) return b.score - a.score;
        if (typeRank[a.item.type] !== typeRank[b.item.type]) return typeRank[a.item.type] - typeRank[b.item.type];
        return b.item.priority - a.item.priority;
      })
      .slice(0, 12)
      .map((entry) => entry.item);
  }

  function renderSearchResults(raw) {
    const value = String(raw || '');
    searchClear.hidden = !value;
    const q = value.trim();
    activeSearchIndex = -1;
    searchInput.removeAttribute('aria-activedescendant');

    if (!q) {
      currentResults = [];
      const examples = ['Kathmandu', 'काठमाडौं', 'Bagmati', '30608'];
      searchResults.innerHTML = `<div class="search-hint">
        <b>${esc(t('searchHint'))}</b>
        <div class="search-examples">
          ${examples.map((ex) => `<button type="button" class="search-example" data-example="${esc(ex)}">${esc(ex)}</button>`).join('')}
        </div>
      </div>`;
      openSearch();
      return;
    }

    currentResults = findSearchResults(q);
    if (!currentResults.length) {
      searchResults.innerHTML = `<div class="search-empty">${esc(t('searchNoResults'))}</div>`;
      openSearch();
      return;
    }

    const typeLabel = { province: 'typeProvince', district: 'typeDistrict', local: 'typeLocal' };
    searchResults.innerHTML = currentResults.map((item, index) => {
      const primary = state.lang === 'ne' ? item.npDisplay : item.enDisplay;
      const secondary = state.lang === 'ne' ? item.enDisplay : item.npDisplay;
      const primaryClass = hasDevanagari(primary) ? ' np' : '';
      const secondaryClass = hasDevanagari(secondary) ? ' np' : '';
      const context = state.lang === 'ne' ? item.contextNp : item.contextEn;
      return `<button type="button" class="search-row" id="search-opt-${index}" role="option" aria-selected="false" data-result="${index}">
        <span class="search-type ${item.type}">${esc(t(typeLabel[item.type]))}</span>
        <span class="search-main">
          <span class="search-name"><span class="search-primary${primaryClass}">${esc(primary)}</span><span class="search-secondary${secondaryClass}">${esc(secondary)}</span></span>
          <span class="search-context">${esc(context)}</span>
        </span>
        <span class="search-code">${esc(item.code)}</span>
      </button>`;
    }).join('');
    openSearch();
  }

  function openSearch() {
    searchResults.classList.add('open');
    searchInput.setAttribute('aria-expanded', 'true');
  }

  function closeSearch() {
    searchResults.classList.remove('open');
    searchInput.setAttribute('aria-expanded', 'false');
    searchInput.removeAttribute('aria-activedescendant');
    activeSearchIndex = -1;
  }

  function setActiveSearch(index) {
    const rows = Array.from(searchResults.querySelectorAll('.search-row'));
    if (!rows.length) return;
    activeSearchIndex = Math.max(0, Math.min(index, rows.length - 1));
    rows.forEach((row, i) => {
      const on = i === activeSearchIndex;
      row.classList.toggle('active', on);
      row.setAttribute('aria-selected', on ? 'true' : 'false');
    });
    const row = rows[activeSearchIndex];
    if (row) {
      searchInput.setAttribute('aria-activedescendant', row.id);
      row.scrollIntoView({ block: 'nearest' });
    }
  }

  function selectSearchItem(item) {
    if (!item) return;
    const label = state.lang === 'ne' ? item.npDisplay : item.enDisplay;
    searchInput.value = label;
    searchClear.hidden = false;
    closeSearch();
    searchInput.blur();
    if (item.type === 'province') focusProvince(Number(item.code), { popup: true });
    else if (item.type === 'district') focusDistrict(item.code, { popup: true });
    else focusLocal(item.code, { popup: true });
  }

  function bindSearch() {
    searchInput.addEventListener('input', () => renderSearchResults(searchInput.value));
    searchInput.addEventListener('focus', () => renderSearchResults(searchInput.value));
    searchInput.addEventListener('keydown', (event) => {
      if (event.key === 'ArrowDown') {
        event.preventDefault();
        if (!searchResults.classList.contains('open')) renderSearchResults(searchInput.value);
        setActiveSearch(activeSearchIndex < 0 ? 0 : activeSearchIndex + 1);
      } else if (event.key === 'ArrowUp') {
        event.preventDefault();
        if (!searchResults.classList.contains('open')) renderSearchResults(searchInput.value);
        setActiveSearch(activeSearchIndex <= 0 ? 0 : activeSearchIndex - 1);
      } else if (event.key === 'Enter') {
        if (activeSearchIndex >= 0 && currentResults[activeSearchIndex]) {
          event.preventDefault();
          selectSearchItem(currentResults[activeSearchIndex]);
        } else if (currentResults.length) {
          event.preventDefault();
          selectSearchItem(currentResults[0]);
        }
      } else if (event.key === 'Escape') {
        event.preventDefault();
        closeSearch();
        searchInput.blur();
      }
    });

    searchClear.addEventListener('click', () => {
      searchInput.value = '';
      searchClear.hidden = true;
      renderSearchResults('');
      searchInput.focus();
    });

    searchResults.addEventListener('click', (event) => {
      const example = event.target.closest('[data-example]');
      if (example) {
        searchInput.value = example.dataset.example;
        searchInput.focus();
        renderSearchResults(searchInput.value);
        return;
      }
      const row = event.target.closest('[data-result]');
      if (row) {
        const item = currentResults[Number(row.dataset.result)];
        if (item) selectSearchItem(item);
      }
    });

    searchResults.addEventListener('pointermove', (event) => {
      const row = event.target.closest('[data-result]');
      if (!row) return;
      const index = Number(row.dataset.result);
      if (index !== activeSearchIndex) setActiveSearch(index);
    });

    document.addEventListener('pointerdown', (event) => {
      if (!searchWrap.contains(event.target)) closeSearch();
    });
  }

  // -------------------------------------------------------------------------
  // Sidebar
  // -------------------------------------------------------------------------
  function valleyLocalCount() {
    return valleyDistricts.reduce((sum, f) => sum + Number(f.properties.local_count || 0), 0);
  }

  function renderSidebar() {
    if (!sidebarContent) return;
    const scrollTop = sidebar.scrollTop;
    const active = String(state.activeProvince ?? '');
    const bagmati = A.provinceStats.find((p) => Number(p.code) === 3);
    const valleyLocals = valleyLocalCount();
    const introAlt = state.lang === 'ne' ? 'Nepal Local Level Atlas' : 'नेपाल स्थानीय तह एटलस';
    const introAltClass = hasDevanagari(introAlt) ? ' np' : '';

    const provinceRows = A.provinceStats.map((p) => {
      const c = provinceColor(p.code);
      const isActive = active === String(p.code);
      const primary = state.lang === 'ne' ? p.name_np : p.name_en;
      const secondary = state.lang === 'ne' ? p.name_en : p.name_np;
      const primaryClass = hasDevanagari(primary) ? ' np' : '';
      const secondaryClass = hasDevanagari(secondary) ? ' np' : '';
      return `<button type="button" class="province-row${isActive ? ' active' : ''}" data-province="${p.code}" aria-pressed="${isActive}" title="${esc(primary + ' · ' + secondary)}">
        <span class="province-swatch" style="background:${c.fill};border-color:${c.line}"></span>
        <span class="province-names">
          <span class="primary${primaryClass}">${esc(primary)}</span>
          <span class="secondary${secondaryClass}">${esc(secondary)}</span>
        </span>
        <span class="province-meta"><b>${formatNum(p.districts)}</b> ${esc(t('districtsShort'))}<br><b>${formatNum(p.locals)}</b> ${esc(t('localsShort'))}</span>
      </button>`;
    }).join('');

    const layerDefs = [
      ['provinces', 'layerProvinces', 'layerProvincesNote'],
      ['districts', 'layerDistricts', 'layerDistrictsNote'],
      ['locals', 'layerLocals', 'layerLocalsNote'],
      ['labels', 'layerLabels', 'layerLabelsNote'],
      ['graticule', 'layerGraticule', 'layerGraticuleNote'],
    ];
    const layerRows = layerDefs.map(([key, name, note]) => `<label class="layer-row">
      <span class="layer-text">
        <span class="layer-name">${esc(t(name))}</span>
        <span class="layer-note">${esc(t(note))}</span>
      </span>
      <span class="switch"><input type="checkbox" data-layer="${key}"${state.layers[key] ? ' checked' : ''}><span class="track"></span></span>
    </label>`).join('');

    const sheetCards = meta.sheets.map((s) => {
      const title = state.lang === 'ne' ? s.title_np : s.title_en;
      const scope = state.lang === 'ne' ? s.scope_np : s.scope_en;
      const titleClass = hasDevanagari(title) ? ' np' : '';
      return `<article class="sheet-card">
        <div class="sheet-no">${esc(s.sheet)}</div>
        <div>
          <div class="sheet-title${titleClass}">${esc(title)}</div>
          <div class="sheet-scope">${esc(scope)}</div>
          <div class="sheet-links">
            <a href="${esc(s.pdf)}" target="_blank" rel="noopener">PDF ↗</a>
            <a href="${esc(s.html)}" target="_blank" rel="noopener">HTML ↗</a>
          </div>
        </div>
      </article>`;
    }).join('');

    const accuracyText = state.lang === 'ne' ? meta.disclaimer_np : meta.disclaimer_en;
    const quick = [
      ['national', 'qNational', t('qNationalSub')],
      ['bagmati', 'qBagmati', bagmati ? `${formatNum(bagmati.districts)} ${t('districts')}` : ''],
      ['valley', 'qValley', `${formatNum(valleyDistricts.length)} ${t('districts')} · ${formatNum(valleyLocals)} ${t('localsShort')}`],
      ['kathmandu', 'qKathmandu', `${formatNum(11)} ${t('localLevels')}`],
    ];
    const quickButtons = quick.map(([view, label, sub]) => `<button type="button" class="quick-btn" data-view="${view}">
      <span class="q-primary">${esc(t(label))}</span>
      <span class="q-secondary">${esc(sub)}</span>
    </button>`).join('');

    sidebarContent.innerHTML = `
      <button class="sidebar-close" type="button" data-action="close-sidebar" aria-label="${esc(t('close'))}">&times;</button>
      <section class="intro">
        <div class="eyebrow">${esc(t('brandKicker'))} · ${esc(state.lang === 'ne' ? meta.date_np : meta.date_en)}</div>
        <h1>${esc(t('atlasTitle'))}</h1>
        <div class="intro-np${introAltClass}">${esc(introAlt)}</div>
        <p>${esc(t('intro'))}</p>
      </section>

      <div class="stat-grid">
        <div class="stat-card"><b>${formatNum(meta.counts.provinces)}</b><span>${esc(t('provinces'))}</span></div>
        <div class="stat-card"><b>${formatNum(meta.counts.districts)}</b><span>${esc(t('districts'))}</span></div>
        <div class="stat-card"><b>${formatNum(meta.counts.locals)}</b><span>${esc(t('localLevels'))}</span></div>
        <div class="stat-card"><b>${formatNum(meta.area_km2)}</b><span>${esc(t('km2'))}</span></div>
      </div>

      <section class="side-section" id="provinces">
        <div class="side-section-head">
          <h2>${esc(t('provinces'))}</h2>
          <span class="count"><b>${formatNum(meta.counts.provinces)}</b> / ${formatNum(meta.counts.districts)} ${esc(t('districtsShort'))}</span>
        </div>
        <div class="province-list">${provinceRows}</div>
      </section>

      <section class="side-section">
        <div class="side-section-head"><h2>${esc(t('quickViews'))}</h2></div>
        <div class="quick-grid">${quickButtons}</div>
      </section>

      <section class="side-section">
        <div class="side-section-head"><h2>${esc(t('layers'))}</h2></div>
        <div class="layer-list">${layerRows}</div>
        <p class="side-note">${esc(t('phase2'))}</p>
      </section>

      <section class="accuracy-box" id="accuracy-box" tabindex="-1">
        <h2>${esc(t('accuracyTitle'))}</h2>
        <p>${esc(accuracyText)}</p>
        <span class="badge">${esc(t('notSurvey'))}</span>
      </section>

      <section class="side-section" id="sheets">
        <div class="side-section-head"><h2>${esc(t('printSheets'))}</h2></div>
        <p class="side-note" style="margin:0 0 7px">${esc(t('printSheetsNote'))}</p>
        <div class="sheet-list">${sheetCards}</div>
      </section>

      <footer class="sidebar-footer">
        <p><b>${esc(t('sources'))}</b></p>
        <p>${esc(t('sourceBoundaries'))}</p>
        <p>${esc(t('sourceCodes'))}</p>
        <p>${esc(t('sourceProjection'))} ${esc(t('builtWith'))}.</p>
        <p class="offline">${esc(t('offline'))}</p>
      </footer>`;

    sidebar.scrollTop = scrollTop;
  }

  // -------------------------------------------------------------------------
  // Chrome, language and view title
  // -------------------------------------------------------------------------
  function applyLanguage() {
    document.documentElement.lang = state.lang === 'ne' ? 'ne' : 'en';
    document.body.classList.toggle('lang-ne', state.lang === 'ne');
    document.title = state.lang === 'ne'
      ? 'नेपाल स्थानीय तह एटलस — खुला तथ्याङ्क पाइलट'
      : 'Nepal Local Level Atlas — Open-data pilot';

    const brandKicker = document.getElementById('brand-kicker');
    const brandTitle = document.getElementById('brand-title');
    const brandCount = document.getElementById('brand-count');
    const brandUnit = document.getElementById('brand-unit');
    if (brandKicker) brandKicker.textContent = t('brandKicker');
    if (brandTitle) brandTitle.textContent = t('brandTitle');
    if (brandCount) brandCount.textContent = formatNum(meta.counts.locals);
    if (brandUnit) brandUnit.textContent = state.lang === 'ne' ? 'एकाइ' : 'units';
    searchInput.placeholder = t('searchPlaceholder');
    searchInput.setAttribute('aria-label', t('searchAria'));
    searchClear.setAttribute('aria-label', t('clearSearch'));
    searchClear.title = t('clearSearch');

    const sheetsLabel = document.getElementById('sheets-link-label');
    if (sheetsLabel) sheetsLabel.textContent = t('sheetsLink');
    const accuracyText = document.getElementById('accuracy-text');
    if (accuracyText) accuracyText.textContent = t('accuracyShort');
    const accuracyMore = document.getElementById('accuracy-more');
    if (accuracyMore) accuracyMore.textContent = t('accuracyDetails');
    const loadingTitleEl = document.getElementById('loading-title');
    if (loadingTitleEl) loadingTitleEl.textContent = t('loadingTitle');
    if (loadingSub) loadingSub.textContent = t('loadingSub');
    const viewKicker = document.getElementById('view-kicker');
    if (viewKicker) viewKicker.textContent = t('currentView');
    if (mapBadge) mapBadge.textContent = t('mapBadge');
    const sidebarOpenLabel = document.getElementById('sidebar-open-label');
    if (sidebarOpenLabel) sidebarOpenLabel.textContent = t('placesLayers');

    const legendTitle = document.getElementById('legend-title');
    if (legendTitle) legendTitle.textContent = t('legendTitle');
    const legendNp = document.getElementById('legend-np');
    if (legendNp) legendNp.textContent = state.lang === 'ne' ? 'Legend' : 'संकेत';
    if (legendNp) legendNp.classList.toggle('np', state.lang !== 'ne');
    const legendProvince = document.getElementById('legend-province');
    if (legendProvince) legendProvince.textContent = t('legendProvince');
    const legendDistrict = document.getElementById('legend-district');
    if (legendDistrict) legendDistrict.textContent = t('legendDistrict');
    const legendLocal = document.getElementById('legend-local');
    if (legendLocal) legendLocal.textContent = t('legendLocal');
    const legendGap = document.getElementById('legend-gap');
    if (legendGap) legendGap.textContent = t('legendGap');
    const legendCapital = document.getElementById('legend-capital');
    if (legendCapital) legendCapital.textContent = t('legendCapital');
    const legendNote = document.getElementById('legend-note');
    if (legendNote) legendNote.textContent = t('legendNote');
    map.getContainer().setAttribute('aria-label', t('mapAria'));

    document.querySelectorAll('.lang-toggle button').forEach((btn) => {
      btn.setAttribute('aria-pressed', btn.dataset.lang === state.lang ? 'true' : 'false');
    });

    renderSidebar();
    updateMapTitle();
    updateHint();
    closePopups();
    scheduleLabels();
    if (searchResults.classList.contains('open')) renderSearchResults(searchInput.value);
    writePref('atlas.lang', state.lang);
  }

  function updateMapTitle() {
    if (!map) return;
    const titleEl = document.getElementById('view-title');
    const altEl = document.getElementById('view-title-alt');
    const subEl = document.getElementById('view-sub');
    if (!titleEl || !altEl || !subEl) return;
    const v = state.view || { type: 'national', code: null };
    let primary = '';
    let secondary = '';
    let sub = '';

    if (v.type === 'province') {
      const f = provinceByCode.get(String(v.code));
      if (f) {
        const p = f.properties;
        primary = state.lang === 'ne' ? p.province_name_np : p.province_name;
        secondary = state.lang === 'ne' ? p.province_name : p.province_name_np;
        sub = `${formatNum(p.district_count)} ${t('districts')} · ${formatNum(p.local_count)} ${t('localLevels')} · ${formatNum(p.area_km2, 0)} ${t('km2')}`;
      }
    } else if (v.type === 'district') {
      const f = districtByCode.get(String(v.code));
      if (f) {
        const p = f.properties;
        const prov = provinceByCode.get(String(p.province_code));
        primary = state.lang === 'ne' ? p.district_name_np : p.district_name;
        secondary = state.lang === 'ne' ? p.district_name : p.district_name_np;
        sub = `${prov ? provinceFull(prov) + ' · ' : ''}${formatNum(p.local_count)} ${t('localLevels')} · ${formatNum(p.area_km2, 0)} ${t('km2')}`;
      }
    } else if (v.type === 'local') {
      const f = localByCode.get(String(v.code));
      if (f) {
        primary = localeLocalTitle(f);
        secondary = state.lang === 'ne' ? f.properties.name_en : f.properties.name_np;
        const d = districtByCode.get(String(f.properties.district_code));
        sub = `${unitType(f)}${d ? ' · ' + districtName(d) : ''} · ${formatNum(f.properties.area_km2, 1)} ${t('km2')}`;
      }
    } else if (v.type === 'valley') {
      primary = t('qValley');
      secondary = state.lang === 'ne' ? 'Kathmandu Valley' : 'काठमाडौं उपत्यका';
      sub = `${formatNum(valleyDistricts.length)} ${t('districts')} · ${formatNum(valleyLocalCount())} ${t('localLevels')}`;
    }

    if (!primary) {
      primary = state.lang === 'ne' ? 'नेपाल' : 'Nepal';
      secondary = state.lang === 'ne' ? 'Nepal' : 'नेपाल';
      sub = `${formatNum(meta.counts.provinces)} ${t('provinces')} · ${formatNum(meta.counts.districts)} ${t('districts')} · ${formatNum(meta.counts.locals)} ${t('localLevels')}`;
    }

    titleEl.textContent = primary;
    altEl.textContent = secondary;
    altEl.classList.toggle('np', hasDevanagari(secondary));
    subEl.textContent = sub;
  }

  function localeLocalTitle(f) {
    const p = f.properties;
    return state.lang === 'ne' ? npShort(p.name_np) : p.name_en_short;
  }

  function closePopups() {
    if (map) map.closePopup();
  }

  // -------------------------------------------------------------------------
  // Views and navigation
  // -------------------------------------------------------------------------
  function fitOptions(opts = {}) {
    const small = map.getSize().x < 720;
    return {
      paddingTopLeft: L.point(small ? 16 : 26, small ? 64 : 84),
      paddingBottomRight: L.point(small ? 16 : 26, small ? 26 : 40),
      maxZoom: opts.maxZoom || 12,
      animate: opts.animate !== false,
      duration: 0.55,
    };
  }

  function setView(type, code = null, opts = {}) {
    state.view = { type, code: code == null ? null : String(code) };
    let active = null;
    if (type === 'province') {
      active = String(code);
    } else if (type === 'district') {
      const f = districtByCode.get(String(code));
      active = f ? String(f.properties.province_code) : null;
    } else if (type === 'local') {
      const f = localByCode.get(String(code));
      active = f ? String(f.properties.province_code) : null;
    } else if (type === 'valley') {
      active = '3';
    }
    state.activeProvince = active;
    if (opts.render !== false) renderSidebar();
    updateMapTitle();
  }

  function focusNational(opts = {}) {
    setView('national');
    if (!nepalBounds || !nepalBounds.isValid()) return;
    map.fitBounds(nepalBounds, fitOptions({ maxZoom: 8, animate: opts.animate }));
  }

  function focusProvince(code, opts = {}) {
    const key = String(code);
    const f = provinceByCode.get(key);
    const b = boundsByProvince.get(key);
    if (!f || !b) return;
    setView('province', key);
    map.fitBounds(b, fitOptions({ maxZoom: 9.25, animate: opts.animate }));
    if (opts.popup) afterNextMove(() => openPopup('province', key));
  }

  function focusDistrict(code, opts = {}) {
    const key = String(code);
    const f = districtByCode.get(key);
    const b = boundsByDistrict.get(key);
    if (!f || !b) return;
    setView('district', key);
    map.fitBounds(b, fitOptions({ maxZoom: 11.5, animate: opts.animate }));
    if (opts.popup) afterNextMove(() => openPopup('district', key));
  }

  function focusLocal(code, opts = {}) {
    const key = String(code);
    const f = localByCode.get(key);
    const layer = layerIndex.local.get(key);
    const b = layer ? layer.getBounds() : null;
    if (!f || !b || !b.isValid()) return;
    setView('local', key);
    map.fitBounds(b, fitOptions({ maxZoom: 13, animate: opts.animate }));
    if (opts.popup) afterNextMove(() => openPopup('local', key));
  }

  function focusValley(opts = {}) {
    if (!valleyBounds || !valleyBounds.isValid()) return;
    setView('valley');
    map.fitBounds(valleyBounds, fitOptions({ maxZoom: 11, animate: opts.animate }));
    if (opts.popup) afterNextMove(() => openPopup('district', '306'));
  }

  function focusKathmanduDistrict(opts = {}) {
    const d = A.districtStats.find((x) => x.name_en === 'Kathmandu');
    if (d) focusDistrict(d.code, opts);
  }

  // -------------------------------------------------------------------------
  // Drawer
  // -------------------------------------------------------------------------
  function isDrawerMode() {
    return window.matchMedia('(max-width: 900px)').matches;
  }

  function openDrawer() {
    sidebar.classList.add('open');
    const backdrop = document.getElementById('sidebar-backdrop');
    if (backdrop) backdrop.hidden = false;
    const toggle = document.getElementById('menu-toggle');
    if (toggle) toggle.setAttribute('aria-expanded', 'true');
  }

  function closeDrawer() {
    sidebar.classList.remove('open');
    const backdrop = document.getElementById('sidebar-backdrop');
    if (backdrop) backdrop.hidden = true;
    const toggle = document.getElementById('menu-toggle');
    if (toggle) toggle.setAttribute('aria-expanded', 'false');
  }

  function maybeCloseDrawer() {
    if (isDrawerMode()) closeDrawer();
  }

  // -------------------------------------------------------------------------
  // Events
  // -------------------------------------------------------------------------
  function setLanguage(lang) {
    if (lang !== 'en' && lang !== 'ne') return;
    if (state.lang === lang) return;
    state.lang = lang;
    applyLanguage();
    closeSearch();
  }

  function bindSidebarEvents() {
    sidebarContent.addEventListener('click', (event) => {
      const close = event.target.closest('[data-action="close-sidebar"]');
      if (close) {
        closeDrawer();
        return;
      }
      const province = event.target.closest('[data-province]');
      if (province) {
        focusProvince(province.getAttribute('data-province'));
        maybeCloseDrawer();
        return;
      }
      const view = event.target.closest('[data-view]');
      if (view) {
        const kind = view.getAttribute('data-view');
        if (kind === 'national') focusNational();
        else if (kind === 'bagmati') focusProvince(3);
        else if (kind === 'valley') focusValley();
        else if (kind === 'kathmandu') focusKathmanduDistrict();
        maybeCloseDrawer();
      }
    });

    sidebarContent.addEventListener('change', (event) => {
      const input = event.target.closest('[data-layer]');
      if (!input) return;
      const key = input.getAttribute('data-layer');
      if (!(key in state.layers)) return;
      state.layers[key] = input.checked;
      persistLayers();
      applyLayers();
    });
  }

  function bindChromeEvents() {
    document.querySelectorAll('.lang-toggle button').forEach((btn) => {
      btn.addEventListener('click', () => setLanguage(btn.dataset.lang));
    });

    const brand = document.getElementById('brand-home');
    if (brand) {
      brand.addEventListener('click', (event) => {
        event.preventDefault();
        focusNational();
        maybeCloseDrawer();
      });
    }

    const menu = document.getElementById('menu-toggle');
    if (menu) {
      menu.addEventListener('click', () => {
        if (sidebar.classList.contains('open')) closeDrawer();
        else openDrawer();
      });
    }

    const backdrop = document.getElementById('sidebar-backdrop');
    if (backdrop) backdrop.addEventListener('click', closeDrawer);

    const mapOpen = document.getElementById('sidebar-open');
    if (mapOpen) mapOpen.addEventListener('click', openDrawer);

    const accuracyMore = document.getElementById('accuracy-more');
    if (accuracyMore) {
      accuracyMore.addEventListener('click', () => {
        if (isDrawerMode()) openDrawer();
        const box = document.getElementById('accuracy-box');
        if (!box) return;
        box.scrollIntoView({ behavior: 'smooth', block: 'center' });
        box.classList.remove('flash');
        void box.offsetWidth;
        box.classList.add('flash');
      });
    }

    const sheetsLink = document.getElementById('sheets-link');
    if (sheetsLink) {
      sheetsLink.addEventListener('click', (event) => {
        event.preventDefault();
        if (isDrawerMode()) openDrawer();
        const section = document.getElementById('sheets');
        if (section) section.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    }

    document.addEventListener('click', (event) => {
      const local = event.target.closest('[data-focus-local]');
      if (local) {
        focusLocal(local.getAttribute('data-focus-local'), { popup: true });
        return;
      }
      const district = event.target.closest('[data-focus-district]');
      if (district) {
        focusDistrict(district.getAttribute('data-focus-district'), { popup: true });
        return;
      }
      const province = event.target.closest('[data-focus-province]');
      if (province) {
        focusProvince(province.getAttribute('data-focus-province'), { popup: true });
      }
    });

    document.addEventListener('keydown', (event) => {
      const typing = /^(INPUT|TEXTAREA|SELECT)$/.test(event.target.tagName) || event.target.isContentEditable;
      if (event.key === '/' && !typing && !event.metaKey && !event.ctrlKey && !event.altKey) {
        event.preventDefault();
        searchInput.focus();
      } else if (event.key === 'Escape' && sidebar.classList.contains('open')) {
        closeDrawer();
      }
    });

    let resizeTimer = null;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(() => {
        map.invalidateSize({ pan: false });
        scheduleLabels();
      }, 120);
    });
  }

  // -------------------------------------------------------------------------
  // Init
  // -------------------------------------------------------------------------
  function init() {
    try {
      buildLookups();
      buildSearchIndex();
      buildLabelData();
      initMap();
      bindSearch();
      bindSidebarEvents();
      bindChromeEvents();
      applyLanguage();
      applyLayers();
      focusNational({ animate: false });
      map.invalidateSize();
      map.whenReady(() => {
        window.setTimeout(() => loading.classList.add('hidden'), 180);
      });

      window.AtlasApp = {
        version: '1.0.0-pilot',
        map,
        state,
        meta,
        focusNational,
        focusProvince,
        focusDistrict,
        focusLocal,
        focusValley,
        setLanguage,
        openPopup,
        refreshLabels,
        findSearchResults,
        get counts() {
          return {
            provinces: meta.counts.provinces,
            districts: meta.counts.districts,
            locals: meta.counts.locals,
          };
        },
      };
    } catch (error) {
      console.error(error);
      fatal(error && error.message ? error.message : String(error));
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
