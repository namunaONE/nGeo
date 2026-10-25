// tool/generate.dart
//
// Generates lib/src/nepal_data.dart from data/nepal_local_levels.json.
//
// Usage (from the package root):
//   dart run tool/generate.dart
//
// The generator validates the dataset against the official federal
// structure before writing anything, so a corrupted or hand-mangled
// JSON fails loudly instead of producing a broken package.

import 'dart:convert';
import 'dart:io';

const jsonPath = 'data/nepal_local_levels.json';
const outputPath = 'lib/src/nepal_data.dart';

void main() {
  final jsonFile = File(jsonPath);
  if (!jsonFile.existsSync()) {
    stderr.writeln('ERROR: $jsonPath not found — run from the package root.');
    exit(1);
  }

  final Map<String, dynamic> json =
      jsonDecode(jsonFile.readAsStringSync()) as Map<String, dynamic>;
  final List<Map<String, dynamic>> provinces =
      (json['provinces'] as List).cast<Map<String, dynamic>>();
  final Map<String, int> totals =
      (json['meta']['totals'] as Map<String, dynamic>).cast<String, int>();

  _validate(provinces, totals);

  File(outputPath).writeAsStringSync(_generate(provinces));

  final formatted = Process.runSync('dart', ['format', outputPath]);
  stdout.write(formatted.stdout as String);
  stderr.write(formatted.stderr as String);
  if (formatted.exitCode != 0) exit(formatted.exitCode);

  stdout.writeln('Generated $outputPath from $jsonPath.');
}

