# Merge sources & provenance

Every external dataset consumed by the merge pipeline is pinned here: the
exact URL, the license, and the retrieval date. **No third-party data is
vendored into this repository** — it lives in `data/_raw/` locally and is
re-fetchable from the URLs below. Integrity is verified against
`data/PROVENANCE.sha256`.

## Why nothing is vendored

1. **Licensing.** Two sources are **CC-BY-4.0**, which requires *visible
   attribution in the distributed package* — a decision that is still open.
2. **Size.** The sources total ~2.5 MB today.
3. **Precedent.** `datasets/country-codes` (the closest flagship-grade
   reference for this kind of dataset) ships a fetch script, not the data.

## Source pins

| # | Source | Branch | License | Attribution required | Retrieved |
|---|---|---|---|---|---|
| 1 | `abinrimal/nepal-administrative-divisions-json` | `main` | MIT | No | 2026-10-11 |
| 2 | `sagautam5/local-states-nepal` | `master` | MIT | No | 2026-10-11 |
| 3 | `l3lackcurtains/nepali-geo-pro-max` | `main` | MIT | No | 2026-10-11 |
| 4 | `open-admin-data/nepal-administrative-divisions` | `main` | **CC-BY-4.0** | **Yes** | 2026-10-11 |
| 5 | opendatanepal `geographical-codes-for-states-districts-and-local-bodies` (CBS harvest) | CKAN resource IDs, see §6 | **CC-BY** (`license_id: cc-by`, re-verified at fetch) | **Yes — via NOTICE** | 2026-10-11 |
| 7 | Nepal Post local-level code list (giwmscdnone.gov.np portal PDFs) | n/a — referenced, not vendored | Government of Nepal publication (no stated licence) | No | 2026-10-25 |
| 8 | Government of Nepal administrative code table (`1695378470_83.xls`, user-provided) | n/a — vendored workbook + pinned TSV exports | Government of Nepal administrative data; redistribution with attribution per the provider's direction | **Yes — via NOTICE** | 2026-10-27 |

## File-level pins and blob SHAs

`data/PROVENANCE.sha256` records, for every vendored file, its SHA-256, byte
length, and repo-relative path. It is generated from `data/_raw/`.

### How to verify — and what each outcome means

```
dart run tool/merge/verify_provenance.dart             # full check
dart run tool/merge/verify_provenance.dart --manifest  # contract only
```

The tool distinguishes four outcomes, and the distinction matters because
`data/_raw/` is **gitignored** (≈2.5 MB of CC-BY snapshots that are
re-fetchable from the URLs below). A clean checkout therefore has no payloads
at all, which is *not* evidence that anything changed:

| Exit | Status | Meaning |
|---|---|---|
| `0` | `verified` | Every pinned input is present and matches its hash and size. |
| `2` | `sourcesAbsent` | `data/_raw/` is not here. **Expected in CI.** Nothing was checked. |
| `1` | `drifted` | Sources present, and at least one disagrees with the manifest. |
| `1` | `manifestInvalid` | The pinning contract itself is broken. |

> This separation exists because the previous arrangement conflated them. The
> scheduled `provenance-watch` job ran the full hash check unconditionally and
> filed a GitHub issue titled *"[provenance] vendored source drift detected"*
> whenever it failed — i.e. it blamed upstream for the condition "we chose not
> to commit the snapshots". It had never fired only because the job is
> `schedule`-only. The job now audits the *contract* every run (which needs no
> payload) and hash-verifies only when sources are present.

`verifyProvenance()` — used by all eight merge tools as their first action,
and which returns a plain problem list — keeps its original contract: **if you
are about to merge, you must be holding the sources.** Use `auditProvenance()`
when you need to know *why* a check did not pass.

> **Reproducibility gap.** Because the payloads are not in the repository, a
> contributor who clones this repo cannot run the merge; only a machine holding
> `data/_raw/` can. Re-fetching from the URLs below and verifying against the
> manifest closes that gap, and would be the preferred fix over committing the
> snapshots. Not yet implemented.

