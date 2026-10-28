# Roadmap — Nepal Administrative Data (`nepal_admin_api`)

> Working plan for expanding the project in depth. Tracks what is shipped (v2.9.0),
> what is blocked on external inputs, and what the next phases could be.
> Doctrine that constrains every item below: **honesty tiers** (verified =
> doubly-attested only; never invent/transliterate; conflicting evidence stops
> the run), **core package ≤ 100 KB**, **wards on hold until CBS Census 2021**,
> **overlays are context, never competitors to the figure**.

Status key: ✅ shipped · 🔄 in progress · ⏸ blocked on external input · 📋 planned

---

## 0. Current state (v2.9.0, `main` @ `c9e7622`)

| Asset | State |
|---|---|
| Provinces / districts / palikas / wards | 7 / 77 / 753 / 6,743 declared |
| CBS codes | 753/753 coded (548 verified · 205 single-source · 0 unverified) |
| Devanagari names | 753/753 palikas · 77/77 districts · 7/7 provinces (450 corroborated) |
| Centroids | 753/753 mapped |
| Palika boundaries | 753/753 joined (0 unmatched) · ~101 KB (100 KB gate) |
| Province boundaries | 7/7 high-res (National Geoportal) |
| District boundaries | 77/77 (lossless VLQ, ~175 KB) — shipped 2026-10-28 (#15) |
| Bindings | Dart · TS/JS · Python · CSV · GeoJSON (drift-checked in CI) |
| Widgets | 7 Flutter components (`nepal_admin_widgets`) |
| Docs site | Explorer (table + clustered map) · API ref · llms.txt/llms-full.txt |
| Map overlays | National outline (K1) · Protected areas (K2) · NH01 highway (H1) |
| Tests | 155 + 1 justified skip · bindings 139/139 · analyze clean |

---

## Phase 1 — "Complete the base" (v3.0) 📋

Unblocks everything downstream. No new data invented; only resolution of
already-known gaps and housekeeping.

| # | Item | Status | Notes |
|---|---|---|---|
| 1.1 | Publish `nepal_admin_api` 2.9.0 to pub.dev | 📋 | Widgets resolve `^2.7.2`; tests version-agnostic |
| 1.2 | Gazette confirmation for the 7 renames (`doc/REVIEW-codes.md` §8.3) | ⏸ | Apply or reject in English once confirmed |
| 1.3 | First real Pass A2 run on a source-complete machine | ⏸ | Needs full `data/_raw/` (mofaga manual) |
| 1.4 | Resolve the 7 unmatched palika boundaries | ✅ | Resolved via the 2026-10-26 centroid completion (point-in-polygon fallback joined all 7 spelling variants); `kUnmatchedPalikaBoundaries` is now empty and all 753 roster palikas carry a boundary |
| 1.5 | Fill the 22 palikas with no attested Devanagari name | ✅ | All 753/753 now carry a Devanagari name (450 corroborated); the 22 were filled across v2.8.x–v2.9.0 |
| 1.6 | Promote `singleSource` → `verified` where a second attestation exists | 📋 | CBS Census 2021 / MoFAGA re-harvest; directory attestations alone never promote |
| 1.7 | Decide on high-res palika boundaries vs. the 100 KB gate | ✅ | Decided: core stays at 100 KB (eps 0.006, already high-res-derived); high-res ships as a separate optional package `packages/nepal_admin_boundaries_highres` (eps 0.001, ~75k vertices, ~300 KB, 7 tests green) |
| 1.8 | Fix stale README feature table (said 9 unverified / 196 singleSource / 731 nameNe) | ✅ | Updated to 548 / 205 / 0 and 753/753 across README, docs/index.html, data/SOURCES.md, widgets README |
| 1.9 | License verification for `custom.geo.json` (77-district GeoJSON) | ⏸ | Origin undocumented; on hold |

**Exit criteria for v3.0:** all 753 coded at the strongest defensible tier,
all 753 nameNe filled or honestly null, boundaries ≥ 750/753 joined, Pass A2
manifest green, package published.

---

## Phase 2 — "Spatial depth" (v3.1) 📋

Make the geometry first-class in the API, not just in the explorer.

| # | Item | Status | Notes |
|---|---|---|---|
| 2.1 | Spatial query API: `pointInPalika(lat, lng)`, `nearestPalika`, `palikasWithinRadius`, `boundariesIntersect` | 📋 | Pure Dart; reuse boundary codec |
| 2.2 | Reverse geocode endpoint in the explorer (click map → identify palika) | 📋 | Uses 2.1 |
| 2.3 | Choropleth explorer (metric switcher: wards, type, code tier, verified %) | 📋 | `feat/choropleth-explorer` content was merged; verify shipped |
| 2.4 | District- and province-level choropleth | 📋 | Aggregate over palika boundaries |
| 2.5 | More highway overlays: NH02 (Tribhuvan), NH03, NH04 (Prithvi), NH05 (Siddhartha) | 📋 | Reuse `tool/extract_nh01.cjs` template; ODbL attribution |
| 2.6 | River network overlay (Koshi, Gandaki, Karnali, Mahakali, Bagmati, …) | 📋 | OSM waterways; new extractor |
| 2.7 | Additional overlays: national-park buffer zones, RAMSAR sites, community forests | 📋 | Extend K2 pattern |
| 2.8 | Hillshade / elevation contour overlay | 📋 | Size-budget check first |
| 2.9 | Flutter map widget (flutter_map) rendering palika boundaries colored by metric | 📋 | Lives in `nepal_admin_widgets` |

**Exit criteria:** spatial queries in the core API; ≥ 2 new overlays shipped with
the same provenance gates as NH01; explorer choropleth live.

---

## Phase 3 — "Wards & population" (v3.2) ⏸

Gated on CBS Census 2021 data. Do not start until sourced.

| # | Item | Status | Notes |
|---|---|---|---|
| 3.1 | `Ward` model + `getWardsByPalika` / `getWardByNumber` | ⏸ | Wards currently on hold |
| 3.2 | Ward boundaries (polygons) when CBS 2021 available | ⏸ | Size budget: wards × polygons |
| 3.3 | Population & demographics per palika (population, sex ratio, literacy, …) | ⏸ | CBS 2021 census |
| 3.4 | Close the 8 roster-defect ward gaps | ⏸ | CBS 2021 reconciles them |
| 3.5 | Ward-level choropleth in the explorer | ⏸ | Depends on 3.1/3.2 |

**Exit criteria:** wards are first-class entities with boundaries; population
attached at palika level with honesty tiers.

---

## Phase 4 — "Economic & social data" (v3.3) 📋

New datasets, each with its own confidence tier and provenance pin.

| # | Item | Status | Notes |
|---|---|---|---|
| 4.1 | Local-government budgets & revenue (MoFAGA) | 📋 | New source; tiered like codes |
| 4.2 | Health facility counts per palika (MoHP) | 📋 | |
| 4.3 | Education facility counts per palika (DoE) | 📋 | |
| 4.4 | Local election results (mayors, ward chairs) | 📋 | Time-stamped; version per election |
| 4.5 | Elected-representative contact directory | 📋 | Extends 371/753 contact coverage |
| 4.6 | Elevation / area at palika level (currently district/province only) | 📋 | From boundary polygons (computable now) |

**Exit criteria:** ≥ 1 new domain dataset shipped with honesty tiers and tests.

---

## Phase 5 — "Developer & ecosystem" (v3.4) 📋

Make the data easy to consume in every environment.

| # | Item | Status | Notes |
|---|---|---|---|
| 5.1 | Automated npm publish for `nepal-admin-data` | 📋 | CI on tag |
| 5.2 | Automated PyPI publish for `nepal-admin-data` | 📋 | CI on tag |
| 5.3 | MCP server exposing the dataset to AI assistants | 📋 | High leverage for this project's audience |
| 5.4 | `nepal_admin` CLI (query/filter/export) | 📋 | Wraps the package |
| 5.5 | Versioned docs site (per-release API + explorer) | 📋 | GitHub Pages |
| 5.6 | Interactive API playground on the site | 📋 | |
| 5.7 | Flutter example app (cascading pickers + map) | 📋 | `packages/.../example` already exists |
| 5.8 | Offline tile support in the map widget | 📋 | Size budget |

**Exit criteria:** one-command install in Dart/JS/Python/CLI; MCP server live.

---

## Phase 6 — "Linked data & standards" (v3.5) 📋

Interoperability with the wider geo/gov ecosystem.

| # | Item | Status | Notes |
|---|---|---|---|
| 6.1 | Wikidata QIDs for provinces/districts/palikas | 📋 | Linked-data joins |
| 6.2 | OSM relation IDs for palika boundaries | 📋 | Enables OSM-driven boundary updates |
| 6.3 | UN/LOCODE or ISO 3166-2 alignment review | 📋 | Province ISO already shipped |
| 6.4 | GeoNames IDs | 📋 | |
| 6.5 | Historical administrative changes (pre-2017 VDCs/DDCs) | 📋 | Time-series of restructuring |
| 6.6 | CRS / simplify-tolerance options in GeoJSON export | 📋 | |

---

## Cross-cutting rules (apply to every phase)

1. **Honesty tiers** — every new field gets a confidence story; `null` over a guess.
2. **Core package ≤ 100 KB** — boundaries are ~91 KB; any new bundled geometry must
   be measured and either quantised or shipped as a separate artifact.
3. **Wards on hold** until CBS Census 2021 is sourced; do not approximate.
4. **Overlays are context** — dedicated Leaflet pane (z 450), off by default, ODbL/CC
   attribution inside the artifact metadata + on-map credit.
5. **Pipeline-gated** — `dart run tool/pipeline.dart` is the entry point; steps are
   order-dependent (bilingual before attributes); abort on first failure.
6. **Drift-checked** — `node bindings/verify_bindings.cjs` + `dart test` in CI.
7. **No invented data** — conflicting evidence stops the run for review.

## Suggested immediate next steps (v3.0 sprint)

1. Publish 2.9.0 to pub.dev.
2. Run Pass A2 on a source-complete machine; commit the manifest.
3. Open a Gazette-confirmation task for the 7 renames.
4. ~~Resolve the 7 unmatched boundaries via point-in-polygon + manual adjudication.~~ ✅ done (centroid completion, 2026-10-26).
5. ~~Fix the stale "9 unverified" line in the README feature table.~~ ✅ done (548/205/0, 753/753 nameNe).

Remaining v3.0 blockers are all external-input gated (Gazette, CBS 2021, source-complete machine).

## Out of scope (explicitly declined)

- Inventing or transliterating Devanagari names.
- Promoting codes on directory attestations alone.
- Shipping ward boundaries before CBS 2021.
- Bundling `custom.geo.json` without a verified license.
- Letting overlays compete with the figure (z-index, default-on, or replacing data).

---

*Last updated: 2026-10-27 (v2.9.0). Revisit after each phase exit.*
