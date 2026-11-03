# Peak review notes — names, identities and locations

**Status:** Working notes for the language and geo reviewers. **Not a sign-off.**  
**Date:** 28 October 2026  
**Companion files:** [`peaks_name_review.csv`](../data/reference/peaks_name_review.csv) · [`peaks_geo_review.csv`](../data/reference/peaks_geo_review.csv) · [`peaks_evidence_review.csv`](../data/reference/peaks_evidence_review.csv) · [`peaks_master.csv`](../data/reference/peaks_master.csv)

This memo records what the source review resolved, what it did not, and the recommended next decision for each open row. It does not change any `review_status` from `draft`. The row-level evidence is in [`peaks_evidence_review.csv`](../data/reference/peaks_evidence_review.csv): four name rows and four high-priority district rows, each with source, quote, confidence and blank reviewer fields.

**Decisions recorded 28 October 2026 (reviewer sign-off):** names — Nepal Peak **confirm**, Ganesh II **confirm** (amended label गणेश-II), Thulagi Chuli **keep_pending**, Ratna Chuli **confirm** (रत्नचुली). Chamar form confirmed without हिमाल. Geo — all four high-priority rows **confirm** (Solukhumbu, Gorkha, Rasuwa, Manang), all 32 medium rows **confirm**, Yalung Kang West coordinate **confirm**. Thulagi Chuli is the only peak that remains `draft`.

---

## 1. Nepali names — four pending rows

`name_np_status: attested` requires DNPWC, Nepali Wikipedia, a Nepali Wikidata label, or a named reviewer. Press, trekking and social-media usage can support a reviewer decision but cannot by itself turn a proposed label into an attested one.

| ID | Peak | Proposed Nepali | Evidence found | Confidence | Recommendation |
|---|---|---|---|---|---|
| `pk-nepal-peak` | Nepal Peak | नेपाल पिक | Utprerana (`S21`) caption: **ताप्लेजुङको फक्ताङलुङ गाउँपालिका—६ रामधाङ क्षेत्रबाट देखिएको नेपाल पिक (हिमाल)को दृश्य**. Shikshasanjal (`S22`) item 14: **नेपाल पिक पर्ने जिल्ला : ताप्लेजुङ**. English Wikipedia (`S15`) confirms the 7,177 m Nepal–India border summit but gives no Nepali name. | medium | Confirm the short form **नेपाल पिक**; record **नेपाल पिक हिमाल** as the fuller media variant. This is media and study-blog usage, not a gazetteer attestation. |
| `pk-ganesh-ii` | Ganesh II | गणेश-II | Nepali Wikipedia, **गणेश हिमाल** (`S14`), photo caption: **चुचुराहरू (बायाँदेखि दायाँ): नाम नभएको चुचुरो (६२५० मि), गणेश-II, पविल, सालसुङ्गो**. The earlier proposed **गणेश दोस्रो** was derived and is not attested. | medium | **Confirm the amended label गणेश-II.** Keep **Ganesh NW** as the English alias. The summit is 7,118 m, in Gorkha, inside Nepal. |
| `pk-thulagi-chuli` | Thulagi Chuli | थुलागी चुली | English Wikipedia (`S15`) describes the mountain and gives 7,059 m, but no Nepali form. No Nepali-language attestation was found for **थुलागी चुली** or **थुलागी हिमाल**. | low | **Keep pending** unless the reviewer accepts a standard transliteration. If accepted, record `transliterated`, not `attested`. |
| `pk-ratna-chuli` | Ratna Chuli | रत्नचुली | English Wikipedia (`S15`) carries **रत्नचुली** in the article. Nepali Wikipedia, **बुढानीलकण्ठ स्कूल** (`S14`), lists **रत्नचुली** among visible peaks. Peregrine Treks (`S23`) uses both **रत्न चुली** and **रत्नचुली**, but gives 7,128 m, which conflicts with the 7,035 m master; use it for the name form only. | medium | Confirm the closed form **रत्नचुली**, with **रत्न चुली** as an alias variant. |

### Decision needed

For each row, the reviewer records `confirm`, `amend` or `reject`, plus name, date and notes in `peaks_name_review.csv`. A `confirm` decision is what changes the master row from `pending` to `attested`; the source review alone does not.

**Recommended outcome:** confirm Nepal Peak, confirm Ganesh II as **गणेश-II** (the earlier proposal was amended), confirm Ratna Chuli as **रत्नचुली**, and leave Thulagi Chuli pending unless the reviewer accepts a transliteration.

### Chamar — resolved

Nepali Wikipedia (`S14`) lists **चामर** at 7,187 m, matching the master elevation exactly. The earlier proposed label **चमर हिमाल** was not attested and is superseded. The master now carries **चामर** as `attested`; the reviewer only needs to confirm the form without **हिमाल**.

---

## 2. Geo review — four high-priority rows

The four `high` rows are artefacts of the simplified v1.0 district polygons, not evidence that the peak is in the wrong district. Each assignment is supported by the peak's location and by the named source. The evidence table records these as `EV-GEO-01` to `EV-GEO-04`.

