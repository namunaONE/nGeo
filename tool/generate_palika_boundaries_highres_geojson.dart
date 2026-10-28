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
// Output: lib/src/geo/palika_boundaries.dart ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€šÃ‚Â palika boundaries encoded
// as compact strings (format version 1, see palika_boundary_codec.dart).
// Size gate: refuses to emit if >= 100 KB.

import 'dart:convert';
import 'dart:io';

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
    t = t.clamp(0, 1).toDouble();
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
      if (d > maxD) {
        maxD = d;
        idx = i;
      }
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

bool _pointInMultiPolygon(
    double lat, double lng, List<List<List<List<double>>>> polys) {
  for (final rings in polys) {
    if (rings.isEmpty) continue;
    if (_pointInRing(lat, lng, rings.first)) {
      var inHole = false;
      for (var i = 1; i < rings.length; i++) {
        if (_pointInRing(lat, lng, rings[i])) {
          inHole = true;
          break;
        }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

String _normName(String s) =>
    s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

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
    'Gaunpalika',
    'Nagarpalika',
    'Mahanagarpalika',
    'Upamahanagarpalika',
    'Gaun Palika',
    'Nagar Palika',
    'Mahanagar Palika',
    'Upamahanagar Palika',
    'Municipality',
    'Rural Municipality',
    'Sub-Metropolitan City',
    'Metropolitan City',
  ];
  var n = s.trim();
  for (final suf in suffixes) {
    if (n.endsWith(suf)) n = n.substring(0, n.length - suf.length).trim();
  }
  return n;
}

void main(List<String> args) {
  const geoPath = 'docs/palika-boundaries-highres.geojson';
  const rosterPath = 'data/nepal_local_levels.json';
  const outPath = 'docs/palika-boundaries-highres-mid.geojson';
  const eps = 0.001;

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
  final roster =
      jsonDecode(rosterFile.readAsStringSync()) as Map<String, dynamic>;

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
      'nameNe': props['nameNe'],
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
            'province': p['name'],
            'provinceCbs': p['cbsCode'],
            'district': d['name'],
            'name': lb['name'],
            'type': lb['type'],
            'nameNe': lb['nameNe'],
            'lat': (lb['lat'] as num).toDouble(),
            'lng': (lb['lng'] as num).toDouble(),
          });
        }
      }
    }
  }
  stderr.writeln('Roster palikas with centroids: ${rosterRows.length}');

  // Match: point-in-polygon first, name match fallback.
  final matched = <String, dynamic>{};
  var unmatched = 0;
  final unmatchedList = <String>[];
  for (final row in rosterRows) {
    final lat = row['lat'] as double, lng = row['lng'] as double;
    Map<String, dynamic>? best;

    // 1. Point-in-polygon.
    for (final f in features) {
      if (_pointInMultiPolygon(
          lat, lng, f['polys'] as List<List<List<List<double>>>>)) {
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
        if (d < nameBestD) {
          nameBestD = d;
          nameBest = f;
        }
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

  stderr.writeln('DEBUG raw source verts: (see below)');
  stderr.writeln('Matched: ${matched.length} of ${rosterRows.length}');
  stderr.writeln('Unmatched: $unmatched');
  if (unmatchedList.isNotEmpty) {
    stderr.writeln('Unmatched: ${unmatchedList.take(10).join(', ')}');
  }

  // Build district-name -> districtId map from the simplified boundaries file.
  final simpleGeo =
      jsonDecode(File('docs/palika-boundaries.geojson').readAsStringSync())
          as Map<String, dynamic>;
  final districtNameToId = <String, String>{};
  final districtNameToProvinceId = <String, String>{};
  for (final raw in _maps(simpleGeo['features'])) {
    final p = raw['properties'] as Map<String, dynamic>;
    final did = p['districtId'] as String;
    final pid = p['provinceId'] as String;
    final nameEn = p['nameEn'] as String;
    // Find the roster palika with this nameEn in this province to get the
    // district name. Province id P# -> province cbsCode.
    final provCode = int.parse(pid.substring(1));
    final province = roster['provinces'].firstWhere(
        (pr) => (pr as Map)['cbsCode'] == provCode,
        orElse: () => null);
    if (province == null) continue;
    for (final d in _maps((province as Map)['districts'])) {
      for (final lb in _maps(d['localBodies'])) {
        if ((lb['name'] as String).toLowerCase() == nameEn.toLowerCase()) {
          districtNameToId[d['name'] as String] = did;
          districtNameToProvinceId[d['name'] as String] = pid;
        }
      }
    }
  }

  // Build roster lookups: district name -> (province name, province cbsCode)
  // and palika name -> type/nameNe (from roster).
  final rosterTypeByName = <String, String>{};
  final rosterNameNeByName = <String, String?>{};
  final rosterProvinceByDistrict = <String, String>{};
  final rosterProvinceCbsByDistrict = <String, int>{};
  for (final p in _maps(roster['provinces'])) {
    for (final d in _maps(p['districts'])) {
      rosterProvinceByDistrict[d['name'] as String] = p['name'] as String;
      rosterProvinceCbsByDistrict[d['name'] as String] =
          (p['cbsCode'] as num).toInt();
      for (final lb in _maps(d['localBodies'])) {
        final k = '${d['name']}|${lb['name']}';
        rosterTypeByName[k] = lb['type'] as String? ?? '';
        rosterNameNeByName[k] = lb['nameNe'] as String?;
      }
    }
  }

  // Build GeoJSON features from matched high-res boundaries.
  final geoFeatures = <Map<String, dynamic>>[];
  for (final e in matched.entries) {
    final key = e.key;
    final sep = key.indexOf('|');
    final districtName = key.substring(0, sep);
    final f = e.value;
    final polys = f['polys'] as List<List<List<List<double>>>>;

    // (Already simplified at eps during feature loading; do not re-simplify.)

    final districtId = districtNameToId[districtName] ?? '';
    final provinceId = districtNameToProvinceId[districtName] ??
        'P${rosterProvinceCbsByDistrict[districtName]}';
    final type = rosterTypeByName[key] ?? '';
    final nameNe = rosterNameNeByName[key] ?? (f['nameNe'] as String?);
    final nameEn = f['nameEn'] as String;

    geoFeatures.add({
      'type': 'Feature',
      'properties': {
        'districtId': districtId,
        'provinceId': provinceId,
        'nameEn': nameEn,
        'nameNe': nameNe,
        'type': type,
        'matched': true,
      },
      'geometry': {
        'type': 'MultiPolygon',
        'coordinates': polys,
      },
    });
  }

  // Sort by districtId then nameEn for stable output.
  geoFeatures.sort((a, b) {
    final pa = a['properties'] as Map<String, dynamic>;
    final pb = b['properties'] as Map<String, dynamic>;
    final dc =
        (pa['districtId'] as String).compareTo(pb['districtId'] as String);
    if (dc != 0) return dc;
    return (pa['nameEn'] as String).compareTo(pb['nameEn'] as String);
  });

  final fc = {
    'type': 'FeatureCollection',
    'features': geoFeatures,
  };

  File(outPath).writeAsStringSync(jsonEncode(fc));
  stderr.writeln('Wrote $outPath: ${geoFeatures.length} features, '
      '${_countVerts(geoFeatures)} vertices.');
}

int _countVerts(List<Map<String, dynamic>> features) {
  var n = 0;
  for (final f in features) {
    final g = f['geometry'] as Map<String, dynamic>;
    void walk(dynamic x) {
      if (x is List && x.isNotEmpty && x[0] is num) {
        n++;
      } else if (x is List) {
        for (final y in x) {
          walk(y);
        }
      }
    }

    walk(g['coordinates']);
  }
  // each vertex counted once (points are [lng,lat] pairs -> 2 nums; count points)
  return n ~/ 2;
}

List<Map<String, dynamic>> _maps(dynamic v) =>
    (v as List<dynamic>).cast<Map<String, dynamic>>();
