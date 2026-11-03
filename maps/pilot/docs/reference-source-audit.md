# Reference source audit — v1.1

**Audit date:** 27–28 October 2026  
**Scope:** protected-area and buffer-zone geometry for v1.1  
**Status:** G1 source lock remains open for the geometry layer. The DNPWC request is **deferred by D10** (28 October 2026); the non-spatial reference path is active. No geometry has been added to `data/` or the web bundle.

---

## 1. Purpose

D6 approved DNPWC as the primary source, `stepps00` CC BY 4.0 as a labelled fallback, and OSM only if the bundle is relicensed to ODbL. This audit tests whether either fallback can actually support the approved layer model:

- 21 federal core areas as one layer;
- 14 federal buffer zones as a separate layer;
- optional 1 provincial Badimalika feature;
- no merged or double-counted geometry.

A fallback is only usable if it can preserve that separation. This audit found that neither fallback can.

---

## 2. DNPWC — primary route

| Item | Result |
|---|---|
| Homepage | Reachable, HTTP 200, 27 Oct 2026 |
| Contact | `info@dnpwc.gov.np` · 01-5320850 · 01-5320912 |
| Area coverage page | Reachable, but contains no table, iframe, download link or data file |
| Downloads category | HTTP 503 at audit time |
| Park office pages | Present for the current network, including Chhayanath |
| Boundary package | **Not found** |

The “Area Coverage Database of All PAs” page is a page shell only. It did not expose an embedded dashboard, API, spreadsheet or archive. The DNPWC site does provide Nepali names and office pages, which are useful for the master tables, but not geometry.

**Conclusion:** a written request is required. See [`outreach/dnpwc-data-request.md`](outreach/dnpwc-data-request.md).

### 2.1 2020 DNPWC-commissioned GIS report (`S20`)

A 47-page PDF, **“Coverage Area Database on Protected Areas of Nepal by Province, District, Palika and Ward Level (2077)”**, was submitted to DNPWC in Bhadra 2077 (September 2020). It tabulates protected areas by province, district, palika and ward.

It is a **factual cross-check only**. It contains no distributable geometry and no open-geometry licence; the PDF must not be redistributed or treated as a boundary source.

| Finding | Figure | Use |
|---|---:|---|
| Bardiya buffer | 507.00 km² | Confirms the master figure; 327 km² is the older 1996 declaration |
| Gaurishankar core | 2,179 km² | Master corrected from 2,197; federal core now 28,741.94 km² |
| Parsa core | 627.39 km² | Recorded as geometry-derived in `area_geom_km2`; published figure remains 637 km² |
| Shey Phoksundo in Mugu | 843.50 km² | Supports the 843.36 km² Chhayanath transfer within rounding |
| Pre-Chhayanath core network | 28,731.97 km² | 2020 baseline, not the current 21-area total |
| Pre-Chhayanath buffer network | 5,687.78 km² | 2020 baseline, not the 5,602 km² 12-zone aggregate or the 14-row total |

The report predates Chhayanath and Badimalika, so its aggregate totals are not directly comparable with the current master. It does not resolve the Parsa buffer 298.2/285.3 difference; that remains a DNPWC confirmation item.

---

## 3. OSM / Overpass — secondary geometry and QA

### 3.1 Queries

Both queries were run on 27 October 2026 with a descriptive `User-Agent`.

| Query | Result |
|---|---|
| Nepal area, `boundary=protected_area` | 27 elements: 18 ways, 9 relations |
| Bounding box 26.3–30.5°N, 80.0–88.3°E | 43 elements, including Indian and Chinese protected areas, community forests and unrelated sites |

### 3.2 Nepal core areas present

Only eight of the 21 federal core areas could be identified:

- Annapurna Conservation Area
- Manaslu Conservation Area
- Kanchenjunga Conservation Area
- Gaurishankar Conservation Area
- Api Nampa Conservation Area
- Koshi Tappu Wildlife Reserve
- Dhorpatan Hunting Reserve
- Krishnasar / Blackbuck Conservation Area

