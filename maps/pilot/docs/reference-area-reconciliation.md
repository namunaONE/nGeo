# Protected-area and buffer-zone area reconciliation

**Status:** Working reconciliation for G2 review. Figures are sourced but not yet signed off by the data reviewer or confirmed by DNPWC.
**Date:** 28 October 2026
**Related:** [`v1.1-implementation-plan.md`](v1.1-implementation-plan.md) · [`v1.1-status.md`](v1.1-status.md) · [`../data/reference/README.md`](../data/reference/README.md)

---

## 1. Summary

The long-standing “13 buffer zones, 5,602 km²” pairing is internally inconsistent. The reconciliation below shows that **5,602 km² describes the 12 buffer zones declared between 1996 and 2010**, not all buffer zones now in force.

Three corrections close the arithmetic:

1. **Parsa buffer zone** was 285.3 km² in the draft table. The Nepal Tourism Board lists **298.2 km²**. The 12.9 km² difference accounts for almost all of the apparent gap.
2. **Shivapuri-Nagarjun buffer zone** (118.61 km²) was declared in **2016**, after the 5,602 km² aggregate was in use. It should never have been expected to fit inside that aggregate.
3. **Chhayanath National Park** was created in 2025 from Shey Phoksundo. Its core is **843.36 km²**, not the early “about 906 km²” announcement. Its buffer is **177.37 km²**, separated from Shey Phoksundo’s buffer, which falls from 1,349 km² to **1,170.1 km²**.

After these corrections the 12 original buffer zones total **5,601.67 km²**, which is **0.33 km² (0.006%) below** the official 5,602 km² aggregate. That residual is a rounding difference, subject to the Bardiya 507/327 cross-check in §2.4 and DNPWC confirmation. It is not an unresolved coverage gap.

The **2020 DNPWC-commissioned GIS report** (`S20`) provides an independent factual cross-check. It supports **Bardiya 507 km²**, records **Gaurishankar 2,179 km²**, records **Parsa 627.39 km²** as geometry-derived, and records **843.50 km²** of Shey Phoksundo in Mugu, consistent with the 843.36 km² Chhayanath transfer within rounding. Applying the Gaurishankar correction reduces the federal core total from 28,759.94 to **28,741.94 km²**. The report is not a geometry licence and does not resolve the buffer totals to the last decimal.

---

## 2. Buffer-zone arithmetic

### 2.1 The 12 buffer zones declared 1996–2010

| Buffer zone | Parent core area | Area (km²) | Source |
|---|---|---:|---|
| Chitwan | Chitwan National Park | 750.00 | S16 |
| Bardiya | Bardiya National Park | 507.00 | S02; S20 |
| Shuklaphanta | Shuklaphanta National Park | 243.50 | S16 |
| Banke | Banke National Park | 343.00 | S16 |
| Parsa | Parsa National Park | 298.20 | S16 (corrected from 285.30; S20 still lists 285.30) |
| Koshi Tappu | Koshi Tappu Wildlife Reserve | 173.50 | S02 (NTB rounds to 173) |
| Langtang | Langtang National Park | 420.00 | S16 |
| Sagarmatha | Sagarmatha National Park | 275.00 | S16 |
| Makalu Barun | Makalu Barun National Park | 830.00 | S02 |
| Khaptad | Khaptad National Park | 216.00 | S16 |
| Shey Phoksundo | Shey Phoksundo National Park | 1,170.10 | S17 |
| Chhayanath | Chhayanath National Park | 177.37 | S17 |
| Rara | Rara National Park | 198.00 | S02 |
| **Total** | **12 original zones, 13 rows after the 2025 split** | **5,601.67** | |

Published aggregate: **5,602 km²**. Difference: **−0.33 km²**.

The 2025 split does not change the total: the former Shey Phoksundo buffer of 1,349 km² is now 1,170.1 + 177.37 = **1,347.47 km²**. The 1.53 km² difference is rounding in the older figure.

### 2.2 Buffer zones added after 2010

| Buffer zone | Parent core area | Area (km²) | Declared | Source |
|---|---|---:|---|---|
| Shivapuri-Nagarjun | Shivapuri Nagarjun National Park | 118.61 | 2016 | S02 |
| **Total, all 14 rows** | | **5,720.28** | | |

### 2.3 What may be published

- The **5,602 km²** figure may be used only with the qualifier “12 buffer zones declared 1996–2010”.
- The **5,720.28 km²** figure is the sum of the 14 individual rows and covers the current network as recorded in the master table. It is **not** an official DNPWC aggregate.
- Do not describe the 5,720.28 km² figure as “official”, and do not add it to a core-area total without a dated source note.

### 2.4 Independent attribute cross-check

