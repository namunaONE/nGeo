# Reference master tables — v1.1

**Status:** Draft data. Not approved for release. No production geometry yet. **D10:** protected-area and buffer-zone geometry is deferred; the peaks layer and non-spatial reference tables proceed.  
**Updated:** 28 October 2026

These tables are the source of truth for protected-area, buffer-zone and peak attributes. They are deliberately separate from any geometry. `prepare_reference.js` will validate them and join them to licensed geometry when the source gate closes. Under D10, the 22 core/provincial and 14 buffer rows are published as **non-spatial records** until DNPWC permission or another compliant source is obtained. See [`v1.1-completion-ledger.md`](../../docs/v1.1-completion-ledger.md).

---

## Files

| File | Rows | Purpose |
|---|---:|---|
| `protected_areas_master.csv` | 22 | 21 federal core areas + 1 provincial Badimalika–Ramaroshan feature |
| `buffer_zones_master.csv` | 14 | Federal buffer zones, each linked to its parent core area |
| `peaks_master.csv` | 51 | 8 main eight-thousanders + 6 official additional summits + 37 seven-thousanders |
| `peaks_name_review.csv` | 51 | Nepali-name review sheet for the language reviewer |
| `peaks_geo_review.csv` | 51 | District and border review sheet; distances are indicative only |
| `peaks_evidence_review.csv` | 8 | Row-level source evidence: 4 pending names + 4 high-priority district rows |
| `reference_tables_draft.json` | — | Non-spatial export of the 22 + 14 rows (D10 draft; not for release) |
| `sources.csv` | 25 | Source register with licence and intended use |
| `master_qa.json` | — | Machine-readable QA report generated from the master tables and evidence review |

The v1.0 snapshot is at `maps/_archive/pilot-v1.0-2026-10-26/`.

---

## Conventions

- Encoding: UTF-8.
- CSV: comma-separated, quoted where required.
- Array fields (`aliases_*`, `province_codes`, `district_codes`, `border_countries`): semicolon-separated.
- Blank numeric fields are unknown or pending, not zero.
- `review_status: draft` on every row. Release requires `approved`.
- IDs are stable lowercase slugs. Do not renumber when a designation is added.
- `name_np_status` values:
  - `attested` — sourced from DNPWC, Wikidata `ne`, Nepali Wikipedia, or a named reviewer;
  - `derived` — a standard compositional name built from an attested parent name, used for buffer zones;
  - `transliterated` — a reviewed transliteration;
  - `pending` — draft only; blocks release.
- `name_np_source` records the source for a newly attested or transliterated peak name. Existing names without a recorded source remain valid but should be re-attested during language review.
- `border_source` records the source for an international-border status. Blank means the status has not been separately verified.

---

## Area totals

| Class | Rows | Published area (km²) |
|---|---:|---:|
| Federal core | 21 | **28,741.94** |
| Provincial Badimalika–Ramaroshan | 1 | **498.40** |
| Federal buffer zones | 14 | **5,720.28** |
| Federal core + buffer, using individual buffer figures | 35 | **34,462.22** |
| Federal core + provincial + all buffer rows | 36 | **34,960.62** |

The **5,602 km²** official aggregate describes the **12 buffer zones declared between 1996 and 2010**, not all buffer zones now in force. Those 12 zones, after the 2025 Shey Phoksundo/Chhayanath split, total **5,601.67 km²**, which is **0.33 km²** below the aggregate. The 14-zone total includes Shivapuri-Nagarjun (2016, 118.61 km²) and the Chhayanath split (177.37 km², offset by a reduction of 178.9 km² in the Shey Phoksundo buffer).

**Do not describe the 5,720.28 km² figure as official.** It is the sum of 14 individually sourced rows. The 5,602 figure may be used only with its 12-zone qualifier. See [`docs/reference-area-reconciliation.md`](../../docs/reference-area-reconciliation.md).

### Known area reconciliation points

