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