OpenDataNepal publishes a CSV of 20 protected areas and 12 buffer zones (`S19`, CC BY 4.0). It contains no geometry and is older than the current network, but it is useful for checking individual figures.

| Feature | Master figure | OpenDataNepal | Reading |
|---|---:|---:|---|
| Parsa core | 637 | 499 | S19 records the pre-2017 wildlife reserve. 637 is the current published national park figure; 627.39 is recorded as geometry-derived in S20. |
| Parsa buffer | 298.2 | 298 | Confirms the corrected figure within rounding. S20 lists 285.3; DNPWC confirmation required. |
| Chitwan core | 952.63 | 932 | Older alternative already listed in the README. |
| Gaurishankar core | 2,179 | 2,179 | **Confirmed.** The master was corrected from 2,197 to 2,179 using S19 and S20. |
| Bardiya buffer | 507 | 327 | Material difference. S20 records 507.00 km², confirming the figure used here; 327 appears to be the original 1996 declaration. DNPWC must confirm the extension. |
| Chitwan buffer | 750 | 750 | Agrees. |
| Banke buffer | 343 | 344 | Rounding. |
| Shuklaphanta buffer | 243.5 | 244 | Rounding. |
| Koshi Tappu buffer | 173.5 | 173 | Rounding; NTB also rounds to 173. |
| Shey Phoksundo buffer | 1,170.1 | 1,349 | S19 predates the 2025 Chhayanath split. |

The 12 S19 buffer rows sum to **5,424 km²**, 178 km² below the master total. Almost all of that difference is Bardiya (180 km²); the remaining items are rounding. S19 therefore supports the Parsa buffer correction but does not, on its own, prove the current Bardiya figure. The 2020 DNPWC-commissioned report (`S20`) supplies that confirmation.

### 2.5 2020 DNPWC-commissioned GIS report (`S20`)

The report **“Coverage Area Database on Protected Areas of Nepal by Province, District, Palika and Ward Level (2077)”** was submitted to DNPWC in Bhadra 2077 (September 2020) by a GIS consultant. It is a 47-page PDF with province, district, palika and ward tables. It contains no distributable geometry and carries no open-geometry licence.

| Finding | S20 figure | Effect on the master |
|---|---:|---|
| Bardiya buffer | 507.00 km² | Confirms the 507 km² row; the 327 km² OpenDataNepal figure is treated as the older 1996 declaration. |
| Gaurishankar core | 2,179 km² | Master corrected from 2,197 to 2,179; federal core falls to 28,741.94 km². |
| Parsa core | 627.39 km² (geometry-derived) | Recorded in `area_geom_km2`; the published figure remains 637 km². |
| Parsa buffer | 285.3 km² (gazette table) | Conflicts with the 298.2 km² NTB figure; the master keeps 298.2 and records the conflict for DNPWC. |
| Shey Phoksundo in Mugu | 843.50 km² | Supports the 843.36 km² Chhayanath transfer within 0.14 km² rounding. |
| Pre-Chhayanath core network | 28,731.97 km² | A 2020 baseline, not the current 21-area total. |
| Pre-Chhayanath buffer network | 5,687.78 km² | A 2020 baseline; it is not the 5,602 km² 12-zone aggregate and not the current 14-row total. |

The report's 2020 totals cover the network before Chhayanath and Badimalika, so they are **not** directly comparable with the current master totals. They are used only to cross-check individual rows. The report does not resolve the Parsa buffer 298.2/285.3 difference; that remains a DNPWC confirmation item.

---

## 3. Shey Phoksundo and Chhayanath

| Feature | Before 2025 | After 2025 | Source |
|---|---:|---:|---|
| Shey Phoksundo core | 3,555.00 | 2,711.64 (recorded as 2,712) | S02; S17 |
| Chhayanath core | — | 843.36 | S17 |
| **Core total** | **3,555.00** | **3,555.00** | |
| Shey Phoksundo buffer | 1,349.00 | 1,170.10 | S02; S17 |
| Chhayanath buffer | — | 177.37 | S17 |
| **Buffer total** | **1,349.00** | **1,347.47** | |

The arithmetic closes the core area exactly: 2,711.64 + 843.36 = 3,555.00. The rounded master figure of 2,712 is retained. The 2020 report (`S20`) records **843.50 km²** of Shey Phoksundo in Mugu, which supports the 843.36 km² transfer within 0.14 km² rounding.

The 2025 government decision transferred **843.36 km²** of Shey Phoksundo to the new park. Several early reports said “about 906 km²”. The 906 figure is not compatible with the 2,712 km² post-transfer figure and is retained only as an announcement note in `protected_areas_master.csv`.

**Boundary caveat:** neither park has a boundary polygon. The core and buffer figures are published areas, not measured geometry. The Mugu/Dolpa split shown in the master table is an attribute-level reconstruction and must not be drawn as a boundary.