### 1. abinrimal — `abinrimal/…`

| File | Git tree SHA |
|---|---|
| `provinces.json` | `98a2d877e67df35bb625df87ab124425478750c4` |
| `districts.json` | `36dcf62f7f2dff7ded86f95cba9a63efb91294c9` |
| `local_levels.json` | `ea22335ec04f14eca3b3a189738782b3e872cd1c` |
| `local_level_types.json` | `0079a1105fd3c7e5c0a11c480b902448ac9866fc` |

Tree: `cbecbeae1c29cd0fd93e5f44a850a1a7538e07e7`

**Provides:** Devanagari names (7 provinces, 77 districts, 753 local bodies) —
the most complete bilingual set.
**Defects:** `Gulmi | Chatrakot` appears twice in `local_levels.json`; the
`code` field has only 4 distinct values (type codes, not identifiers).
**Used for:** `nameNe`. **Not used for:** counts, identifiers.

### 2. sagautam5 — `local-states-nepal/…`

| File | Git tree SHA |
|---|---|
| `dataset/provinces/en.json` | `d1ed4158650570c539d2b35729e2f618abc7af90` |
| `dataset/districts/en.json` | `d6854cbe2859bdde48f9f2a313093408bf9430b7` |
| `dataset/municipalities/en.json` | `6ceff9130ed6d5e1e1d9d902d66ee4a017b70409` |
| `dataset/municipalities/np.json` | `a5460712490b5206808d608dc00f6154b66aff83` |

Tree: `035cb3d2ce2420ad04d7aac1d0ce4d08960c57f0`

**Provides:** per-palika **ward counts** (sums to exactly 6,743), district
**headquarters**, province **capitals**, `area_sq_km`, `website`.
**Used for:** `wardCount` (the only source whose total reconciles),
`headquarter`, `capital`, `areaSqKm`, `website`.
**Flag:** `headquarter` / `areaSqKm` / `website` are **single-source**.

### 3. nepali-geo-pro-max — `nepali-geo-pro-max/…`

| File | Git tree SHA |
|---|---|
| `src/data/provinces.ts` | `9c06c176c36b3b822564abffc18a0fe32c6d5599` |
| `src/data/districts.ts` | `21274e0f6bd0aa814ddfefbb1d97f0ce222de4ea` |
| `src/data/local-units.ts` | `1c27389e3d6553db3b9f4ed9d316ea00910691c1` |
| `src/data/legacy-districts.ts` | `aca6f89e7ada8a9bdcc6272162c04019f26d9fff` |
| `src/data/postal-codes.ts` | `eabf8bf540e8494733b17fef67728941f533e0d7` |
| `src/data/postal-codes-2025.ts` | `b866e9a8ceaa8cdf855e5634c899e984e84bfe4d` |

Tree: `117fd0f3d2dabae3bd86bfe9e4c57098ffe56669`

> ⚠️ **Derived, not independent.** Its own header states it was generated from
> `sagautam5/local-states-nepal`. It must **never** be used as an independent
> verification vote.

**Provides:** `postal-codes-2025.ts` carries the **CBS/NSO administrative code
list** (`PDDPP` = province + district + palika), 752 of 753 coded (the single gap is Mahakali Municipality, Kanchanpur = 70905; see doc/REVIEW-codes.md); `aliases`;
province coordinates; two postal-code systems; the legacy 14-zone / 5-region /
75-district cross-walk.
**Defect:** its per-palika ward counts sum to **6,742** (one short) — a
transcription error introduced downstream of sagautam5.
**Used for:** supplementary extraction only.

### 4. open-admin-data — `open-admin-data/…`

Tree pin: dataset updated 2026-09-08; files fetched 2026-10-11.

