// tool/merge/join_hdx.dart — join HDX COD-AB ADM3 (775) to our roster (753).
//
// Matches each of our palikas to an HDX ADM3 feature by:
//   1. Exact normalized name + district (case-insensitive, strip type suffix).
//   2. Fuzzy name (Levenshtein <= 3, same district).
//   3. Centroid containment (our roster centroid inside HDX polygon).
//
// District names are normalized via a manual mapping (HDX uses different
// spellings: Chitawan, Dhanusa, Kapilbastu, Nawalparasi East/West, Tanahu).
//
// Output: data/_stage/hdx_join_report.json
//
// Usage: dart run tool/merge/join_hdx.dart
//        dart run tool/merge/join_hdx.dart --check  (drift check, exit 2 on mismatch)

import 'dart:convert';
import 'dart:io';
import 'dart:math';

const String rosterPath = 'data/nepal_local_levels.json';
const String hdxPath = 'data/_raw/hdx-cod-ab/npl_admin3.geojson';
const String outPath = 'data/_stage/hdx_join_report.json';

// District name normalization: ours -> HDX.
const Map<String, String> districtNorm = {
  'Chitwan': 'Chitawan',
  'Dhanusha': 'Dhanusa',
  'Kapilvastu': 'Kapilbastu',
  'Nawalpur': 'Nawalparasi East',
  'Parasi (Nawalparasi West)': 'Nawalparasi West',
  'Tanahun': 'Tanahu',
};

String normDistrict(String name) => districtNorm[name] ?? name;

String normName(String s) {
  var n = s.toLowerCase().trim();
  // strip type suffixes
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
  // remove non-alphanumeric
  n = n.replaceAll(RegExp(r'[^a-z0-9]'), '');
  return n;
}