---

## 4. Updated totals

| Measure | Value | Notes |
|---|---:|---|
| Federal core areas (21) | **28,741.94 km²** | Chhayanath 843.36; Gaurishankar corrected to 2,179 |
| Provincial feature (1) | **498.40 km²** | Badimalika–Ramaroshan; separate, not federal |
| Buffer zones (14 rows) | **5,720.28 km²** | 12 original zones + Shivapuri-Nagarjun + Chhayanath split |
| Federal core + all buffers | **34,462.22 km²** | Attribute-only sum; no geometry |
| Federal core + provincial | **29,240.34 km²** | Excludes buffers |
| All three layers | **34,960.62 km²** | Attribute-only sum; not an official figure |

The earlier federal core total of 28,822.58 km² included the 906 km² Chhayanath announcement. The current total is 80.64 km² lower after the Chhayanath correction (843.36) and the Gaurishankar correction (2,179).

---

## 5. Residual issues

1. **DNPWC confirmation is still required** for every area, the Chhayanath carve-out and the buffer split. The figures above are published-source arithmetic, not a gazette transcription. The 2020 report (`S20`) is a 2020 baseline, not a current gazette.
2. **Parsa core area:** the master uses **637 km²** as the published national-park figure and records **627.39 km²** as geometry-derived in `S20`; **499 km²** is the pre-2017 wildlife-reserve figure. The distinction is resolved for publication, but DNPWC should confirm which figure is current.
3. **Parsa buffer:** the master uses **298.2 km²** from the Nepal Tourism Board (`S16`); the 2020 report (`S20`) lists **285.3 km²**. DNPWC must confirm which is current.
4. **Koshi Tappu buffer** is carried at 173.5 km²; NTB rounds it to 173 km². Using the rounded figure would move the 12-zone total to 5,601.17 km², a −0.83 km² residual. The difference is rounding, not a coverage gap.
5. **Chhayanath buffer** is recorded as a separate zone on the strength of a government-decision news report (S17). A gazette or DNPWC table is still needed before the 14-zone count is called official. The 2020 report's **843.50 km²** Mugu figure supports the core transfer within rounding.
6. **Shey Phoksundo buffer** fell by 1.53 km² more than the Chhayanath figure accounts for. This is treated as rounding; confirm against the gazette.
7. **Bardiya buffer is 507 km² in the master table, and the 2020 report (`S20`) records 507.00 km².** OpenDataNepal lists 327 km², apparently the original 1996 declaration. DNPWC must confirm whether 507 is a later extension. If 327 is current, the 12-zone total falls by 180 km² and the 5,602 aggregate needs re-examination.
8. **No geometry** exists for any of these areas. The reconciliation is attribute-only and must not be used to draw, clip or measure polygons. The `area_geom_km2` value for Parsa is a report-derived cross-check, not project geometry.

---

## 6. Publication wording

For the web and print editions, until DNPWC confirms the table:

> Protected-area and buffer-zone areas are published figures compiled from government and secondary sources. They are not survey measurements and do not define legal boundaries. The 5,602 km² buffer-zone aggregate covers the 12 zones declared between 1996 and 2010; later zones are listed separately.

In Nepali:

> संरक्षित क्षेत्र र मध्यवर्ती क्षेत्रको क्षेत्रफल सरकारी तथा दोस्रो स्रोतबाट संकलित प्रकाशित अङ्क हुन्। यी सर्वेक्षण मापन वा कानुनी सीमा होइनन्। ५,६०२ वर्ग किमीको मध्यवर्ती क्षेत्र जोड १९९६–२०१० मा घोषित १२ क्षेत्रमा लागू हुन्छ; पछि थपिएका क्षेत्र अलग सूचीबद्ध छन्।

---

## 7. Sources used

| Id | Source | Use |
|---|---|---|
| S02 | Wikipedia, protected areas list | Cross-check; old figures |
| S12 | Tourism Mail, Chhayanath establishment | Early ~906 km² announcement |
| S16 | Nepal Tourism Board, National Parks of Nepal | Nine buffer-zone figures; Parsa correction |
| S17 | The Rising Nepal, 5 September 2025 | 843.36 km² carve-out; 177.37 / 1,170.1 buffer split |
| S19 | OpenDataNepal, protected areas CSV | Independent attribute cross-check; older figures; no geometry |
| S20 | 2020 DNPWC-commissioned GIS report | Bardiya 507; Gaurishankar 2,179; Parsa 627.39; 843.50 in Mugu; 2020 baselines |

All six are recorded in [`../data/reference/sources.csv`](../data/reference/sources.csv). S12 and S17 are copyright news sources used for facts only; S19 is CC BY 4.0 and attribute-only; S20 is a government-commissioned report used for facts only and carries no geometry licence.
