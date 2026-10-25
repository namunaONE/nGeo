# Daily gap & source watch

A zero-dependency Node watcher plus a scheduled GitHub Actions workflow that
runs **every day at 09:00 Asia/Kathmandu (03:15 UTC)** and answers one
question: *has anything upstream moved, and can any of our unverified gaps now
be closed?*

```bash
node tool/daily_watch/watch.cjs     # roster & provenance watch (local run)
node tool/daily_watch/hunt.cjs      # palika-website hunt (local run)
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
| 7 | Every palika website recorded in the dataset (`hunt.cjs`) | per-site | Reachability, redirects, and each site's own `<title>` Devanagari name: a third attestation vote and candidates for the 22 null `nameNe`. |

`mofaga/mofaga_all.json` is a manual harvest with no public URL; the watch
reports it as unmapped, never as drift.

## Exit-code contract

| Exit | Meaning | Workflow reaction |
|------|---------|-------------------|
| 0 | Clean or informational-only differences | Report uploaded as an artifact; nothing else happens |
| 1 | **Actionable drift**: a pinned input changed; the fresh CBS roster disagrees with our structure; a previously-uncoded palika became resolvable; or the hunt surfaced a plausible Devanagari candidate for a null `nameNe` | An issue labelled `data` is filed (or commented on, if one is already open) with the report body |
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

## The hunt phase (palika websites) — `hunt.cjs`

Every day after the roster watch, the hunt probes every palika website
recorded in the dataset (371 of 753 currently carry one; 8 concurrent, one
request per site, 12 s timeout, identified `User-Agent`, only the document
head is read) and mines each reachable site's `<title>` / `og:site_name` for
Devanagari runs. A palika's own website is the most authoritative public
source for **its own** name, so this yields:

1. a **third Devanagari attestation vote** (after abinrimal and sagautam5),
2. **candidate `nameNe`** for the 22 palikas whose Devanagari name is still
   null — filtered against the district's Devanagari name and sibling palika
   names to reject menu/logo bleed; each candidate cites its exact source
   line and URL, and exits 1 (→ GitHub issue) because it is actionable,
3. **liveness signals** for the `website` field: dead sites and redirects are
   reported as informational, never as name evidence.

Unreachable sites say nothing (absence is not drift). A `<title>` candidate is
review material for the merge pipeline — the repo's "never transliterated"
policy stands, and one website title alone is a strong candidate, not a
doubly-attested fact.

## Where the hunt expands next (source acquisition roadmap)

Ranked by value-per-effort for closing gaps and adding features. Each becomes
a new phase in this workflow — one script per source family, same exit-code
contract, same "report everything, fail only for actionable findings" rule.

| Priority | Source family | Closes / adds | Cadence |
|---|---|---|---|
| 1 | **NSO/CBS census 2021 ward tables** (via the NSO census data portal and Nepal in Data) | ward existence + ward population for all 6,743 wards; a second attestation for the 8 missing ward counts | fetch monthly, verify daily |
| 2 | **Nepal Post official directory** (`nepalpost.gov.np` district pages) | 5-digit palika codes + 7-digit ward PO codes; fills 279 empty `zipCodes`; second code attestation | daily |
| 3 | **National Geoportal local-units layer** (Survey Department; needs one manual inspection) | official boundary geometry → v2.8 program, plus `lat/lng` for the 27 missing | weekly |
| 4 | **MoFAGA office directory & LGCDP "Local Level Details"** (LGCDP-II is closed — verify any page against a live MoFAGA reference before pinning) | fills 382 null `website`/`email`/`phone`; ward names via palika profiles | monthly |
| 5 | **OSM admin_level 7/9** | palika + ward geometry centroids; coordinates for the 27 missing | weekly |
| 6 | **BIPAD portal** (`bipadportal.gov.np` — disaster/incident data localized to all 753 palikas) | new feature: incident/disaster joins; structural liveness (a palika that reports incidents exists) | monthly |
| 7 | **Election Commission ward-level data** | independent attestation of ward counts and palika names/types | once per electoral cycle |
| 8 | **Nepal Gazette / Law Commission + restructuring news** | rename/split/merge events — the triggers that turn the dataset into a versioned time series | daily (research-grade) |

### Codebase improvement loop (senior-dev discipline)

- Every hunt finding becomes a **GitHub issue with a reproduction** (source
  URL + extracted value + our value), never a direct `data/` edit.
- Adjudication lands in the **merge pipeline** with its decision recorded
  (`decisions_manual.json`), then `tool/generate.dart` regenerates every
  artifact and the CI drift gates prove the tree is byte-reproducible.
- Each closed gap moves a counter in the coverage stats — the daily report
  should show monotone improvement (9 uncoded → 0, 22 nameNe → 0,
  27 coords → 0, 8 wards → 0, 196 single-source → shrinking).
- Schema additions (ward names, populations, geometry) bump the package minor
  version and go through the existing golden-test + `CHANGELOG.md` gates.

## Extending the watch

Update `baseline.json` only after adjudicating a change in a merge review;
baselines are informational, not gates. New source families get a new
`tool/daily_watch/<family>.cjs` script, one workflow step, one issue marker —
and the same two design rules: absence is not drift, and the hunt never
writes the dataset.
