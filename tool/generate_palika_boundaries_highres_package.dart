// tool/generate_palika_boundaries_highres_package.dart
//
// Regenerates packages/nepal_admin_boundaries_highres/lib/src/highres_boundaries_data.dart
// from the HDX COD-AB GeoJSON (official Survey Department of Nepal boundaries).
//
// Same matching logic as generate_palika_boundaries_hdx.dart, but with
// eps=0.001 (higher detail) and output to the high-res package.
//
// Usage:
//   dart run tool/generate_palika_boundaries_highres_package.dart

import 'dart:convert';
import 'dart:io';

const _alphabet =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

// ---- Helpers ----

int _levenshtein(String a, String b) {
  if (a == b) return 0;
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;
  var prev = List<int>.generate(b.length + 1, (i) => i);
  for (var i = 1; i <= a.length; i++) {
    var cur = <int>[i];
    for (var j = 1; j <= b.length; j++) {
      final cost = a[i - 1] == b[j - 1] ? 0 : 1;
      cur.add([prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + cost]
          .reduce((x, y) => x < y ? x : y));
    }
    prev = cur;
  }
  return prev[b.length];
}

bool _pointInRing(double lat, double lng, List<dynamic> ring) {
  var inside = false;
  for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    final xi = (ring[i][0] as num).toDouble();
    final yi = (ring[i][1] as num).toDouble();
    final xj = (ring[j][0] as num).toDouble();
    final yj = (ring[j][1] as num).toDouble();
    if ((yi > lat) != (yj > lat) &&
        lng < (xj - xi) * (lat - yi) / (yj - yi) + xi) {
      inside = !inside;
    }
  }
  return inside;
}

bool _containsPoint(Map<String, dynamic> geom, double lat, double lng) {
  final type = geom['type'] as String;
  final polys = type == 'Polygon'
      ? <dynamic>[geom['coordinates']]
      : geom['coordinates'] as List<dynamic>;
  for (final poly in polys) {
    final rings = poly as List<dynamic>;
    if (rings.isEmpty) continue;
    if (_pointInRing(lat, lng, rings[0] as List<dynamic>)) {
      var inHole = false;
      for (var h = 1; h < rings.length; h++) {
        if (_pointInRing(lat, lng, rings[h] as List<dynamic>)) {
          inHole = true;
          break;
        }
      }
      if (!inHole) return true;
    }
  }
  return false;
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

  final pts = ring.length > 1 &&
          ring.first[0] == ring.last[0] &&
          ring.first[1] == ring.last[1]
      ? ring.sublist(0, ring.length - 1)
      : ring;
  if (pts.length <= 2) return List.of(ring);
  final deduped = <List<double>>[pts.first];
  for (var i = 1; i < pts.length; i++) {
    final prev = deduped.last;
    if ((prev[0] - pts[i][0]).abs() > 1e-4 ||
        (prev[1] - pts[i][1]).abs() > 1e-4) {
      deduped.add(pts[i]);
    }
  }
  if (deduped.length <= 2) return List.of(ring);
  final simplified = dp(deduped);
  final qResult = simplified
      .map((v) => [(v[0] * 1e4).round() / 1e4, (v[1] * 1e4).round() / 1e4])
      .toList();
  final finalResult = <List<double>>[qResult.first];
  for (var i = 1; i < qResult.length; i++) {
    final prev = finalResult.last;
    if ((prev[0] - qResult[i][0]).abs() > 1e-12 ||
        (prev[1] - qResult[i][1]).abs() > 1e-12) {
      finalResult.add(qResult[i]);
    }
  }
  if (finalResult.length > 1 &&
      (finalResult.first[0] != finalResult.last[0] ||
          finalResult.first[1] != finalResult.last[1])) {
    finalResult.add([finalResult.first[0], finalResult.first[1]]);
  }
  return finalResult.length >= 4 ? finalResult : List.of(ring);
}

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

String _esc(String s) {
  var out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    final ch = s.codeUnitAt(i);
    if (ch == 0x27) {
      out.write("\\'");
    } else if (ch == 0x5C) {
      out.write('\\\\');
    } else if (ch == 0x0A) {
      out.write('\\n');
    } else if (ch == 0x0D) {
      out.write('\\r');
    } else if (ch < 0x20 || ch > 0x7E) {
      out.write('\\u${ch.toRadixString(16).padLeft(4, '0')}');
    } else {
      out.writeCharCode(ch);
    }
  }
  return out.toString();
}

