# Data and permission request — DNPWC

**Status:** Draft. Not sent. **Deferred by D10 on 28 October 2026.** Ready to send when the geometry workstream resumes.  
**Prepared:** 27 October 2026  
**Recipient:** Department of National Parks and Wildlife Conservation (DNPWC), Babarmahal, Kathmandu  
**Email:** `info@dnpwc.gov.np`  
**Phone:** 01-5320850 · 01-5320912

This request is not on the critical path for the DNPWC-deferred v1.1 edition. See [`../v1.1-completion-ledger.md`](../v1.1-completion-ledger.md).

---

## Email subject

Request for protected-area and buffer-zone boundary data and permission to include them in a bilingual, non-commercial open-data atlas

---

## Email body

Dear Director General,

I am writing on behalf of the **Nepal Local Level Atlas** project, a bilingual (Nepali and English) reference atlas of Nepal's provinces, districts and local levels. The current edition is a non-commercial, open-data pilot covering 7 provinces, 77 districts and 753 local levels, published as printable PDF sheets and an offline web map.

We are preparing version 1.1, which will add Nepal's protected areas and buffer zones as **reference layers**. They will be shown separately from administrative boundaries, with a clear notice that they are indicative and not a legal or survey-grade boundary determination.

We would like to request the following.

### 1. Boundary data

Current boundaries for:

- **21 federal core protected areas:** 13 national parks, 6 conservation areas, 1 wildlife reserve and 1 hunting reserve;
- **14 federal buffer zones**, as a **separate layer** linked to their parent core area. The network comprises the 12 zones declared between 1996 and 2010, the Shivapuri-Nagarjun zone declared in 2016, and the Chhayanath zone declared in 2025.

Preferred formats are Esri Shapefile or GeoJSON in WGS 84 (EPSG:4326). Separate core-area and buffer-zone layers are important so that the atlas does not double-count or merge the two legal categories.

### 2. Attribute data

For each feature, where available:

- official name in Nepali and English;
- designation and legal status;
- gazettal or declaration date;
- published area in square kilometres;
- province(s) and district(s);
- parent protected area for each buffer zone;
- IUCN category, if assigned.

### 3. Recent designations

- The boundary and attributes of **Chhayanath National Park** (established 2025), including whether its core area is **843.36 km²** and its buffer zone **177.37 km²**.
- Confirmation of the current **Shey Phoksundo National Park** core area and buffer zone following the creation of Chhayanath, including whether the buffer is now **1,170.1 km²**.
- Confirmation of the composition of the **5,602 km²** buffer-zone aggregate that is widely cited: whether it covers the 12 zones declared between 1996 and 2010, and what aggregate DNPWC now uses for all buffer zones.
- Confirmation of the **Parsa buffer zone** area, which we carry as **298.2 km²** rather than the older 285.3 km².
- Confirmation of the **Bardiya buffer zone** area, which we carry as **507 km²**. Older listings give **327 km²**; please confirm whether 507 km² reflects a later extension.
- Where published figures differ, confirmation of the current area: Parsa core (637 / 627.39 / 499 km²), Chitwan (952.63 / 932 km²), Gaurishankar (2,179 km²; 2,197 km² is superseded), Khaptad (225 / 211.31 km²), Dhorpatan (1,325 / 1,012.83 km²) and Shuklaphanta (305 km² park; 399.63 km² including buffer).
- Confirmation of whether the 2020 “Coverage Area Database on Protected Areas of Nepal” (Bhadra 2077) is still current, or whether a later gazette or area table supersedes its figures for Bardiya (507 km²), Gaurishankar (2,179 km²), Parsa (627.39 km² geometry-derived; 285.3 km² buffer) and Mugu (843.50 km²).
- Notification of any other boundary or designation change after 2025.

### 4. Permission to publish

We request written permission to reproduce and redistribute the supplied geometry and attributes, with attribution, in:

- the offline web application and its downloadable data bundle;
- printable PDF sheets;
- the project documentation and source register.

The use is **non-commercial and public-interest**. We will not present the data as survey-grade, cadastral or a legal boundary determination. We will use the attribution and any usage conditions you specify.

If redistribution of the full geometry is not possible, we would welcome a discussion of alternatives, such as permission for print and online publication without a downloadable geometry file, or a simplified public version approved by DNPWC.

### 5. Attribution and conditions

Please let us know the preferred citation, attribution wording, and any conditions or restrictions that must accompany the data.

### 6. Format and contact

You may send the data by email or provide a download link. If a data-sharing agreement or a specific request form is required, please let us know and we will complete it.

We would be grateful for a response by **[date]** so that the current edition can be scheduled. If a partial response is possible sooner — for example, the core-area boundaries and attributes — that would already be very helpful.

Thank you for your work in conserving Nepal's protected areas, and for considering this request.

Yours sincerely,

**[Name]**  
**[Role / organisation]**  
**[Email]**  
**[Phone]**  
**[Project URL or repository, if applicable]**

---

## What to attach

1. A one-page project summary and a sample of the current atlas.
2. A sample of the proposed protected-area attribute schema, showing exactly which fields are requested.
3. A short statement of the intended use, licence and attribution.
4. This request as a PDF on letterhead, if available.

## Before sending

- [ ] Confirm the current Director General's name and title on `dnpwc.gov.np`.
- [ ] Confirm the current contact email and phone on the official site.
- [ ] Replace all bracketed placeholders.
- [ ] Have a Nepali speaker review the request and prepare a Nepali covering letter if preferred.
- [ ] Record the send date and any reference number in `data/reference/sources.csv`.
- [ ] Log the response, including refusals and conditions, in `docs/reference-source-audit.md`.

## If the response is partial

Ask specifically which of the following can be released:

- core-area boundaries only;
- buffer-zone boundaries only;
- attributes without geometry;
- geometry for print/online use but not download;
- permission for a simplified public version.

Record the answer before changing the scope. Do not treat a partial response as permission for the full layer.
