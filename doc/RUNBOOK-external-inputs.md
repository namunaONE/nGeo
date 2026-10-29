# Runbook — external inputs needed to close the v3.0 blockers

This document prepares the three v3.0 items that cannot be executed in this
repository as it stands: they depend on inputs that are not in git (a
Government Gazette, a complete `data/_raw/`, and CBS Census 2021 ward data).
Nothing here changes canonical data. When an input arrives, follow the matching
section top-to-bottom and commit the resulting generated files together with
the input provenance.

---

## 1. Gazette confirmation for the 7 (representative) renames

### What is pending
`doc/REVIEW-codes.md` §7.4 and §8.3 document palikas whose names changed after
our roster snapshot. The Devanagari (`nameNe`) fills are **already applied**
(753/753 named, `nameNeVerified: false` for the 20 fills). The **English**
names are **deliberately NOT renamed** pending Gazette confirmation (doctrine:
a rename needs a Gazette, not a Wikipedia article).

Representative pairs (7) with public corroboration:

| # | Ours (legacy English) | Current (directory) | Code | Corroboration |
|---|---|---|---|---|
| 1 | Bheri (Jajarkot) | Bheri Malika | 60706 | en.wiki "(earlier: Bheri Malika)" |
| 2 | Sunkoshi (Udayapur) | Limchungbung | 11405 | AEPC roster "Sunkoshi (Limchungbung)"; JICA report |
| 3 | Belhi Chapena (Saptari) | Rajgadh | 20111 | CIJ Nepal documents the rename |
| 4 | Dhorchaur (Salyan) | Siddha Kumakh | 60904 | palika's own site issues notices as "Siddha Kumakh … Dhorchaur" |
| 5 | Kumakh Malika (Salyan) | Kumakh | 60902 | en.wiki |
| 6 | Kanda (Bajhang) | Saipal | 70201 | Kathmandu Post (2018) covers Kanda-village RM named Saipal |
| 7 | Kalika (Kalikot / Rasuwa) | Shuva Kalika | 60509 / 30304 | en.wiki titles Kalikot's RM "Shuva Kalika" |

Plus 13 "name expansions of the same shape" (Netrawati Dabjong, Likhu
Tamakoshi, Bhimsenthapa, Barpak Sulikot, Narpa Bhumi, Manang Ngisyang,
Varagung Muktichhetra, Lo Ghekar Damodarkunda, Ruruchhetra, Diprung
Chuichumma, Barahachhetra, Bhokraha Narsingh, Swamikartik Khapar,
Bogatan Phudsil) and orthography-only candidates (Bheri Malika, Nalagad).

### What "Gazette confirmation" means
A Nepal Gazette (`rajpatra.nepal.gov.np`) notification or a Ministry of
Federal Affairs and General Administration (MoFAGA) circular that records the
rename as gazetted. Wikipedia / news / AEPC rosters are **corroboration only**
— they do not settle the English spelling.

### How to confirm (manual)
1. For each of the 7 pairs, search the Nepal Gazette (and MoFAGA's local-level
   rename notifications) for the palika's old and new English names.
2. Record the Gazette reference (date, part, page) in `doc/REVIEW-codes.md`
   §7.4 next to the entry.
3. Decide per entry: **apply** (English name → current) or **reject** (keep
   legacy English; Devanagari fill stays as current).

### How to apply (once confirmed) — code changes
- Edit `data/nepal_local_levels.json`: set `name` to the current English name
  for the approved entries only.
- Re-run `dart run tool/pipeline.dart` (Step 4 bilingual join re-runs; the
  `nameNe` fill already matches the new spelling, so no Devanagari change).
- Bump the package version (minor) and add a CHANGELOG entry listing each
  rename with its Gazette reference.
- Update `doc/REVIEW-codes.md` §7.4 status from "NONE applied" to "applied:
  N of 7".
- Tests that pin names (e.g. `bilingual_test.dart`) will need their expected
  strings updated — do this in the same commit, not as a silent fix.

### How to reject
- Leave `name` unchanged. Update `doc/REVIEW-codes.md` §7.4 to mark the entry
  "rejected — Gazette not found / rename not gazetted" with the search date.
- The Devanagari fill remains (`nameNeVerified: false`), since it is still the
  best available spelling.

### Exit criteria
Every one of the 7 pairs is marked applied or rejected with a Gazette
reference or a documented search. None left in "pending".

---

## 2. Pass A2 on a source-complete machine

### Why it hasn't run
Pass A2 (`tool/merge/resolve_code_tiers.dart`, with the adjudications ledger)
needs the full `data/_raw/` (~2.5 MB of CC-BY snapshots). `data/_raw/` is
gitignored and this checkout holds none of `abinrimal`, `cbs-codes`,
`local-states-nepal`, `mofaga`, `nepali-geo-pro-max`, `open-admin-data`.
The v2.9.0 commit shipped the ledger (`data/_stage/code_adjudications.json`,
9 entries) and the code change; the first real execution is pending.

### What is needed
1. A machine with network access.
2. `dart run tool/fetch_sources.dart` to populate `data/_raw/` from the URLs
   in `data/SOURCES.md` (verify against `data/PROVENANCE.sha256`).
