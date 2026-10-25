# Daily gap & source watch

A zero-dependency Node script (`watch.cjs`) plus a scheduled GitHub Actions
workflow that runs **every day at 09:00 Asia/Kathmandu (03:15 UTC)** and
answers one question: *has anything upstream moved, and can any of our
unverified gaps now be closed?*

```bash
node tool/daily_watch/watch.cjs     # local run, same behaviour
```

## What it checks, against what

| # | Source | Licence | What is compared |
|---|--------|---------|------------------|
| 1 | Our own `data/nepal_local_levels.json` + `data/PROVENANCE.sha256` | — | The gap snapshot itself: uncoded palikas, missing Devanagari names, missing coordinates, missing ward counts, single-source codes. This is the daily "list of unverified local bodies". |
| 2 | The five pinned upstream inputs (`abinrimal`, `sagautam5`, `nepali-geo-pro-max`, `open-admin-data`, CBS via opendatanepal CKAN) at their documented URLs | MIT / CC-BY-4.0 / CC-BY | SHA-256 and byte length of every mapped file against `data/PROVENANCE.sha256`. **This closes the reproducibility gap noted in `data/SOURCES.md`:** upstream drift is now detected by CI, not only by the machine holding `data/_raw/`. |
| 3 | Fresh CBS/NSO geographical codes (opendatanepal CKAN `cbs_local_bodies.csv`) | CC-BY | Per-district row counts vs. our structure; our 744 codes still present; and — the payoff — whether any of the **9 uncoded palikas** has become uniquely resolvable (normalized-name Levenshtein ≤ 2, unique best, or forced by elimination), using the same refusal rules as `resolve_code_tiers.dart`. |
| 4 | geoBoundaries NPL ADM3 metadata API | CC-BY-SA 4.0 | `admUnitCount` (baseline: 774 — known ≠ 753) and `boundaryYearRepresented`. |
| 5 | Open Knowledge Nepal `localboundaries` source GeoJSON | CC-BY 4.0 | Feature count (baseline: 777 features / 755 local levels — known ≠ 753). |
| 6 | OpenStreetMap via Nominatim + Overpass | ODbL | Count of `admin_level=7` (palika) relations inside Nepal. OSM Nepal also maps `admin_level=9` wards — the only public ward-boundary source today. |

`mofaga/mofaga_all.json` is a manual harvest with no public URL; the watch
reports it as unmapped, never as drift.

## Exit-code contract

| Exit | Meaning | Workflow reaction |
|------|---------|-------------------|
| 0 | Clean or informational-only differences | Report uploaded as an artifact; nothing else happens |
| 1 | **Actionable drift**: a pinned input changed; the fresh CBS roster disagrees with our structure; or a previously-uncoded palika became resolvable | An issue labelled `data` is filed (or commented on, if one is already open) with the report body |
| 2 | Configuration error (dataset/manifest unreadable) | Fails the job visibly |

Two design rules carried over from the `provenance-watch` lesson in
`data/SOURCES.md`:

- **Absence is not drift.** Unreachable sources are reported as unreachable;
  nothing is inferred from them. A flaky network can never file an issue.
- **The watch never writes the dataset.** A "resolvable" finding is an
  invitation to run the merge pipeline, human-adjudicated — never a
  hand-edit of `lib/src/nepal_data.dart`.

## The 9 uncoded palikas, and what the fresh-CBS check is looking for

`cbsCode == null` is not an omission but a refusal: in each of these districts
the CBS roster and our roster disagree enough that assignment would be a
permutation guess.

| Palika | District | Free codes in the district (inferred) | Known context |
|--------|----------|----------------------------------------|---------------|
| Mapya Dudhkoshi | Solukhumbu (103) | 10304, 10305 | Nepal Post's office list already carries 10304 for Mapya Dudhkoshi R.Mun. — awaiting the CBS roster catching up |
| Thulung Dudhkoshi | Solukhumbu (103) | 10304, 10305 | Same list carries 10305 for Thulung Dudhkoshi R.Mun. |
| Gangadev | Rolpa (502) | 50203, 50204, 50209 | — |
| Paribartan | Rolpa (502) | 50203, 50204, 50209 | — |
| Sunil Smriti | Rolpa (502) | 50203, 50204, 50209 | Renamed from Suwarnawati (Subarnawati) rural municipality; rosters still disagree |
| Bheri | Jajarkot (607) | 60706, 60707 | — |
| Nalagad | Jajarkot (607) | 60706, 60707 | Also spelled "Nalgad" in several sources |
| Jagannath | Bajura (701) | 70105, 70107 | — |
| Khaptad Chhededaha | Bajura (701) | 70105, 70107 | Also spelled "Chhededaha" / "Chhede Daha" |

The "free codes" are the PDDPP codes in each district's 01–N run that none of
the palika's district-mates claim; they are inference, not fact. When the
fresh CBS harvest starts naming rows that match these palikas within the
merge's own matching rules, the watch reports the exact candidate pairing and
exits 1.

## Extending the watch (recommended next sources)

- **Nepal Post postal-code directory** (`nepalpost.gov.np`): district pages
  publish the federal-structure codes; the 7-digit ward post-office codes are
  `PDDPP + ward`, making it both a name and a ward-existence attestation.
- **National Geoportal (Survey Department)** — "Administrative Boundary:
  Nepal Local Units" layer: the official geometry source; the repo's boundary
  rule (v2.7.2) requires exactly this before polygons may ship.
- **Wikidata/Wikipedia**: useful tertiary votes for the 22 missing Devanagari
  names, never primary.
- **News/gazette monitoring** for the restructuring debate ahead of the 2027
  local elections: any structural change must bump `meta.totals`, the golden
  tests and the package version together.

Update `baseline.json` only after adjudicating a change in a merge review;
baselines are informational, not gates.
