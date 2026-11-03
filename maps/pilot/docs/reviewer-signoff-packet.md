# Reviewer sign-off packet — v1.1 peaks

**Status:** Sign-off applied 28 October 2026 for all recommended decisions. This packet is retained as the audit record of the review.  
**Date:** 28 October 2026  
**Purpose:** Collect the named decisions that close G2 for the peak layer, so the peak list can be frozen and the G3 peaks build can start.  
**Companion files:** [`peaks_name_review.csv`](../data/reference/peaks_name_review.csv) · [`peaks_geo_review.csv`](../data/reference/peaks_geo_review.csv) · [`peaks_evidence_review.csv`](../data/reference/peaks_evidence_review.csv) · [`peaks_master.csv`](../data/reference/peaks_master.csv) · [`peaks-review-notes.md`](peaks-review-notes.md)

---

## 0. What this packet closes

| Item | Rows | Review file | Decision needed |
|---|---:|---|---|
| Pending Nepali names | 4 | `peaks_name_review.csv` | `confirm`, `amend` or `reject` |
| High-priority district rows | 4 | `peaks_geo_review.csv` | Confirm or replace the district |
| Medium-priority district rows | 32 | `peaks_geo_review.csv` | Confirm in bulk, or flag exceptions |
| Yalung Kang West coordinate | 1 | `peaks_geo_review.csv` | Confirm `S18` or replace it |
| Chamar name form (optional) | 1 | `peaks_name_review.csv` | Confirm चामर without हिमाल |

The other 15 geo rows are `low` priority and need no action. The other 47 name rows are already `attested` or `transliterated`; only the four pending names block the freeze.

## 1. How to record a decision

1. Read the recommendation and the quoted evidence below.
2. Open the named CSV and fill the row’s reviewer fields:
   - `review_decision`: `confirm`, `amend` or `reject`;
   - `reviewer_name`;
   - `review_date` (ISO `YYYY-MM-DD`);
   - `reviewer_notes` (required for `amend` or `reject`; optional otherwise).
3. For an amendment, write the final label or district in `reviewer_notes`.
4. Return the completed CSV or the sign-off block in §6.
5. **Do not edit `peaks_master.csv` and do not change `review_status`.** The data manager applies the decisions, updates the master, and regenerates `master_qa.json`.

A blank reviewer field means “not reviewed.” A recommendation in this packet is not a decision.

---

## 2. Nepali names — four decisions

`name_np_status: attested` requires DNPWC, Nepali Wikipedia, a Nepali Wikidata label, or a named reviewer. Media and trekking usage can support a reviewer decision but do not by themselves make a label attested.

| ID | Peak | Proposed Nepali | Key evidence | Confidence | Recommendation |
|---|---|---|---|---|---|
| `pk-nepal-peak` | Nepal Peak | **नेपाल पिक** | Utprerana (`S21`): **ताप्लेजुङको फक्ताङलुङ गाउँपालिका—६ रामधाङ क्षेत्रबाट देखिएको नेपाल पिक (हिमाल)को दृश्य**. Shikshasanjal (`S22`): **नेपाल पिक पर्ने जिल्ला : ताप्लेजुङ**. English Wikipedia (`S15`) confirms the 7,177 m Nepal–India border summit but gives no Nepali name. | Medium | **Confirm नेपाल पिक.** Record नेपाल पिक हिमाल as the fuller media variant. |
| `pk-ganesh-ii` | Ganesh II | **गणेश-II** | Nepali Wikipedia, गणेश हिमाल (`S14`), caption: **चुचुराहरू (बायाँदेखि दायाँ): नाम नभएको चुचुरो (६२५० मि), गणेश-II, पविल, सालसुङ्गो**. The earlier proposal गणेश दोस्रो was derived and is not attested. | Medium | **Confirm the amended label गणेश-II.** Keep Ganesh NW as the English alias. |
| `pk-thulagi-chuli` | Thulagi Chuli | **थुलागी चुली** | English Wikipedia (`S15`) describes the mountain at 7,059 m but gives no Nepali form. No Nepali-language attestation was found for थुलागी चुली or थुलागी हिमाल. | Low | **Keep pending** unless the reviewer accepts a standard transliteration; if accepted, record `transliterated`, not `attested`. |
| `pk-ratna-chuli` | Ratna Chuli | **रत्नचुली** | English Wikipedia (`S15`) carries रत्नचुली. Nepali Wikipedia, बुढानीलकण्ठ स्कूल (`S14`), lists रत्नचुली among visible peaks. Peregrine Treks (`S23`) uses both रत्न चुली and रत्नचुली, but its 7,128 m conflicts with the 7,035 m master; use it for the name form only. | Medium | **Confirm the closed form रत्नचुली**, with रत्न चुली as an alias. |

