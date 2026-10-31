# Website — Nepal Administrative Data by namunaONE

Static documentation site deployed via GitHub Pages from `docs/`.

- **Live:** https://namunaone.github.io/nGeo/
- **Pages:** `index.html` (landing), `api.html` (reference),
  `explorer.html` (interactive table + figure-selector boundary map over `data.json`),
  `brand.html` (Design System v3 showcase over `brand-tokens.css`)
- **Assets:** `logo.svg` (icon), `logo-full.svg` (icon + wordmark),
  `favicon.svg`, `styles.css`, `app.js`, `data.json`
- **Cache policy:** asset URLs carry `?v=N` (bump on every visual/data
  change; `DATA_URL` in `app.js` likewise) so returning visitors never
  run mixed old/new bundles after a deploy.
- **No build step.** Pure HTML/CSS/JS. `.nojekyll` disables Jekyll.

## Design system

`styles.css` is the single source of truth (Design System v1.1, palette remapped to Design System v3 — accessible blue `#1D4ED8` primary, growth green `#4FD166` accent, brand blue `#3B82F6` for large graphics):

1. **Primitive tokens** — palette scales (`--slate-*`, `--nepal-*`,
   status scales). Never use directly in components.
2. **Semantic tokens** — `--color-primary`, `--color-bg`, `--color-text`,
   `--color-border`, `--color-success/warning/danger/info`.
3. **Fluid typography + spacing** — `--text-*` and `--space-*` use
   `clamp()` (rem anchors + vw interpolation); no breakpoint-jumps.
4. **Layout primitives** — `.stack`, `.cluster`, `.grid-auto`; card grids
   use container queries (`container-type: inline-size`).
5. **Iconography** — `--icon-xs`…`--icon-xl` (14/16/20/24/32px),
   `currentColor` stroke icons, `.theme-icon` sun/moon swap.
6. **Components** — `.btn` (+primary/secondary/ghost/danger/sm/lg),
   `.badge` (+neutral/success/warning/danger/info), `.card`,
   `.alert-*`, `.code-block`, `.explorer-table` (sticky header +
   scroll-shadow hint), `.pagination`, `.toast`, `.maintainer-badge`.
7. **Nav** — sticky blurred header, floating pill on scroll (`.scrolled`,
   passive rAF listener), hamburger panel ≤860px (aria-expanded,
   Escape/outside-click close), 44px touch targets.
8. **Map** — fluid height `clamp(300px, 52vh, 460px)`, dark-filtered tiles,
   themed Leaflet controls/popups.
9. **Badges** — explicit `TYPE_META` map (class + short label + full-name
   tooltip); `.type-unknown` fallback; filter dropdown uses short labels.
   Never derive chip classes via chained string replaces.

Dark mode: `html.dark` class (JS toggle + `localStorage`), with
`prefers-color-scheme` as first-visit default. Honor
`prefers-reduced-motion` and print styles.

## Logo

- `logo.svg` — double-pennon mark: Nepal crimson `#DC143C`,
  Nepal blue `#003893`, white moon/sun/Himalaya, 7 province dots.
- `logo-full.svg` — mark + “Nepal Administrative Data” +
  “7 provinces · 77 districts · 753 palikas” + “BY namunaONE”.
- `favicon.svg` — 64px rounded version for browsers.
- `logo-full-dark.svg` — dark-mode wordmark (light text); swapped by JS
  via `data-logo-light`/`data-logo-dark` because SVG `<img>` cannot read
  page classes. `logo-full.svg` also carries a `prefers-color-scheme`
  media fallback for no-JS.
- Header uses `logo.svg` + stacked wordmark; hero uses `logo-full.svg`;
  footer reuses `logo.svg`.
- v3 keeps the logo unchanged by design — the double-pennon crimson
  `#DC143C` × Nepal blue `#003893` is national symbolism, not the
  product palette.

## AI docs (llms.txt)

- `llms.txt` — spec-compliant index (single H1, ≤50-word blockquote
  summary, H2 sections, absolute-URL links with descriptions). Served at
  site root; footer-linked from every page.
- `llms-full.txt` — complete documentation in one file for deep ingestion.
  Hand-maintained alongside releases (install, quickstart, full API
  signatures, code formats, verification stats, known gaps, links).
  Update both when the API, coverage numbers, or version change.

## Map

Explorer map is a "figure shown on the map" selector (Leaflet 1.9.4,
lazy-loaded CDN, only on `explorer.html`): all 753 palika boundaries are
shaded as a choropleth by the selected metric — local level type (default:
Nepal-flag crimson `#DC143C` for metropolitan, the same crimson lightened
35% for sub-metropolitan, green `#16A34A` for municipality and the same
green lightened 35% for rural municipality), wards per local level (v3
blue ramp), or CBS code confidence — with the classic centroid dot map
available as a legacy view:

