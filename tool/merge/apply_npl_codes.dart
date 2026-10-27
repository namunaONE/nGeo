// tool/merge/apply_npl_codes.dart
//
// Step 6 of the pipeline: apply the Government of Nepal administrative code
// table (data/_raw/npl-codes/, the 1695378470_83.xls workbook, exported to
// UTF-8 TSVs by tool/export_npl_codes.ps1) to the dataset.
//
// What this step contributes (and what it deliberately does not)
// ---------------------------------------------------------------
// The workbook attests the PDDPP code of every one of the 753 local units
// directly (sheet localunit_code), plus the state codes (sheet pradesh_code)
// and a district register (sheet district_code, whose S.N. column is a
// SERIAL 1..77, NOT a code - district PDD codes are derived from palika-code
// prefixes instead, then cross-checked against our district cbsCodes).
//
// The attestations are treated as a government DIRECTORY:
//
//   - a code the directory attests is applied at the singleSource tier
//     (cbsCodeVerified stays false). The verified tier remains exclusively
//     doubly-attested (postal-2025 + CBS); a directory attestation never
//     promotes anything.
//   - existing dataset values are never overwritten. Names are not touched
//     at all: name variants ("Bheri" vs the directory's updated "Bheri
//     Malika") are REPORTED, and adopting them needs a Gazette confirmation
//     (doc/REVIEW-codes.md).
//   - nameNe is filled ONLY where it is null, from the directory's Unicode
//     Devanagari column (sheets 1-2 carry legacy Preeti garble and are read
//     only for their English/code columns), with nameNeVerified=false.
//   - every code applied here is appended to the hand-curated code
//     adjudications ledger (data/_stage/code_adjudications.json) so
//     tool/merge/resolve_code_tiers.dart reserves it on future full runs.
//
// Gates (any failure exits non-zero WITHOUT writing):
//   0. targeted provenance: data/PROVENANCE.sha256 must be well-formed and
//      every npl-codes/* pin present and byte-identical, with no unpinned
//      file sitting in data/_raw/npl-codes/. (This step consumes only the
//      npl-codes sources plus the dataset, so it does not demand the rest of
//      data/_raw the way the shared verifyProvenance() gate does.)
//   1. structural asserts on the three TSVs (counts, serial contiguity,
//      PDDPP pattern, uniqueness, one PDD per sheet-3 district).
//   2. dataset agreement: province cbsCodes == {1..7}; derived PDD set ==
//      our district cbsCode set; every district name in both district
//      registers resolves (via canonDistrict + paren folds) to one of our
//      districts, whose cbsCode equals the derived PDD.
//   3. code-primary join: every coded palika's code must identify exactly
//      one directory row, sitting in that palika's own district. Name and
//      type agreement is REPORTED, never enforced.
//   4. uncoded resolution: a district with uncoded palikas must have exactly
//      one uncoded palika and exactly one unclaimed directory row, in the
//      same district, with name affinity (normalized containment or
//      Levenshtein <= 2). Applied as singleSource + ledger entry.
//   5. nameNe: every palika with null nameNe must join by code; after the
//      step zero nulls remain.
//
// Outputs (written only after every gate passes; --dry-run writes only the
// evidence/report files):
//   - data/nepal_local_levels.json         (codes + nameNe fills)
//   - data/_stage/code_adjudications.json  (new entries appended)
//   - data/_stage/npl_codes.json           (this run's evidence)
//   - doc/_apply-npl-codes-raw.txt         (full join/fill report)
//
// Idempotent: a second run finds nothing unclaimed and no null nameNe left,
// re-validates the join, and writes identical facts.
//
// Usage (from the package root):
//   dart run tool/merge/apply_npl_codes.dart            # apply
//   dart run tool/merge/apply_npl_codes.dart --dry-run  # report only

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'common.dart';

const _xlsName = '1695378470_83.xls';
const _tsvs = ['pradesh_code.tsv', 'district_code.tsv', 'localunit_code.tsv'];
const _ledgerPath = 'data/_stage/code_adjudications.json';
const _evidencePath = 'data/_stage/npl_codes.json';
const _reportPath = 'doc/_apply-npl-codes-raw.txt';