### Chamar — form check only

Nepali Wikipedia (`S14`) lists **चामर** at 7,187 m, matching the master elevation. The master already carries it as `attested`. Confirm the form **without** हिमाल; the earlier proposal चमर हिमाल was not attested. No status change is needed.

### Thulagi Chuli — do not re-open the district

English Wikipedia gives the district as Gorkha, but both its own coordinate (28.5278, 84.5278) and the master coordinate (84.5204, 28.5275) reverse-geocode to **Nashong, Manang** (`S07`). The master retains **402 Manang**. The only open Thulagi decision is the name.

---

## 3. High-priority district rows — four decisions

The four `high` rows are artefacts of the simplified v1.0 district polygons, not evidence that the peak is in the wrong district. Full evidence is in `peaks_evidence_review.csv` (`EV-GEO-01` to `EV-GEO-04`).

| Peak | Assigned district | Why the polygon flags it | Independent evidence | Recommendation |
|---|---|---|---|---|
| Cho Oyu | **103 Solukhumbu** | Summit lies on the China border; the simplified polygon stops short. The point is 0.27 km outside the polygon. | English Wikipedia (`S15`): China–Nepal border, Koshi Province. Visit Nepal (`S24`): Solukhumbu, Koshi Province. | **Confirm Solukhumbu.** |
| Manaslu | **401 Gorkha** | Summit is 0.14 km outside the simplified Gorkha polygon, with Manang 0.14 km away. | English Wikipedia (`S15`): Gorkha District; “highest peak in the Gorkha District.” | **Confirm Gorkha.** Do not revert to Manang. |
| Langtang Ri | **303 Rasuwa** | Summit is 0.29 km outside the simplified Rasuwa polygon on the China border. | English Wikipedia (`S15`): Bagmati Zone–Tibet border. Altitude Himalaya (`S25`): Rasuwa district; Nepal–Tibet border. | **Confirm Rasuwa.** Nearest alternative is Sindhupalchok, 23.25 km away. |
| Ratna Chuli | **402 Manang** | Summit is 0.02 km outside the simplified Manang polygon on the China border. | English Wikipedia (`S15`): infobox district Manang; categorised under Manang District; Nar Phu valley. | **Confirm Manang.** Nearest alternative is Mustang, 14.90 km away. |

---

## 4. Medium-priority district rows — 32 confirmations

All 32 medium rows share the same pattern:

- the point is **inside** the assigned district polygon;
- it is within **0.5 km** of that district’s boundary;
- the nearest alternative district is the assigned district at **0 km**.

These are ridge and border summits. The flag is expected and is not a misassignment. **Recommended action: bulk confirm all 32**, unless local knowledge identifies a specific exception. Record exceptions individually in `peaks_geo_review.csv`.