void _validate(List<Map<String, dynamic>> provinces, Map<String, int> totals) {
  var districts = 0;
  var bodies = 0;
  var wards = 0;
  var verifiedWards = 0;
  var wardGaps = 0;
  var coded = 0;
  var doublyAttested = 0;
  final byType = <String, int>{};
  final seenCbsCodes = <int, String>{};
  const validTiers = {'verified', 'singleSource', 'unverified'};

  for (final province in provinces) {
    var verifiedWardsInProvince = 0;

    // A nameNe that holds no Devanagari at all is a broken pipeline, not a
    // gap: it means a Latin string reached the Devanagari field.
    void checkNameNe(Object? value, String where) {
      if (value == null) return;
      final s = value as String;
      if (!RegExp('[\u0900-\u097F]').hasMatch(s)) {
        stderr.writeln('ERROR: $where nameNe holds no Devanagari: "$s".');
        exit(1);
      }
    }

    checkNameNe(province['nameNe'], 'province ${province['name']}');
    for (final district in province['districts'] as List) {
      final dmap = district as Map<String, dynamic>;
      checkNameNe(dmap['nameNe'], 'district ${dmap['name']}');
      final units = (dmap['localBodies'] as List).cast<Map<String, dynamic>>();
      districts++;
      for (final unit in units) {
        bodies++;
        final type = unit['type'] as String;
        byType[type] = (byType[type] ?? 0) + 1;

        // --- CBS code confidence integrity -------------------------------
        // The tier and the boolean flag must agree, codes must be unique
        // nationwide, and a code must sit in its own district. A dataset
        // that violates any of these would publish a join-key map that
        // silently returns the wrong palika.
        final cbs = unit['cbsCode'] as int?;
        final tier = unit['cbsCodeConfidence'] as String? ?? 'unverified';
        final verified = unit['cbsCodeVerified'] == true;
        if (!validTiers.contains(tier)) {
          stderr.writeln('ERROR: invalid cbsCodeConfidence "$tier" for '
              '${unit['name']} (${dmap['name']}).');
          exit(1);
        }
        if (cbs == null) {
          if (tier != 'unverified' || verified) {
            stderr.writeln('ERROR: ${unit['name']} (${dmap['name']}) has '
                'cbsCode=null but tier=$tier verified=$verified.');
            exit(1);
          }
        } else {
          coded++;
          if (verified) doublyAttested++;
          if (verified && tier != 'verified') {
            stderr.writeln('ERROR: ${unit['name']} is cbsCodeVerified but '
                'tier=$tier.');
            exit(1);
          }
          if (!verified && tier == 'verified') {
            stderr.writeln('ERROR: ${unit['name']} has tier=verified but '
                'cbsCodeVerified=false.');
            exit(1);
          }
          final owner = seenCbsCodes[cbs];
          if (owner != null) {
            stderr.writeln('ERROR: CBS code $cbs is used by both $owner and '
                '${unit['name']} (${dmap['name']}).');
            exit(1);
          }
          seenCbsCodes[cbs] = '${dmap['name']}/${unit['name']}';
          final dCbs = dmap['cbsCode'] as int?;
          if (dCbs != null && cbs ~/ 100 != dCbs) {
            stderr.writeln('ERROR: ${unit['name']} code $cbs is not in '
                'district ${dmap['name']} ($dCbs).');
            exit(1);
          }
        }

        // Coordinate validation: nullable, but when present must be
        // numeric and inside the Nepal bounding box.
        final lat = unit['lat'];
        final lng = unit['lng'];
        if (lat != null || lng != null) {
          final latD = (lat as num?)?.toDouble();
          final lngD = (lng as num?)?.toDouble();
          if (latD == null ||
              lngD == null ||
              latD < 26.0 ||
              latD > 31.0 ||
              lngD < 80.0 ||
              lngD > 89.0) {
            stderr.writeln('ERROR: invalid coordinates for ${unit['name']} '
                '(${dmap['name']}): lat=$lat lng=$lng.');
            exit(1);
          }
        }
        // Ward-count validation: nullable, but when present must be a
        // sane positive integer (observed range 5-32; cap 40 for safety).
        final w = unit['wards'];
        if (w == null) {
          wardGaps++;
        } else if (w is! int || w < 1 || w > 40) {
          stderr.writeln('ERROR: invalid wards for ${unit['name']} '
              '(${dmap['name']}): wards=$w.');
          exit(1);
        } else {
          verifiedWards += w;
          verifiedWardsInProvince += w;
        }
      }
    }
    wards += province['wards'] as int;
    // A province's declared total can only ever be >= what its rows support.
    // If it is not, the declared figure is stale and must be re-sourced
    // rather than quietly published.
    final declaredInProvince = province['wards'] as int;
    if (verifiedWardsInProvince > declaredInProvince) {
      stderr.writeln(
        'ERROR: ${province['name']} rows sum to $verifiedWardsInProvince '
        'wards but the province declares only $declaredInProvince.',
      );
      exit(1);
    }
  }

  void check(String label, int actual, int expected) {
    if (actual != expected) {
      stderr.writeln('ERROR: $label = $actual, expected $expected.');
      exit(1);
    }
  }

  check('provinces', provinces.length, totals['provinces']!);
  check('districts', districts, totals['districts']!);
  check('localBodies', bodies, totals['localBodies']!);
  check('metropolitan', byType['metropolitan'] ?? 0, totals['metropolitan']!);
  check('subMetropolitan', byType['subMetropolitan'] ?? 0,
      totals['subMetropolitan']!);
  check('municipality', byType['municipality'] ?? 0, totals['municipality']!);
  check('ruralMunicipality', byType['ruralMunicipality'] ?? 0,
      totals['ruralMunicipality']!);
  check('wards', wards, totals['wards']!);

  // Derived totals are reported, not gated: the gap between the declared
  // national ward total and the substantiated one is a documented data
  // property (8 palikas pending roster adjudication), not a defect. It is
  // printed on every run so a change in the gap cannot pass unnoticed.
  stdout.writeln('Coverage: $coded/$bodies palikas carry a CBS code '
      '($doublyAttested doubly-attested, '
      '${coded - doublyAttested} single-source).');
  stdout.writeln('Wards: $wards declared, $verifiedWards substantiated '
      'across ${bodies - wardGaps}/$bodies palikas ($wardGaps gaps, '
      'difference ${wards - verifiedWards}).');
}