| Peak | Assigned district | Why the simplified polygon flags it | Independent evidence | Recommendation |
|---|---|---|---|---|
| Cho Oyu | Solukhumbu (`103`) | Summit lies on the China border; the simplified district polygon stops short of the summit. The point is 0.27 km outside the polygon and 0.25 km from the national boundary. | English Wikipedia (`S15`): China–Nepal border, Koshi Province. Visit Nepal (`S24`): Solukhumbu district, Koshi Province. | **Confirm Solukhumbu.** The flag is a boundary-generalisation artefact. |
| Manaslu | Gorkha (`401`) | Summit is 0.14 km outside the simplified Gorkha polygon, with Manang 0.14 km away. | English Wikipedia (`S15`): Gorkha District; “highest peak in the Gorkha District”. | **Confirm Gorkha.** Do not revert to Manang. |
| Langtang Ri | Rasuwa (`303`) | Summit is 0.29 km outside the simplified Rasuwa polygon on the China border. | English Wikipedia (`S15`): Bagmati Zone–Tibet border. Altitude Himalaya (`S25`): Rasuwa district; Nepal–Tibet border. | **Confirm Rasuwa.** The nearest alternative is Sindhupalchok, 23.25 km away. |
| Ratna Chuli | Manang (`402`) | Summit is 0.02 km outside the simplified Manang polygon on the China border. | English Wikipedia (`S15`): infobox district Manang; categorised under Manang District. The peak is in the Nar Phu valley. | **Confirm Manang.** The nearest alternative is Mustang, 14.90 km away. |

### Thulagi Chuli — district conflict resolved

English Wikipedia gives the district as **Gorkha**, while the master assigns **Manang (402)**. This is a source-field error, not a location dispute:

- The Wikipedia infobox coordinate is **28°31′40″N 84°31′40″E** (28.5278, 84.5278).
- The Wikidata/master coordinate is **84.5204, 28.5275**.
- Both points reverse-geocode to **Nashong, Manang** in OpenStreetMap (`S07`). The master point is 4.12 km inside the simplified Manang polygon; Gorkha is the nearest alternative.
- The master assignment of **402 Manang** is retained. Thulagi Chuli does **not** become a fifth high-priority geo row.

---

## 3. Identity and coordinate questions

### Pabil and Ganesh II — identity closed

- **Ganesh II** = **Ganesh NW**, 7,118 m, inside Nepal, Gorkha (`401`).
- **Pabil** = **Ganesh IV**, 7,104 m, inside Nepal, Gorkha (`401`).
- **Ganesh III** = **Salasungo**, 7,043 m, a separate summit not in the 51-peak list.
- The master’s old Pabil alias `Ganesh III` has been corrected to `Ganesh IV`.

Neither Pabil nor Ganesh II is a border peak. The earlier note that Pabil might be on the Nepal–Tibet border was a naming confusion and has been removed.

### Yalung Kang West — coordinate still open

- Candidate coordinate: **27.7062, 88.1250**, from Peakbook (`S18`), converted from UTM 45R 610914 3065161.
- It is 1.16 km west of Yalung Kang (27.7052, 88.1367).
- `S15` places the West summit and Kangbachen in Nepal’s Taplejung District, so the border status is now **inside**, not `border`.
- The point is 2.5 km inside the simplified national polygon. That is consistent with `inside` but does not independently prove the coordinate.
- **Decision still needed:** confirm or reject the candidate coordinate. Do not plot the peak until confirmed.

### Nepal Peak — border confirmed

Wikidata describes Nepal Peak as a mountain on the Nepal–Sikkim border. The master carries `border` / `India`; `border_source` is `S04`. The Nepali name remains the open item.

---

## 4. What this memo does not close

1. **Language sign-off.** Four names still need a named reviewer and a date: Nepal Peak, Ganesh II, Thulagi Chuli and Ratna Chuli. Chamar is attested as चामर from Nepali Wikipedia and only needs confirmation of the form.
2. **Yalung Kang West coordinate.** A reviewer must accept `S18` or replace it.
3. **District review.** The four `high` rows need sign-off; the 32 `medium` rows still need confirmation, although most are ridge summits within 0.5 km of a district boundary.
4. **DNPWC area and geometry confirmation.** No protected-area or buffer polygon is available. The area corrections are documented in [`reference-area-reconciliation.md`](reference-area-reconciliation.md).
5. **Peak freeze.** The list cannot move from `draft` to `approved` until items 1–4 are recorded.

---

## 5. Sources used in this memo

| ID | Source | Use |
|---|---|---|
| `S04` | Wikidata | Coordinates, labels, aliases; Nepal Peak border description |
| `S07` | OpenStreetMap / Nominatim | Reverse-geocode check for the Thulagi Chuli district conflict |
| `S14` | Nepali Wikipedia | Attested Nepali names, including चामर, गणेश-II and रत्नचुली |
| `S15` | English Wikipedia | Border status; district cross-checks; Ratna Chuli and Thulagi Chuli |
| `S18` | Peakbook | Candidate Yalung Kang West coordinate |
| `S20` | 2020 DNPWC-commissioned GIS report | Area reconciliation only; not a name or geometry source |
| `S21` | Utprerana, नेपाल पिक हिमाल | Nepali media usage of नेपाल पिक |
| `S22` | Shikshasanjal geography blog | Nepal Peak district cross-check (Taplejung) |
| `S23` | Peregrine Treks, रत्न चुली अभियान | Nepali usage of रत्न चुली / रत्नचुली; not the elevation |
| `S24` | Visit Nepal, Cho Oyu | Cho Oyu district cross-check (Solukhumbu) |
| `S25` | Altitude Himalaya, Langtang Mountains | Langtang Ri district cross-check (Rasuwa) |

All eleven resolve in [`sources.csv`](../data/reference/sources.csv). `S18` is user-contributed and must not be treated as authoritative without reviewer confirmation. `S20` is a government-commissioned report used for facts only; it carries no geometry licence. `S21`–`S25` are secondary or commercial sources used only to corroborate name and district usage.
