# Nepal Local Level Atlas

A cartographic atlas of Nepal's **753 local units (palikas)** in **77 districts** and **7 provinces**, built from the three supplied source files and open administrative boundaries.

## Main file

**`Nepal_Local_Level_Atlas.pdf`** — 10 pages, A3 landscape, vector PDF with selectable text.

| Page | Content |
|---|---|
| 1 | Cover |
| 2 | National overview: 7 provinces, 77 districts, numbered province markers |
| 3 | Koshi Province — 137 units, 14 districts |
| 4 | Madhesh Province — 136 units, 8 district panels |
| 5 | Bagmati Province — 119 units, 13 districts |
| 6 | Gandaki Province — 85 units, 11 districts |
| 7 | Lumbini Province — 109 units, 12 districts |
| 8 | Karnali Province — 79 units, 10 districts |
| 9 | Sudurpashchim Province — 88 units, 9 districts |
| 10 | About the atlas, code structure and province summary |

Each local-unit label shows the official five-digit code and the local-unit name. The atlas includes every one of the 753 codes exactly once.

## Other files

- `png/` — the same 10 pages as 170 dpi PNG images.
- `nepal_local_levels_coded.geojson` — 753 local-unit polygons with code, province, district, English name, Nepali name and unit type.
- `nepal_local_levels_codes.csv` — the same 753 records in a flat table (UTF-8 with BOM, opens correctly in Excel).

## Data sources

- **Codes and official names:** `1695378470_83.xls`, sheets `pradesh_code`, `district_code`, `localunit_code`.
- **Cross-check table:** `1695378470_68.pdf` — 15-page print of the same 753-row table.
- **Source map reference:** `1695378470_30.pdf` — seven province maps.
- **Boundaries:** Open Knowledge Nepal, `localboundaries` (CC BY 4.0), <https://localboundries.oknp.org>.

## Corrections made

The supplied map PDF contains 730 unique code labels for 753 units: 23 units are unlabelled and two labels are duplicated. The atlas restores the missing labels and labels each unit once:

- 14 missing in Province 2, 6 in Bagmati, 1 in Gandaki, 2 in Lumbini.
- Duplicated labels: `40808` Binayi Tribeni (Gandaki) and `51201` Bansgadhi (Lumbini).

Those two units are genuinely split into two polygon parts; the parts have been merged and each unit is labelled once.

## Map specification

- Projection: Albers equal-area conic, standard parallels 27°N and 30°N, central meridian 84.1°E.
- Page size: A3 landscape (420 × 297 mm).
- Unit boundaries are generalised slightly for legibility at A3.
- Text is embedded as TrueType and remains selectable/searchable in the PDF.

## Validation

Run `../validate_outputs.py` to verify the 753 features, unique codes, 10 PDF pages and code coverage on each province page.