- **Shey Phoksundo / Chhayanath:** resolved. 843.36 km² was transferred from Shey Phoksundo (3,555 − 843.36 = 2,711.64, recorded as 2,712). Chhayanath’s buffer is 177.37 km² and Shey’s buffer falls to 1,170.1 km²; the two sum to 1,347.47 km² against the former 1,349 km², a 1.53 km² rounding difference.
- **Parsa buffer:** corrected from 285.3 to 298.2 km² per the Nepal Tourism Board. This accounts for 12.9 km² of the former buffer gap. The 2020 DNPWC-commissioned GIS report (`S20`) still lists 285.3 km² in its gazette table; DNPWC confirmation is required.
- **Bardiya buffer:** 507 km² is used; the 2020 DNPWC-commissioned GIS report (`S20`) records 507.00 km², confirming it. OpenDataNepal (`S19`) lists 327 km², apparently the original 1996 declaration. DNPWC must confirm the extension.
- **Chitwan:** 952.63 km² used; 932 km² also circulates.
- **Parsa core:** 637 km² is the published figure used here; 627.39 km² is recorded as geometry-derived in the 2020 DNPWC-commissioned GIS report (`S20`), and 499 km² is the pre-2017 wildlife reserve figure. This is separate from the buffer question.
- **Gaurishankar:** corrected from 2,197 to **2,179 km²** using the 2020 DNPWC-commissioned GIS report (`S20`) and OpenDataNepal (`S19`).
- **Shuklaphanta:** 305 km² is the park; 399.63 km² in the old draft includes the buffer.
- **Khaptad:** 225 km² is the published park figure; 211.31 km² in the old draft was geometry-derived.
- **Dhorpatan:** 1,325 km² is published; 1,012.83 km² in the old draft was geometry-derived.
- **Koshi Tappu:** 175 km² is the reserve; 143.02 km² in the old draft was clipped. The buffer is carried at 173.5 km²; NTB rounds it to 173 km².

---

## Protected areas

- 21 federal core features: 13 national parks, 6 conservation areas, 1 wildlife reserve, 1 hunting reserve.
- 1 provincial feature: Badimalika–Ramaroshan Forest Conservation Area, declared 12 August 2026, 498.4 km², Bajura and Achham. It is **not** part of the federal DNPWC network and is excluded from the federal total.
- Chhayanath National Park (2025, 843.36 km² core, Mugu) is included in the federal 21. Its boundary is not available. Early reports of “about 906 km²” are retained only as an announcement note.
- Shey Phoksundo is recorded as Dolpa only after Chhayanath; the Mugu portion was transferred in 2025. The published areas close exactly at 843.36 + 2,711.64 = 3,555 km².
- Old names (`Parsa Wildlife Reserve`, `Chitawan`, `Royal Bardia`, `Shivapuri Watershed and Wildlife Reserve`) are aliases, not separate features.
- `geometry_quality`, `geometry_note` and label-anchor fields remain blank because no licensed geometry has been joined. `area_geom_km2` is blank except for Parsa, where **627.39 km²** is recorded as a report-derived cross-check (`S20`), not as project geometry. This is expected at the draft stage.

### Buffer zones

- 14 features, each with a `parent_pa_id`: 12 zones declared 1996–2010, Shivapuri-Nagarjun (2016), and Chhayanath (2025, split from Shey Phoksundo).
- The 5,602 km² official aggregate covers the 12 zones declared 1996–2010. It does not cover Shivapuri-Nagarjun or the 2025 Chhayanath split.
- Default visibility is **off** in the web app.
- `name_np` is `derived`: the standard `<parent> मध्यवर्ती क्षेत्र` form. A Nepali reviewer must confirm each one.
- Buffer zones are **not** core protected areas and must never be added to the core count.
- No buffer-zone geometry is available. The `stepps00` fallback was withdrawn after audit because it cannot separate core and buffer.

---

## Peaks

### Counts

| Class | Count |
|---|---:|
| `eight_thousander_main` | 8 |
| `eight_thousander_official_additional` | 6 |
| `seven_thousander` | 37 |
| **Total** | **51** |

### Open issues before the peak freeze