String _generate(List<Map<String, dynamic>> provinces) {
  final geoSources = <String>[];
  final provRows = <String>[];
  final distRows = <String>[];
  final bodyRows = <String>[];

  for (final province in provinces) {
    final provinceDistricts =
        (province['districts'] as List).cast<Map<String, dynamic>>();
    final pNameNe = province['nameNe'] as String?;
    final row = _join([
      _s(province['id'], 'province id'),
      _s(province['name'], 'province name'),
      _s(pNameNe, 'province nameNe'),
      _flag(pNameNe != null && province['nameNeVerified'] == true),
      _s(province['capital'], 'province capital'),
      _dbl(province['areaSqKm']),
      _s(province['website'], 'province website'),
      _int(province['cbsCode'], 'province cbsCode'),
      _s(province['isoCode'], 'province isoCode'),
      _int(province['wards'], 'province wards'),
      '${provinceDistricts.length}',
    ]);
    provRows.add(row);

    for (final district in provinceDistricts) {
      final units =
          (district['localBodies'] as List).cast<Map<String, dynamic>>();
      final dNameNe = district['nameNe'] as String?;
      final dRow = _join([
        _s(district['name'], 'district name'),
        _s(dNameNe, 'district nameNe'),
        _flag(dNameNe != null && district['nameNeVerified'] == true),
        _int(district['cbsCode'], 'district cbsCode'),
        _s(district['headquarter'], 'district headquarter'),
        _dbl(district['areaSqKm']),
        _s(district['website'], 'district website'),
        '${units.length}',
      ]);
      distRows.add(dRow);

      for (final unit in units) {
        _checkConfidence(unit, '${district['name']}/${unit['name']}');
        final zips = unit['zipCodes'] as List?;
        var zipsCsv = '';
        if (zips != null && zips.isNotEmpty) {
          zipsCsv = zips.map((z) => _s(z, 'local body zipCode')).join(',');
        }
        final bRow = _join([
          _s(unit['name'], 'local body name'),
          _s(unit['nameNe'], 'local body nameNe'),
          _flag(unit['nameNe'] != null && unit['nameNeVerified'] == true),
          _typeChar(unit['type'] as String, unit['name'] as String),
          _int(unit['cbsCode'], 'local body cbsCode'),
          _flag(unit['cbsCode'] != null && unit['cbsCodeVerified'] == true),
          _dbl(unit['lat']),
          _dbl(unit['lng']),
          _geoIdx(unit, geoSources),
          _int(unit['wards'], 'local body wards'),
          _flag(unit['wards'] != null && unit['wardsVerified'] == true),
          _s(unit['website'], 'local body website'),
          _s(unit['email'], 'local body email'),
          _s(unit['phone'], 'local body phone'),
          zipsCsv,
        ]);
        bodyRows.add(bRow);
      }
    }
  }

  final b = StringBuffer();
  b.writeln('// GENERATED CODE — DO NOT MODIFY BY HAND.');
  b.writeln('//');
  b.writeln('// Source of truth: $jsonPath');
  b.writeln('// Regenerate with: dart run tool/generate.dart');
  b.writeln('//');
  b.writeln('// Official federal structure: 7 provinces, 77 districts,');
  b.writeln('// 753 local bodies (6 metropolitan, 11 sub-metropolitan,');
  b.writeln('// 276 municipalities, 460 rural municipalities), 6,743');
  b.writeln('// wards. Data as of October 2026.');
  b.writeln('//');
  b.writeln('// Compact roster, format version 1 (decoded by');
  b.writeln('// roster_codec.dart): the dataset ships as pipe-separated rows');
  b.writeln('// — one per province, district and local body —');
  b.writeln('// instead of constructor literals, so the generated file');
  b.writeln('// stays small while decoding to the same objects.');
  b.writeln();
  b.writeln("import 'nepal_admin_api_base.dart';");
  b.writeln("import 'roster_codec.dart';");
  b.writeln();
  b.writeln('/// Version of the compact roster format carried by this file.');
  b.writeln("const String kRosterFormatVersion = '1';");
  b.writeln();
  b.writeln('/// Coordinate provenance labels, referenced from');
  b.writeln('/// local-body rows by index, in first-appearance order.');
  b.writeln('const List<String> kRosterGeoSources = [');
  for (final source in geoSources) {
    b.writeln("  '$source',");
  }
  b.writeln('];');
  b.writeln();
  b.writeln('/// Province rows, one per province, in dataset order:');
  b.writeln('/// id|name|nameNe|nameNeVerified|capital|areaSqKm|website|');
  b.writeln('/// cbsCode|isoCode|declaredWards|districtCount');
  b.writeln('const List<String> kRosterProvinces = [');
  for (final provRow in provRows) {
    b.writeln("  '$provRow',");
  }
  b.writeln('];');
  b.writeln();
  b.writeln('/// District rows, one per district, in dataset order:');
  b.writeln('/// name|nameNe|nameNeVerified|cbsCode|headquarter|areaSqKm|');
  b.writeln('/// website|unitCount');
  b.writeln('const List<String> kRosterDistricts = [');
  for (final distRow in distRows) {
    b.writeln("  '$distRow',");
  }
  b.writeln('];');
  b.writeln();
  b.writeln('/// Local-body rows, one per palika, in dataset order:');
  b.writeln('/// name|nameNe|nameNeVerified|type|cbsCode|cbsVerified|');
  b.writeln('/// lat|lng|geoSourceIndex|wards|wardsVerified|website|email|');
  b.writeln('/// phone|zipCodes');
  b.writeln('const List<String> kRosterLocalBodies = [');
  for (final bodyRow in bodyRows) {
    b.writeln("  '$bodyRow',");
  }
  b.writeln('];');
  b.writeln();
  b.writeln("/// The package's embedded dataset. Do not construct by hand —");
  b.writeln('/// use [NepalAdminApi] to query it.');
  b.writeln('class NepalData {');
  b.writeln('  static final List<Province> provinces = RosterCodec.decode(');
  b.writeln('    formatVersion: kRosterFormatVersion,');
  b.writeln('    geoSources: kRosterGeoSources,');
  b.writeln('    provinces: kRosterProvinces,');
  b.writeln('    districts: kRosterDistricts,');
  b.writeln('    localBodies: kRosterLocalBodies,');
  b.writeln('  );');
  b.writeln('}');
  return b.toString();
}

