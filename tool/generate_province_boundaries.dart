// tool/generate_province_boundaries.dart
//
// Regenerates lib/src/geo/province_boundaries.dart — all 7 provincial
// boundary polygons as compact pure-Dart strings (format version 1, see
// palika_boundary_codec.dart) — from data/_raw/province_boundaries_highres.geojson.
//
// Usage:
//   dart run tool/generate_province_boundaries.dart          # regenerate
//   dart run tool/generate_province_boundaries.dart --check  # CI drift gate
//
// Source: National Geoportal (Survey Department of Nepal) high-res provincial
// boundaries, already WGS 84 (EPSG:4326). Coordinates quantised to 1e-4
// degrees (~11 m), delta-coded, zigzagged, VLQ-packed. Lossless round trip.
//
// Provinces are 1:1 with the roster by province code (1..7); no join stage
// is needed (unlike palika boundaries). Output is byte-stable.

import 'dart:convert';
import 'dart:io';

const _alphabet =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

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

void main(List<String> args) {
  final check = args.contains('--check');
  const geoPath = 'docs/province-boundaries.geojson';
  const outPath = 'lib/src/geo/province_boundaries.dart';

  final geoFile = File(geoPath);
  if (!geoFile.existsSync()) {
    stderr.writeln('Missing input: $geoPath. Run the conversion script first.');
    exit(1);
  }
  final geo = jsonDecode(geoFile.readAsStringSync()) as Map<String, dynamic>;
  final features = geo['features'] as List<dynamic>;

  final entries = <Map<String, dynamic>>[];
  var uniqueVerts = 0;
  for (final raw in features) {
    final props = raw['properties'] as Map<String, dynamic>;
    final geom = raw['geometry'] as Map<String, dynamic>;
    final rawPolys = geom['type'] == 'Polygon'
        ? <dynamic>[geom['coordinates']]
        : geom['coordinates'] as List<dynamic>;
    final polys = <List<List<List<double>>>>[];
    for (final rawPoly in rawPolys) {
      final rings = <List<List<double>>>[];
      for (final rawRing in rawPoly as List<dynamic>) {
        final ring = <List<double>>[];
        for (final v in rawRing as List<dynamic>) {
          final c = v as List<dynamic>;
          ring.add([(c[0] as num).toDouble(), (c[1] as num).toDouble()]);
        }
        rings.add(ring);
        uniqueVerts += ring.length - 1;
      }
      polys.add(rings);
    }
    final enc = _encode(polys);
    entries.add({
      'code': props['provinceCode'] as int,
      'nameEn': props['nameEn'] as String,
      'enc': enc,
      'verts': uniqueVerts,
    });
  }
  entries.sort((a, b) => (a['code'] as int).compareTo(b['code'] as int));

  final out = StringBuffer();
  void w(String line) => out.writeln(line);

  w('// GENERATED FILE - DO NOT EDIT.');
  w('//');
  w('// Lossless boundary geometry for all 7 provinces of Nepal,');
  w('// encoded as compact strings (format version 1 - see');
  w('// palika_boundary_codec.dart).');
  w('//');
  w('// Source: National Geoportal (Survey Department of Nepal) high-res');
  w('// provincial boundaries, WGS 84 (EPSG:4326). Coordinates quantised to');
  w('// 1e-4 degrees (~11 m) and stored as zigzag VLQ deltas: the round');
  w('// trip is bit-exact, nothing is simplified or dropped.');
  w('//');
  w('// Regenerate with: dart run tool/generate_province_boundaries.dart');
  w('');
  w("const String kProvinceBoundaryFormatVersion = '1';");
  w('');
  w('const int kProvinceBoundaryFeatureCount = ${entries.length};');
  w('');
  w('const Map<String, String> kProvinceBoundaries = {');
  for (final e in entries) {
    final code = e['code'] as int;
    w("  'NP-P$code': '${e['enc']}',");
  }
  w('};');
  w('');
  w('const Map<int, String> kProvinceBoundaryNames = {');
  for (final e in entries) {
    w("  ${e['code']}: '${e['nameEn']}',");
  }
  w('};');

  final text = out.toString();
  if (check) {
    final existing = File(outPath).readAsStringSync();
    if (existing != text) {
      stderr.writeln('Drift detected: $outPath differs from a fresh regeneration.');
      exit(2);
    }
    stdout.writeln('OK: $outPath is up to date.');
    return;
  }
  File(outPath).writeAsStringSync(text);
  stdout.writeln('Wrote $outPath: ${entries.length} provinces, '
      '$uniqueVerts stored vertices.');
}

// avoid unused import warning
// ignore: unused_element
void _noop() {}