int levenshtein(String a, String b) {
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

// Point-in-polygon (ray casting). HDX geometry: Polygon or MultiPolygon.
// Coordinates are [lng, lat].
bool pointInRing(double lat, double lng, List<dynamic> ring) {
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

bool containsPoint(Map<String, dynamic> geom, double lat, double lng) {
  final type = geom['type'] as String;
  final polys = type == 'Polygon'
      ? <dynamic>[geom['coordinates']]
      : geom['coordinates'] as List<dynamic>;
  for (final poly in polys) {
    final rings = poly as List<dynamic>;
    if (rings.isEmpty) continue;
    if (pointInRing(lat, lng, rings[0] as List<dynamic>)) {
      var inHole = false;
      for (var h = 1; h < rings.length; h++) {
        if (pointInRing(lat, lng, rings[h] as List<dynamic>)) {
          inHole = true;
          break;
        }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

// Protected area detection.
const protectedNames = {
  'Koshi Tappu',
  'Shivapuri',
  'Langtang',
  'Parsa',
  'Chitawan',
  'Dhorpatan',
  'Lumbini Sanskritik',
  'Bardiya',
  'Khaptad',
  'Shuklaphanta',
  'Annapurna',
  'Makalu Barun',
  'Sagarmatha',
  'Rara',
  'Shey Phoksundo',
  'Banke',
  'Shivapuri Nagarjun',
};

bool isProtected(String name) {
  return protectedNames
      .any((k) => name.toLowerCase().startsWith(k.toLowerCase()));
}

// Manual rename mapping: our legacy name -> HDX current name.
// From doc/REVIEW-codes.md §8.3 (public corroboration).
const Map<String, String> renameMap = {
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

Map<String, dynamic> _readJson(File file) =>
    jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

void main(List<String> args) {
  final check = args.contains('--check');

  final dataFile = File(rosterPath);
  final hdxFile = File(hdxPath);
  if (!dataFile.existsSync() || !hdxFile.existsSync()) {
    stderr.writeln('ERROR: $rosterPath or $hdxPath is missing.');
    stderr.writeln(
        'Run from the package root. For HDX, extract the GeoJSON zip to $hdxPath.');
    exit(2);
  }

  // ---- Load roster ----
  final data = _readJson(dataFile);
  final rows = <Map<String, dynamic>>[];
  for (final province in (data['provinces'] as List<dynamic>)) {
    final pName = (province as Map<String, dynamic>)['name'] as String;
    final pCbs = (province)['cbsCode'] as int;
    for (final district in (province['districts'] as List<dynamic>)) {
      final dName = (district as Map<String, dynamic>)['name'] as String;
      final dArea = (district['areaSqKm'] as num?)?.toDouble();
      for (final body in (district['localBodies'] as List<dynamic>)) {
        final lb = body as Map<String, dynamic>;
        rows.add({
          'name': lb['name'] as String,
          'district': dName,
          'province': pName,
          'provinceCbs': pCbs,
          'lat': (lb['lat'] as num?)?.toDouble(),
          'lng': (lb['lng'] as num?)?.toDouble(),
          'cbsCode': lb['cbsCode'] as int?,
          'type': lb['type'] as String?,
          'wards': lb['wards'] as int?,
          'districtArea': dArea,
        });
      }
    }
  }

  // ---- Load HDX GeoJSON ----
  final hdx = _readJson(hdxFile);
  final hdxFeatures = hdx['features'] as List<dynamic>;

  // Build HDX index by normalized district name.
  final hdxByDistrict = <String, List<Map<String, dynamic>>>{};
  for (final raw in hdxFeatures) {
    final f = raw as Map<String, dynamic>;
    final props = f['properties'] as Map<String, dynamic>;
    final distName = props['adm2_name'] as String;
    final normDist =
        normName(distName).toLowerCase(); // district name normalized
    hdxByDistrict.putIfAbsent(normDist, () => []).add(f);
  }

  // ---- Match ----
  final matched = <Map<String, dynamic>>[];
  final unmatchedOurs = <Map<String, dynamic>>[];
  final unmatchedHdx = <Map<String, dynamic>>[];
  final districtNameMismatches = <Map<String, dynamic>>[];

  // Track which HDX features are claimed (by pcode, globally).
  final claimedPcodes = <String>{};

  for (final row in rows) {
    final ourName = row['name'] as String;
    final ourDistrict = row['district'] as String;
    final normOurDistrict = normName(normDistrict(ourDistrict)).toLowerCase();
    final candidates =
        hdxByDistrict[normOurDistrict] ?? <Map<String, dynamic>>[];

    // Tier 1: exact normalized name + district
    int? hitIdx;
    var matchTier = 'exact';
    for (var i = 0; i < candidates.length; i++) {
      final f = candidates[i];
      final hdxPcode =
          (f['properties'] as Map<String, dynamic>)['adm3_pcode'] as String;
      if (claimedPcodes.contains(hdxPcode)) continue;
      final hdxName =
          (f['properties'] as Map<String, dynamic>)['adm3_name'] as String;
      if (normName(hdxName) == normName(ourName)) {
        hitIdx = i;
        break;
      }
    }

    // Tier 1.5: rename map (our legacy name -> HDX current name)
    if (hitIdx == null && renameMap.containsKey(ourName)) {
      final targetName = renameMap[ourName]!;
      for (var i = 0; i < candidates.length; i++) {
        final f = candidates[i];
        final hdxPcode =
            (f['properties'] as Map<String, dynamic>)['adm3_pcode'] as String;
        if (claimedPcodes.contains(hdxPcode)) continue;
        final hdxName =
            (f['properties'] as Map<String, dynamic>)['adm3_name'] as String;
        if (normName(hdxName) == normName(targetName)) {
          hitIdx = i;
          matchTier = 'rename';
          break;
        }
      }
    }

    // Tier 2: fuzzy name (Levenshtein <= 3, same district)
    // Validate with centroid containment to avoid false positives
    // (e.g. Baraha -> Barju are different palikas).
    if (hitIdx == null) {
      var bestD = 999;
      var bestI = -1;
      for (var i = 0; i < candidates.length; i++) {
        final f = candidates[i];
        final hdxPcode =
            (f['properties'] as Map<String, dynamic>)['adm3_pcode'] as String;
        if (claimedPcodes.contains(hdxPcode)) continue;
        final hdxName =
            (f['properties'] as Map<String, dynamic>)['adm3_name'] as String;
        final d = levenshtein(normName(hdxName), normName(ourName));
        if (d < bestD) {
          bestD = d;
          bestI = i;
        }
      }
      if (bestI >= 0 && bestD <= 3) {
        // Validate with centroid containment
        final f = candidates[bestI];
        final geom = f['geometry'] as Map<String, dynamic>;
        final lat = row['lat'] as double?;
        final lng = row['lng'] as double?;
        if (lat != null && lng != null && containsPoint(geom, lat, lng)) {
          hitIdx = bestI;
          matchTier = 'fuzzy';
        } else {
          // Fuzzy match rejected — centroid not inside. Don't claim.
        }
      }
    }

    // Tier 3: centroid containment (our centroid inside HDX polygon)
    // This is the strongest fallback for renamed palikas.
    if (hitIdx == null && row['lat'] != null && row['lng'] != null) {
      for (var i = 0; i < candidates.length; i++) {
        final f = candidates[i];
        final hdxPcode =
            (f['properties'] as Map<String, dynamic>)['adm3_pcode'] as String;
        if (claimedPcodes.contains(hdxPcode)) continue;
        final geom = f['geometry'] as Map<String, dynamic>;
        if (containsPoint(geom, row['lat'] as double, row['lng'] as double)) {
          hitIdx = i;
          matchTier = 'centroid';
          break;
        }
      }
    }

    if (hitIdx != null) {
      final f = candidates[hitIdx];
      final props = f['properties'] as Map<String, dynamic>;
      final hdxPcode = props['adm3_pcode'] as String;
      claimedPcodes.add(hdxPcode);
      final hdxName = props['adm3_name'] as String;
      final hdxArea = (props['area_sqkm'] as num).toDouble();
      final hdxLat = (props['center_lat'] as num).toDouble();
      final hdxLng = (props['center_lon'] as num).toDouble();

      double centroidDelta = 0.0;
      if (row['lat'] != null && row['lng'] != null) {
        final dlat = (row['lat'] as double) - hdxLat;
        final dlng = (row['lng'] as double) - hdxLng;
        centroidDelta = sqrt(dlat * dlat + dlng * dlng);
      }

      matched.add({
        'ourName': ourName,
        'ourDistrict': ourDistrict,
        'ourProvince': row['province'],
        'ourCbsCode': row['cbsCode'],
        'ourType': row['type'],
        'ourLat': row['lat'],
        'ourLng': row['lng'],
        'hdxName': hdxName,
        'hdxDistrict': props['adm2_name'],
        'hdxProvince': props['adm1_name'],
        'hdxPcode': hdxPcode,
        'hdxArea': hdxArea,
        'hdxLat': hdxLat,
        'hdxLng': hdxLng,
        'matchTier': matchTier,
        'centroidDeltaDeg': centroidDelta,
        'nameMismatch': hdxName != ourName,
      });
    } else {
      unmatchedOurs.add({
        'name': ourName,
        'district': ourDistrict,
        'province': row['province'],
        'cbsCode': row['cbsCode'],
        'lat': row['lat'],
        'lng': row['lng'],
        'reason': 'no match (likely renamed palika)',
      });
    }
  }

  // ---- Unmatched HDX features ----
  final allHdxFeatures = hdxFeatures;
  for (final f in allHdxFeatures) {
    final props = f['properties'] as Map<String, dynamic>;
    final hdxPcode = props['adm3_pcode'] as String;
    if (claimedPcodes.contains(hdxPcode)) continue;
    final name = props['adm3_name'] as String;
    final isProtected = protectedNames
        .any((k) => name.toLowerCase().startsWith(k.toLowerCase()));
    unmatchedHdx.add({
      'name': name,
      'district': props['adm2_name'],
      'province': props['adm1_name'],
      'pcode': hdxPcode,
      'area': props['area_sqkm'],
      'type': isProtected ? 'protected area' : 'renamed palika (new name)',
    });
  }

  // ---- District name mismatches (using normalized names) ----
  final ourDistricts = <String>{};
  final hdxDistricts = <String>{};
  for (final row in rows) {
    ourDistricts.add(row['district'] as String);
  }
  for (final f in hdxFeatures) {
    hdxDistricts
        .add((f['properties'] as Map<String, dynamic>)['adm2_name'] as String);
  }
  for (final d in ourDistricts) {
    final normD = normDistrict(d);
    if (!hdxDistricts.contains(normD)) {
      // find closest HDX district name
      String? closest;
      var bestD = 999;
      for (final hd in hdxDistricts) {
        final dist = levenshtein(d.toLowerCase(), hd.toLowerCase());
        if (dist < bestD) {
          bestD = dist;
          closest = hd;
        }
      }
      districtNameMismatches.add({
        'ours': d,
        'hdx': closest,
        'levenshtein': bestD,
        'mapped': false,
      });
    } else {
      // District name differs but maps correctly
      if (d != normD) {
        districtNameMismatches.add({
          'ours': d,
          'hdx': normD,
          'levenshtein': 0,
          'mapped': true,
        });
      }
    }
  }

  // ---- Stats ----
  final exactCount = matched.where((m) => m['matchTier'] == 'exact').length;
  final fuzzyCount = matched.where((m) => m['matchTier'] == 'fuzzy').length;
  final centroidCount =
      matched.where((m) => m['matchTier'] == 'centroid').length;
  final renameCount = matched.where((m) => m['matchTier'] == 'rename').length;
  final nameMismatchCount =
      matched.where((m) => m['nameMismatch'] == true).length;
  final protectedCount =
      unmatchedHdx.where((u) => u['type'] == 'protected area').length;
  final renamedCount = matched.where((m) => m['matchTier'] == 'rename').length;

  final report = {
    'generated': DateTime.now().toUtc().toIso8601String(),
    'source': 'HDX COD-AB v02 (Survey Department of Nepal, CC BY-IGO)',
    'stats': {
      'totalOurs': rows.length,
      'totalHdx': hdxFeatures.length,
      'matched': matched.length,
      'matchRate': matched.length / rows.length,
      'exactMatch': exactCount,
      'fuzzyMatch': fuzzyCount,
      'centroidMatch': centroidCount,
      'renameMatch': renameCount,
      'unmatchedOurs': unmatchedOurs.length,
      'unmatchedHdx': unmatchedHdx.length,
      'protectedAreas': protectedCount,
      'renamedPalikas': renamedCount,
      'nameMismatches': nameMismatchCount,
      'districtNameMismatches': districtNameMismatches.length,
    },
    'matched': matched,
    'unmatchedOurs': unmatchedOurs,
    'unmatchedHdx': unmatchedHdx,
    'districtNameMismatches': districtNameMismatches,
  };

  // Write report
  final outFile = File(outPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(report));

  // Console summary
  stdout.writeln('=== HDX Join Report ===');
  stdout.writeln('Roster palikas: ${rows.length}');
  stdout.writeln('HDX ADM3 features: ${hdxFeatures.length}');
  stdout.writeln(
      'Matched: ${matched.length} (${(matched.length / rows.length * 100).toStringAsFixed(1)}%)');
  stdout.writeln(
      '  exact: $exactCount, fuzzy: $fuzzyCount, centroid: $centroidCount, rename: $renameCount');
  stdout.writeln('  name mismatches (spelling): $nameMismatchCount');
  stdout.writeln('Unmatched ours: ${unmatchedOurs.length}');
  stdout.writeln(
      'Unmatched HDX: ${unmatchedHdx.length} ($protectedCount protected areas, $renamedCount renamed palikas)');
  stdout.writeln('District name mismatches: ${districtNameMismatches.length}');
  for (final d in districtNameMismatches) {
    stdout.writeln(
        '  ${d['ours']} -> ${d['hdx']} (levenshtein=${d['levenshtein']})');
  }
  stdout.writeln();
  stdout.writeln('Report written to: $outPath');

  // Exit code for --check mode
  if (check) {
    const threshold = 0.95;
    if (matched.length / rows.length < threshold) {
      stderr.writeln(
          'FAIL: match rate ${(matched.length / rows.length * 100).toStringAsFixed(1)}% < ${(threshold * 100).toStringAsFixed(0)}%');
      exit(1);
    }
    stdout.writeln(
        'OK: match rate ${(matched.length / rows.length * 100).toStringAsFixed(1)}% >= ${(threshold * 100).toStringAsFixed(0)}%');
  }
}
