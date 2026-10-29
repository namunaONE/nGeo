# External-input gates — status & evidence (2026-10-28)

Three items on the v3.0 roadmap are gated on inputs this repo cannot produce
autonomously. This file records what was attempted and what was found, so the
next run starts from evidence rather than from scratch.

## 1. Gazette confirmation for the rename flags (doc/REVIEW-codes.md §7.4)

Doctrine (unchanged): **renames stay UNAPPLIED in English** until a Nepal
Gazette notification confirms them. The English names in
`data/nepal_local_levels.json` are untouched. What follows is corroborating
evidence gathered 2026-10-28, ranked by strength.

| # | Current English name | Suggested rename | Corroboration | Strength |
|---|---|---|---|---|
| 1 | Jagannath (Bajura) | Pandav Gufa | Wikipedia re-titled the article to "Pandav Gufa Rural Municipality"; body still opens "Jagannath Rural Municipality" | weak (Wikipedia editorial) |
| 2 | Sunkoshi (Udayapur) | Limchungbung | Own palika website `limchungbungmun.gov.np` is live and names the body "Limchungbung"; Wikipedia + district coordination committee | strong (official site) |
| 3 | Dalome (Mustang) | Lo-Ghekar Damodarkunda | Own palika website `loghekardamodarkundamun.gov.np`; district coordination committee lists "लो-घेकर दामोदरकुण्ड गाउँपालिका"; Wikipedia "(earlier: Dalome)" | strong (official site) |
| 4 | Neshang (Manang) | Nesyang | Wikipedia only ("Nesyang (…)") | weak |
| 5 | Barhagaun Muktichhetra (Mustang) | Varagung Muktichhetra | Own palika website `varagungmuktichhetramun.gov.np`; district coordination committee lists "वारागुङ मुक्तिक्षेत्र गाउँपालिका"; Wikipedia records the 2017 council decision requesting the correction | strong (official site + gazette-style council decision) |
| 6 | Netrawati (Dhading) | Netrawati Dabjong | Wikipedia only ("Netrawati Dabjong Rural Municipality", 5 wards) | weak |
| 7 | Sunil Smriti (Rolpa) | Sahid Sunil Smriti | Setopati 2017 rename coverage | medium (news report) |
| 8 | Bheri (Jajarkot) | (orthography: Bheri Malika) | Wikipedia "(earlier: Bheri Malika)" — candidate only | weak (orthography) |
| 9 | Nalagad (Jajarkot) | Nalgad | Wikipedia spelling "Nalgad" vs our "Nalagad"; orthography candidate only | weak (orthography) |

**What would unblock this:** a Nepal Gazette (rajpatra.nepal.gov.np) notification
naming the palika. The gazette site did not surface searchable entries for these
names in this pass; the palika-level "Gazette" pages (e.g. Lo-Ghekar's
`/rajpatra`) publish internal by-laws, not the federal rename notification.
Recommendation: a human with Nepali-language access to the Gazette index confirms
items 2, 3, 5 (strong) first; items 1, 4, 6, 7 need secondary-source
corroboration; items 8, 9 are orthography-only and should not be renamed at all.

## 2. Pass A2 on a source-complete machine

`data/_raw/` currently holds only `npl-codes/`. `tool/fetch_sources.dart` was run
2026-10-28:

- Fetched OK: 17 files (abinrimal, local-states-nepal, nepali-geo-pro-max, cbs-codes,
  npl-codes partials).
- Failed: 14 files — all `open-admin-data/*` returned HTTP 404 (upstream moved).
- Skipped: 8 (mofaga manual, already-present npl-codes).
- Verified OK: 21 · Missing: 18 · Mismatch/Drift: 0.

**Blocker:** the open-admin-data upstream URLs are stale, and `mofaga/` is a
manual harvest (no public URL). Pass A2 cannot run end-to-end until those are
sourced. Recommend: re-point the open-admin-data base URL in `fetch_sources.dart`
and `data/SOURCES.md`, re-fetch, then run `dart run tool/pipeline.dart` on a
machine holding the full `data/_raw/`.

## 3. CBS Census 2021 ward data

Not sourced. The 8 palikas with no verified ward count (Bheri, Netrawati,
Sunkoshi (Udayapur), Dalome/Lo-Ghekar, etc.) remain gaps; wards stay on hold
per doctrine. `NationalStats` already reports both declared (6743) and
substantiated (6697) totals, so no code change is needed until the data lands.

## Bottom line

None of the three can be closed from this repo alone. The rename evidence
above is the strongest progress available without the Gazette; the source fetch
advanced reproducibility but exposed a moved upstream. Recommend treating these
as a standing "data operations" track rather than code sprints.