- Choropleth (default): 753 palika polygons from nepali-geo-pro-max (MIT,
  pinned commit), vendored same-origin (`palika-boundaries.geojson`) with
  pinned CDN fallbacks (jsDelivr → raw.githubusercontent). Joined to
  `data.json` by normalized English name + districtId, with a
  centroid-in-own-polygon fallback — 753/753 matched (the seven
  upstream spelling variants joined once every roster row carried a
  centroid); the join is pinned by a CI gate
  (`tool/check_boundary_join.dart`). Filters dim non-matching
  palikas (fill 0.08) instead of hiding them, so the national figure
  keeps its context.
- Classic dots: canvas circleMarkers colored by the flag-coded type palette
  (same colors as the type choropleth), hollow
  when CBS-unverified; clusters via `chunkedLoading` +
  `removeOutsideVisibleBounds`. The selector falls back to dots
  automatically if boundaries cannot load.
- Tiles: OSM Standard keyless, maxZoom 19, `© OpenStreetMap contributors`
  on-map + footer. Dark mode reuses the same tiles with a CSS filter
  (no second tile set, no API key).
- Sync: filters/search restyle the choropleth or rebuild dots (all
  filtered, not just the page); table-row click/Enter flies to the palika;
  `?cbs=31304` deep-links. The URL is the shareable explorer state:
  `?q=`, `?province=`, `?district=`, `?type=` and `?metric=` apply as the
  initial filters on load, every filter change rewrites the address bar
  via `history.replaceState`, and the toolbar "Share view" button
  copies the link.
- Tile factory is a single `MAP_TILES` constant + `createTileLayer()` in
  `app.js`, so the tile source is defined in exactly one place.

- **National outline (K1):** Nepal's official चुच्चे (chuche) map as
  published May 2020 — includes Kalapani, Lipulekh and Limpiyadhura
  (Darchula, Sudurpashchim). Rendered as a blue outline-only overlay,
  off by default. Geometry shipped unchanged from
  Acesmndr/nepal-geojson (MIT) — the same source family as the palika
  boundary layer. A smoke gate pins the map: ring resolution > 1,000
  points and point-in-polygon asserts for Lipulekh Pass, Kalapani and
  Kathmandu, so a pre-2020 outline cannot pass CI. Documented gap: no
  local-level units exist inside the Kalapani–Lipulekh–Limpiyadhura
  pocket, so the outline intentionally extends beyond the palika
  layer in the northwest.
- **Protected areas (K2):** the 20 core units on the official DNPWC
  roster — 12 national parks, 6 conservation areas, Koshi Tappu Wildlife
  Reserve and Dhorpatan Hunting Reserve — vendored same-origin
  (`protected-areas.geojson`) as an optional green overlay, toggled in
  the map legend bar. Off by default, green fill-only (v3 accent) so
  context never competes with the choropleth. Geometry: WDPA
  (UNEP-WCMC & IUCN) via the WWF Nepal Biodiversity Areas dataset,
  server-side simplified (~150 m); completeness pinned by a smoke gate
  (20 units, expected IDs, geometry present). Buffer zones, Ramsar
  sites and post-roster proposals (Bara, Phulchoki) stay out of scope.
- **NH01 highway (H1):** Mahendra / Hulaki Highway, Kakarbhitta
  (Jhapa) to Bhim Datta (Kanchanpur) — the DoR's primary east–west
  corridor, vendored same-origin (`nh01-highway.geojson`, ~449 KB) as
  an optional amber overlay, off by default. Geometry extracted from
  OSM route relations by `tool/extract_nh01.cjs`, whose structural
  gates fail the extract loudly (≥ 50 member ways, both termini in
  Jhapa/Kanchanpur, length inside the 800–1,300 km corridor). The
  artifact's metadata member carries the OSM relation IDs, the exact
  Overpass queries, the extract date and the ODbL 1.0 attribution; a
  smoke gate re-checks the corridor length, the termini and the
  LineString shape.
- **Overlays:** context layers (national outline, protected areas,
  the NH01 highway; more to come)
  render in a dedicated Leaflet pane (z-index 450)
  above the figure and persist across metric switches. Each overlay is a
  `MAP_OVERLAYS` entry in `app.js` — a new layer is a data PR, not a
  code PR: vendor the GeoJSON beside `palika-boundaries.geojson`, add
  the registry entry (label, URL fallback chain, style, tooltip), and
  the loader, toggles (`#map-overlays`) and graceful "(unavailable)"
  degradation come for free. Overlays are context, not data — their
  styling must never compete with the choropleth figure.

## Regenerating explorer data

```bash
dart run tool/generate_explorer_data.dart
# reads data/nepal_local_levels.json → writes docs/data.json (753 rows,
# incl. lat/lng/geoSource: 753/753)
```

## Local preview

```bash
cd docs
python -m http.server 8000
# open http://localhost:8000/index.html
```

## Smoke test (no browser, no npm deps)

`node docs/smoke.cjs` loads the real `app.js` in Node with minimal DOM
stubs and runs the full explorer flow (fetch → filters → stats → table →
pagination) against the real `data.json`. It catches ReferenceError/scope
bugs that `node --check` (syntax-only) misses — e.g. the `escapeHtml is
not defined` outage, where a module-scope caller used an
initExplorer-scoped helper. Runs in CI before Pages deploy.

Maintained by **namunaONE** under **HyaMuji** and **Taire Bhai**.