**Provides:** lat/lon on all levels, JSON Schema, CC-BY-4.0.
**Defect:** ships **775** local units, not 753. **Counts rejected** per the
roadmap hard gate; `geo` retained as supplementary only.
**License status: RESOLVED.** CC-BY-4.0 coordinate/postal/slug fields may be
imported: attribution travels in the shipped package via `NOTICE` (credit +
license link + adaptation note, per CC-BY-4.0 section 3(a)), is surfaced in
`README.md`, and is pinned per-field in this file. `LICENSE` stays MIT for
the package's own code; it does not — and cannot — relicense the adapted
CC-BY-4.0 portions, which remain under their original terms.

### 5. CBS geographical codes via opendatanepal — `cbs-codes/…`

Dataset: `geographical-codes-for-states-districts-and-local-bodies`
(package `22870675-146d-4e4f-8848-2216380170de`), organization
Central Bureau of Statistics, notes "harvested from Central Bureau of
Statistics". License `cc-by` (attribution-only), re-verified at fetch
2026-10-11; metadata unchanged since 2026-06-14.

| File | CKAN resource ID | CKAN MD5 | Bytes |
|---|---|---|---|
| `cbs_districts.csv` | `de973922-7b56-4521-b6a4-aa3de7f8d8a2` | `e7f757371dda9765e310ac78bb2c0d8b` | 3022 |
| `cbs_local_bodies.csv` | `e33aa0f3-72de-4074-a38b-c6a1bf55d9a8` | `78fac72eb1faf0a7913f8c9c58ab3a62` | 75955 |
| `cbs_states.csv` | `37aa60f6-cbbe-43fd-b581-6864b72744ae` | `9ebc36a04637bf976b50af9b24aaa235` | 267 |

Downloads verified MD5-identical to the CKAN metadata before use.
Base download URL pattern:
`https://api.opendatanepal.com/dataset/22870675-146d-4e4f-8848-2216380170de/resource/<id>/download/<file>`

**Provides:** the authoritative CBS hierarchical codes — 77 districts
(`PDD`, 101–709), 753 local bodies (`PDDPP`, 10101–70909), 7 states
(1–7) — plus English and Devanagari names at every level.
**Defects (verified at codepoint level, Step 2):** the districts CSV
Devanagari column is corrupt from row 43 (`NAWALPARASI EAST`) onward —
row 43 truncated mid-parenthetical, rows 44–77 each carry the previous
row's district name (off-by-one cascade). **Quarantined: district
`nameNe` is never sourced from this file.** The palika CSV is guarded by
the suffix-correspondence check in `tool/merge/verify_codes.dart`.
English spellings are UPPERCASE variants (`CHITAWAN`, `DHANUSA`,
`Sub-Metropolitian` [sic]); codes join on codes, names join fuzzy.
**Used for:** `nsoCode` (verified), `nsoCodeVerified`, district-code
resolution, 4th Devanagari vote (palika level, where aligned).

### 7. Nepal Post local-level code list — referenced, not vendored (2026-10-25)

Two PDFs published on Nepal Post's GIS portal and read via search-index
extracts on 2026-10-25 (not machine-parsed into `data/_raw/`; every extract
used is quoted in `doc/REVIEW-codes.md` §7):

- Local-level code list — English + Devanagari name + `PDDPP` per local unit:
  `https://giwmscdnone.gov.np/media/pdf_upload/locallevelcode_tjstksd.pdf`
- Federal-structure post office list — office, province, local-level code,
  office postal code:
  `https://giwmscdnone.gov.np/media/pdf_upload/पोष्टल कोड_5aoxvqu.pdf`
  (mirror: `https://giwmscdnone.gov.np/media/pages/files/postl code english (1)_ihneau2.pdf`)

