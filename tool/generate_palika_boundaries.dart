// tool/generate_palika_boundaries.dart
//
// Regenerates lib/src/geo/palika_boundaries.dart — all 753 palika
// boundary polygons as one compact pure-Dart literal — from
// docs/palika-boundaries.geojson plus data/nepal_local_levels.json.
//
// Usage:
//   dart run tool/generate_palika_boundaries.dart          # regenerate
//   dart run tool/generate_palika_boundaries.dart --check  # CI drift gate
//
// Why this shape: the package must ship boundaries without assets,
// downloads or runtime dependencies, and the payload has to stay under
// 100 KB. The source is already simplified (Douglas-Peucker was measured
// and saves <3%), so the encoding is LOSSLESS: coordinates quantised to
// 1e-4 degrees (~11 m), delta-coded, zigzagged and VLQ-packed. Format
// version 1 is documented in lib/src/geo/palika_boundary_codec.dart.
//
// The join to the roster is self-verifying, in three stages:
//   1. Every district name is mapped to a geometry districtId by
//      point-in-polygon majority vote across the roster centroids
//      (77/77 districts, no conflicting majorities).
//   2. Normalized names join within a district (592 pairs).
//   3. Remaining features join by point-in-polygon on the roster
//      centroid (154 pairs), which fixes spelling variants such as
//      'Sitganga' vs 'Shitaganga'.
// The 7 features that survive all three are published under
// `districtId|nameEn` rather than guessed.
//
// Output is byte-stable — fixed ordering, LF, UTF-8, no timestamps — so
// CI drift is a plain file compare (`--check` exits 2 on drift).

import 'dart:convert';
import 'dart:io';

const _alphabet =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

