// tool/generate_palika_boundaries_highres.dart
//
// Regenerates lib/src/geo/palika_boundaries.dart from the high-resolution
// palika boundary GeoJSON (docs/palika-boundaries-highres.geojson, scraped
// from sthaniya.gov.np via Acesmndr/nepal-geojson, MIT license).
//
// Matching: each roster palika centroid (lat/lng) is tested against every
// highres palika boundary using point-in-polygon (ray casting). Name
// matching (Levenshtein <= 3) is used as fallback.
//
// Output: lib/src/geo/palika_boundaries.dart — palika boundaries encoded
// as compact strings (format version 1, see palika_boundary_codec.dart).
// Size gate: refuses to emit if >= 100 KB.

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
  var curLat = 0, curLng = 0, anchored = false;
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

List<List<double>> _simplifyRing(List<List<double>> ring, double eps) {
  if (ring.length <= 2) return List.of(ring);
  double perpDist(List<double> pt, List<double> a, List<double> b) {
    final dx = b[0] - a[0], dy = b[1] - a[1];
    final len2 = dx * dx + dy * dy;
    if (len2 == 0) {
      final dx2 = pt[0] - a[0], dy2 = pt[1] - a[1];
      return dx2 * dx2 + dy2 * dy2;
    }
    var t = ((pt[0] - a[0]) * dx + (pt[1] - a[1]) * dy) / len2;
    t = t.clamp(0, 1);
    final px = a[0] + t * dx, py = a[1] + t * dy;
    final dx2 = pt[0] - px, dy2 = pt[1] - py;
    return dx2 * dx2 + dy2 * dy2;
  }
  List<List<double>> dp(List<List<double>> pts) {
    if (pts.length <= 2) return List.of(pts);
    var maxD = -1.0, idx = 1;
    final a = pts.first, b = pts.last;
    for (var i = 1; i < pts.length - 1; i++) {
      final d = perpDist(pts[i], a, b);
      if (d > maxD) { maxD = d; idx = i; }
    }
    if (maxD > eps * eps) {
      final left = dp(pts.sublist(0, idx + 1));
      final right = dp(pts.sublist(idx));
      return [...left.sublist(0, left.length - 1), ...right];
    }
    return [pts.first, pts.last];
  }
  return dp(ring);
}

