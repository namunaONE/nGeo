# Step 2 — CBS Code Verification

**Status:** complete. **No canonical data modified** (assignments staged, not merged).
**Generated:** 2026-10-11 · **Tooling:** `tool/merge/verify_codes.dart` (+ shared `tool/merge/common.dart`)
**Raw report:** `doc/_verify-codes-raw.txt` (regenerate with `dart run tool/merge/verify_codes.dart`)
**Staged mapping:** `data/_stage/nso_codes.json` (753 assignments, provenance-headered)

---

## 1. What was verified, and against what

| List | Codes | Authority |
|---|---|---|
| CBS harvest (`cbs-codes/`, opendatanepal, "harvested from CBS") | 753 × `PDDPP` (10101–70909), 77 × `PDD` (101–709), 7 states | Primary — downloads MD5-identical to CKAN metadata, license `cc-by` re-verified at fetch |
| postal-2025 (`nepali-geo-pro-max`) | 752 distinct codes | Secondary — now doubly-attested (CBS + Shrestha 2019, DOI `10.3126/njg.v18i1.51115`) |
| Ours (`data/nepal_local_levels.json`) | none yet | Receives assignments |

Dharan = 11301 confirmed independently in the CBS file (with CBS's own "Sub-Metropolitian" typo — codes matter, spellings don't).

## 2. Gate results

| Gate | Result |
|---|---|
| Provenance (33 files) | ✅ pass |
| Structural (7/77/753 counts, uniqueness, patterns, prefix sets, referential integrity) | ✅ all pass |
| Alignment guard (EN↔Ne suffix correspondence) | ✅ 747/753, max consecutive run 1 (no cascade) |
| District Ne quarantine signature | ✅ confirmed present — column never consumed |
| Postal uniqueness (752 distinct) | ✅ pass |
| Sudurpashchim P7 rows | ✅ 88 = ours — structural match |

## 3. Reconciliation numbers

- **Postal-only codes (stale?): 0** — every postal-2025 code exists in CBS.
- **CBS-only codes (coverage gap): 1** — Mahakali Municipality, Kanchanpur = **70905**.
- **Assignments: 547 verified / 206 unverified / 753 total.**
- Verified rule (strict): postal T1/T2-accepted code doubly-attested by a same-district CBS row with agreeing normalized name. The 30 T1/T2 accepts that failed CBS name agreement went to review rather than being force-verified.
- Unverified = `nsoCode: null`, `nsoCodeVerified: false`, with a district-scoped suggestion for Step 4 (never auto-applied).

### Corrections to Step 1 figures

Step 1 reported postal-2025 as "751 codes" with "86 in Sudurpashchim". Both were an undercount from a shell regex whose character class excluded dots — it missed `k.i.singh rural municipality` = 70606. True figures: **752 codes, 87 in P7**. The single CBS-only gap is Mahakali 70905.

## 4. Source defects catalogued (all carry into Step 4)

