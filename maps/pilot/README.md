# Nepal Local Level Atlas — open-data pilot

A bilingual (Nepali / English) reference atlas of Nepal's **7 provinces, 77 districts and 753 local levels**, delivered as three print sheets and an offline web map.

**Edition:** Open-data pilot · October 2026  
**Version:** 1.0.0-pilot  
**Status:** Pilot release. Boundaries are generalised and **not survey-grade**.

---

## What is in this delivery

### Print sheets

| Sheet | Coverage | Size | PDF |
|---|---|---|---|
| 1 | Nepal — 7 provinces, 77 districts, 753 local levels | A1 | [`print/01_national.pdf`](print/01_national.pdf) |
| 2 | Bagmati Province — 13 districts, 119 local levels, Kathmandu Valley inset | A2 | [`print/02_bagmati.pdf`](print/02_bagmati.pdf) |
| 3 | Kathmandu District — 11 local levels, at approximately 1:178,094 | A3 | [`print/03_kathmandu.pdf`](print/03_kathmandu.pdf) |
| 4 | Peaks — 8 main + 6 official additional + 37 seven-thousanders (A2 landscape) | A2 | [`print/04_peaks.pdf`](print/04_peaks.pdf) |

Each sheet has a matching HTML file in `print/`. The web app links to both the PDF and the HTML view.

### Web map

Open [`web/index.html`](web/index.html) directly in Microsoft Edge, Chrome, or another current browser. No web server or internet connection is required: Leaflet, its assets, and the full data bundle are local.

Features:

- Bilingual **EN / नेपाली** interface and map labels.
- Search across provinces, districts, and all 753 local levels, including common short names and unit codes.
- Quick views for Nepal, Bagmati Province, Kathmandu Valley, and Kathmandu District.
- Layer controls for provinces, districts, local levels, boundaries, labels, and graticule.
- Clickable map features with bilingual profiles and links to the relevant print sheet.
- View-aware labels: national view labels provinces, province view labels districts, district and valley views label local levels.
- Responsive desktop and mobile layouts, including a mobile drawer.
- A persistent accuracy strip and legend, with a clearly styled **“No local-level data”** polygon where protected areas fall outside the open local-level geometry.

The web data bundle is [`web/data/atlas.js`](web/data/atlas.js) (`window.ATLAS`). It contains 753 locals, 77 districts, 7 provinces, and 4 gap polygons, plus merged statistics and sheet links.

---

## Accuracy and scope

This is an **open-data reference atlas**, not a cadastral, legal, or survey-grade boundary determination.

- Local-level geometry comes from **Open Knowledge Nepal, LocalBoundaries (CC BY 4.0)**, simplified to 5% for the web map.
- District and province polygons in the web map are **dissolved from the same simplified local-level geometry**, so the three layers share edges and do not produce slivers.
- The print sheets use an Albers equal-area projection (27°N / 30°N standard parallels).
- Names, unit types, codes, and counts were reconciled against the supplied official 753-unit table.
- **Wards are deferred to Phase 2.**
- Protected-area overlays are deliberately omitted from this pilot because the available open overlay is incomplete. Where a protected area leaves a hole in the dissolved province geometry, the web map marks it as **“No local-level data”** rather than showing a false local-level polygon.

An official Survey Department geometry edition is a separate upgrade track and would be released only if that geometry is secured.

---

## Repository layout

```
maps/pilot/
├─ README.md
├─ data/
│  ├─ local_levels.geojson
│  ├─ districts.geojson
│  ├─ provinces.geojson
│  ├─ protected_areas.geojson   # superseded 10-feature v1.0 draft; not used for v1.1
│  ├─ peaks_draft.geojson       # D10 draft; 51 peak points; not for release
│  ├─ reference/                # v1.1 master tables, sources, evidence review
│  └─ summary.json
├─ build/
│  ├─ prepare_data.js        master-data preparation
│  ├─ prepare_reference.js   v1.1 reference preparation (D10-deferred: peaks + non-spatial tables)
│  ├─ mapkit.js              projection, SVG paths, labels, scale bars
│  ├─ pagekit.js             shared print-page CSS and HTML shell
│  ├─ make_national.js       national A1 sheet
│  ├─ make_bagmati.js        Bagmati A2 sheet
│  ├─ make_kathmandu.js      Kathmandu A3 sheet
│  └─ make_web_data.js       offline web data bundle
├─ print/                    final HTML and PDF sheets
└─ web/
   ├─ index.html
   ├─ style.css
   ├─ app.js
   ├─ assets/                local Leaflet 1.9.4 assets
   └─ data/                  simplified geometry and atlas.js
```