/// Sheet-3 district spellings that canonDistrict does not fold: the
/// parenthesized spellings of the 2017 splits. NEVER run stripParens() over
/// district names here - "Rukum (East)" and "Rukum (West)" would collapse
/// onto each other and silently mis-scope half of Rukum.
const _parenFolds = {
  'nawalparasi (east)': 'nawalpur',
  'nawalparasi (west)': 'nawalparasi west',
  'rukum (east)': 'rukum east',
  'rukum (west)': 'rukum west',
};

String _canonXlsDistrict(String raw) {
  final n = canonDistrict(raw);
  return _parenFolds[n] ?? n;
}

/// Normalized comparison key for a directory English name: [normCbsKey]
/// strips the type suffix, but the directory also writes an "Urban"
/// qualifier ("Phungling Urban Municipality") that ours never carries.
/// Drop it for comparison only - never for display or storage.
String _normXlsName(String raw) {
  var s = normCbsKey(raw);
  if (s.endsWith('urban')) {
    s = s.substring(0, s.length - 'urban'.length);
  }
  return s;
}

/// Canonical CBS type suffix (from common.dart) -> our dataset type value.
const _ourTypeByCbsCanonical = {
  'metropolitan city': 'metropolitan',
  'sub-metropolitan city': 'subMetropolitan',
  'municipality': 'municipality',
  'rural municipality': 'ruralMunicipality',
};

Never _fail(String message) {
  stderr.writeln('APPLY_NPL_CODES FAILED: $message');
  exit(1);
}