**Provides:** direct 5-digit PDDPP attestation for 8 of the 9 palikas that were unverified before v2.9.0
palikas — Mapya Dudhkoshi 10304, Thulung Dudhkoshi 10305 (Solukhumbu);
Paribartan 50203, Gangadev 50204, Sunil Smriti 50209 (Rolpa); Nalagad 60707
(Jajarkot); Jagannath 70105, Khaptad Chhededaha 70107 (Bajura). Its 7-digit
office postal codes (`PDDPP` + post-office ward, e.g. `7010503` for
Jagannath) are a *different system* from `zipCodes` and are **not** merged.
Its Devanagari column is a candidate second vote for the `nameNe` backlog —
never auto-applied.
**Limits:** a Government of Nepal publication with no stated licence — treated
as a factual reference, not vendored data. Bheri (Jajarkot) is **not** directly
attested in the extracts; its inferred 60706 stays refused.
**Correction recorded:** the Rolpa free-code inference had Gangadev = 50203 /
Paribartan = 50204; the directory attests the reverse. The attestation wins —
the inference was never merged.

## Code confidence tiers (`resolve_code_tiers.dart`, v2.4.0; postal-list addendum 2026-10-25)

`verify_codes.dart` is deliberately strict: a code is `verified` only when
postal-2025 and the CBS harvest independently name the same code for the same
entity. That rule is right, but it left **206 of 753 palikas with
`cbsCode == null`** even though the CBS roster names every one of them — so a
consumer building a code-keyed map to join against government datasets was
silently dropping over a quarter of Nepal's local bodies.

`resolve_code_tiers.dart` keeps the strict tier and adds a weaker one that is
**published with an honest label rather than discarded**:

- `verified` (548) — unchanged: doubly-attested.
- `singleSource` (196 → **204** since 2026-10-25) — one attestation from the
  authoritative CBS roster, accepted only when **all** of these hold:
  1. the row is in the same district (PDD prefix match),
  2. its palika type agrees after canonicalising the harvest's own dialect
     (`Metropolitian`, `Municipaity`, `Gaun Palika`, `Gaunpaika` — see
     `cbsTypeToCanonical` in `tool/merge/common.dart`),
  3. its normalized name is within Levenshtein distance 2 of ours, **and is
     the unique best such candidate** (a tie is a guess, so it is refused), or
     the pairing is forced by elimination — exactly one of our palikas and
     exactly one free CBS row of that type remain in a district whose roster
     matches the CBS roster type-for-type.

  Since 2026-10-25 the tier also holds codes **directly attested by the Nepal
  Post local-level code list** (§7): 8 palikas whose CBS-roster pairing was a
  refused permutation guess, but whose PDDPP code a government directory
  names explicitly. `cbsCodeVerified` stays `false` for them — the
  doubly-attested rule needs CBS + postal-2025, not the postal directory.