1. **One Nepali name remains pending.** Release is blocked until it is resolved. It is **Thulagi Chuli**; the proposed label थुलागी चुली is recorded in `peaks_name_review.csv`, and the evidence, confidence and recommended action are in `peaks_evidence_review.csv` (`EV-NAME-03`). The other three pending names (Nepal Peak, Ganesh II, Ratna Chuli) were attested by reviewer sign-off on 28 October 2026. Nepal Peak and Ratna Chuli have medium-confidence media/encyclopaedic evidence; Ganesh II was amended to **गणेश-II**; Thulagi Chuli has no Nepali attestation and remains low confidence.
2. **Fifteen Nepali names were newly attested** from Nepali Wikipedia (`S14`) on 27 October 2026: Annapurna II, Dhaulagiri II, Dhaulagiri IV, Dhaulagiri V, Annapurna III, Churen Himal, Dhaulagiri VI, Putha Hiunchuli, Annapurna South, Nemjung, Tilicho Peak, Gurja Himal, Pabil, Baruntse and Chamar (चामर). **Three more were attested on 28 October 2026 by reviewer sign-off:** Nepal Peak, Ganesh II and Ratna Chuli. All still require language-review sign-off for the release record. Chamar is recorded as चामर, without हिमाल; the earlier proposed label चमर हिमाल was not attested.
3. **Yalung Kang West now has a candidate coordinate.** Peakbook records UTM 45R 610914 3065161, which converts to **27.7062, 88.1250** — about 1.16 km west of Yalung Kang (88.1367, 27.7052). The Himalayan Database independently confirms a separate 8,077 m summit (peak ID `YALW`). The coordinate is sourced to `S18` but is user-contributed; a reviewer must confirm it before the peak is plotted. Border status is now **inside Nepal**: `S15` places the West summit and Kangbachen in Taplejung District. The point lies 2.5 km inside the simplified national polygon, so the generalised boundary cannot independently confirm the coordinate.
4. **Border status was confirmed for five additional peaks** on 27 October 2026 (`S15`): Yangra, Gaurishankar, Langtang Ri and Ratna Chuli are border peaks with China; Jongsong Peak is the India–Nepal–China tripoint and now lists both countries. Yalung Kang West was subsequently reclassified from `border` to `inside` on the same source. The table now has **22 border peaks and 29 inside peaks**.
5. **Pabil and Ganesh II are resolved.** Pabil is Ganesh IV (7,104 m, inside Nepal); Ganesh II is Ganesh NW (7,118 m, inside Nepal); Ganesh III is Salasungo (7,043 m), a separate summit not in this list. Neither Pabil nor Ganesh II is a border peak. The earlier “Pabil on the Nepal–Tibet border” note was a naming confusion; the corrected alias and notes supersede it.
6. **District assignment is draft.** It was computed by point-in-polygon against the simplified v1.0 district geometry, with nearest-district fallback. `peaks_geo_review.csv` records the method, distances and flags. The four high-priority rows — Cho Oyu, Manaslu, Langtang Ri and Ratna Chuli — are source-resolved (Solukhumbu, Gorkha, Rasuwa and Manang respectively) but still need reviewer sign-off; the evidence is in `peaks_evidence_review.csv` (`EV-GEO-01` to `EV-GEO-04`). The Thulagi Chuli district conflict is resolved: English Wikipedia gives Gorkha, but both its coordinate and the master coordinate reverse-geocode to Nashong, Manang (`S07`), so `402 Manang` is retained. Yalung Kang West is low priority but still needs coordinate confirmation.
7. **Many summits sit on or within 0.5 km of a district boundary.** That is expected for ridge summits and is not an error, but the chosen district needs reviewer confirmation.
8. **Naming consistency:** resolved on 27 October 2026. Ganesh II = Ganesh NW; Pabil = Ganesh IV; Ganesh III is Salasungo. The earlier Pabil alias `Ganesh III` has been corrected in the master table.
9. **Dhaulagiri VI** coordinates were corrected to 28.7086, 83.2742. Prominence 518 m is from a secondary source.
10. **Lhotse Shar** official height is 8,400 m; Wikidata gives 8,383 m. The official figure is used, with a note.
11. **First-ascent years** are incomplete and should be verified before print; they are optional for the web.
12. **Official 14 vs UIAA 8.** The table carries both classes. Do not collapse them or describe the 14 as internationally recognised eight-thousanders.

### Rules

- Peaks are Point features only. No polygons, buffers or viewsheds.
- The eight main peaks are filled symbols; the six official additional summits are open symbols; 7,000 m peaks are small triangles.
- `label_rank` runs 1–14 for the official set and 15–51 for the 7,000 m set.
- `label_min_zoom` is 0 for the official set and 8 for the 7,000 m set.
- `nepal_share` is `inside` or `border`; border peaks list adjacent countries.

### Review artifacts

