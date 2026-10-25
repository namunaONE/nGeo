import 'package:flutter/material.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';

/// A compact chip naming a palika's type with a stable, theme-derived
/// accent colour.
///
/// The four palika types carry real administrative meaning — a metropolitan
/// city and a rural municipality are different kinds of government — so the
/// chip always spells out what a row is instead of leaving an abbreviation
/// for the user to decode. The accent comes from [ColorScheme] roles only, so
/// the chip themes correctly in light and dark with zero configuration and
/// stays in harmony with whatever seed colour the host app uses.
///
/// ```dart
/// LocalBodyTypeChip(type: body.type)                  // 'Rural Municipality'
/// LocalBodyTypeChip(type: body.type, compact: true)  // 'RM'
/// ```
class LocalBodyTypeChip extends StatelessWidget {
  const LocalBodyTypeChip({
    super.key,
    required this.type,
    this.compact = false,
    this.showTooltip = true,
  });

  /// The palika type to render.
  final LocalBodyType type;

  /// Use the dataset abbreviation ('RM') instead of the full name
  /// ('Rural Municipality') — for dense tables.
  final bool compact;

  /// Show the full name in a tooltip when [compact] is true.
  final bool showTooltip;

  /// The accent colour for a type, derived from theme roles only.
  ///
  /// Metropolitan takes the primary role, sub-metropolitan the tertiary,
  /// municipality the secondary and rural municipalities a neutral — the
  /// hierarchy reads as colour weight without ever leaving the scheme, and
  /// re-theming the app re-themes every chip.
  static Color accentFor(LocalBodyType type, ColorScheme scheme) =>
      switch (type) {
        LocalBodyType.metropolitan => scheme.primary,
        LocalBodyType.subMetropolitan => scheme.tertiary,
        LocalBodyType.municipality => scheme.secondary,
        LocalBodyType.ruralMunicipality => scheme.onSurfaceVariant,
        LocalBodyType.unknown => scheme.outline,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = accentFor(type, scheme);
    final label = compact ? type.shortName : type.fullName;

    Widget chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            type == LocalBodyType.ruralMunicipality
                ? Icons.grass
                : Icons.location_city,
            size: 13,
            color: accent,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );

    if (compact && showTooltip) {
      chip = Tooltip(message: type.fullName, child: chip);
    }

    return Semantics(label: type.fullName, child: chip);
  }
}