- `unverified` (0 as of v2.9.0 — Bheri, the last gap, resolved to 60706). The tier is retained for future gaps.
  postal-list extracts name every other Jajarkot code (60701–60707 minus the
  district's coded rows), so 60706 is a strong inference but **not a direct
  attestation**; it stays null rather than guessed.

  Since 2026-10-27 the Government of Nepal administrative code table (see the
  code-table section below) attests that last code directly, closing the
  tiers: `singleSource` (204 → **205**), `unverified` (1 → **0**), 753/753
  coded. The resolver consumes the hand-curated code adjudications ledger
  (`data/_stage/code_adjudications.json`, Pass A2), so a full pipeline re-run
  re-derives the directory codes instead of stripping them.

Two invariants are machine-enforced, so a wrong code cannot ship:

- **Bijection** — the assignment set is forced one-to-one; no two palikas can
  share a code.
- **District containment** — every code's PDD prefix must equal the CBS code of
  its owning district. `tool/generate.dart` re-checks both and refuses to emit.

Per-record evidence for all 753 palikas is written to
`data/_stage/code_tiers.json`.

> **Honesty note.** `singleSource` is *one* source, not two. It is offered for
> joins and clearly labelled; anything load-bearing (payments, statutory
> filings, addressing) should use `verified` only.

## Government of Nepal administrative code table (`apply_npl_codes.dart`, 2026-10-27)

- File: `1695378470_83.xls` — the Government of Nepal's administrative code
  table. Three sheets: province codes (1–7), a district register (77 rows —
  the `S.N.` column is a serial, **not** a code; the `Code` column carries
  the 3-digit PDD), and all 753 local units with their 5-digit PDDPP code and
  an "Updated name" pair (English + Unicode Devanagari). Vendored under
  `data/_raw/npl-codes/`.
- Retrieved: 2026-10-27, user-provided. The workbook has no stable public
  URL, so `tool/fetch_sources.dart` lists the source as `manual` (the mofaga
  precedent) — a fresh checkout cannot fetch it; the workbook must be
  supplied by hand.
- License: Government of Nepal administrative data; the provider directs
  redistribution with attribution (carried in `bindings/*/NOTICE`).
- Interface: the `.xls` is legacy BIFF, so `tool/export_npl_codes.ps1`
  (Excel COM) exports the three sheets to UTF-8 TSVs beside it —
  `pradesh_code.tsv`, `district_code.tsv`, `localunit_code.tsv` — and all
  four files are pinned in `data/PROVENANCE.sha256`. A re-export that
  differs byte-wise fails the provenance gate loudly instead of feeding the
  merge different data silently.
- What the merge consumes (and deliberately does not):
  - Local-unit codes are applied ONLY where the dataset has none (Bheri,
    Jajarkot → 60706), always at the `singleSource` tier. Every applied code
    is appended to `data/_stage/code_adjudications.json`, which
    `resolve_code_tiers.dart` (Pass A2) reserves on later full runs.
  - District codes are cross-checked three ways before anything is written:
    the district sheet's `Code` column == the PDD prefixes derived from the
    local-unit sheet == the dataset's district `cbsCode` values (77/77).
  - `nameNe` is filled ONLY where it is null (20 palikas), from the Unicode
    Devanagari column, with `nameNeVerified = false`; internal whitespace is
    normalised, characters kept verbatim. Sheets 1–2 carry legacy
    Preeti-font Devanagari and are read only for their English/code columns.
  - Name variants (55) — including the directory's renames ("Bheri Malika",
    "Limchungbung", "Rajgadh", "Siddha Kumakh", "Kumakh", "Saipal",
    "Shuva Kalika") and legacy spellings ours carries ("Nalagad" vs
    "Nalgad", "Budhanilkantha" vs "Budhanilkhantha") — are REPORTED in
    `data/_stage/npl_codes.json` and `doc/_apply-npl-codes-raw.txt`, never
    applied. Adopting a rename needs a Gazette confirmation
    (`doc/REVIEW-codes.md` §8).

## Boundaries — removed (v2.7.2)

Boundary polygons were investigated (`opentechcommunity/map-of-nepal`, 777
features) and deliberately never shipped: 4,477 of 4,478 rings violated
RFC 7946, and nothing in the repository could confirm the boundaries are
current. In v2.7.2 the quarantine was removed entirely — the vendored files,
their manifest pins, the `probe_boundaries.dart` diagnostic, and the
`pmtiles.yml` tile workflow are all gone — so the package makes no boundary
claim at all. See CHANGELOG for the full record. Re-introducing polygons
requires an official CBS/MoFAGA file or a second independent geometry source,
pinned and reviewed like any other source.

## Bilingual names (`attach_bilingual.dart`, v2.5.0)

`nameNe` is taken from upstream rosters, never transliterated from the English
name: a machine transliteration is a guess about how a Nepali speaker spells a
place, and it disagrees with the gazette, the building and the voter roll often
enough to matter.

| Level | Named | Corroborated by two sources |
|---|---|---|
| Province | 7/7 | 6/7 |
| District | 77/77 | 77/77 |
| Local body | 731/753 | 450/731 |

- **Primary:** source #1 (`abinrimal`), `name_ne`.
- **Second vote / fallback:** source #4 (`open-admin-data`), `name.local`.
  Where abinrimal's roster is short in a district or blank for a row, this
  source fills the gap — it is never used as an *identifier*, because it ships
  775 units against 753.