Map<String, dynamic> _readJson(File file) =>
    jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

const Map<String, String> _renameMap = {
  'Chitwan': 'Chitawan',
  'Dhanusha': 'Dhanusa',
  'Kapilvastu': 'Kapilbastu',
  'Nawalpur': 'Nawalparasi East',
  'Parasi (Nawalparasi West)': 'Nawalparasi West',
  'Tanahun': 'Tanahu',
  'Sunkoshi': 'Limchunbung',
  'Belhi Chapena': 'Rajgadh',
  'Dhorchaur': 'Siddha Kumakh',
  'Kumakh Malika': 'Kumakh',
  'Kanda': 'Saipal',
  'Nalagad': 'Nalgad',
  'Netrawati': 'Netrawati Dabjong',
  'Neshang': 'Ngisyang',
  'Kalika': 'Shuva Kalika',
  'Baraha': 'Barahachhetra',
  'Bheri': 'Bheri Malika',
  'Mugu Karmarong': 'Mugumakarmarog',
  'Meghang': 'Myagang',
  'Nashong': 'Nason',
  'Gharapjhong': 'Gharpajhong',
  'Baitedhar': 'Baiteshwor',
  'Tyamke Maiyum': 'Temkemaiyum',
  'Solu Dudhkunda': 'Solu Dhudhakunda',
  'Phaktanglung': 'Phaktanlung',
  'Sirijangha': 'Sirijanga',
  'Menchhyayem': 'Menchhayayem',
  'Sahidbhumi': 'Shahidbhumi',
  'Ilam': 'Illam',
  'Fakfokathum': 'Fakphokthum',
  'Harinagara': 'Harinagar',
  'Budhanilkantha': 'Budhanilkhantha',
  'Gokarneshwar': 'Gokarneshwor',
  'Kageshwari Manohara': 'Kageshwori Manahara',
  'Tarakeshwar': 'Tarakeshwor',
  'Chautara Sangachowkgadhi': 'Choutara Sangachowkgadhi',
  'Jaimini': 'Jaimuni',
  'Arjunchaupari': 'Arjun Choupari',
  'Nepalgunj': 'Nepalganj',
  'Airawati': 'Aairawati',
  'Paribartan': 'Pariwartan',
  'Thabang': 'Thawang',
  'Jayaprithvi': 'Jayaprithbi',
  'Aanbu Khaireni': 'Ambukhaireni',
  'Shuklagandaki': 'Shukla Gandaki',
  'Likhu': 'Likhu Tamakoshi',
  'Bhimsen': 'Bhimsenthapa',
  'Sulikot': 'Barpak Sulikot',
  'Narpa Bhumi': 'Narpa Bhumi',
  'Manang Ngisyang': 'Manang Ngisyang',
  'Varagung Muktichhetra': 'Varagung Muktichhetra',
  'Lo Ghekar Damodarkunda': 'Lo-Ghekar Damodarkunda',
  'Ruruchhetra': 'Ruruchhetra',
  'Diprung Chuichumma': 'Diprung Chuichumma',
  'Barahachhetra': 'Barahachhetra',
  'Bhokraha Narsingh': 'Bhokraha Narsingh',
  'Swami Kartik': 'Swamikartik Khapar',
  'Bogatan': 'Bogatan Phudsil',
  'Sahidnagar': 'Shahidnagar',
};