/// Joins the fields of one roster row.
String _join(List<String> fields) => fields.join('|');

/// A string field: null becomes the empty field, and anything the row
/// format cannot carry is refused rather than silently corrupted.
String _s(Object? value, String where) {
  final s = value == null ? '' : '$value';
  _safe(s, where);
  return s;
}

/// Refuses the characters a pipe-separated, single-quoted row cannot
/// carry. The dataset is clean today; this keeps a future merge from
/// quietly corrupting the roster.
void _safe(String s, String where) {
  for (final bad in const ['|', "'", r'\', r'$', '\n', '\r']) {
    if (s.contains(bad)) {
      stderr.writeln('ERROR: $where contains $bad: $s');
      exit(1);
    }
  }
}

/// A boolean field: true is written as '1', everything else as empty.
String _flag(bool value) => value ? '1' : '';

/// An integer field: null becomes the empty field.
String _int(Object? n, String where) {
  if (n == null) return '';
  if (n is! int) {
    stderr.writeln('ERROR: $where is not an integer: $n');
    exit(1);
  }
  return '$n';
}

/// A real-valued field: null becomes the empty field. Integral values
/// keep their '.0' so the shortest representation round-trips.
String _dbl(Object? n) {
  if (n == null) return '';
  final d = (n as num).toDouble();
  final i = d.toInt();
  return i == d ? '$i.0' : '$d';
}

/// The one-letter type code of a local-body row.
String _typeChar(String type, String where) {
  const codes = <String, String>{
    'metropolitan': 'M',
    'subMetropolitan': 'S',
    'municipality': 'm',
    'ruralMunicipality': 'r',
  };
  final code = codes[type];
  if (code == null) {
    stderr.writeln('ERROR: unknown local-body type "$type" for $where.');
    exit(1);
  }
  return code;
}

/// The geo-source field: the index of the label in [geoSources] (added on
/// first appearance), or empty when the row carries no coordinates.
String _geoIdx(Map<String, dynamic> unit, List<String> geoSources) {
  if (unit['lat'] == null || unit['lng'] == null) return '';
  final raw = unit['geoSource'];
  if (raw == null) return '';
  final source = _s(raw, 'local body geoSource');
  var idx = geoSources.indexOf(source);
  if (idx < 0) {
    idx = geoSources.length;
    geoSources.add(source);
  }
  return '$idx';
}

/// The roster derives the tier away: no code means no tier, a
/// doubly-attested code is verified, any other code is single-source.
/// Refuses a dataset whose declared tier disagrees with that rule —
/// decoding it would tell a different story than the source JSON.
void _checkConfidence(Map<String, dynamic> unit, String where) {
  final cbs = unit['cbsCode'];
  final verified = unit['cbsCodeVerified'] == true;
  final declared = unit['cbsCodeConfidence'] as String? ?? 'unverified';
  String derived;
  if (cbs == null) {
    derived = 'unverified';
  } else if (verified) {
    derived = 'verified';
  } else {
    derived = 'singleSource';
  }
  if (declared != derived) {
    stderr.writeln('ERROR: $where declares cbsCodeConfidence '
        '$declared but its code and flag derive $derived.');
    exit(1);
  }
}
