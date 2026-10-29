// tool/generate_district_elevation.dart
//
// Regenerates lib/src/geo/district_elevation.dart — per-district elevation
// statistics (min/mean/max, integer metres) — from
// bindings/geojson/districts.elevation.geojson.
//
// Usage:
//   dart run tool/generate_district_elevation.dart          # regenerate
//   dart run tool/generate_district_elevation.dart --check  # CI drift gate
//
// Source: Copernicus GLO-30 (30 m, frozen 2021 release) zonal statistics
// over the official district polygons, computed by
// tool/elevation/build_elevation_stats.py in the elevation-stats workflow
// and committed as a small text artifact. This tool only re-validates and
// repackages that artifact — no network, no raster processing.
//
// Gates (all hard failures):
//   - 77 features, geometry null, ids unique and well-formed,
//   - monotonicity elevMin <= elevMean <= elevMax for every district,
//   - the id set joins the district boundary layer in BOTH directions and
//     every nameEn agrees with it,
//   - measured anchors: Solukhumbu >= 8,700 m (Everest), Taplejung
//     >= 8,400 m (Kangchenjunga), Myagdi >= 7,900 m (Annapurna I),
//     Mustang >= 1,300 m (Kali Gandaki gorge), national minimum in the
//     50-100 m band (Kechana Kalan, Jhapa),
//   - the 64 KB output budget.

import 'dart:convert';
import 'dart:io';

const _expectedDistricts = 77;

const _maxOutputBytes = 64 * 1024;

class _Row {
  final String id;
  final String nameEn;
  final String nameNe;
  final int min;
  final int mean;
  final int max;

  const _Row(this.id, this.nameEn, this.nameNe, this.min, this.mean, this.max);
}

/// 'P{1-7}.D{01-77}', validated structurally — no regex needed.
bool _validId(String id) {
  if (id.length != 6 || id[0] != 'P' || id[2] != '.' || id[3] != 'D') {
    return false;
  }
  final province = id.codeUnitAt(1) - 0x30;
  if (province < 1 || province > 7) return false;
  for (var i = 4; i < 6; i++) {
    final digit = id.codeUnitAt(i) - 0x30;
    if (digit < 0 || digit > 9) return false;
  }
  return true;
}

Never _fail(String message) {
  stderr.writeln(message);
  exit(1);
}