### 3.3 Missing

Thirteen core areas were not present, including Chitwan, Sagarmatha, Langtang, Rara, Khaptad, Shey Phoksundo, Bardiya, Makalu Barun, Shivapuri Nagarjun, Banke, Shuklaphanta, Parsa and Chhayanath.

**No buffer zones were present as separate features.**

Names are also inconsistent (`Manasalu`, `Guarishankar`, `Kanchanjunga`, `Black Buck`), and several relevant-looking features are unnamed ways or community forests.

**Conclusion:** OSM cannot supply the approved layer model. It is not necessary to make an ODbL relicensing decision at this stage, because no OSM geometry will be shipped. OSM may still be used as a visual QA reference for the eight areas it covers.

---

## 4. `stepps00/Protected-Areas-Data-Nepal` — CC BY 4.0 fallback

### 4.1 Dataset facts

| Item | Value |
|---|---|
| Repository | `stepps00/Protected-Areas-Data-Nepal` |
| Licence | CC BY 4.0 |
| Last edit in attributes | 2023-09-25 |
| Features | 20 polygons |
| CRS | WGS 84 |
| Bounds | 80.0585–88.2018°E, 26.5560–30.2261°N |
| Attributes | `id`, `name`, `namealt`, `nameloc`, `namelocalt`, `langloc`, `type`, `typeloc`, `iso3`, `area`, `daterec`, `datelast`, `srcgeom`, `note` |
| `area` field | Empty for every feature |
| Local names | Empty for every feature |
| New designations | No Chhayanath, no Badimalika–Ramaroshan |

The `type` field is the critical problem. Most national parks are labelled **“National Park and Buffer Zone”** as a single feature. The dataset does not provide a separate core polygon and buffer polygon.

### 4.2 Computed geometry areas

Areas below are spherical estimates from the downloaded shapefile, for audit only. Published figures are the plan’s current values. “Core + BZ” is the sum of the published core and buffer figures.

| Feature | Dataset type | Computed km² | Published core | Core + BZ | Reading |
|---|---|---:|---:|---:|---|
| Annapurna Conservation Area | Conservation Area | 7,570.19 | 7,629 | — | Core only; close |
| Shey Phoksundo National Park | National Park and Buffer Zone | 4,794.49 | 2,712 | 4,061 | Closer to the old 3,555 + 1,349 = 4,904; pre-Chhayanath |
| Langtang National Park | National Park and Buffer Zone | 2,461.68 | 1,710 | 2,130 | Above both; inconsistent |
| Makalu Barun National Park | National Park and Buffer Zone | 2,140.16 | 1,500 | 2,330 | Close to combined |
| Chitwan National Park | National Park and Buffer Zone | 2,042.08 | 952.63 | 1,702.63 | Above combined |
| Kanchenjunga Conservation Area | Conservation Area | 1,994.67 | 2,035 | — | Core only; close |
| Api Nampa Conservation Area | Conservation Area | 1,815.63 | 1,903 | — | Core only; close |
| Manaslu Conservation Area | Conservation Area | 1,568.02 | 1,663 | — | Core only; close |
| Gaurishankar Conservation Area | Conservation Area | 1,437.59 | 2,197 | — | 34.6% low |
| Sagarmatha National Park | National Park and Buffer Zone | 1,396.83 | 1,148 | 1,423 | Close to combined |
| Bardiya National Park | National Park and Buffer Zone | 1,376.20 | 968 | 1,475 | Near combined |
| Dhorpatan Hunting Reserve | Hunting Reserve | 1,191.44 | 1,325 | — | 10.1% low |
| Parsa National Park | National Park and Buffer Zone | 1,046.40 | 637 | 922.3 | Above combined |
| Banke National Park | National Park and Buffer Zone | 869.99 | 550 | 893 | Close to combined |
| Shuklaphanta National Park | National Park and Buffer Zone | 736.65 | 305 | 548.5 | 34.3% above combined |
| Khaptad National Park | National Park and Buffer Zone | 410.54 | 225 | 441 | Near combined |
| Rara National Park | National Park and Buffer Zone | 243.75 | 106 | 304 | 2.3× core |
| Koshi Tappu Wildlife Reserve | Wildlife Reserve and Buffer Zone | 239.86 | 175 | 348.5 | 1.37× core, below combined |
| Shivapuri Nagarjun National Park | National Park and Buffer Zone | 142.39 | 159 | 277.61 | Core only, 10.5% low |
| Krishnasar Conservation Area | Conservation Area | 110.08 | 16.95 | — | 6.5× core; clearly wrong or a different feature |
| **Total** | | **33,588.64** | **28,822.58** | **34,424.58** | Between the two totals |