**What `nameNeVerified` means.** True only when the two sources produce the
*same string*. False does not mean the name is doubtful: of 704 palikas where
both sources spoke, **262 differ only in orthography** — `ब`/`व`, `ी`/`ि`, the
candrabindu, `प्प`/`प`. That is the same phenomenon as the English spelling
variants documented for source #3, and it mirrors them one for one. Both
sources agreed on which palika it is; they disagree on the letters.

**Matching rule.** Palikas are identified from the *English* name, scoped to
the district, by normalized name (lowercased, type suffix and parentheticals
stripped, punctuation flattened) with Levenshtein distance ≤ 2 and a
unique-best-candidate requirement. Ties are refused, never arbitrated.

> **Why 2 and not 4.** A threshold of 4 was implemented and measured. It
> produced confidently wrong pairings between genuinely different neighbouring
> palikas — our `Dhorchaur` taking Bagachour's name, `Sulikot` taking
> Ajirkot's, `Kanda` taking Masta's. Distance 2 still covers every observed
> transliteration variant (`Pauwa Dunma`/`Pauwadungma`, `Gulmi Durbar`/
> `Gulmidarbar`, `Kapilvastu`/`Kapilbastu`). A wrong name is worse than an
> absent one.

**Source defects absorbed:**
- abinrimal's `code` column holds only four distinct values (it is a type
  code, not an identifier). It cannot key a "already matched" set; doing so
  silently dropped 575 matches. Identity uses `district_code` + `name_en`.
- abinrimal duplicates `Gulmi / Chatrakot`. Duplicate Devanagari names inside a
  district are resolved by evidence strength (corroboration first, then match
  distance); the weaker claim is dropped rather than duplicating a name across
  two palikas.
- Two abinrimal rows carry no Devanagari at all (Meringden, Bogtan Foodsil).
  open-admin-data supplies them.

## Administrative attributes (`attach_attributes.dart`, v2.5.0)

**All fields below are single-source.** They were extracted by earlier steps
and held back of the schema for exactly this reason; they ship now with the
limitation stated on every field. Treat `areaSqKm` as approximate for anything
load-bearing.

| Field | Coverage | Source |
|---|---|---|
| `District.headquarter`, `areaSqKm`, `website` | 77/77 | #2 sagautam5 |
| `Province.capital`, `areaSqKm`, `website` | 7/7 | #2 sagautam5 |
| `LocalBody.website`, `email`, `phone` | 371/753 | #6 MoFAGA harvest |
| `LocalBody.zipCodes` | 474/753 | #4 open-admin-data |

**MoFAGA joins on Devanagari, not on a code.** The harvest carries no
identifiers, so a palika is matched by its bare Devanagari name. Two hazards
were measured and handled:

- *District-keyed matching loses whole districts.* 12 districts spell their
  Devanagari differently in this source (`स्याङ्जा` vs `स्याञ्जा`, `रुपन्देही`
  vs `रूपन्देही`, `नवलपरासी पूर्व` …). Indexing by district silently dropped all
  of their contact details. Indexing is therefore global, by bare name.
- *Bare Devanagari palika names are not unique.* Many rural municipalities
  share a name across districts — 41 collisions in this harvest. A candidate is
  accepted only when it is unambiguous: exactly one row nationwide, or several
  of which exactly one sits in our district. Where our own roster has two
  palikas sharing a Devanagari name, **55 palikas are skipped entirely** rather
  than handed a contact block that may belong to a different palika.

sagautam5's province names also need one fold: it spells Sudurpashchim with
one `c` fewer ("Sudurpaschim").

## Ward-level records — NOT AVAILABLE

`wards` is a **count**. No vendored source names individual wards, so
6,743 ward records cannot be published without inventing them.

Checked and confirmed absent:

| Source | What it actually holds |
|---|---|
| #6 MoFAGA `mofaga_all.json` | 750 rows, all palikas — no wards |
| #3 nepali-geo-pro-max `local-units.ts` | ~757 rows, all palikas — no wards |
| #2 sagautam5 | `wards` **count** only |
| #4 open-admin-data | `children_count` is an empty object |
| #1 abinrimal | 753 palikas, no ward layer |