void main(List<String> args) {
  final check = args.contains('--check');
  final geoPath = 'docs/palika-boundaries.geojson';
  final rosterPath = 'data/nepal_local_levels.json';
  final outPath = 'lib/src/geo/palika_boundaries.dart';

  final geoFile = File(geoPath);
  final rosterFile = File(rosterPath);
  if (!geoFile.existsSync() || !rosterFile.existsSync()) {
    stderr.writeln(
      'Missing input: $geoPath and $rosterPath must both be present.',
    );
    exit(1);
  }

  final geo = jsonDecode(geoFile.readAsStringSync()) as Map<String, dynamic>;
  final meta = geo['metadata'] as Map<String, dynamic>;
  final roster = jsonDecode(rosterFile.readAsStringSync())
      as Map<String, dynamic>;

  // ── 1. Encode every feature, verifying the round trip as we go ──
  final features = <_Feature>[];
  var uniqueVerts = 0;
  var ringCount = 0;
  var roundTripOk = 0;
  for (final raw in (geo['features'] as List).cast<Map<String, dynamic>>()) {
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
        ringCount++;
        uniqueVerts += ring.length - 1;
      }
      polys.add(rings);
    }
    final enc = _encode(polys);
    if (_roundTripOk(polys, enc)) roundTripOk++;
    features.add(_Feature(
      districtId: props['districtId'] as String,
      nameEn: props['nameEn'] as String,
      enc: enc,
      polys: polys,
    ));
  }
  if (roundTripOk != features.length) {
    stderr.writeln(
      'Round-trip verification failed ($roundTripOk/${features.length}).',
    );
    exit(1);
  }

  // ── 2. Roster rows in canonical order ──
  final rows = <_Row>[];
  for (final p in (roster['provinces'] as List).cast<Map<String, dynamic>>()) {
    for (final d in (p['districts'] as List).cast<Map<String, dynamic>>()) {
      for (final lb
          in (d['localBodies'] as List).cast<Map<String, dynamic>>()) {
        rows.add(_Row(
          district: d['name'] as String,
          name: lb['name'] as String,
          lat: lb['lat'] as num?,
          lng: lb['lng'] as num?,
        ));
      }
    }
  }
  if (rows.length != 753) {
    stderr.writeln('Expected 753 roster rows, got ${rows.length}.');
    exit(1);
  }

  // ── 3. Point-in-polygon: which feature contains each roster centroid ──
  for (final f in features) {
    f.bbox = _bboxOf(f.polys);
  }
  for (final row in rows) {
    if (row.lat == null || row.lng == null) continue;
    for (final f in features) {
      if (_inFeature(row.lng!, row.lat!, f)) {
        row.containing = f;
        break;
      }
    }
  }

  // ── 4. District identity by majority vote ──
  final votes = <String, Map<String, int>>{};
  for (final row in rows) {
    final f = row.containing;
    if (f == null) continue;
    final byDistrict = votes.putIfAbsent(row.district, () => {});
    byDistrict[f.districtId] = (byDistrict[f.districtId] ?? 0) + 1;
  }
  final districtToId = <String, String>{};
  for (final entry in votes.entries) {
    var bestId = '';
    var bestCount = -1;
    for (final c in entry.value.entries) {
      if (c.value > bestCount) {
        bestId = c.key;
        bestCount = c.value;
      }
    }
    districtToId[entry.key] = bestId;
  }

  // ── 5. Stage 1: name join within district ──
  final byGeometryDistrict = <String, List<_Feature>>{};
  for (final f in features) {
    byGeometryDistrict.putIfAbsent(f.districtId, () => []).add(f);
  }
  var nameJoins = 0;
  for (final row in rows) {
    final did = districtToId[row.district];
    if (did == null) continue;
    final cands = (byGeometryDistrict[did] ?? const <_Feature>[])
        .where((f) => f.matchedRow == null && f.n == _norm(row.name))
        .toList();
    if (cands.length == 1) {
      cands.first.matchedRow = rows.indexOf(row);
      row.matched = true;
      nameJoins++;
    }
  }

  // ── 6. Stage 2: point-in-polygon fallback for the remainder ──
  var pipJoins = 0;
  for (final f in features) {
    if (f.matchedRow != null) continue;
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      if (row.matched || row.lat == null) continue;
      if (row.containing == f) {
        f.matchedRow = i;
        row.matched = true;
        pipJoins++;
        break;
      }
    }
  }

  final unmatched = features.where((f) => f.matchedRow == null).toList()
    ..sort(
      (a, b) => ('${a.districtId}|${a.nameEn}')
          .compareTo('${b.districtId}|${b.nameEn}'),
    );
  final matched = features.length - unmatched.length;
  if (matched + unmatched.length != 753) {
    stderr.writeln('Expected 753 features, got ${features.length}.');
    exit(1);
  }

  final featureByRow = <int, _Feature>{};
  for (final f in features) {
    if (f.matchedRow != null) featureByRow[f.matchedRow!] = f;
  }

  // ── 7. Emit the Dart literal ──
  final out = StringBuffer();
  void w(String line) => out.writeln(line);
  w('// GENERATED FILE - DO NOT EDIT.');
  w('//');
  w('// Lossless boundary geometry for all 753 local bodies (palikas) of '
      'Nepal,');
  w('// encoded as compact strings (format version 1 - see '
      'palika_boundary_codec.dart).');
  w('//');
  w('// Source: $geoPath (${meta['source']} @');
  w('// ${(meta['sourceCommit'] as String).substring(0, 7)}, '
      '${meta['license']}; originally');
  w('// ${meta['upstream']}, ${meta['license']}). '
      'Coordinates quantised to 1e-4');
  w('// degrees (~11 m) and stored as zigzag VLQ deltas: the round trip is');
  w('// bit-exact, nothing is simplified or dropped.');
  w('//');
  w('// Regenerate with: dart run tool/generate_palika_boundaries.dart');
  w('');
  w('/// Version of the palika boundary string format used in this file.');
  w("const String kPalikaBoundaryFormatVersion = '1';");
  w('');
  w('/// Number of palika boundary features carried in this file.');
  w('const int kPalikaBoundaryFeatureCount = ${features.length};');
  w('');
  w('/// Total boundary vertices across all features (ring closure vertices');
  w('/// are re-appended on decode and are not stored).');
  w('const int kPalikaBoundaryVertexCount = $uniqueVerts;');
  w('');
  w('/// Features joined to canonical roster entries by name or');
  w('/// point-in-polygon. The remainder is in [kUnmatchedPalikaBoundaries].');
  w('const int kPalikaBoundaryMatchedCount = $matched;');
  w('');
  w('/// Encoded boundaries, keyed by district name then local-body name '
      '(roster');
  w("/// spelling), e.g. `kPalikaBoundaries['Chitwan']?['Bharatpur']`.");
  w('const Map<String, Map<String, String>> kPalikaBoundaries = {');
  var emitted = 0;
  final seen = <String>{};
  var i = 0;
  while (i < rows.length) {
    final district = rows[i].district;
    final entries = <String>[];
    while (i < rows.length && rows[i].district == district) {
      final f = featureByRow[i];
      final key = '$district|${rows[i].name}';
      if (f != null && !seen.contains(key)) {
        seen.add(key);
        entries.add("    '${_esc(rows[i].name)}': '${f.enc}',");
        emitted++;
      }
      i++;
    }
    if (entries.isNotEmpty) {
      w("  '${_esc(district)}': {");
      for (final e in entries) {
        w(e);
      }
      w('  },');
    }
  }
  w('};');
  w('');
  w('/// Boundaries that could not be joined to a canonical roster entry '
      'by');
  w('/// name or point-in-polygon. Keyed by `districtId|geojsonName`.');
  if (unmatched.isEmpty) {
    w('const Map<String, String> kUnmatchedPalikaBoundaries = {};');
  } else {
    w('const Map<String, String> kUnmatchedPalikaBoundaries = {');
    for (final f in unmatched) {
      w("  '${_esc(f.districtId)}|${_esc(f.nameEn)}': '${f.enc}',");
    }
    w('};');
  }

  final text = out.toString();
  final bytes = utf8.encode(text).length;
  if (bytes >= 100 * 1024) {
    stderr.writeln('Size gate failed: $bytes bytes >= 100 KB.');
    exit(1);
  }

  if (check) {
    final existing = File(outPath).readAsStringSync();
    if (existing != text) {
      stderr.writeln(
        'Drift detected: $outPath differs from a fresh regeneration.',
      );
      exit(2);
    }
    stdout.writeln('OK: $outPath is up to date ($bytes bytes).');
    return;
  }

  File(outPath).writeAsStringSync(text);
  stdout.writeln('Wrote $outPath ($bytes bytes): '
      '$matched matched ($nameJoins name + $pipJoins point-in-polygon), '
      '${unmatched.length} unmatched.');
  stdout.writeln('Rings: $ringCount, stored vertices: $uniqueVerts, '
      'round-trip verified: $roundTripOk/${features.length}.');
}