The published totals in this table are the figures used at audit time. They were subsequently corrected by the area reconciliation: **Gaurishankar 2,197 → 2,179 km²**, federal core **28,741.94 km²** and dated combined coverage **34,343.94 km²**. The stepps00 comparison and the conclusion are unchanged. See [`reference-area-reconciliation.md`](reference-area-reconciliation.md).

### 4.3 Finding

The dataset is not a consistent “core only” or “core + buffer” product. Some features match core-only, some approximate core + buffer, several are materially outside both, and one is 6.5× its published area. The missing `area` field means there is no authoritative check inside the dataset.

**It cannot be used to create separate core-area and buffer-zone layers.** Using it would either merge 13 buffer zones into core features or require inventing a split. Both violate D1 and D6.

**Retain it only as a visual QA reference. Do not import it into the build.**

### 4.4 Additional fallback checks — 27 October 2026

Three further possibilities were checked before leaving G1 open.

| Candidate | Result | Usable? |
|---|---|---|
| National GeoPortal (Survey Department GeoNode) | DNS resolves to `202.45.146.139`, but TCP 80 and 443 timed out from the audit environment. The WMS/WFS endpoints could not be inspected. | **Unknown; not counted.** Recheck from a Nepali network before the next source review. |
| ArcGIS item “Protected Area Nepal” (`54417fbdb6d84b10b77c5c676968617d`) | Public feature service labelled CC BY 4.0, but its access statement cites UNEP-WCMC/IUCN **WDPA, December 2022**. It is a WDPA republication, not an independent Nepali source. Its description lists 20 core areas and 13 buffer zones, so it predates Chhayanath and cannot supply the 21 + 14 network. | **No.** WDPA geometry is excluded by D6; 2022 vintage and coverage also fail. |
| OpenDataNepal “Protected Areas of Nepal…” (`S19`) | CSV only, 20 core areas and 12 buffer zones. No geometry. Older figures: Parsa core 499 km² (pre-2017 wildlife reserve), Bardiya buffer 327 km², Chitwan 932 km², Gaurishankar 2,179 km². | **Attribute cross-check only.** No geometry, no current network. |

**Conclusion:** no additional compliant geometry source was found. DNPWC remains the critical path for core and buffer polygons. The National GeoPortal is the only untested lead; its WFS should be rechecked from a network that can reach the service.

---

## 5. Effects on the approved plan

| Decision | Effect |
|---|---|
| **D1** — buffer zones separate | Still the target, but the `stepps00` fallback cannot supply it. Buffer geometry now depends on DNPWC or another permission-capable source. |
| **D6** — DNPWC first, `stepps00` fallback | DNPWC remains the only viable route to a compliant separate layer. The `stepps00` fallback is **withdrawn as a geometry source**; it may be cited only as QA. |
| **D7** — missing geometry as non-spatial records | Applies to Chhayanath and Badimalika now. It may also have to apply to buffer zones if no source is secured. That would be a scope amendment, not a silent omission. |
| **ODbL / OSM** | No relicense needed. OSM is QA only. |