void main(List<String> args) {
  const geoPath = 'docs/palika-boundaries-highres.geojson';
  const rosterPath = 'data/nepal_local_levels.json';
  const outPath =
      'packages/nepal_admin_boundaries_highres/lib/src/highres_boundaries_data.dart';
  const eps = 0.001;

  final geoFile = File(geoPath);
  final rosterFile = File(rosterPath);
  if (!geoFile.existsSync() || !rosterFile.existsSync()) {
    stderr.writeln(
        'Missing input: $geoPath and $rosterPath must both be present.');
    exit(1);
  }

  final geo = _readJson(geoFile);
  final roster = _readJson(rosterFile);

  // ---- Load HDX features (filter protected areas by pcode >= 500) ----
  final hdxFeatures = <Map<String, dynamic>>[];
  for (final raw in (geo['features'] as List<dynamic>)) {
    final f = raw as Map<String, dynamic>;
    final props = f['properties'] as Map<String, dynamic>;
    final pcode = props['adm3_pcode'] as String;
    final palikaCode = int.parse(pcode.substring(pcode.length - 3));
    if (palikaCode >= 500) continue;
    final geom = f['geometry'] as Map<String, dynamic>;
    final coords = geom['coordinates'] as List<dynamic>;
    final rawPolys = geom['type'] == 'Polygon'
        ? <dynamic>[coords]
        : coords; // MultiPolygon: list of polygons, each = [ring]
    final polys = <List<List<List<double>>>>[];
    for (final rawPoly in rawPolys) {
      final rings = <List<List<double>>>[];
      for (final rawRing in (rawPoly as List<dynamic>)) {
        final ring = <List<double>>[];
        for (final v in (rawRing as List<dynamic>)) {
          final c = v as List<dynamic>;
          ring.add([(c[0] as num).toDouble(), (c[1] as num).toDouble()]);
        }
        rings.add(_simplifyRing(ring, eps));
      }
      polys.add(rings);
    }
    hdxFeatures.add({
      'district': props['adm2_name'] ?? '',
      'nameEn': props['adm3_name'] ?? '',
      'polys': polys,
      'props': props,
      'geometry': geom,
    });
  }
  stderr.writeln(
      'HDX palika features: ${hdxFeatures.length} (after filtering protected areas)');

  // ---- Roster rows with centroids ----
  final rosterRows = <Map<String, dynamic>>[];
  for (final p in (roster['provinces'] as List<dynamic>)) {
    for (final d
        in ((p as Map<String, dynamic>)['districts'] as List<dynamic>)) {
      for (final lb
          in ((d as Map<String, dynamic>)['localBodies'] as List<dynamic>)) {
        final lbm = lb as Map<String, dynamic>;
        if (lbm['lat'] != null && lbm['lng'] != null) {
          rosterRows.add({
            'district': d['name'],
            'name': lbm['name'],
            'lat': (lbm['lat'] as num).toDouble(),
            'lng': (lbm['lng'] as num).toDouble(),
          });
        }
      }
    }
  }
  stderr.writeln('Roster palikas with centroids: ${rosterRows.length}');

  // ---- Matching ----
  String normDistrict(String name) {
    const mapping = {
      'Chitwan': 'Chitawan',
      'Dhanusha': 'Dhanusa',
      'Kapilvastu': 'Kapilbastu',
      'Nawalpur': 'Nawalparasi East',
      'Parasi (Nawalparasi West)': 'Nawalparasi West',
      'Tanahun': 'Tanahu',
    };
    return mapping[name] ?? name;
  }

  String normName(String s) {
    var n = s.toLowerCase().trim();
    const suffixes = [
      'gaunpalika',
      'nagarpalika',
      'mahanagarpalika',
      'upamahanagarpalika',
      'municipality',
      'rural municipality',
      'metropolitan city',
      'sub-metropolitan city',
      'sub metropolitan city',
    ];
    for (final suf in suffixes) {
      if (n.endsWith(suf)) n = n.substring(0, n.length - suf.length).trim();
    }
    n = n.replaceAll(RegExp(r'[^a-z0-9]'), '');
    return n;
  }

  int matchedCount = 0;
  final entries = <Map<String, dynamic>>[];
  final seen = <String>{};
  var uniqueVerts = 0;
  var roundTripOk = 0;

  for (final row in rosterRows) {
    final lat = row['lat'] as double, lng = row['lng'] as double;
    final district = row['district'] as String;
    final name = row['name'] as String;
    final hdxDistrict = normDistrict(district);

    final candidates =
        hdxFeatures.where((f) => f['district'] == hdxDistrict).toList();

    Map<String, dynamic>? best;

    // 1. Exact normalized name.
    for (final f in candidates) {
      final props = f['props'] as Map<String, dynamic>;
      if (normName(props['adm3_name'] as String) == normName(name)) {
        best = f;
        break;
      }
    }

    // 2. Rename map.
    if (best == null && _renameMap.containsKey(name)) {
      final target = _renameMap[name]!;
      for (final f in candidates) {
        final props = f['props'] as Map<String, dynamic>;
        if (normName(props['adm3_name'] as String) == normName(target)) {
          best = f;
          break;
        }
      }
    }

    // 3. Fuzzy name (Levenshtein <= 3), validated by centroid containment.
    if (best == null) {
      Map<String, dynamic>? fuzzyBest;
      var fuzzyBestD = 999;
      for (final f in candidates) {
        final props = f['props'] as Map<String, dynamic>;
        final d = _levenshtein(
            normName(props['adm3_name'] as String), normName(name));
        if (d < fuzzyBestD) {
          fuzzyBestD = d;
          fuzzyBest = f;
        }
      }
      if (fuzzyBest != null && fuzzyBestD <= 3) {
        final geom = fuzzyBest['geometry'] as Map<String, dynamic>;
        if (_containsPoint(geom, lat, lng)) {
          best = fuzzyBest;
        }
      }
    }

    // 4. Centroid containment.
    if (best == null) {
      for (final f in candidates) {
        final geom = f['geometry'] as Map<String, dynamic>;
        if (_containsPoint(geom, lat, lng)) {
          best = f;
          break;
        }
      }
    }

    if (best == null) {
      stderr.writeln('UNMATCHED: $name ($district)');
      continue;
    }

    // Encode.
    final polys = best['polys'] as List<List<List<List<double>>>>;
    final enc = _encode(polys);
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
    for (final rings in polys) {
      for (final ring in rings) {
        fVerts += ring.length - 1;
      }
    }
    uniqueVerts += fVerts;

    final key = '$district|${row['name']}';
    if (!seen.contains(key)) {
      seen.add(key);
      entries.add({
        'district': district,
        'nameEn': row['name'] as String,
        'enc': enc,
      });
      matchedCount++;
    }
  }

  stderr.writeln('Matched: $matchedCount of ${rosterRows.length}');

  entries.sort((a, b) {
    final dc = (a['district'] as String).compareTo(b['district'] as String);
    if (dc != 0) return dc;
    return (a['nameEn'] as String).compareTo(b['nameEn'] as String);
  });

  // Write output.
  final out = StringBuffer();
  void w(String line) => out.writeln(line);
  String entryLine(int indent, String key, String value) {
    final pad = ' ' * indent;
    final inline = '$pad$key: $value';
    if (inline.length <= 80) return inline;
    final valuePad = ' ' * (indent + 4);
    return '$pad$key:\n$valuePad$value';
  }

  w('// GENERATED FILE - DO NOT EDIT.');
  w('//');
  w('// Lossless boundary geometry for local bodies (palikas) of Nepal,');
  w('// encoded as compact strings (format version 1 - see');
  w('// palika_boundary_codec.dart).');
  w('//');
  w('// Source: HDX COD-AB (Survey Department of Nepal, CC BY-IGO).');
  w('// Coordinates quantised to 1e-4 degrees (~11 m) and stored as');
  w('// zigzag VLQ deltas: the round trip is bit-exact.');
  w('//');
  w('// Regenerate with: dart run tool/generate_palika_boundaries_highres_package.dart');
  w('');
  w("const String kHighResPalikaBoundaryFormatVersion = '1';");
  w('');
  w('const int kHighResPalikaBoundaryFeatureCount = ${entries.length};');
  w('');
  w('/// Total boundary vertices across all features.');
  w('const int kHighResPalikaBoundaryVertexCount = $uniqueVerts;');
  w('');
  w('/// Features joined to canonical roster entries.');
  w('const int kHighResPalikaBoundaryMatchedCount = ${entries.length};');
  w('');
  w('const Map<String, Map<String, String>> kHighResPalikaBoundaries = {');
  final seen2 = <String>{};
  var i = 0;
  while (i < entries.length) {
    final district = entries[i]['district'] as String;
    final ents = <String>[];
    while (i < entries.length && entries[i]['district'] == district) {
      final key = '$district|${entries[i]['nameEn']}';
      if (!seen2.contains(key)) {
        seen2.add(key);
        ents.add(entryLine(
          4,
          "'${_esc(entries[i]['nameEn'] as String)}'",
          "'${entries[i]['enc']}',",
        ));
      }
      i++;
    }
    if (ents.isNotEmpty) {
      w("  '${_esc(district)}': {");
      for (final e in ents) {
        w(e);
      }
      w('  },');
    }
  }
  w('};');
  w('');
  w('/// Boundaries that could not be joined to a canonical roster entry.');
  w('const Map<String, String> kHighResUnmatchedPalikaBoundaries = {};');

  final text = out.toString();
  final bytes = utf8.encode(text).length;
  if (bytes >= 1000 * 1024) {
    stderr.writeln('Size gate failed: $bytes bytes >= 1000 KB.');
    exit(1);
  }
  final outFile = File(outPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(text);
  stdout.writeln('Wrote $outPath: ${entries.length} palikas, '
      '$uniqueVerts vertices, round-trip: $roundTripOk/${entries.length}.');
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