// ── Encoding (format version 1) ────────────────────────────────────────

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

/// Decodes [enc] back to coordinates and compares against [polys] with a
/// 1e-9 tolerance. The round trip is expected to be exact.
bool _roundTripOk(List<List<List<List<double>>>> polys, String enc) {
  final decoded = _decode(enc);
  if (decoded.length != polys.length) return false;
  for (var p = 0; p < polys.length; p++) {
    if (decoded[p].length != polys[p].length) return false;
    for (var g = 0; g < polys[p].length; g++) {
      final a = polys[p][g], b = decoded[p][g];
      if (a.length != b.length) return false;
      for (var v = 0; v < a.length; v++) {
        if ((a[v][0] - b[v][0]).abs() > 1e-9) return false;
        if ((a[v][1] - b[v][1]).abs() > 1e-9) return false;
      }
    }
  }
  return true;
}

List<List<List<List<double>>>> _decode(String s) {
  final idx = <String, int>{};
  for (var i = 0; i < 64; i++) {
    idx[_alphabet[i]] = i;
  }
  var pos = 0;
  int vlq() {
    var result = 0;
    var shift = 0;
    int d;
    do {
      d = idx[s[pos++]]!;
      result += (d & 31) << shift;
      shift += 5;
    } while ((d & 32) != 0);
    return result;
  }

  int unzz(int u) => (u & 1) == 1 ? -((u + 1) >> 1) : u >> 1;

  final polys = <List<List<List<double>>>>[];
  var curLat = 0, curLng = 0;
  var anchored = false;
  final nPolys = vlq();
  for (var p = 0; p < nPolys; p++) {
    final nRings = vlq();
    final rings = <List<List<double>>>[];
    for (var g = 0; g < nRings; g++) {
      final n = vlq();
      final ring = <List<double>>[];
      for (var i = 0; i < n; i++) {
        if (anchored) {
          curLat += unzz(vlq());
          curLng += unzz(vlq());
        } else {
          curLat = unzz(vlq());
          curLng = unzz(vlq());
          anchored = true;
        }
        ring.add([curLng / 1e4, curLat / 1e4]);
      }
      ring.add([ring.first[0], ring.first[1]]);
      rings.add(ring);
    }
    polys.add(rings);
  }
  return polys;
}

