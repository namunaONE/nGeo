// tool/merge/apply_hdx_data.dart — apply HDX COD-AB official data to
// nepal_local_levels.json.
//
// Reads the HDX COD-AB GeoJSON, joins each ADM3 feature to our roster
// palikas (by name + district, with rename map and fuzzy/centroid fallback),
// and writes hdxPcode, areaSqKmOfficial, latHdx, lngHdx into the JSON.
//
// Usage:
//   dart run tool/merge/apply_hdx_data.dart           # apply
//   dart run tool/merge/apply_hdx_data.dart --dry-run  # report only

import 'dart:convert';
import 'dart:io';

const String geoPath = 'data/_raw/hdx-cod-ab/npl_admin3.geojson';
const String rosterPath = 'data/nepal_local_levels.json';

String _normName(String s) {
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

const Map<String, String> _renameMap = {
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

Map<String, dynamic> _readJson(File file) =>
    jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');
  const geoPath = 'data/_raw/hdx-cod-ab/npl_admin3.geojson';
  const rosterPath = 'data/nepal_local_levels.json';

  final geoFile = File(geoPath);
  final rosterFile = File(rosterPath);
  if (!geoFile.existsSync() || !rosterFile.existsSync()) {
    stderr.writeln('ERROR: $geoPath or $rosterPath is missing.');
    exit(2);
  }

  final geo = _readJson(geoFile);
  final rosterJson = _readJson(rosterFile);
  final provinces =
      (rosterJson['provinces'] as List).cast<Map<String, dynamic>>();

  // Build HDX lookup by normalized district name.
  final hdxByDistrict = <String, List<Map<String, dynamic>>>{};
  for (final raw in (geo['features'] as List<dynamic>)) {
    final f = raw as Map<String, dynamic>;
    final props = f['properties'] as Map<String, dynamic>;
    final pcode = props['adm3_pcode'] as String;
    final palikaCode = int.parse(pcode.substring(pcode.length - 3));
    // Skip protected areas (pcode >= 500).
    if (palikaCode >= 500) continue;
    final distName = props['adm2_name'] as String;
    final normDist = _normDistrictName(distName);
    hdxByDistrict.putIfAbsent(normDist, () => []).add(f);
  }

  // Match and apply.
  var matched = 0;
  var unmatched = 0;
  for (final province in provinces) {
    for (final district
        in (province['districts'] as List).cast<Map<String, dynamic>>()) {
      final districtName = district['name'] as String;
      final hdxDistrict = _normDistrictName(districtName);
      final candidates = hdxByDistrict[hdxDistrict] ?? <Map<String, dynamic>>[];

      for (final body
          in (district['localBodies'] as List).cast<Map<String, dynamic>>()) {
        final bodyName = body['name'] as String;
        final lat = (body['lat'] as num?)?.toDouble();
        final lng = (body['lng'] as num?)?.toDouble();

        // Find matching HDX feature.
        Map<String, dynamic>? hit;

        // 1. Exact normalized name.
        for (final f in candidates) {
          final props = f['properties'] as Map<String, dynamic>;
          if (_normName(props['adm3_name'] as String) == _normName(bodyName)) {
            hit = f;
            break;
          }
        }

        // 2. Rename map.
        if (hit == null && _renameMap.containsKey(bodyName)) {
          final target = _renameMap[bodyName]!;
          for (final f in candidates) {
            final props = f['properties'] as Map<String, dynamic>;
            if (_normName(props['adm3_name'] as String) == _normName(target)) {
              hit = f;
              break;
            }
          }
        }

        // 3. Fuzzy name (Levenshtein <= 3), validated by centroid containment.
        if (hit == null && lat != null && lng != null) {
          Map<String, dynamic>? fuzzyBest;
          var fuzzyBestD = 999;
          for (final f in candidates) {
            final props = f['properties'] as Map<String, dynamic>;
            final d = _levenshtein(
                _normName(props['adm3_name'] as String), _normName(bodyName));
            if (d < fuzzyBestD) {
              fuzzyBestD = d;
              fuzzyBest = f;
            }
          }
          if (fuzzyBest != null && fuzzyBestD <= 3) {
            final geom = fuzzyBest['geometry'] as Map<String, dynamic>;
            if (_containsPoint(geom, lat, lng)) {
              hit = fuzzyBest;
            }
          }
        }

        // 4. Centroid containment.
        if (hit == null && lat != null && lng != null) {
          for (final f in candidates) {
            final geom = f['geometry'] as Map<String, dynamic>;
            if (_containsPoint(geom, lat, lng)) {
              hit = f;
              break;
            }
          }
        }

        if (hit != null) {
          final props = hit['properties'] as Map<String, dynamic>;
          body['hdxPcode'] = props['adm3_pcode'] as String;
          body['areaSqKmOfficial'] = (props['area_sqkm'] as num).toDouble();
          body['latHdx'] = (props['center_lat'] as num).toDouble();
          body['lngHdx'] = (props['center_lon'] as num).toDouble();
          matched++;
        } else {
          unmatched++;
          stderr.writeln('UNMATCHED: $bodyName ($districtName)');
        }
      }
    }
  }

  stdout.writeln('Matched: $matched / ${matched + unmatched}');
  stdout.writeln('Unmatched: $unmatched');

  if (dryRun) {
    stdout.writeln('Dry run — no files written.');
    return;
  }

  // Write updated JSON.
  const encoder = JsonEncoder.withIndent('  ');
  rosterFile.writeAsStringSync(encoder.convert(rosterJson));
  stdout.writeln('Updated $rosterPath with HDX data.');
}

String _normDistrictName(String name) {
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