1. **CBS districts Devanagari column corrupt from row 43** (`NAWALPARASI EAST` truncated mid-parenthetical; rows 44–77 carry the previous row's name — proven at codepoint level). Quarantined.
2. **CBS palika typos (isolated, max run 1):** `Sirijanga` Ne "गाउंपालिका", `Bensi Shahar` Ne "नगरापालिका", `Bhirkot Municipaity` (EN), `Gulmi Durbar Gaunpaika` (EN), `Tilottama` Ne "नगरापालिका", `Kanaka Sundari Gaun Palika` (EN spaced). Spelling evidence for adjudication, not alignment breaks.
3. **CBS uppercase romanization variants** (`CHITAWAN`, `DHANUSA`, `TANAHU`, `KAPILBASTU`, `NAWALPARASI EAST/WEST`, `RUKUM EAST/WEST`) — explain open-admin-data's spellings; codes join on codes.
4. **Postal-2025 shortfall: exactly 1 code** (Mahakali 70905, Kanchanpur).

## 5. What Step 4 receives

- `data/_stage/nso_codes.json` — every ours palika with either a doubly-attested code or an explicit null + suggestion.
- 206 review items (149 T3 + 27 MISS + 30 CBS-name-disagree), each with a district-scoped code suggestion.
- The 219 palika + 13 district Devanagari diffs gain a 4th vote (CBS `स्थानीय तह`, where aligned).
- District codes 101–709 validated and ready for schema v2.

## 6. Open items resolved

- REVIEW-inputs §7.1 (verify postal-2025): **done** — doubly-attested, see §3.
- REVIEW-inputs §7.4 (86 vs 88): **done** — 88, structural match, see §3.
- REVIEW-inputs §7.2 (name divergences) and §7.3 (Chatrakot dupe): **Step 4**.

---

## 7. Addendum (2026-10-25) — Nepal Post adjudication: 8 of 9 unverified resolved

**Status:** adjudicated and applied to `data/nepal_local_levels.json` as
`singleSource` (`cbsCodeVerified` stays false — the doubly-attested rule needs
CBS + postal-2025, not the postal directory). Human sign-off: HyaMuji, 2026-10-25.

**Sources** (search-index extracts of Nepal Post GIS portal PDFs, quoted below):

1. Local-level code list: <https://giwmscdnone.gov.np/media/pdf_upload/locallevelcode_tjstksd.pdf>
   — "Mapya Dudhkoshi Rural Municipality · माप्य दुधकोशी गाउँपाललका · 10304",
     "Thulung Dudhkoshi Rural Municipality · थुलुङ दुधकोशी गाउँपाललका · 10305"
2. Federal-structure post office list:
   <https://giwmscdnone.gov.np/media/pdf_upload/पोष्टल%20कोड_5aoxvqu.pdf>
   (mirror <https://giwmscdnone.gov.np/media/pages/files/postl%20code%20english%20(1)_ihneau2.pdf>)
   — "Post Office, Paribartan R.Mun., Rolpa · Lumbini · 50203 · 5020305 · 05",
     "Post Office, Gangadev R.Mun., Rolpa · Lumbini · 50204 · 5020402 · 02",
     "Post Office, Sunil Smriti R.Mun., Rolpa · Lumbini · 50209 · 5020904 · 04",
     "Post Office, Nalgad Mun., Jajarkot · Karnali · 60707 · 6070707 · 07",
     "Post Office, Jagannath R.Mun., Bajura · Sudur Paschim · 70105 · 7010503 · 03",
     "Post Office, Khaptad Chhededaha R.Mun., Bajura · Sudur Paschim · 70107 · 7010705 · 05"

### 7.1 Codes applied

| Palika | District | Code | Postal code (office, 7-digit system — NOT `zipCodes`) |
|---|---|---|---|
| Mapya Dudhkoshi | Solukhumbu | **10304** | 1030403 |
| Thulung Dudhkoshi | Solukhumbu | **10305** | 1030501 |
| Paribartan | Rolpa | **50203** | 5020305 |
| Gangadev | Rolpa | **50204** | 5020402 |
| Sunil Smriti | Rolpa | **50209** | 5020904 |
| Nalagad | Jajarkot | **60707** | 6070707 |
| Jagannath | Bajura | **70105** | 7010503 |
| Khaptad Chhededaha | Bajura | **70107** | 7010705 |

**Correction vs. the inference:** the free-PDDPP inference for Rolpa paired
Gangadev = 50203 / Paribartan = 50204. The postal directory attests the
**reverse**. The attestation wins; the inference was never merged, so no code
is being changed — only added.

**Still refused:** Bheri (Jajarkot) — 60706 is implied by the district
sequence (every other Jajarkot code is attested) but was not directly
extracted; it stays `null` / `unverified` until a direct attestation exists.

**Invariants re-checked by hand for this change:** bijection (all 8 codes were
previously unused — verified against the full dataset before writing) and
district containment (10304/10305 ⊂ 103, 50203/50204/50209 ⊂ 502,
60707 ⊂ 607, 70105/70107 ⊂ 701). `tool/generate.dart` re-verifies both at
regeneration.

### 7.2 Devanagari names applied (single-source, `nameNeVerified: false`)

| Palika | nameNe | Source |
|---|---|---|
| Bhokraha (Sunsari) | भोक्राहा | en.wikipedia "भोक्राहा गाउँपालिका" + fr.wiki "भोक्राहा" (same string) |
| Yangwarak (Taplejung) | याङवरक | en.wikipedia "याङवरक गाउँपालिका" (exact name match; see flag below) |

`nameNe` null count: 22 → 20.

### 7.3 Candidates seen and refused (do not apply without Gazette/palika-site confirmation)

- **Baraha (Sunsari)** — fr.wiki "बाराहा" page is tagged Udayapur, not Sunsari; identity not safe.
- **Bungdikali (Nawalpur)** — en.wiki spells the palika "Baudikali" (बौदीकाली); normalized distance to our name is 3, above the ≤ 2 gate.
- **Kumakh Malika (Salyan)** — en.wiki names it "Kumakh" (कुमाख गाउँपालिका); name mismatch unresolved (Kumakh vs Kumakh Malika).
- **Netrawati (Dhading)** — en.wiki calls it "Netrawati Dabjong"; Devanagari string not captured. Rename flag below.

### 7.4 Rename flags (documented; NONE applied — roster identity unchanged pending Gazette)

1. **Jagannath (Bajura)** — Wikipedia re-titled the article to "Pandav Gufa
   Rural Municipality" (<https://en.wikipedia.org/wiki/Pandav_Gufa_Rural_Municipality>),
   body still opens "Jagannath Rural Municipality". Possible rename; needs Gazette.
2. **Sunkoshi (Udayapur)** — en.wiki: "Limchungbung (लिम्चुङबुङ गाउँपालिका)
   (earlier: Sunkoshi)", 5 wards — also a candidate ward count for one of the
   8 ward gaps.
3. **Dalome (Mustang)** — en.wiki: "Lo-Ghekar Damodarkunda (लोकेघर दामोदरकुण्ड)
   (earlier: Dalome)".
4. **Neshang (Manang)** — en.wiki: "Nesyang (ङिस्याङ गाउँपालिका)".
5. **Barhagaun Muktichhetra (Mustang)** — en.wiki titles it "Varagung/Baragung
   Muktichhetra".
6. **Netrawati (Dhading)** — en.wiki: "Netrawati Dabjong Rural Municipality", 5 wards.
7. **Sunil Smriti (Rolpa)** — the 2017 rename coverage (Setopati) records the
   adopted name as "Sahid Sunil Smriti"; we ship the short form.
8. **Bheri (Jajarkot)** — en.wiki notes "(earlier: Bheri Malika)";
   **Nalagad** — "(earlier: Tribeni Nalgad)" and en.wiki spells it "Nalgad
   (नलगाड)" where we ship "Nalagad (नालागड)". Orthography candidates only.
9. **Yangwarak district text** — en.wiki places Yangwarak RM in Panchthar in
   prose; our roster and the CBS structure place it in Taplejung. The nameNe
   (याङवरक) is applied on exact name match; the district discrepancy is a
   Wikipedia defect to watch, not a roster change.

### 7.5 Follow-ups required in the merge pipeline (cannot be done by hand)

1. `dart run tool/pipeline.dart` — regenerate `lib/src/nepal_data.dart`,
   `docs/data.json`, `bindings/`, `data/_stage/code_tiers.json` (the tier
   evidence file still records the 9 unverified items from 2026-10-11).
2. `dart test` — update every pinned count that this change makes stale:
   22 → 20 null `nameNe` (widget suite lists the 22), 9 → 1 unverified,
   196 → 204 singleSource, 744 → 752 coded, and any `dataAsOf` pin.
3. `data/_stage/decisions_manual.json` — record this adjudication as a human
   decision (the Rolpa swap correction above all).

---

## 8. Addendum (2026-10-27) — Government of Nepal code table: all 753 coded

**Status:** applied to `data/nepal_local_levels.json` by
`tool/merge/apply_npl_codes.dart` (pipeline step 6 of 9). Tier counts become
548 verified / 205 singleSource / **0 unverified**; 753/753 coded; `nameNe`
nulls 20 → 0. `cbsCodeVerified` stays `false` for everything this step
contributes — a directory attestation is not the doubly-attested tier.

**Source:** the Government of Nepal administrative code table
(`1695378470_83.xls`, user-provided; vendored `data/_raw/npl-codes/` with
pinned TSV exports — see `data/SOURCES.md`). Its local-unit sheet attests
all 753 PDDPP codes directly; its district register's `Code` column matches
the PDD prefixes derived from the local-unit sheet and our district codes
(77/77); the district sheet's `S.N.` is a serial, not a code.

### 8.1 Bheri (Jajarkot) resolved — the §7 leftover

§7 left Bheri uncoded because 60706 was only *implied* by the district
sequence. The code table attests it directly: row S_N 639, "Bheri Malika
Urban Municipality" / भेरीमालिका नगरपालिका / 60706. The join is code-primary
with a forced 1↔1 elimination inside Jajarkot (our roster and the directory
each have exactly one uncoded/unclaimed unit left) and a name-affinity guard
("Bheri" is contained in "Bheri Malika" — en.wiki's §7.4 note "(earlier:
Bheri Malika)" corroborates the same entity). Applied as `singleSource`,
`cbsCodeVerified: false`.

### 8.2 The stale `code_tiers.json` hazard, and the ledger fix

`data/_stage/code_tiers.json` still recorded the pre-adjudication state
(2026-10-13: 548/196/9) while the dataset carried the §7 codes applied
out-of-band (commit `c7983e1`). A full pipeline re-run would therefore have
**demoted all 8 Nepal Post codes** — the resolver cannot re-derive them (the
harvest's names sit outside the distance-2 gate and the 2-vs-2 districts
defeat forced elimination). Fix shipped with this change:

- `data/_stage/code_adjudications.json` — a hand-curated, git-tracked ledger
  of directory-attested codes (the 8 Nepal Post entries + Bheri), edited by
  hand only, each entry carrying source + quote + sign-off. This is the
  code-decision record §7.5.3 asked for.
- `resolve_code_tiers.dart` gains **Pass A2**: it reserves ledger codes
  before re-derivation (validating each entry's type, dataset-code and
  CBS-row existence, refusing collisions), skips them in the re-derivation
  pass, and fails the run on any unconsumed entry. The staged provenance
  records the ledger in `inputs` and `ledgerEntries`.

Pass A2 ships compile-verified only (`dart analyze`) — this machine does not
hold the full `data/_raw/` (mofaga is a manual harvest with no public URL),
so its first real execution happens on a machine with the complete sources.

### 8.3 The 20 `nameNe` fills and the rename question

The table's Unicode Devanagari column filled the last 20 null `nameNe`
values (`nameNeVerified: false`; internal whitespace normalised, characters
verbatim). For **all 20**, the directory's name for the joined code differs
from our English name — these are precisely the palikas whose names changed
after our roster snapshot, which is why `attach_bilingual` never matched
them. Identity is established by code + district + type, attested by BOTH
sides: the CBS roster names our exact legacy spelling at the same code
(normalized distance 0, per `code_tiers.json` evidence) and the directory
names the new spelling at the same code. Representative pairs:

| Ours (legacy English) | Directory (current) | Code |
|---|---|---|
| Bheri (Jajarkot) | Bheri Malika | 60706 |
| Sunkoshi (Udayapur) | Limchungbung | 11405 |
| Belhi Chapena (Saptari) | Rajgadh | 20111 |
| Dhorchaur (Salyan) | Siddha Kumakh | 60904 |
| Kumakh Malika (Salyan) | Kumakh | 60902 |
| Kanda (Bajhang) | Saipal | 70201 |
| Kalika (Kalikot / Rasuwa) | Shuva Kalika | 60509 / 30304 |

Public corroboration for the checked renames: an AEPC (government) roster
lists "Sunkoshi Rural Municipality (Limchungbung)"; JICA's report lists
"Sunkoshi (Limchungbung)"; CIJ Nepal documents the Belhi Chapena → Rajgadh
rename; the palika's own site (dhorchaurmun.gov.np) issues notices as
"Siddha Kumakh Rural Municipality, Dhorchaur"; the Kathmandu Post (2018)
covers the Kanda-village RM named Saipal; en.wiki titles Kalikot's RM
"Shuva Kalika". The remaining 13 fills are name expansions of the same
shape (Netrawati Dabjong, Likhu Tamakoshi, Bhimsenthapa, Barpak Sulikot,
Narpa Bhumi, Manang Ngisyang, Varagung Muktichhetra, Lo Ghekar
Damodarkunda, Ruruchhetra, Diprung Chuichumma, Barahachhetra, Bhokraha
Narsingh, Swamikartik Khapar, Bogatan Phudsil).

**Renames stay UNAPPLIED in English** (per the §7.4 doctrine): adopting one
needs a Gazette confirmation. The fills carry the current Devanagari of the
same entity, flagged `nameNeVerified: false`, and the full variant list is
preserved in `data/_stage/npl_codes.json` and `doc/_apply-npl-codes-raw.txt`.

### 8.4 Follow-ups

1. Run the full pipeline (steps 1–9) on a machine holding the complete
   `data/_raw/` to regenerate the stale `code_tiers.json` with Pass A2 live
   and confirm zero drift against the committed dataset.
2. Adopt or reject the directory renames once Gazette confirmation exists
   (§7.4 list + §8.3 pairs).
3. Wards remain on hold pending CBS Census 2021 ward-level data (per the
   standing decision).

---

## 9. Addendum (2026-11-01) — CBS administrative atlas: the corroboration audit

**Status:** audit only — no canonical data modified, no tier promotion. The
atlas is the CBS family (same issuer as source #5's harvest), so it is
corroborating evidence, not an independent second attestation. The
doubly-attested rule (`verified` = postal-2025 + CBS) is unchanged.

**Source:** a 9-page CBS administrative atlas (`1695376827_32.pdf`,
user-provided 2026-11-01; not vendored — no stated licence, same treatment
as source #7). Maps 1–2 index the provinces and districts; Maps 3–9 list
every district's palikas with their PDDPP code and an (U)/(R) tag. Every
page credits "Prepared by GIS Section, CBS" and "Map Source: Topographic
Zonal Map (1:125,000), Department of Survey". The old province naming
(no Koshi / Madhesh / Bagmati / Lumbini on the index pages) dates the
printing between the 2017 restructuring and the ~2023 renames; the
filename timestamp (2023-09-22) sits two minutes from the §8 code
table's `1695378470_83.xls` — same origin day, likely the same portal.

**Audit (OCR cross-check against `data/nepal_local_levels.json`):**

- **741/753 exact PDDPP code matches.** The remaining 12 all sit on the
  atlas's Province-2 page, whose printed code column OCR-shifted (Bara
  20701–20707 appears inside a 206xx run); all 12 are present by name
  with the correct district and type.
- **0/741 urban-vs-rural disagreements** — every exact code match agrees
  with the dataset's type.
- **The ledger is corroborated directly:** the atlas prints "Bheri Malika
  (U)" at 60706 — a second government printing of the §8.1 flagship
  adjudication.
- **The §8.3 rename set is corroborated:** the atlas prints the expanded
  names at the same codes we hold (Barpak Sulikot 40103, Narpa Bhumi
  40201, Netrawati Dabajong 30405, Likhu Tamakoshi 31003, Bhimsen Thapa
  40106, Lo-Ghekar Damodarkunda 40301), and older spellings elsewhere
  ("Janakpur" at 20315, where we ship Janakpurdham). Printings differ in
  vintage in both directions; the audit joins on codes.
- **79 name variants** across the matches: transliteration plus the
  rename phenomena above. None affects identity, which the audit keyed
  on code + district + type.

**Verdict:** zero detected mis-assignments in the singleSource tier — an
official printing of the same roster family agrees with every assignment
it legibly attests. The tier label is unchanged (one attestation family,
honestly labelled; see the Honesty note in data/SOURCES.md).

**Follow-up (optional):** a human read of the atlas's Province-2 page
would confirm the 7 OCR-shifted Bara codes at code level. Nothing in the
dataset waits on it.