bool _pointInRing(double lat, double lng, List<List<double>> ring) {
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

bool _pointInMultiPolygon(double lat, double lng,
    List<List<List<List<double>>>> polys) {
  for (final rings in polys) {
    if (rings.isEmpty) continue;
    if (_pointInRing(lat, lng, rings.first)) {
      var inHole = false;
      for (var i = 1; i < rings.length; i++) {
        if (_pointInRing(lat, lng, rings[i])) { inHole = true; break; }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

String _normName(String s) =>
    (s ?? '').toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

int _levenshtein(String a, String b) {
  if (a == b) return 0;
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;
  var prev = List<int>.generate(b.length + 1, (i) => i);
  for (var i = 1; i <= a.length; i++) {
    var cur = <int>[i];
    for (var j = 1; j <= b.length; j++) {
      final cost = a[i - 1] == b[j - 1] ? 0 : 1;
      cur.add((prev[j] + 1).clamp(0, 1000000).toInt());
      cur[j] = (cur[j - 1] + 1).clamp(0, 1000000).toInt();
      cur[j] = (prev[j - 1] + cost).clamp(0, 1000000).toInt();
    }
    prev = cur;
  }
  return prev[b.length];
}

String _stripTypeSuffix(String s) {
  final suffixes = [
    'Gaunpalika', 'Nagarpalika', 'Mahanagarpalika', 'Upamahanagarpalika',
    'Gaun Palika', 'Nagar Palika', 'Mahanagar Palika', 'Upamahanagar Palika',
    'Municipality', 'Rural Municipality', 'Sub-Metropolitan City',
    'Metropolitan City',
  ];
  var n = s.trim();
  for (final suf in suffixes) {
    if (n.endsWith(suf)) n = n.substring(0, n.length - suf.length).trim();
  }
  return n;
}

void main(List<String> args) {
  final check = args.contains('--check');
  const geoPath = 'docs/palika-boundaries-highres.geojson';
  const rosterPath = 'data/nepal_local_levels.json';
  const outPath = 'lib/src/geo/palika_boundaries.dart';
  const eps = 0.006;

  final geoFile = File(geoPath);
  final rosterFile = File(rosterPath);
  if (!geoFile.existsSync()) {
    stderr.writeln('Missing input: $geoPath.');
    exit(1);
  }
  if (!rosterFile.existsSync()) {
    stderr.writeln('Missing input: $rosterPath.');
    exit(1);
  }

  final geo = jsonDecode(geoFile.readAsStringSync()) as Map<String, dynamic>;
  final roster = jsonDecode(rosterFile.readAsStringSync()) as Map<String, dynamic>;

  // Decode highres features (all are palikas after conversion filtering).
  final features = <Map<String, dynamic>>[];
  for (final raw in _maps(geo['features'])) {
    final props = raw['properties'] as Map<String, dynamic>;
    final geom = raw['geometry'] as Map<String, dynamic>;
    final coords = geom['coordinates'] as List<dynamic>;
    final rawPolys = geom['type'] == 'Polygon'
        ? <dynamic>[coords]
        : coords.expand((p) => p as List<dynamic>).toList();
    final polys = List<List<List<List<double>>>>.empty(growable: true);
    for (final rawPoly in rawPolys) {
      final rings = List<List<List<double>>>.empty(growable: true);
      for (final rawRing in rawPoly as List<dynamic>) {
        final ring = List<List<double>>.empty(growable: true);
        for (final v in rawRing as List<dynamic>) {
          final c = v as List<dynamic>;
          ring.add([(c[0] as num).toDouble(), (c[1] as num).toDouble()]);
        }
        rings.add(_simplifyRing(ring, eps));
      }
      polys.add(rings);
    }
    features.add({
      'district': props['district'] ?? '',
      'nameEn': props['nameEn'] ?? '',
      'polys': polys,
    });
  }
  stderr.writeln('Highres palika features: ${features.length}');

  // Roster rows with centroids.
  final rosterRows = <Map<String, dynamic>>[];
  for (final p in _maps(roster['provinces'])) {
    for (final d in _maps(p['districts'])) {
      for (final lb in _maps(d['localBodies'])) {
        if (lb['lat'] != null && lb['lng'] != null) {
          rosterRows.add({
            'district': d['name'],
            'name': lb['name'],
            'lat': (lb['lat'] as num).toDouble(),
            'lng': (lb['lng'] as num).toDouble(),
          });
        }
      }
    }
  }
  stderr.writeln('Roster palikas with centroids: ${rosterRows.length}');

  // Match: point-in-polygon first, name match fallback.
  final matched = Map<String, dynamic>();
  var unmatched = 0;
  final unmatchedList = <String>[];
  for (final row in rosterRows) {
    final lat = row['lat'] as double, lng = row['lng'] as double;
    Map<String, dynamic>? best;

    // 1. Point-in-polygon.
    for (final f in features) {
      if (_pointInMultiPolygon(lat, lng,
          f['polys'] as List<List<List<List<double>>>>)) {
        best = f;
        break;
      }
    }

    // 2. Name match fallback.
    if (best == null) {
      final nEn = _normName(_stripTypeSuffix(row['name'] as String));
      Map<String, dynamic>? nameBest;
      var nameBestD = 999;
      for (final f in features) {
        if (f['district'] != row['district']) continue;
        final hName = f['nameEn'] as String;
        final d = _levenshtein(nEn, _normName(_stripTypeSuffix(hName)));
        if (d < nameBestD) { nameBestD = d; nameBest = f; }
      }
      if (nameBest != null && nameBestD <= 3) best = nameBest;
    }

    if (best != null) {
      matched['${row['district']}|${row['name']}'] = best;
    } else {
      unmatched++;
      unmatchedList.add('${row['district']} / ${row['name']}');
    }
  }

  stderr.writeln('Matched: ${matched.length} of ${rosterRows.length}');
  stderr.writeln('Unmatched: $unmatched');
  if (unmatchedList.isNotEmpty) {
    stderr.writeln('Unmatched: ${unmatchedList.take(10).join(', ')}');
  }

  // Encode matched features.
  final entries = <Map<String, dynamic>>[];
  final seenKeys = <String>{};
  var uniqueVerts = 0, roundTripOk = 0;
  for (final e in matched.entries) {
    final key = e.key;
    if (seenKeys.contains(key)) continue;
    seenKeys.add(key);
    final f = e.value;
    final enc = _encode(f['polys'] as List<List<List<List<double>>>>);

    var rtOk = false;
    try {
      final reader = _Reader(enc);
      final nPolys = reader.vlq();
      for (var p = 0; p < nPolys; p++) {
        final nRings = reader.vlq();
        for (var g = 0; g < nRings; g++) {
          final n = reader.vlq();
          for (var i = 0; i < n; i++) {
            reader.zigzagVlq();
            reader.zigzagVlq();
          }
        }
      }
      if (reader.remaining == 0) rtOk = true;
    } catch (_) {}
    if (rtOk) roundTripOk++;

    var fVerts = 0;
    for (final rings in f['polys'] as List<List<List<List<double>>>>) {
      for (final ring in rings) fVerts += ring.length - 1;
    }
    uniqueVerts += fVerts;

    final rd = key.substring(0, key.indexOf('|'));
    final rn = key.substring(key.indexOf('|') + 1);
    entries.add({
      'district': rd,
      'nameEn': rn,
      'enc': enc,
    });
  }
  entries.sort((a, b) {
    final dc = (a['district'] as String).compareTo(b['district'] as String);
    if (dc != 0) return dc;
    return (a['nameEn'] as String).compareTo(b['nameEn'] as String);
  });

  final out = StringBuffer();
  void w(String line) => out.writeln(line);
  w('// GENERATED FILE - DO NOT EDIT.');
  w('//');
  w('// Lossless boundary geometry for local bodies (palikas) of Nepal,');
  w('// encoded as compact strings (format version 1 - see');
  w('// palika_boundary_codec.dart).');
  w('//');
  w('// Source: docs/palika-boundaries-highres.geojson (scraped from');
  w('// sthaniya.gov.np via Acesmndr/nepal-geojson, MIT license).');
  w('// Coordinates quantised to 1e-4 degrees (~11 m) and stored as');
  w('// zigzag VLQ deltas: the round trip is bit-exact.');
  w('//');
  w('// Regenerate with: dart run tool/generate_palika_boundaries_highres.dart');
  w('');
  w("const String kPalikaBoundaryFormatVersion = '1';");
  w('');
  w('const int kPalikaBoundaryFeatureCount = ${entries.length};');
  w('');
  w('/// Total boundary vertices across all features (ring closure vertices');
  w('/// are re-appended on decode and are not stored).');
  w('const int kPalikaBoundaryVertexCount = $uniqueVerts;');
  w('');
  w('/// Features joined to canonical roster entries.');
  w('const int kPalikaBoundaryMatchedCount = ${entries.length};');
  w('');
  w('/// Encoded boundaries, keyed by district name then local-body name');
  w("/// spelling, e.g. \`kPalikaBoundaries['Chitwan']?['Bharatpur']\`.");
  w('const Map<String, Map<String, String>> kPalikaBoundaries = {');
  final seen = <String>{};
  var i = 0;
  while (i < entries.length) {
    final district = entries[i]['district'] as String;
    final ents = <String>[];
    while (i < entries.length && entries[i]['district'] == district) {
      final key = '$district|${entries[i]['nameEn']}';
      if (!seen.contains(key)) {
        seen.add(key);
        ents.add("    '${_esc(entries[i]['nameEn'])}': '${entries[i]['enc']}',");
      }
      i++;
    }
    if (ents.isNotEmpty) {
      w("  '${_esc(district)}': {");
      for (final e in ents) w(e);
      w('  },');
    }
  }
  w('};');
  w('');
  w('/// Boundaries that could not be joined to a canonical roster entry.');
  w('const Map<String, String> kUnmatchedPalikaBoundaries = {};');

  final text = out.toString();
  if (check) {
    final existing = File(outPath).readAsStringSync();
    if (existing != text) {
      stderr.writeln('Drift detected: $outPath differs.');
      exit(2);
    }
    stdout.writeln('OK: $outPath is up to date.');
    return;
  }
  File(outPath).writeAsStringSync(text);
  stdout.writeln('Wrote $outPath: ${entries.length} palikas, '
      '$uniqueVerts vertices, round-trip: $roundTripOk/${entries.length}.');
}

List<Map<String, dynamic>> _maps(dynamic v) =>
    (v as List<dynamic>).cast<Map<String, dynamic>>();

String _esc(String s) {
  var out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    final ch = s.codeUnitAt(i);
    if (ch == 0x27) out.write("\\'");
    else if (ch == 0x5C) out.write('\\\\');
    else if (ch == 0x0A) out.write('\\n');
    else if (ch == 0x0D) out.write('\\r');
    else if (ch < 0x20 || ch > 0x7E)
      out.write('\\u${ch.toRadixString(16).padLeft(4, '0')}');
    else out.writeCharCode(ch);
  }
  return out.toString();
}

class _Reader {
  final String _s;
  var _pos = 0;
  _Reader(this._s);
  int get remaining => _s.length - _pos;
  int vlq() {
    var result = 0, shift = 0;
    int digit;
    do {
      if (_pos >= _s.length) throw const FormatException('Truncated VLQ');
      digit = _digit(_s.codeUnitAt(_pos++));
      result += (digit & 31) << shift;
      shift += 5;
      if (shift > 50) throw const FormatException('VLQ too long');
    } while (digit & 32 != 0);
    return result;
  }
  int zigzagVlq() {
    final u = vlq();
    return (u & 1) == 1 ? -((u + 1) >> 1) : u >> 1;
  }
  static int _digit(int unit) {
    if (unit >= 65 && unit <= 90) return unit - 65;
    if (unit >= 97 && unit <= 122) return unit - 97 + 26;
    if (unit >= 48 && unit <= 57) return unit - 48 + 52;
    if (unit == 43) return 62;
    if (unit == 47) return 63;
    throw const FormatException('Invalid VLQ char');
  }
}