/// One parsed row of the localunit_code sheet.
typedef _Unit = ({String district, String en, String ne, int sn});

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');
  final out = StringBuffer();
  out.writeln('=' * 78);
  out.writeln('APPLY NPL-CODES DIRECTORY ATTESTATIONS');
  out.writeln('generated: ${DateTime.now().toUtc().toIso8601String()}');
  out.writeln('dry-run: $dryRun');
  out.writeln('=' * 78);

  // ---- Gate 0: targeted provenance ----------------------------------------
  final contract = auditProvenance(manifestOnly: true);
  if (contract.status == ProvenanceStatus.manifestInvalid) {
    stderr.writeln('PROVENANCE MANIFEST INVALID - refusing to run.');
    for (final p in contract.problems) {
      stderr.writeln('  $p');
    }
    exit(1);
  }

  final dir = Directory('data/_raw/npl-codes');
  if (!dir.existsSync()) {
    _fail(
      'data/_raw/npl-codes/ is not here. Vendor $_xlsName into it and run '
      'tool/export_npl_codes.ps1 (see data/SOURCES.md).',
    );
  }

  final manifestRe = RegExp(r'^([0-9A-Fa-f]{64})\s+(\d+)\s+(\S+)\s*$');
  final pins = <String, ({String hash, int size})>{};
  for (final line in File('data/PROVENANCE.sha256').readAsLinesSync()) {
    if (line.trim().isEmpty) continue;
    final m = manifestRe.firstMatch(line);
    if (m == null) continue; // contract already validated above
    final rel = m.group(3)!;
    if (rel.startsWith('npl-codes/')) {
      pins[rel] = (
        hash: m.group(1)!.toUpperCase(),
        size: int.parse(m.group(2)!),
      );
    }
  }

  final problems = <String>[];
  if (!pins.containsKey('npl-codes/$_xlsName')) {
    problems.add('the manifest does not pin npl-codes/$_xlsName');
  }
  for (final t in _tsvs) {
    if (!pins.containsKey('npl-codes/$t')) {
      problems.add(
        'the manifest does not pin npl-codes/$t (run '
        'tool/export_npl_codes.ps1, then pin the result)',
      );
    }
  }
  for (final entry in pins.entries) {
    final f = File('data/_raw/${entry.key}');
    if (!f.existsSync()) {
      problems.add('MISSING: data/_raw/${entry.key} (pinned, not on disk)');
      continue;
    }
    final bytes = f.readAsBytesSync();
    final got = sha256.convert(bytes).toString().toUpperCase();
    if (got != entry.value.hash) {
      problems.add(
        'MISMATCH: data/_raw/${entry.key} '
        '(manifest ${entry.value.hash.substring(0, 16)}… != disk '
        '${got.substring(0, 16)}…)',
      );
    } else if (bytes.length != entry.value.size) {
      problems.add('SIZE-DRIFT: data/_raw/${entry.key}');
    }
  }
  for (final entity in dir.listSync()) {
    if (entity is! File) continue;
    final name = entity.uri.pathSegments.last;
    if (!pins.containsKey('npl-codes/$name')) {
      problems.add(
        'UNPINNED: data/_raw/npl-codes/$name exists but is not in the '
        'manifest - pin it or remove it',
      );
    }
  }
  if (problems.isNotEmpty) {
    stderr.writeln('NPL-CODES PROVENANCE CHECK FAILED - refusing to run.');
    for (final p in problems) {
      stderr.writeln('  $p');
    }
    exit(1);
  }
  out.writeln('provenance: ${pins.length} npl-codes pins verified byte-exact');

  // ---- Gate 1: parse the three TSVs ----------------------------------------
  List<List<String>> loadTsv(String path) {
    final rows = <List<String>>[];
    for (final line in splitCsvLines(File(path).readAsStringSync())) {
      if (line.trim().isEmpty) continue;
      final cells = line.split('\t');
      while (cells.isNotEmpty && cells.last.trim().isEmpty) {
        cells.removeLast();
      }
      rows.add(cells);
    }
    return rows;
  }

  const tsvDir = 'data/_raw/npl-codes';

  // Pradesh sheet data rows: `<blank><blank>State N <garbled><code 1..7>`.
  final pradeshRows = loadTsv('$tsvDir/pradesh_code.tsv')
      .where((r) => r.length >= 5 && RegExp(r'^[1-7]$').hasMatch(r[4].trim()))
      .toList();
  // District sheet data rows: `<S.N. 1..77><NAME><garbled ne><PDD Code>`.
  // S.N. is a SERIAL, not a code; the register's own PDD code sits in the
  // last column and is cross-checked below against the PDD prefixes derived
  // from the local-unit sheet and against our district cbsCodes.
  final districtRows = loadTsv('$tsvDir/district_code.tsv')
      .where((r) => r.length >= 4 && RegExp(r'^\d+$').hasMatch(r[0].trim()))
      .toList();
  // Local-unit sheet data rows: `<S_N><District><English><Nepali><code>`.
  final unitRows = loadTsv('$tsvDir/localunit_code.tsv')
      .where((r) => r.length >= 5 && RegExp(r'^\d+$').hasMatch(r[0].trim()))
      .toList();

  void check(bool cond, String message) {
    if (!cond) _fail('structural assert failed: $message');
    out.writeln('  ok: $message');
  }

  check(
    pradeshRows.length == 7,
    'pradesh rows == 7 (got ${pradeshRows.length})',
  );
  final stateCodes = pradeshRows.map((r) => int.parse(r[4].trim())).toSet();
  check(
    stateCodes.length == 7 &&
        stateCodes.containsAll(const [1, 2, 3, 4, 5, 6, 7]),
    'state codes are exactly 1..7',
  );

  check(
    districtRows.length == 77,
    'district rows == 77 (got ${districtRows.length})',
  );
  for (var i = 0; i < districtRows.length; i++) {
    if (int.parse(districtRows[i][0].trim()) != i + 1) {
      _fail(
        'district sheet S.N. is not the serial 1..77 at data row ${i + 1} '
        '(got ${districtRows[i][0]}) - the register shifted',
      );
    }
  }
  check(true, 'district sheet S.N. is the serial 1..77 in order');
  final xlsDistrictNames = districtRows.map((r) => r[1].trim()).toList();
  check(
    xlsDistrictNames.toSet().length == 77,
    'district register names distinct (77)',
  );

  // The register's PDD Code column: exactly one per district name, every
  // value shaped like a district code (P = province 1..7, DD = 01..99).
  final sheet2Pdd = <String, String>{};
  for (final r in districtRows) {
    final name = r[1].trim();
    final pdd = r[3].trim();
    if (!RegExp(r'^[1-7]\d{2}$').hasMatch(pdd)) {
      _fail('district sheet Code "$pdd" ($name) is not a PDD code');
    }
    final prior = sheet2Pdd[name];
    if (prior != null && prior != pdd) {
      _fail('district sheet lists "$name" under two codes ($prior, $pdd)');
    }
    sheet2Pdd[name] = pdd;
  }
  check(
    sheet2Pdd.length == 77,
    'district sheet Code column holds 77 distinct PDD codes',
  );

  check(
    unitRows.length == 753,
    'local-unit rows == 753 (got ${unitRows.length})',
  );
  for (var i = 0; i < unitRows.length; i++) {
    if (int.parse(unitRows[i][0].trim()) != i + 1) {
      _fail(
        'local-unit sheet S_N is not the serial 1..753 at data row '
        '${i + 1} (got ${unitRows[i][0]}) - the register shifted',
      );
    }
  }
  check(true, 'local-unit sheet S_N is the serial 1..753 in order');

  final units = <String, _Unit>{};
  final pddByXlsDistrict = <String, String>{};
  for (final r in unitRows) {
    final code = r[4].trim();
    if (!RegExp(r'^[1-7]\d{4}$').hasMatch(code)) {
      _fail('local-unit code "$code" is not a PDDPP code');
    }
    if (units.containsKey(code)) {
      _fail('local-unit code $code appears twice in the register');
    }
    final district = r[1].trim();
    final en = r[2].trim();
    // Collapse whitespace runs and trim: the spreadsheet wraps long
    // Devanagari cells and pads some with stray spaces ("लिम्चुङबुङ  गाउँपालिका").
    // Whitespace hygiene only - the characters are kept verbatim.
    final ne = r[3].trim().replaceAll(RegExp(r'\s+'), ' ');
    if (district.isEmpty || en.isEmpty) {
      _fail('local-unit row $code has an empty district or English name');
    }
    if (!devaRegex.hasMatch(ne)) {
      _fail('local-unit row $code has no Devanagari name (column broken?)');
    }
    units[code] = (district: district, en: en, ne: ne, sn: int.parse(r[0]));
    final pdd = code.substring(0, 3);
    final known = pddByXlsDistrict[district];
    if (known == null) {
      pddByXlsDistrict[district] = pdd;
    } else if (known != pdd) {
      _fail(
        'sheet-3 district "$district" maps to two PDD prefixes '
        '($known, $pdd)',
      );
    }
  }
  check(
    pddByXlsDistrict.length == 77,
    'each sheet-3 district maps to exactly one PDD (77 distinct)',
  );
  // The two registers must agree: sheet-2's Code column and the PDD
  // prefixes its own local-unit rows carry are the same 77 codes.
  final sheet2CodeSet = sheet2Pdd.values.toSet();
  check(
    sheet2CodeSet.length == 77 &&
        sheet2CodeSet.containsAll(pddByXlsDistrict.values),
    'district sheet Code set == PDD set derived from local-unit prefixes '
    '(77/77)',
  );

  // ---- Gate 2: agreement with our dataset ----------------------------------
  final levelsFile = File('data/nepal_local_levels.json');
  final levelsJson =
      jsonDecode(levelsFile.readAsStringSync()) as Map<String, dynamic>;
  final provinces =
      (levelsJson['provinces'] as List).cast<Map<String, dynamic>>();

  final ourDistrictByCanon = <String, Map<String, dynamic>>{};
  var palikaCount = 0;
  for (final province in provinces) {
    for (final district in (province['districts'] as List)) {
      final dmap = district as Map<String, dynamic>;
      final canon = canonDistrict(dmap['name'] as String);
      if (ourDistrictByCanon.containsKey(canon)) {
        _fail('two of our districts canon to "$canon"');
      }
      ourDistrictByCanon[canon] = dmap;
      palikaCount += (dmap['localBodies'] as List).length;
    }
  }
  check(provinces.length == 7, 'our provinces == 7');
  check(ourDistrictByCanon.length == 77, 'our districts == 77');
  check(palikaCount == 753, 'our local bodies == 753');

  final ourProvinceCodes = <int>{};
  for (final province in provinces) {
    final c = province['cbsCode'];
    if (c is! int) _fail('province ${province['id']} has no int cbsCode');
    ourProvinceCodes.add(c);
  }
  check(
    ourProvinceCodes.length == 7 &&
        ourProvinceCodes.containsAll(const [1, 2, 3, 4, 5, 6, 7]),
    'our province cbsCodes are exactly 1..7 (the pradesh sheet agrees)',
  );

  final ourDistrictCodes = <String>{};
  for (final d in ourDistrictByCanon.values) {
    final c = d['cbsCode'];
    if (c is! int) _fail('district ${d['name']} has no int cbsCode');
    ourDistrictCodes.add('$c'.padLeft(3, '0'));
  }
  check(
    ourDistrictCodes.containsAll(pddByXlsDistrict.values) &&
        ourDistrictCodes.length == 77,
    'every directory PDD is one of our district cbsCodes (77/77)',
  );

  // Name-level district cross-check: both of the register's district lists
  // must resolve to OUR district vocabulary, and the PDD a district's
  // palika codes carry must be that district's cbsCode.
  final districtMismatches = <String>[];
  for (final entry in pddByXlsDistrict.entries) {
    final ours = ourDistrictByCanon[_canonXlsDistrict(entry.key)];
    if (ours == null) {
      districtMismatches.add(
        'sheet-3 "${entry.key}" does not resolve to one of our districts',
      );
      continue;
    }
    if ('${ours['cbsCode']}' != entry.value) {
      districtMismatches.add(
        'sheet-3 "${entry.key}" -> ours "${ours['name']}" has cbsCode '
        '${ours['cbsCode']} but its directory rows sit under ${entry.value}',
      );
    }
  }
  for (final name in xlsDistrictNames) {
    if (!ourDistrictByCanon.containsKey(_canonXlsDistrict(name))) {
      districtMismatches.add(
        'sheet-2 "$name" does not resolve to one of our districts',
      );
    }
  }
  check(
    districtMismatches.isEmpty,
    'every register district name resolves to our vocabulary with the '
    'same PDD (mismatches: ${districtMismatches.length})',
  );
  for (final m in districtMismatches.take(10)) {
    out.writeln('    DISTRICT $m');
  }

  // ---- Gate 3: code-primary join over coded palikas ------------------------
  String ourTypeOfCbs(String cbsType) =>
      _ourTypeByCbsCanonical[canonicalCbsType(cbsType)] ?? '';

  final joinVariants = <String>[];
  final joinTypeIssues = <String>[];
  var exactNames = 0;
  final claimedByCode = <String, String>{};
  final uncodedByDistrict = <String, List<Map<String, dynamic>>>{};
  for (final province in provinces) {
    for (final district in (province['districts'] as List)) {
      final dmap = district as Map<String, dynamic>;
      final dname = dmap['name'] as String;
      final dcode = '${dmap['cbsCode'] as int}'.padLeft(3, '0');
      for (final b
          in (dmap['localBodies'] as List).cast<Map<String, dynamic>>()) {
        final name = b['name'] as String;
        final type = b['type'] as String;
        final code = b['cbsCode'] as int?;
        if (code == null) {
          uncodedByDistrict.putIfAbsent(dname, () => []).add(b);
          continue;
        }
        final key = '$code';
        if (claimedByCode.containsKey(key)) {
          _fail(
            'our dataset codes two palikas $key: '
            '${claimedByCode[key]} and $dname|$name',
          );
        }
        claimedByCode[key] = '$dname|$name';
        final row = units[key];
        if (row == null) {
          _fail(
            'our code $key ($dname|$name) is not attested by the directory '
            '- the register and the dataset disagree, stop',
          );
        }
        if (key.substring(0, 3) != dcode) {
          _fail(
            'directory row $key ("${row.en}") carries PDD '
            '${key.substring(0, 3)} but our palika $dname|$name lives in '
            '$dname (PDD $dcode)',
          );
        }
        // Name agreement: report-only. The code is the attestation; the
        // names document themselves.
        final ourKey = normCbsKey(name);
        final xlsKey = _normXlsName(row.en);
        if (ourKey == xlsKey) {
          exactNames++;
        } else {
          final d = levenshtein(ourKey, xlsKey, 3);
          joinVariants.add(
            '$dname|$name vs "${row.en}" (normalized '
            '${d <= 2 ? 'distance $d' : 'DISAGREES, distance $d'})',
          );
        }
        final cbsType = cbsTypeOf(row.en);
        if (cbsType.isEmpty) {
          joinTypeIssues.add('$dname|"${row.en}" (untyped label)');
        } else {
          final ourFromXls = ourTypeOfCbs(cbsType);
          if (ourFromXls != type) {
            joinTypeIssues.add(
              '$dname|"${row.en}" reads as $ourFromXls, ours is $type',
            );
          }
        }
      }
    }
  }
  final uncodedTotal = uncodedByDistrict.values.fold(0, (s, l) => s + l.length);
  check(
    claimedByCode.length + uncodedTotal == 753,
    'coded palikas joined to the register: ${claimedByCode.length} + '
    '$uncodedTotal still uncoded = 753',
  );
  out.writeln(
    '  name agreement: $exactNames exact, ${joinVariants.length} variants '
    '(reported, never applied)',
  );
  for (final v in joinVariants) {
    out.writeln('    NAME $v');
  }
  if (joinTypeIssues.isNotEmpty) {
    out.writeln(
      '  type reads that differ from ours (${joinTypeIssues.length}, '
      'reported):',
    );
    for (final t in joinTypeIssues) {
      out.writeln('    TYPE $t');
    }
  }

  // ---- Gate 4: resolve the uncoded remainder -------------------------------
  final unclaimed = <String, _Unit>{
    for (final e in units.entries)
      if (!claimedByCode.containsKey(e.key)) e.key: e.value,
  };
  out.writeln('');
  out.writeln(
    'uncoded palikas: $uncodedTotal; unclaimed directory rows: '
    '${unclaimed.length}',
  );
  for (final e in unclaimed.entries) {
    out.writeln(
      '  UNCLAIMED ${e.key} ${e.value.district} / "${e.value.en}" / '
      '"${e.value.ne}" (S_N ${e.value.sn})',
    );
  }

  final forced = <Map<String, dynamic>>[];
  final unclaimedCodes = unclaimed.keys.toSet();
  for (final entry in uncodedByDistrict.entries) {
    final dname = entry.key;
    final pending = entry.value;
    final dmap =
        ourDistrictByCanon.values.firstWhere((d) => d['name'] == dname);
    final dcode = '${dmap['cbsCode'] as int}'.padLeft(3, '0');
    final freeRows =
        unclaimedCodes.where((c) => c.substring(0, 3) == dcode).toList();
    if (pending.length == 1 && freeRows.length == 1) {
      final palika = pending.single;
      final name = palika['name'] as String;
      final code = freeRows.single;
      final row = unclaimed[code]!;
      final oursFlat = flatToken(name.toLowerCase());
      final xlsFlat = flatToken(row.en.toLowerCase());
      final affine = xlsFlat.contains(oursFlat) ||
          oursFlat.contains(xlsFlat) ||
          levenshtein(normCbsKey(name), normCbsKey(row.en), 2) <= 2;
      if (!affine) {
        _fail(
          'forced pairing for $dname would join "$name" with directory row '
          '"${row.en}" ($code), but the names are unrelated - refusing to '
          'guess; add a reviewed adjudication to $_ledgerPath instead',
        );
      }
      forced.add({
        'province': provinces
            .firstWhere((p) => (p['districts'] as List).contains(dmap))['id'],
        'district': dname,
        'name': name,
        'type': palika['type'],
        'code': int.parse(code),
        'tier': 'singleSource',
        'xlsSn': row.sn,
        'xlsEnglish': row.en,
        'xlsNepali': row.ne,
        'affinity': 'name-affine (normalized containment or distance <= 2)',
        'basis': 'forced 1-to-1 elimination inside $dname: our roster and the '
            'directory each have exactly one uncoded/unclaimed unit left',
      });
      unclaimedCodes.remove(code);
    } else {
      _fail(
        '$dname has ${pending.length} uncoded palika(s) and '
        '${freeRows.length} unclaimed directory row(s) - not a forced 1-to-1 '
        'pairing; add reviewed adjudication(s) to $_ledgerPath instead',
      );
    }
  }
  if (unclaimedCodes.isNotEmpty) {
    _fail(
      'directory rows remain unclaimed after resolution: '
      '${unclaimedCodes.join(', ')}',
    );
  }

  // Apply the forced pairings (singleSource tier, never verified).
  for (final f in forced) {
    final dmap = ourDistrictByCanon[canonDistrict(f['district'] as String)]!;
    for (final b
        in (dmap['localBodies'] as List).cast<Map<String, dynamic>>()) {
      if (b['name'] == f['name']) {
        b['cbsCode'] = f['code'];
        b['cbsCodeVerified'] = false;
        b['cbsCodeConfidence'] = 'singleSource';
      }
    }
    out.writeln(
      '  FORCED ${f['district']} / ${f['name']} => ${f['code']} '
      '(singleSource; directory row S_N ${f['xlsSn']} "${f['xlsEnglish']}")',
    );
  }

  // ---- Ledger: record every forced pairing ---------------------------------
  var ledgerAdded = 0;
  if (forced.isNotEmpty) {
    final ledgerOut = <Map<String, dynamic>>[];
    final existing = <String, int>{};
    if (File(_ledgerPath).existsSync()) {
      final parsed = jsonDecode(File(_ledgerPath).readAsStringSync())
          as Map<String, dynamic>;
      for (final raw in (parsed['entries'] as List)) {
        final e = (raw as Map).cast<String, dynamic>();
        existing['${e['district']}|${e['name']}'] = e['code'] as int;
        ledgerOut.add(e);
      }
    }
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    for (final f in forced) {
      final key = '${f['district']}|${f['name']}';
      final prior = existing[key];
      if (prior == f['code']) {
        out.writeln('  ledger: $key already attests ${f['code']} (kept)');
        continue;
      }
      if (prior != null) {
        _fail(
          'ledger already attests $key as $prior but this run derived '
          '${f['code']} - reconcile by hand',
        );
      }
      ledgerOut.add({
        'province': f['province'],
        'district': f['district'],
        'name': f['name'],
        'type': f['type'],
        'code': f['code'],
        'tier': 'singleSource',
        'source': 'Government of Nepal administrative code table '
            '(npl-codes/$_xlsName, sheet localunit_code)',
        'evidence': 'row S_N ${f['xlsSn']}: "${f['xlsEnglish']}" / '
            '"${f['xlsNepali']}" / ${f['code']}',
        'adjudicated': today,
        'signOff': 'apply_npl_codes.dart forced 1-to-1 elimination '
            '(doc/REVIEW-codes.md §8)',
      });
      ledgerAdded++;
    }
    ledgerOut.sort((a, b) => (a['code'] as int).compareTo(b['code'] as int));
    final doc = {
      'comment':
          'Hand-curated code adjudications. Each entry is a palika CBS code '
              'attested by a government directory but NOT doubly-attested '
              '(the verified tier needs postal-2025 + CBS harvest to agree), '
              'so it carries the singleSource tier with cbsCodeVerified=false. '
              'Consumed by tool/merge/resolve_code_tiers.dart (Pass A2), '
              'which reserves these codes before re-deriving the rest - that '
              'is what makes a full pipeline run preserve adjudicated codes '
              'instead of stripping them. Edit by hand only, with a '
              'documented source for every entry; the resolver and '
              'apply_npl_codes.dart hard-fail on any conflict with the '
              'dataset. Duplicates, non-PDDPP codes and unconsumed entries '
              'all fail the run.',
      'entries': ledgerOut,
    };
    if (!dryRun) {
      File(_ledgerPath)
          .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(doc));
    }
  }

  // ---- Gate 5: fill null nameNe from the directory's Unicode column --------
  final fills = <Map<String, dynamic>>[];
  for (final province in provinces) {
    final provId = province['id'] as String;
    for (final district in (province['districts'] as List)) {
      final dmap = district as Map<String, dynamic>;
      final dname = dmap['name'] as String;
      for (final b
          in (dmap['localBodies'] as List).cast<Map<String, dynamic>>()) {
        if (b['nameNe'] != null) continue;
        final code = b['cbsCode'] as int?;
        if (code == null) {
          _fail(
            '${b['name']} ($dname) is still uncoded - it cannot receive a '
            'nameNe fill; resolve the code first',
          );
        }
        final row = units['$code']!;
        final ne = row.ne;
        if (!devaRegex.hasMatch(ne)) {
          _fail('nameNe fill for $dname|${b['name']} would carry no '
              'Devanagari');
        }
        fills.add({
          'province': provId,
          'district': dname,
          'name': b['name'],
          'code': code,
          'nameNe': ne,
          'xlsSn': row.sn,
        });
        b['nameNe'] = ne;
        b['nameNeVerified'] = false;
      }
    }
  }
  out.writeln('');
  out.writeln(
    'nameNe fills from the directory: ${fills.length} (all previously '
    'null; nameNeVerified=false)',
  );
  for (final f in fills) {
    out.writeln(
      '  FILL ${f['district']} / ${f['name']} (${f['code']}) => '
      '"${f['nameNe']}" (S_N ${f['xlsSn']})',
    );
  }

  // ---- Post-state, recomputed from the mutated dataset ----------------------
  var verified = 0, single = 0, unverified = 0, coded = 0, nullNames = 0;
  for (final province in provinces) {
    for (final district in (province['districts'] as List)) {
      for (final b
          in (district['localBodies'] as List).cast<Map<String, dynamic>>()) {
        if (b['cbsCode'] != null) coded++;
        switch (b['cbsCodeConfidence'] as String?) {
          case 'verified':
            verified++;
          case 'singleSource':
            single++;
          default:
            unverified++;
        }
        if (b['nameNe'] == null) nullNames++;
      }
    }
  }
  check(coded == 753, 'all 753 local bodies are coded after this step');
  check(nullNames == 0, 'no null nameNe remains after this step');
  out.writeln('');
  out.writeln(
    'TIERS: $verified verified, $single singleSource, $unverified '
    'unverified; coded $coded/753; nameNe nulls $nullNames',
  );

  // ---- Evidence + report ----------------------------------------------------
  const encoder = JsonEncoder.withIndent('  ');
  final evidence = {
    'provenance': {
      'generated': DateTime.now().toUtc().toIso8601String(),
      'tool': 'tool/merge/apply_npl_codes.dart',
      'inputs': [
        'data/_raw/npl-codes/$_xlsName',
        for (final t in _tsvs) 'data/_raw/npl-codes/$t',
        'data/nepal_local_levels.json',
        'data/_stage/code_adjudications.json',
      ],
      'pins': {for (final e in pins.entries) e.key: e.value.hash},
      'rule': 'directory attestations are applied at the singleSource tier '
          '(cbsCodeVerified=false); existing values are never overwritten; '
          'name variants are reported, not applied; nameNe is filled only '
          'where null, from the Unicode Devanagari column, with '
          'nameNeVerified=false; district PDD codes are derived from '
          'palika-code prefixes and cross-checked against our district '
          'cbsCodes; the district sheet S.N. is a serial, not a code.',
    },
    'counts': {
      'verified': verified,
      'singleSource': single,
      'unverified': unverified,
      'coded': coded,
      'localBodies': 753,
      'nameNeFilled': fills.length,
      'forcedPairings': forced.length,
      'nameVariants': joinVariants.length,
      'typeReadIssues': joinTypeIssues.length,
      'districtMismatches': districtMismatches.length,
    },
    'forcedPairings': forced,
    'nameNeFills': fills,
    'nameVariants': joinVariants,
    'typeReadIssues': joinTypeIssues,
    'districtMismatches': districtMismatches,
  };
  if (!dryRun) {
    levelsJson['meta']['dataAsOf'] =
        DateTime.now().toUtc().toIso8601String().substring(0, 10);
    levelsFile.writeAsStringSync(encoder.convert(levelsJson));
    Directory('data/_stage').createSync(recursive: true);
    File(_evidencePath).writeAsStringSync(encoder.convert(evidence));
  }
  File(_reportPath).writeAsStringSync(out.toString());
  stdout.write(out.toString());
  if (dryRun) {
    stdout.writeln(
      '\nDRY RUN - dataset, ledger and evidence NOT modified. '
      'Report written to $_reportPath only.',
    );
  } else {
    stdout.writeln(
      '\nUpdated data/nepal_local_levels.json '
      '(${forced.length} code(s) forced, ${fills.length} nameNe fill(s), '
      '$ledgerAdded ledger entr${ledgerAdded == 1 ? 'y' : 'ies'}); wrote '
      '$_evidencePath and $_reportPath.',
    );
  }
}
