// tool/generate_district_boundaries.dart
//
// Regenerates lib/src/geo/district_boundaries.dart — all 77 district
// boundary polygons as compact pure-Dart strings (format version 1, see
// palika_boundary_codec.dart) — from docs/district-boundaries.geojson.
//
// Usage:
//   dart run tool/generate_district_boundaries.dart          # regenerate
//   dart run tool/generate_district_boundaries.dart --check  # CI drift gate
//
// Source: official portal district boundary export (Survey Department of
// Nepal / National Geoportal lineage), already WGS 84 (EPSG:4326).
// Coordinates quantised to 1e-4 degrees (~11 m), delta-coded, zigzagged,
// VLQ-packed. The quantised round trip is bit-exact — nothing is simplified.
//
// The input file was joined to the roster at ingestion (77/77 by name, with
// the seven spelling aliases documented in data/SOURCES.md) and every
// feature carries a validated districtId of the form 'P{province}.D{rank}'.
// This tool re-validates shape, count, uniqueness and id/province
// consistency, then emits byte-stable output.

import 'dart:convert';
import 'dart:io';

const _alphabet =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

const _expectedDistricts = 77;

const _maxOutputBytes = 256 * 1024;

final _idPattern = RegExp(r'^P[1-7]\.D\d{2}$');

String _encode(List<List<List<List<double>>>> polys) {
  final b = StringBuffer();
  void put(int v) {
    do {
      var d = v & 31;
      v = v ~/ 32;
      if (v > 0) d |= 32;
      b.write(_alphabet[d]);
    } while (v > 0);
  }

  int zz(int v) => v < 0 ? -v * 2 - 1 : v * 2;

  put(polys.length);
  var curLat = 0, curLng = 0;
  var anchored = false;
  for (final rings in polys) {
    put(rings.length);
    for (final ring in rings) {
      final closed = ring.length > 1 &&
          ring.first[0] == ring.last[0] &&
          ring.first[1] == ring.last[1];
      final n = closed ? ring.length - 1 : ring.length;
      put(n);
      for (var i = 0; i < n; i++) {
        final qLat = (ring[i][1] * 1e4).round();
        final qLng = (ring[i][0] * 1e4).round();
        if (anchored) {
          put(zz(qLat - curLat));
          put(zz(qLng - curLng));
        } else {
          put(zz(qLat));
          put(zz(qLng));
          anchored = true;
        }
        curLat = qLat;
        curLng = qLng;
      }
    }
  }
  return b.toString();
}

void _fail(String message) {
  stderr.writeln(message);
  exit(1);
}

void main(List<String> args) {
  final check = args.contains('--check');
  const geoPath = 'docs/district-boundaries.geojson';
  const outPath = 'lib/src/geo/district_boundaries.dart';

  final geoFile = File(geoPath);
  if (!geoFile.existsSync()) {
    _fail('Missing input: $geoPath. See data/SOURCES.md.');
  }
  final geo = jsonDecode(geoFile.readAsStringSync()) as Map<String, dynamic>;
  final features = geo['features'] as List<dynamic>;
  if (features.length != _expectedDistricts) {
    _fail('Expected $_expectedDistricts districts, found '
        '${features.length}.');
  }

  final entries = <Map<String, dynamic>>[];
  var verts = 0;
  final seenIds = <String>{};
  for (final raw in features) {
    final props = raw['properties'] as Map<String, dynamic>;
    final geom = raw['geometry'] as Map<String, dynamic>;
    if (geom['type'] != 'Polygon') {
      _fail('District geometry must be Polygon, found ${geom['type']}.');
    }
    final id = props['districtId'] as String;
    if (!_idPattern.hasMatch(id)) {
      _fail('Malformed districtId: $id');
    }
    if (!seenIds.add(id)) {
      _fail('Duplicate districtId: $id');
    }
    final provinceCode = props['provinceCode'] as int;
    if (provinceCode < 1 || provinceCode > 7) {
      _fail('Province code out of range for $id: $provinceCode');
    }
    if (int.parse(id.substring(1, 2)) != provinceCode) {
      _fail('Province digit of $id disagrees with provinceCode '
          '$provinceCode');
    }
    final rings = <List<List<double>>>[];
    for (final rawRing in geom['coordinates'] as List<dynamic>) {
      final ring = <List<double>>[];
      for (final v in rawRing as List<dynamic>) {
        final c = v as List<dynamic>;
        ring.add([(c[0] as num).toDouble(), (c[1] as num).toDouble()]);
      }
      if (ring.length < 4) {
        _fail('Degenerate ring in $id: ${ring.length} vertices');
      }
      final closed = ring.length > 1 &&
          ring.first[0] == ring.last[0] &&
          ring.first[1] == ring.last[1];
      verts += closed ? ring.length - 1 : ring.length;
      rings.add(ring);
    }
    entries.add({
      'id': id,
      'nameEn': props['nameEn'] as String,
      'enc': _encode(<List<List<List<double>>>>[rings]),
    });
  }
  entries.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));

  final out = StringBuffer();
  void w(String line) => out.writeln(line);

  /// Emits one map entry, wrapping long values like dart-format does.
  String entryLine(int indent, String key, String value) {
    final pad = ' ' * indent;
    final inline = '$pad$key: $value';
    if (inline.length <= 80) return inline;
    final valuePad = ' ' * (indent + 4);
    return '$pad$key:\n$valuePad$value';
  }

  w('// GENERATED FILE - DO NOT EDIT.');
  w('//');
  w('// District boundary layer for Nepal (77 districts).');
  w('// Source: docs/district-boundaries.geojson (see data/SOURCES.md).');
  w('// Encoding: VLQ base64, zigzag signed deltas, coords quantised to');
  w('// 1e-4 deg.');
  w('//');
  w('// Regenerate with: dart run tool/generate_district_boundaries.dart');
  w('');
  w("const String kDistrictBoundaryFormatVersion = '1';");
  w('');
  w('const int kDistrictBoundaryFeatureCount = ${entries.length};');
  w('');
  w('const Map<String, String> kDistrictBoundaries = {');
  for (final e in entries) {
    w(entryLine(2, "'${e['id']}'", "'${e['enc']}',"));
  }
  w('};');
  w('');
  w('const Map<String, String> kDistrictBoundaryNames = {');
  for (final e in entries) {
    w("  '${e['id']}': '${e['nameEn']}',");
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
        'Drift detected: $outPath differs from a fresh regeneration.',
      );
      exit(2);
    }
    stdout.writeln('OK: $outPath is up to date.');
    return;
  }
  File(outPath).writeAsStringSync(text);
  stdout.writeln('Wrote $outPath: ${entries.length} districts, '
      '$verts stored vertices.');
}