void main(List<String> args) {
  final check = args.contains('--check');
  const elevPath = 'bindings/geojson/districts.elevation.geojson';
  const boundaryPath = 'docs/district-boundaries.geojson';
  const outPath = 'lib/src/geo/district_elevation.dart';

  final elevFile = File(elevPath);
  if (!elevFile.existsSync()) {
    _fail('Missing input: ${elevPath}. See NOTICE and data/SOURCES.md.');
  }
  final elev = jsonDecode(elevFile.readAsStringSync()) as Map<String, dynamic>;
  final metadata = elev['metadata'] as Map<String, dynamic>;
  final tilesSha256 = metadata['tilesSha256'] as String;
  if (tilesSha256.length != 64) {
    _fail('Malformed tilesSha256 pin: ${tilesSha256}');
  }
  final features = elev['features'] as List<dynamic>;
  if (features.length != _expectedDistricts) {
    _fail('Expected $_expectedDistricts districts, found ${features.length}.');
  }

  // The district boundary layer is the join anchor: same 77 ids, same names.
  final boundaryFile = File(boundaryPath);
  if (!boundaryFile.existsSync()) {
    _fail('Missing input: ${boundaryPath}. See data/SOURCES.md.');
  }
  final boundaryGeo =
      jsonDecode(boundaryFile.readAsStringSync()) as Map<String, dynamic>;
  final boundaryNames = <String, String>{};
  for (final raw in boundaryGeo['features'] as List<dynamic>) {
    final feature = raw as Map<String, dynamic>;
    final props = feature['properties'] as Map<String, dynamic>;
    final id = props['districtId'] as String;
    if (boundaryNames.containsKey(id)) {
      _fail('Duplicate districtId in the boundary layer: ${id}');
    }
    boundaryNames[id] = props['nameEn'] as String;
  }
  if (boundaryNames.length != _expectedDistricts) {
    _fail('Boundary layer must list $_expectedDistricts districts, found '
        '${boundaryNames.length}.');
  }

  final entries = <_Row>[];
  for (final raw in features) {
    final feature = raw as Map<String, dynamic>;
    if (feature['geometry'] != null) {
      _fail('Elevation features must carry geometry null.');
    }
    final props = feature['properties'] as Map<String, dynamic>;
    final id = props['districtId'] as String;
    if (!_validId(id)) {
      _fail('Malformed districtId: ${id}');
    }
    if (entries.any((r) => r.id == id)) {
      _fail('Duplicate districtId: ${id}');
    }
    final nameEn = props['nameEn'] as String;
    final nameNe = props['nameNe'] as String;
    if (nameEn.isEmpty || nameNe.isEmpty) {
      _fail('Empty name for ${id}');
    }
    if (nameEn.contains('|') || nameNe.contains('|')) {
      _fail('Name carries the record separator for ${id}');
    }
    final min = props['elevMin'] as int;
    final mean = props['elevMean'] as int;
    final max = props['elevMax'] as int;
    if (min < 0 || min > mean || mean > max) {
      _fail('Non-monotonic or negative elevation stats for ${id}: '
          '${min}/${mean}/${max}');
    }
    if (max > 9000) {
      _fail('Implausible elevMax for ${id}: ${max} (Everest is 8,848.86 m)');
    }
    final boundaryName = boundaryNames[id];
    if (boundaryName == null) {
      _fail('${id} has no district boundary counterpart.');
    }
    if (boundaryName != nameEn) {
      _fail('nameEn disagrees with the boundary layer for ${id}: '
          '"${nameEn}" vs "${boundaryName}"');
    }
    entries.add(_Row(id, nameEn, nameNe, min, mean, max));
  }

  // Measured anchors against known ground truth.
  _Row? row(String name) {
    for (final r in entries) {
      if (r.nameEn == name) return r;
    }
    return null;
  }

  void anchor(String name, bool Function(_Row) holds, String why) {
    final r = row(name);
    if (r == null) {
      _fail('Anchor district missing from the artifact: ${name}');
    }
    if (!holds(r)) {
      _fail('Anchor failed for ${name} (${why}): ${r.min}/${r.mean}/'
          '${r.max}');
    }
  }

  anchor('Solukhumbu', (r) => r.max >= 8700, 'Everest 8,848.86 m');
  anchor('Taplejung', (r) => r.max >= 8400, 'Kangchenjunga 8,586 m');
  anchor('Myagdi', (r) => r.max >= 7900, 'Annapurna I 8,091 m');
  anchor('Mustang', (r) => r.min >= 1300, 'Kali Gandaki gorge');
  var nationalMin = entries.first.min;
  var nationalMax = entries.first.max;
  for (final r in entries) {
    if (r.min < nationalMin) nationalMin = r.min;
    if (r.max > nationalMax) nationalMax = r.max;
  }
  if (nationalMin < 50 || nationalMin > 100) {
    _fail('National minimum outside the 50-100 m band (Kechana Kalan is '
        'about 70 m): ${nationalMin}');
  }
  if (nationalMax < 8700) {
    _fail('National maximum below the Everest band: ${nationalMax}');
  }

  entries.sort((a, b) => a.id.compareTo(b.id));

  final out = StringBuffer();
  void w(String line) => out.writeln(line);

  /// Emits one map entry, wrapping long values like dart-format does.
  String entryLine(int indent, String key, String value) {
    final pad = ' ' * indent;
    final inline = '${pad}${key}: ${value}';
    if (inline.length <= 80) return inline;
    final valuePad = ' ' * (indent + 4);
    return '${pad}${key}:\n${valuePad}${value}';
  }

  w('// GENERATED FILE - DO NOT EDIT.');
  w('//');
  w('// District elevation layer for Nepal (77 districts).');
  w('// Source: bindings/geojson/districts.elevation.geojson (Copernicus');
  w('// GLO-30 zonal stats over the official district polygons; see');
  w('// NOTICE for the required attribution).');
  w('// Encoding: pipe-separated nameEn|nameNe|elevMin|elevMean|elevMax,');
  w('// integer metres, id-sorted.');
  w('//');
  w('// Regenerate with: dart run tool/generate_district_elevation.dart');
  w('');
  w("const String kDistrictElevationFormatVersion = '1';");
  w('');
  w('const int kDistrictElevationFeatureCount = ${entries.length};');
  w('');
  w('const String kDistrictElevationTilesSha256 =');
  w("    '${tilesSha256}';");
  w('');
  w('const Map<String, String> kDistrictElevations = {');
  for (final r in entries) {
    final value = '${r.nameEn}|${r.nameNe}|${r.min}|${r.mean}|${r.max}';
    w(entryLine(2, "'${r.id}'", "'${value}',"));
  }
  w('};');

  final text = out.toString();
  if (text.length >= _maxOutputBytes) {
    _fail('Output exceeds the ${_maxOutputBytes ~/ 1024} KB budget: '
        '${text.length} bytes.');
  }

  if (check) {
    final existing = File(outPath).readAsStringSync();
    if (existing != text) {
      stderr.writeln(
        'Drift detected: ${outPath} differs from a fresh regeneration.',
      );
      exit(2);
    }
    stdout.writeln('OK: ${outPath} is up to date.');
    return;
  }
  File(outPath).writeAsStringSync(text);
  stdout.writeln('Wrote ${outPath}: ${entries.length} districts, '
      'elevation stats from Copernicus GLO-30.');
}