// ── Geometry helpers ──────────────────────────────────────────────────

List<double> _bboxOf(List<List<List<List<double>>>> polys) {
  var minLat = 90.0, maxLat = -90.0, minLng = 180.0, maxLng = -180.0;
  for (final rings in polys) {
    for (final ring in rings) {
      for (final v in ring) {
        if (v[1] < minLat) minLat = v[1];
        if (v[1] > maxLat) maxLat = v[1];
        if (v[0] < minLng) minLng = v[0];
        if (v[0] > maxLng) maxLng = v[0];
      }
    }
  }
  return [minLat, maxLat, minLng, maxLng];
}

bool _inFeature(double lng, double lat, _Feature f) {
  if (lat < f.bbox[0] ||
      lat > f.bbox[1] ||
      lng < f.bbox[2] ||
      lng > f.bbox[3]) {
    return false;
  }
  for (final rings in f.polys) {
    if (rings.isEmpty) continue;
    if (_inRing(lng, lat, rings.first)) {
      var inHole = false;
      for (var i = 1; i < rings.length; i++) {
        if (_inRing(lng, lat, rings[i])) {
          inHole = true;
          break;
        }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

bool _inRing(double lng, double lat, List<List<double>> ring) {
  var inside = false;
  for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    final xi = ring[i][0], yi = ring[i][1];
    final xj = ring[j][0], yj = ring[j][1];
    if ((yi > lat) != (yj > lat) &&
        lng < (xj - xi) * (lat - yi) / (yj - yi) + xi) {
      inside = !inside;
    }
  }
  return inside;
}

// ── Misc ───────────────────────────────────────────────────────────────

String _norm(String s) =>
    s.toLowerCase().replaceAll(RegExp('[^a-z0-9\\u0900-\\u097F]'), '');

String _esc(String s) => s.replaceAll('\\', '\\\\').replaceAll("'", "\\'");

class _Feature {
  final String districtId;
  final String nameEn;
  final String enc;
  final List<List<List<List<double>>>> polys;
  late final List<double> bbox;
  int? matchedRow;

  _Feature({
    required this.districtId,
    required this.nameEn,
    required this.enc,
    required this.polys,
  });

  String get n => _norm(nameEn);
}

class _Row {
  final String district;
  final String name;
  final double? lat;
  final double? lng;
  _Feature? containing;
  bool matched = false;

  _Row({
    required this.district,
    required this.name,
    num? lat,
    num? lng,
  })  : lat = lat?.toDouble(),
        lng = lng?.toDouble();
}
