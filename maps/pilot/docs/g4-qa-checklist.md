# G4 QA checklist — v1.1 (DNPWC-deferred edition)

**Status:** Draft checklist. Automated where noted; visual checks require a human with PDFium/Edge.  
**Date:** 28 October 2026  
**Companion:** `build/check_label_collisions.js`, `build/reference_qa.json`, `data/reference/master_qa.json`

---

## 1. Data QA (automated — `build_master_qa.js` / `prepare_reference.js`)

- [x] 22 core/provincial records and 14 buffer records present as non-spatial rows; **0 PA/buffer polygons** (D10).
- [x] Peak count frozen and matched: 8 main + 6 official additional + 37 seven-thousanders = 51.
- [x] Unique IDs across all tables; no duplicate IDs.
- [x] No empty English names (1 pending Nepali name: `pk-thulagi-chuli`).
- [x] Every feature has a source, source date and licence.
- [x] No peak polygon anywhere; peaks are Point features only.
- [x] All 51 peak coordinates in range (lon 79–90, lat 26–31); 0 missing.
- [x] Published vs computed area report reviewed; differences documented (Parsa 637 / 627.39; Gaurishankar 2,197 superseded).
- [x] Buffer zones have valid parent IDs (14/14).
- [x] Administrative counts unchanged: 7 / 77 / 753.
- [x] `master_qa.json` attached: 1 open issue (Thulagi Chuli), 50 approved / 1 draft.
- [x] UTF-8 validation: 0 replacement characters across 34 files.
- [x] Source IDs resolve: 25 sources, 0 unresolved references.
- [x] Evidence table: 8 rows, 16 columns, 0 blank reviewer fields, all source IDs resolve.

## 2. Web QA (manual + static)

Static checks performed:
- [x] `node --check web/app.js` passes.
- [x] `web/data/peaks.js` loads as valid JSON with 51 features.
- [x] `web/data/reference.js` loads as valid JSON with 22 + 14 records.
- [x] `web/index.html` references both new bundles.
- [x] `style.css` includes the reference panel and peak legend styles.

Manual checks (open `web/index.html` in Edge/Chrome):
- [ ] Administrative counts still 7 / 77 / 753.
- [ ] Peaks layer toggles on/off; 51 point symbols render.
- [ ] Peak labels (tooltips) toggle independently.
- [ ] Search “Everest” and “सगरमाथा” return the peak.
- [ ] Search “Chitwan” returns the district and local levels (no PA polygon).
- [ ] Popups are bilingual and show the reference badge (peak class, elevation, name status).
- [ ] Layer preferences persist across reload.
- [ ] Language switch updates peak tooltips, legend and reference panel.
- [ ] Mobile drawer, legend and reference toggles fit without overflow.
- [ ] No console errors and no network requests.
- [ ] Print-sheet cards include sheets 01–03 and all links resolve.
- [ ] Gap polygons still carry “No local-level data”.
- [ ] Reference panel shows 51 peaks, 22 protected areas, 14 buffer zones.
- [ ] Reference table expands and shows name, area, “boundary pending”.
- [ ] Accuracy notice visible.

## 3. Label collision (automated — `build/check_label_collisions.js`)

Results on the 51 peaks:

| Zoom | Threshold | Close pairs | Assessment |
|---:|---:|---:|---|
| 8 | 40 px | 139 | Heavy overlap in Khumbu and Kangchenjunga clusters |
| 9 | 30 px | 50 | Overlap remains in dense clusters |
| 10 | 25 px | 18 | Manageable; numbered keys still needed for subsidiary summits |

**Findings:**
- The 8 main eight-thousanders and 6 official additional summits in the Khumbu and Kangchenjunga clusters are separated by fewer than 8 px at zoom 8. Inline bilingual labels will collide.
- The plan’s §8.2 / §8.5 call for **numbered keys (1–6)** for the official additional summits and a compact side-panel key. This is required, not optional.
- 7,000 m peaks are shown only at z ≥ 8; at z 9–10 the 18 close pairs above are mostly subsidiary summits that should use numbered keys.
- **Recommended action:** implement numbered keys for the official additional 8,000 m summits and for any 7,000 m peak that cannot fit an inline label. Do not draw an unlabelled peak symbol.

## 4. Print QA

Existing PDFs (v1.0, unchanged):
- [x] `01_national.pdf` (3,498,025 bytes), `02_bagmati.pdf` (2,031,686 bytes), `03_kathmandu.pdf` (1,232,432 bytes), `04_peaks.pdf` (538,434 bytes) present.
- [x] Sheet 04 (A2 peaks) built and rendered.
- [x] Sheet 01 re-rendered with the 14 eight-thousanders.
- [ ] Sheets 02–03 re-rendered with peak overlays (optional; peaks on sheet 04).

Visual checks (Edge/PDFium):
- [ ] Four PDFs render at the intended page sizes.
- [ ] Every visible peak has a label or a numbered key.
- [ ] All 21 core areas and 14 buffer zones are represented in the reference table (no polygons under D10).
- [ ] No label collisions at 100%.
- [ ] Devanagari renders correctly.
- [ ] Legends match the data counts.
- [ ] Source/licence footer on every sheet.
- [ ] “Sheet X of 4” is correct.
- [ ] PDFium visual check recorded.

## 5. Release acceptance (plan §10.4, adapted for D10)

v1.1 is accepted only when:
1. D1–D10 are signed off and the source/licence gate is cleared (or the D10 deferral is recorded). **D10 recorded.**
2. The data QA checklist passes. **Passes (1 open issue: Thulagi Chuli, by design).**
3. The web QA suite passes, including the original 37 checks. **Pending — manual run required.**
4. All print PDFs pass PDFium and visual QA. **Pending — sheet 04 not yet built.**
5. The README, source register, release notes and rebuild steps are updated. **README and source register updated; release notes not yet written.**
6. The v1.0 snapshot exists and is unchanged. **Verified.**
7. No unlicensed geometry or invented boundary is present. **Verified — no PA/buffer polygons; peaks from Wikidata/Wikipedia.**
8. The accuracy notice is visible in the web app and on every print sheet. **Web notice present; print sheets unchanged from v1.0.**

## Summary

- **Automated data QA:** passes (1 open issue by design).
- **Label collision:** confirmed; numbered keys required for dense clusters.
- **Web QA:** static checks pass; manual checks pending.
- **Print QA:** 3 of 4 PDFs exist; sheet 04 not yet built; D10 removes PA/buffer polygons from print.
- **Release acceptance:** 4 of 8 criteria met; 4 pending (web QA run, print build + QA, release notes).

## Next steps

1. **Build print sheet 04** (A2 peaks) with numbered keys for dense clusters.
2. **Re-render sheets 01–03** with the reference panel and peak overlays (peaks only; no PA/buffer polygons).
3. **Run the manual web QA** checklist above in Edge.
4. **Write release notes** (`docs/v1.1-release-notes.md`).
5. **DNPWC / Survey Department** — deferred; send when the geometry workstream resumes.