### Options if DNPWC does not provide geometry

1. **Core-only geometry, buffer zones as non-spatial records.** Publish the 14 buffer zones in a table with area, parent and gazettal date; no buffer polygon, no buffer count in the map legend. This preserves D1’s semantic separation but not its spatial layer.
2. **Defer both protected-area and buffer geometry.** Ship the peaks and the reference tables; retain v1.0 administrative layers unchanged. This avoids a partial or misleading conservation layer.
3. **Use `stepps00` as a merged indicative layer.** Not recommended: it contradicts D1, mixes core and buffer, and would require a new decision and a visible “merged extent” label.

No option may be chosen silently. Option 1 is the closest to the approved plan; option 2 is the safest if DNPWC cannot respond before the release window.

---

## 6. Survey Department

The correct domain is `dos.gov.np`, not `survey.gov.np` or `surveyofnepal.gov.np` (both failed DNS).

| Item | Result |
|---|---|
| Homepage | Reachable, HTTP 200, 27 Oct 2026 |
| Contact | `info@dos.gov.np`, `informationofficer@dos.gov.np` |
| Address | Minbhawan, Kathmandu |
| Geometry | None requested or obtained |
| v1.1 status | Out of scope; separate permission-dependent edition |

See [`outreach/survey-department-data-request.md`](outreach/survey-department-data-request.md).

---

## 7. Source decisions recorded

| Layer | Source status | Decision |
|---|---|---|
| Federal core areas | DNPWC request pending | No geometry shipped until a source is licensed and credible |
| Federal buffer zones | No usable source | DNPWC request pending; `stepps00` withdrawn |
| Badimalika–Ramaroshan | No geometry | Non-spatial record unless an authoritative boundary is provided |
| Chhayanath | No geometry | Non-spatial record unless DNPWC provides the boundary |
| Peaks | Wikidata / Wikipedia / Himalayan Database | Point data only; freeze pending |
| Administrative base | Open Knowledge Nepal, CC BY 4.0 | Unchanged from v1.0 |

### 7.1 Peak-profile site unavailable — 28 October 2026

The Government of Nepal “Nepal Himal Peak Profile” site (`nepalhimalpeakprofile.org`), cited by English Wikipedia's peak articles, resolves to an **“Account Suspended”** page on both the apex and `www` hosts. The Wayback Machine has no snapshot of the Thulagi peak pages. No official peak profile could be retrieved.

Peak names and coordinates therefore continue to rely on Wikidata (`S04`), Wikipedia (`S14`, `S15`), the Himalayan Database (`S05`) and named reviewer sign-off. One candidate coordinate (Yalung Kang West) comes from Peakbook (`S18`) and is pending confirmation. This finding does **not** affect the protected-area or buffer-zone geometry decision, and it does not create a new source for the offline bundle.

---

## 8. Next actions

1. **DNPWC request — deferred by D10 on 28 October 2026.** The draft in `docs/outreach/dnpwc-data-request.md` is ready. Reactivate it before any protected-area or buffer-zone geometry work. Ask explicitly for core and buffer geometry as separate layers, permission to redistribute in the offline bundle and print PDFs, and a current gazette/area table that supersedes the 2020 report (`S20`).
2. **Survey Department request — deferred.** It belongs to the separate official-geometry edition and does not block v1.1.
3. Do not relicense the bundle to ODbL.
4. Do not import `stepps00` geometry.
5. Do not use WDPA, `stepps00`, OSM or traced geometry as a fallback. The DNPWC-deferred edition publishes non-spatial records only.
6. The master tables are drafted and the peak reviewer packet is ready; complete G2 sign-off before the G3 peaks build.
7. When DNPWC responds, add core and buffer geometry as a separate additive layer/edition; re-run data QA and re-render. Do not hot-patch generated geometry.

*No v1.1 build code or production geometry has been created. The 2020 report is used as a factual cross-check only.*
