# Peaks layer

## Features

| Feature | Description |
|---|---|
| **Peak layer** | 51 named peaks above 7,000 m — 8 main eight-thousanders + 6 official additional + 37 seven-thousanders |
| **Bilingual names** | 43 attested Devanagari names / 8 transliterated / 0 pending — never machine-translated |
| **Point symbols only** | Never polygons; three symbol classes for cartographic distinction |
| **Numbered keys** | Numbered keys for all official additional and seven-thousanders (plan §8.5); numbered keys for main peaks on dense clusters |
| **Multi-source coordinates** | Wikidata (S04), Wikipedia (S02/S15), Kathmandu Post (S03), Himalayan Database (S05) |
| **Elevation verification** | Cross-checked against official 14 eight-thousander list (2025) |

## Attestation

| Status | Count | Description |
|---|---|---|
| `attested` | 43 | Nepali name found in a reachable source (Wikipedia, Wikidata, Himalayan Database) |
| `transliterated` | 8 | No attestation found; phonetic Devanagari transliteration recorded |
| `pending` | 0 | All names resolved |

## Review status

| Status | Count |
|---|---|
| `approved` | 51 |
| `draft` | 0 |

## QA

- Label-collision analysis: 139 close pairs @z8/40px, 50 @z9/30px, 18 @z10/25px → numbered keys mandatory
- UTF-8 validation: 0 replacement characters
- Coordinate validation: all 51 peaks inside Nepal bbox (80–88°E, 26–31°N)
- Source resolution: all `source_id` values resolve in `sources.csv`