3. Manual harvests that have no public URL:
   - `mofaga` — MoFAGA contact data (URL not publicly documented).
   - `npl-codes` — Gov. of Nepal administrative code table TSVs (re-exported
     from the vendored `.xls` with `tool/export_npl_codes.ps1`).
4. `dart run tool/pipeline.dart` (or `--dry-run` first).

### Exact run sequence
```powershell
# 1. Populate raw sources
dart run tool/fetch_sources.dart
dart run tool/fetch_sources.dart --verify   # confirm hashes

# 2. Manual sources (by hand, into data/_raw/mofaga/ and data/_raw/npl-codes/)
#    See data/SOURCES.md for the harvest instructions.

# 3. Dry run first
dart run tool/pipeline.dart --dry-run

# 4. Real run (aborts on first failure)
dart run tool/pipeline.dart

# 5. Verify
dart analyze --fatal-infos
dart test
node bindings/verify_bindings.cjs
node docs/smoke.cjs
```

### What Pass A2 produces / verifies
- `data/_stage/code_tiers.json` regenerated (currently stale: says
  `unverified: 9`; should be `0` after a full run).
- `data/_stage/code_adjudications.json` consumed (9 entries reserved).
- `data/nepal_local_levels.json` unchanged in counts (753/753 coded) but the
  tier ledger is re-derived and drift-checked.
- `lib/src/nepal_data.dart`, `docs/data.json`, bindings all regenerated and
  must show zero drift.

### Exit criteria
Pipeline exits 0; `dart test` + smoke + bindings all green; `git diff` shows
only the regenerated artifacts (no unexpected data changes); the adjudications
ledger entries are all consumed (no `unconsumed` failures).

### If it fails
The resolver hard-fails on: duplicate codes, non-PDDPP codes, unconsumed
ledger entries, conflicts with the dataset. Fix the ledger or the dataset, do
not silence the failure. File an issue with the resolver's output.

---

## 3. CBS Census 2021 ward data

### Current state
- 745/753 palikas carry a verified ward count; 8 are roster-defect gaps
  (Janakpurdham is the one human-adjudicated override at 25).
- `NationalStats.wards` = 6,743 (declared); `verifiedWards` = 6,697;
  `unreconciledWards` = 46.
- Wards are explicitly "on hold until CBS Census 2021 data available"
  (ROADMAP Phase 3).

### What is needed
CBS Census 2021 local-level (palika) ward counts. Source: CBS/NSO Nepal
Census 2021 publications (local level reports) or the MoFAGA-maintained
palika roster. Format unknown until sourced — likely a CSV/XLSX with
palika name + district + ward count.

### Harvest template (create when sourcing)
Create `data/_raw/cbs-wards-2021/` containing:
- The raw CBS/MoFAGA file(s), verbatim.
- A `README.md` noting source URL, download date, license.
- An entry in `data/PROVENANCE.sha256` with SHA-256 + size.

### Pipeline integration (when data arrives)
1. Add a new merge step `tool/merge/attach_wards_2021.dart` that:
   - Reads the CBS 2021 ward counts.
   - Joins to palikas by code (preferred) or by normalized name + district.
   - Writes `wards` + `wardsVerified: true` for matches.
   - Reports unmatched palikas (do not guess).
2. Insert into `tool/pipeline.dart` after `attach_attributes.dart` (order:
   codes → bilingual → attributes → wards → codegen).
3. Add a gate: every palika either has `wardsVerified: true` or is listed in
   `decisions_wards_manual.json` with a documented reason.
4. Update `District.wardsFullyVerified` and `Province.wardsReconcile`
   expectations in tests (Lumbini already reconciles; the other six should
   reconcile once the 8 gaps close).
5. Bump version (minor) and CHANGELOG.

### Exit criteria for Phase 3
- 753/753 palikas carry a verified ward count.
- `unreconciledWards == 0` for all 7 provinces.
- `wardGaps == 0`.
- Ward boundaries (polygons) deferred to a later phase (size budget).

### If the source disagrees with the roster
Follow the honesty doctrine: document the conflict in `doc/REVIEW-codes.md`,
stop the run, do not silently pick a value. The 8 current gaps exist precisely
because the two rosters (sagautam5 and geo-pro-max) disagree.

---

## Summary table

| Blocker | What's needed | Who can unblock | ETA driver |
|---|---|---|---|
| Gazette renames | Nepal Gazette / MoFAGA circular | Maintainer (manual search) | Gazette publication schedule |
| Pass A2 | Full `data/_raw/` + manual harvests | Maintainer on a source-complete machine | Network + harvest time |
| CBS 2021 wards | CBS Census 2021 local-level ward counts | Maintainer (source + harvest) | CBS publication schedule |

Until these arrive, the project ships with the current honest state:
753/753 coded (548 verified / 205 singleSource / 0 unverified),
753/753 Devanagari, 753/753 boundaries, 745/753 verified ward counts with
the 8 gaps documented.

*Generated: 2026-10-29. Update this file when any blocker is resolved.*