- `peaks_name_review.csv` is the language-review checklist. It carries the current name, status, source and a proposed label for the four pending rows. The reviewer records `confirm`, `amend` or `reject` and a date.
- `peaks_geo_review.csv` is the location-review checklist. It records the assigned district, whether the point falls inside that district polygon, the distance to the assigned and national boundaries, the nearest alternative district and a priority.
- `peaks_evidence_review.csv` is the row-level evidence table. It has one row for each of the four pending names and each of the four high-priority district rows, with source ID, URL, evidence quote, confidence, recommended action and blank reviewer fields. It does not change any `review_status`.
- The consolidated reviewer memo is [`docs/peaks-review-notes.md`](../../docs/peaks-review-notes.md). It gives the evidence and a recommendation for each pending name, explains why the four `high` rows are district-boundary artefacts, records the Thulagi Chuli district resolution, and records the resolved Pabil/Ganesh II and Yalung Kang West identity questions.
- Distances in `peaks_geo_review.csv` are measured against the simplified v1.0 administrative geometry. They are indicative only; they do not establish a legal border, a survey boundary or a final district assignment.
- Rows flagged `high` need a decision before the peak list is frozen. Rows flagged `medium` are mostly summits on or near district boundaries and need confirmation, not correction by default.

---

## Source and licence notes

- Source IDs resolve in `sources.csv`.
- Published areas are **not** measurements of project geometry. `area_geom_km2` is reserved for QA; only Parsa carries a report-derived value (627.39 km² from `S20`).
- No WDPA geometry is present. No `stepps00` geometry is present. No OSM geometry is present.
- The Himalayan Database PDF is a fact-check source only; it must not be redistributed.
- The 2020 DNPWC-commissioned GIS report (`S20`) is a facts-only cross-check. Do not redistribute the PDF and do not treat it as a geometry licence.
- `S21`–`S25` are secondary or commercial sources used only to corroborate peak-name usage and district assignments.
- Wikidata coordinates are CC0; Wikipedia facts are CC BY-SA 4.0; attribution strings are in the plan §5.3.

---

## What not to do

- Do not generate `protected_areas.geojson`, `buffer_zones.geojson` or `peaks.geojson` from these tables until geometry is licensed and the rows are reviewed.
- Do not build or ship protected-area or buffer-zone polygons while D10 is in force. Publish the rows as non-spatial records.
- Do not fill missing Nepali names with machine translation.
- Do not plot Yalung Kang West until the candidate coordinate (`S18`) is confirmed by a reviewer.
- Do not add Badimalika to the federal total.
- Do not publish the 5,720.28 km² buffer total as official; it is the sum of 14 individual rows.
- Do not use the 5,602 km² aggregate without saying it covers the 12 zones declared 1996–2010.
- Do not reuse the old 10-feature draft.

---

### Draft artifacts (D10)

- `data/peaks_draft.geojson` (51 point features, draft) and `data/reference/reference_tables_draft.json` (22 + 14 non-spatial records) are generated by [`build/prepare_reference.js`](../../build/prepare_reference.js). They are **not production or release files** and are not to be shipped under D10 until the release gates close. A machine-readable QA report is written to `build/reference_qa.json`.

---

## Next data actions

1. **DNPWC and Survey Department requests — deferred under D10.** Drafts are ready in `docs/outreach/`; send them when the geometry workstream resumes. The Survey Department request belongs to the separate edition.
2. Resolve the four pending Nepali peak names with a Nepali reviewer, using the [`reviewer sign-off packet`](../../docs/reviewer-signoff-packet.md), `peaks_name_review.csv` and the row-level evidence in `peaks_evidence_review.csv`; confirm the 15 newly attested names at the same time.
3. Confirm the candidate Yalung Kang West coordinate (`S18`); its border status is now confirmed as `inside`.
4. Review the district and border sheet `peaks_geo_review.csv`; the Pabil/Ganesh II identity question is resolved, leaving the four high-priority district-edge rows and the 32 medium rows for sign-off.
5. Confirm the area reconciliation with DNPWC: the 12-zone 5,602 km² aggregate, the 14-zone total, the Gaurishankar 2,179 km² correction, the Parsa core 637/627.39 distinction, the Parsa buffer 298.2/285.3 difference, the confirmed Bardiya 507 km² buffer and the Chhayanath 843.36 / 177.37 split.
6. Freeze the peak count and mark rows `approved`.
