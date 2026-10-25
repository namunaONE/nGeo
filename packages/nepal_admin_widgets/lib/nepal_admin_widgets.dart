/// Flutter widgets for Nepal's administrative divisions.
///
/// Backs onto [nepal_admin_api], which carries the verified dataset offline:
/// 7 provinces, 77 districts and 753 local bodies, each with a Devanagari
/// name and a confidence-tiered CBS code.
///
/// The hard part of a cascading picker is not the widget — it is the state
/// transitions and the label disambiguation. Those live in
/// [AdministrativeCascade], a plain [ChangeNotifier] with no widget
/// dependency, so they can be unit-tested directly and reused by callers who
/// want a different UI.
///
/// Since 0.2.0 the package also ships the display components —
/// [LocalBodyTypeChip], [TrustBadge] and [AdministrativeSummaryCard] — plus
/// the composed [AdministrativePickerCard]. All of them derive their colours
/// from ColorScheme roles, so they theme correctly in light and dark with
/// zero configuration.
///
/// ```dart
/// AdministrativeDropdown(
///   onChanged: (selection) => print(selection?.localBody?.nameNe),
/// )
/// ```
library;

export 'src/administrative_cascade.dart';
export 'src/administrative_dropdown.dart';
export 'src/administrative_picker_card.dart';
export 'src/administrative_summary_card.dart';
export 'src/local_body_search_field.dart';
export 'src/local_body_type_chip.dart';
export 'src/trust_badge.dart';