| District | Peaks | Max distance to boundary | Recommendation |
|---|---|---:|---|
| **101 Taplejung** | Kabru, Kanchenjunga, Kirat Chuli, Kanchenjunga South, Kanchenjunga Central, Nepal Peak, Jongsong Peak | 0.28 km | Confirm all 7 |
| **102 Sankhuwasabha** | Makalu | 0.12 km | Confirm |
| **103 Solukhumbu** | Lhotse, Gyachung Kang, Chamlang, Nangpai Gosum, Lhotse Shar, Pumori, Lhotse Middle, Mount Everest | 0.29 km | Confirm all 8 |
| **301 Dolakha** | Gaurishankar | 0.48 km | Confirm |
| **401 Gorkha** | Pabil, Yangra, Ngadi Chuli | 0.16 km | Confirm all 3 |
| **402 Manang** | Annapurna II | 0.08 km | Confirm |
| **404 Myagdi** | Annapurna I, Tilicho Peak, Annapurna South, Churen Himal | 0.13 km | Confirm all 4 |
| **405 Kaski** | Annapurna III, Gangapurna | 0.07 km | Confirm both |
| **406 Lamjung** | Himalchuli | 0.19 km | Confirm |
| **601 Dolpa** | Dhaulagiri II, Putha Hiunchuli, Dhaulagiri IV, Dhaulagiri V | 0.18 km | Confirm all 4 |

The row-level checklist, including the exact point coordinates and distances, is [`peaks_geo_review.csv`](../data/reference/peaks_geo_review.csv).

---

## 5. Yalung Kang West — coordinate decision

| Field | Value |
|---|---|
| Candidate coordinate | **27.7062, 88.1250** |
| Source | Peakbook (`S18`), converted from UTM 45R 610914 3065161 |
| Relation to Yalung Kang | 1.16 km west of 27.7052, 88.1367 |
| Border status | **Inside Nepal** per `S15` (West summit and Kangbachen, Taplejung District) |
| Polygon check | 2.5 km inside the simplified national polygon; consistent with `inside`, but the generalised boundary cannot prove the coordinate |
| Recommendation | **Confirm `S18` or replace it.** Do not plot the peak until confirmed. |

`S18` is user-contributed, so it is not authoritative on its own. The Himalayan Database (`S05`) independently confirms a separate 8,077 m summit (`YALW`); that supports the existence of the summit, not this coordinate.

---

## 6. Sign-off block

Complete all that apply. A typed name and date are acceptable for the working review; the release record will carry the same entries in the CSVs.

| Role | Name | Decision | Date | Scope |
|---|---|---|---|---|
| Nepali language reviewer | | | | 4 pending names + Chamar form |
| Data / geographic reviewer | | | | 4 high-priority rows + 32 medium rows + Yalung Kang West |
| Project lead | | | | Accept the completed G2 review and authorise the G3 peaks build |

**Reviewer statement:** I have reviewed the rows named above against the quoted sources. My decisions are recorded in the companion CSV files. I understand that a `confirm` decision is what allows the data manager to change a `pending` name to `attested`, and that `review_status` remains `draft` until the full G2 review is complete.

---

## 7. What happens after sign-off

**Completed on 28 October 2026:** decisions recorded in `peaks_name_review.csv`, `peaks_geo_review.csv` and `peaks_evidence_review.csv`; master tables updated (50 peaks approved, 3 names attested); QA regenerated (1 open issue: Thulagi Chuli).

1. The data manager applies the decisions to `peaks_master.csv`, `peaks_name_review.csv`, `peaks_geo_review.csv` and `peaks_evidence_review.csv`.
2. `master_qa.json` is regenerated; the expected open issues should fall to zero.
3. The peak list moves from `draft` to the approved review state.
4. G3 starts on the **peaks layer and the non-spatial protected-area/buffer-zone reference tables**.
5. Protected-area and buffer-zone **polygons** remain deferred under D10 until DNPWC permission or another compliant source is obtained. They are not part of this packet.

---

## 8. What is not in this packet

- **DNPWC area confirmation** — deferred under D10. The current figures are published-source arithmetic, labelled as such.
- **Protected-area and buffer-zone geometry** — deferred under D10. No polygon will be generated, imported or shipped.
- **Cartographic and print QA** — G4, after the G3 build.
- **The 15 low-priority geo rows** — no action required; they are listed in `peaks_geo_review.csv`.
- **The 47 already-attested or transliterated names** — no action required; a spot-check is welcome but not a gate.
