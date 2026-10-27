/// High-resolution boundary polygons for Nepal's 753 local bodies (palikas).
///
/// Optional add-on to `nepal_admin_api`. Ships ~75k vertices
/// (Douglas-Peucker eps 0.001 deg, ~300 KB) instead of the ~17k in the core
/// package. Use [HighResPalikaBoundaries] for lookups; the codec and models
/// come from `nepal_admin_api`.
library;

export 'package:nepal_admin_api/nepal_admin_api.dart'
    show PalikaBoundary, LocalBody, District, Province, NepalAdminApi;

export 'src/highres_boundaries_data.dart';
export 'src/highres_palika_boundaries.dart';