Adding this layer needs a new source, fetched and pinned like any other, before
any tool is written. Candidates: MoFAGA's own ward-level roster pages, ward
boundaries GeoJSON, or Election Commission delimitation data. Until one is
pinned, the honest position is a count and a documented gap.

## Ward counts (`verify_wards.dart`, HYA-324)

Per-palika ward counts merge from two 753-row snapshots (sagautam5
`dataset_municipalities_en.json` + geo-pro-max `src_data_local-units.ts`)
with district-scoped exact/alias/fuzzy/containment matching. **Honesty
note:** geo-pro-max derives from sagautam5 (per its header), so snapshot
agreement is a transcription check; the independent check is province-sum
reconciliation against declared totals (different lineage): 745/753
verified, Lumbini fully reconciled (109 units, 983 wards). 8 gaps are
MoFAGA-backed roster defects (ours+CBS vs sag+MoFAGA splits + 2 silent
harvest gaps), recorded in `data/_stage/wards.json` review — never guessed.
Human decision: Janakpurdham 25 (sub-metro official; geo-pro-max stale 24).

> **Two ward totals, reported separately.** The declared national total is
> **6,743**; the per-palika rows sum to **6,697**. The 46-ward difference is
> the 8 palikas above, pending roster adjudication. The package exposes both
> (`NationalStats.wards` vs `verifiedWards`, `Province.unreconciledWards`)
> rather than publishing one number that silently disagrees with the other.
> Only Lumbini reconciles exactly (109 units, 983 wards).

## Palika boundary geometry (explorer choropleth)

Website-only artifact — **not shipped in the Dart package**, per the
"Boundaries — removed (v2.7.2)" rule above: package boundaries still
require an official CBS/MoFAGA file or a second independent geometry
source. This file only draws the explorer choropleth.

- Raw pin: `nepali-geo-pro-max/src_geo_local-units.geo.ts` (gitignored
  `data/_raw/`; SHA-256 + size in `data/PROVENANCE.sha256`; tree
  `117fd0f3d2dabae3bd86bfe9e4c57098ffe56669`).
- Lineage: nepali-geo-pro-max (MIT) derived it from
  `younginnovations/nepal-locallevel-map` (MIT, file
  `out/municipalities.high.geojson`); Visvalingam-Whyatt simplification at
  tolerance 0.0001, coordinates rounded to 4 decimals, 22 parks/reserves
  removed, the split Bansagadhi feature merged. 753 features carrying
  `districtId`, `provinceId`, `nameEn`, `nameNe`, `type`.
- Derived committed artifact: `docs/palika-boundaries.geojson`, generated
  by `tool/generate_palika_boundaries.dart` — never hand-edited. A
  `metadata` block inside the file records the source pin verbatim.
- Runtime load order (explorer): same-origin `palika-boundaries.geojson`
  first, pinned CDN copies (jsDelivr, raw.githubusercontent) as fallbacks.
- Join gate: `tool/check_boundary_join.dart` runs in CI and pins the
  explorer join coverage — 753/753 (normalized name + districtId, then a
  centroid-in-own-polygon fallback; expected misses: none) since the
  2026-10-26 centroid completion. The seven upstream spelling variants
  that used to miss (Baitedhar, Baraha, Barhagaun Muktichhetra, Bogatan,
  Mugu Karmarong, Naraphu, Neshang) now join through the fallback. A
  new miss — or a fixed miss that leaves the expected list stale —
  fails the build.
- **Centroid completion (2026-10-26):** the 27 roster rows that had no
  open-admin-data coordinate now carry `geoSource:
  "palika-boundaries-centroid"` — the area-weighted centroid of the
  palika's own feature in this file, computed with the shoelace formula
  (holes subtracted, areas weighted; never a bbox midpoint). Each was
  verified by point-in-polygon against its own feature before shipping;
  the derivation uses no source beyond this vendored, pinned artifact.