---

## Rebuilding

The pilot uses **Node.js 24** and **Microsoft Edge** for PDF output. No Python interpreter is required.

### Print sheets

```powershell
cd maps\pilot
node build\make_national.js
node build\make_bagmati.js
node build\make_kathmandu.js
```

These commands write the HTML sheets to `print/`. To produce the PDFs with Edge:

```powershell
& "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" `
  --headless=new --disable-gpu --no-pdf-header-footer `
  --print-to-pdf="maps\pilot\print\01_national.pdf" `
  --print-to-pdf-no-header `
  "file:///C:/Users/user/Downloads/selected/maps/pilot/print/01_national.html"
```

Repeat for `02_bagmati` and `03_kathmandu`, changing the output filename and source HTML. Print settings are embedded in each sheet (`@page` size), so no extra page setup is needed.

### Web data

```powershell
cd maps\pilot
node build\make_web_data.js
```

This rebuilds `web/data/atlas.js` from the simplified geometry in `web/data/` and the master statistics in `data/`.

---

## Verification performed

- Source audit: **753 unique local levels, 77 districts, 7 provinces**; duplicate multipart features merged; district-name corrections applied.
- Print QA: all three PDFs rendered with **PDFium** at native resolution; bilingual Devanagari labels and titles visually checked.
- Web QA: Playwright / Microsoft Edge suite passed **37/37** checks covering counts, search, language switching, layer toggles, popups, mobile drawer, responsive overflow, and console errors.
- Visual QA: national, province, district, valley, gap-polygon, and mobile views screenshotted and inspected.
- Data QA: web totals are **147,609.54 km²** (Survey Department HDX COD-AB, edge-matched); province, district, and local layers share dissolved edges; **1 gap polygon** is present and labelled. Geometry upgraded from OKN 5%-simplified (202 pts/unit) to HDX COD-AB (1,375 pts/unit, 6.8x denser).

---

## Version 1.1 (in progress)

v1.1 adds the national conservation estate and the high peaks as **reference layers** alongside the administrative hierarchy. The v1.0 files above are unchanged.

- Status and gate log: [`docs/v1.1-status.md`](docs/v1.1-status.md)
- Plan and decisions D1–D10: [`docs/v1.1-implementation-plan.md`](docs/v1.1-implementation-plan.md)
- Task ledger (complete / ready / deferred / blocked): [`docs/v1.1-completion-ledger.md`](docs/v1.1-completion-ledger.md)
- Reviewer sign-off packet: [`docs/reviewer-signoff-packet.md`](docs/reviewer-signoff-packet.md)
- Reference tables and evidence: [`data/reference/`](data/reference/)

**D10 scope note:** the DNPWC request is deferred. v1.1 ships the peaks layer and **non-spatial** protected-area/buffer-zone tables; no protected-area or buffer-zone polygon will be generated until DNPWC permission or another compliant source is obtained. The existing `data/protected_areas.geojson` is the superseded 10-feature v1.0 draft and is **not** used for v1.1.

- Boundaries: **Open Knowledge Nepal**, *LocalBoundaries* — CC BY 4.0.
- Codes, names, and unit types: official 753-unit code table supplied with the project.
- Projection: Albers equal-area, 27°N / 30°N; web geometry in WGS 84 (EPSG:4326).
- Basemap: none. The web map is intentionally offline and does not depend on external tile services.

Please retain the accuracy notice and attribution when reusing or republishing these materials.