- "Mappable", defined once to stop the 718-vs-726 confusion: in the
  package it means CBS code **and** coordinates (752 of 753); in
  `docs/data.json` it is rows with coordinates (753 of 753). Only Bheri
  (Jajarkot) is uncoded; every palika is now mapped.

## Website basemap (not shipped in the package)

The GitHub Pages explorer renders centroid dots over
OpenStreetMap Standard raster tiles
(`https://tile.openstreetmap.org/{z}/{x}/{y}.png`, maxZoom 19, no API key).
Tiles are fetched at view time by the visitor's browser; no tile data is
vendored. Attribution `© OpenStreetMap contributors` is shown on-map and
in the explorer footer, per the ODbL. Dark mode reuses the same tiles with
a CSS filter (no second tile set, no key). Centroid coordinates themselves
derive from source #4 (open-admin-data, CC-BY-4.0, attributed in NOTICE).

The NH01 highway overlay geometry (`docs/nh01-highway.geojson`) is
derived from OpenStreetMap route relations (ref=NH01, relations
339449 and 15086072) and **is vendored**. ODbL 1.0 position: ©
OpenStreetMap contributors, licensed under the Open Database Licence;
the attribution travels inside the artifact's own metadata member
(license, relation IDs, Overpass queries, extract date) and is credited
on the explorer (map-attrib note and the overlay popup). The extractor
(`tool/extract_nh01.cjs`) is the artifact's provenance pin: its
structural gates refuse a wrong-looking corridor (termini, length,
way count) instead of shipping one.

## Re-fetching

```powershell
$sources = @{
  "abinrimal"        = "https://raw.githubusercontent.com/abinrimal/nepal-administrative-divisions-json/main"
  "local-states-nepal" = "https://raw.githubusercontent.com/sagautam5/local-states-nepal/master"
  "nepali-geo-pro-max" = "https://raw.githubusercontent.com/l3lackcurtains/nepali-geo-pro-max/main"
  "open-admin-data"  = "https://raw.githubusercontent.com/open-admin-data/nepal-administrative-divisions/main"
}
# …see tool/merge/inventory.dart for the exact file list per source.
dart run tool/merge/inventory.dart
```

After re-fetching, verify integrity:

```powershell
Get-ChildItem -Recurse -File data\_raw | ForEach-Object {
  $h = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
  $rel = $_.FullName.Replace((Get-Location).Path + '\data\_raw\','').Replace('\','/')
  "{0}  {1,-8}  {2}" -f $h, $_.Length, $rel
}
# compare against data/PROVENANCE.sha256
```

A mismatch means the upstream source has changed and the merge must be
re-reviewed — **not** silently re-accepted.

Two sources cannot be re-fetched at all: `mofaga/mofaga_all.json` (a manual
harvest) and `data/_raw/npl-codes/*` (a user-provided Government of Nepal
workbook). `tool/fetch_sources.dart` reports both as `[MANUAL]`; to rebuild
the npl-codes pins, supply the workbook, run `tool/export_npl_codes.ps1`,
and pin the four files.

---

## Province boundaries (high-res) - added 2026-10-26

- Source: National Geoportal (Survey Department of Nepal) - high-resolution
  provincial boundary shapefile (province0.shp).
- Retrieved: 2026-10-26 (user-provided download).
- CRS: WGS 84 (EPSG:4326) - no reprojection required.
- Content: 7 provincial polygons, 15,146 vertices (after Douglas-Peucker
  simplification, eps=0.0005 deg, ~55 m), one part each, no holes.
- Names: English only (Name_E). Devanagari names come from the CBS roster.
- Dropped fields: Name/NM (legacy font), Cases_Deng (health overlay).
- License: Government of Nepal (National Geoportal / Survey Department).
  Redistribution terms to be confirmed before bundling in a published
  package; currently treated as a high-res cross-check/upgrade source.
- Generated artifact: lib/src/geo/province_boundaries.dart (51 KB).
- Regenerate: dart run tool/generate_province_boundaries.dart
  (input: docs/province-boundaries.geojson).
- Conversion tool: tool/convert_province_shp.js.
