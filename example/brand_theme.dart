// Design System v3 — Himalayan Trust × Everest Growth.
//
// Seeds: brand blue #3B82F6 (accent) + accessible blue #1D4ED8 (primary),
//        brand green #4FD166 (accent fill) + accessible green #15803D
//        (success / secondary actions).
//
// Calculated contrast (WCAG 2.x):
//   #1D4ED8 on white 6.70:1 (AA)   white on #1D4ED8 6.70:1 (AA)
//   #15803D on white 5.02:1 (AA)   #0B1220 on #3B82F6 5.09:1 (AA)
//   #3B82F6 on white 3.68:1  (large text / UI only, never body text)
//   #4FD166 on white 1.97:1  (never text on white)
//
// Copy into your app: import 'brand_theme.dart';
// Requires: flutter/material.dart (no extra deps).
//
// Fonts (optional but recommended): bundle Plus Jakarta Sans (Latin) and
// Noto Sans Devanagari (Nepali) and declare in pubspec.yaml:
//   flutter:
//     fonts:
//       - family: PlusJakartaSans
//         fonts:
//           - asset: assets/fonts/PlusJakartaSans-Regular.ttf
//             weight: 400
//           - asset: assets/fonts/PlusJakartaSans-SemiBold.ttf
//             weight: 600
//           - asset: assets/fonts/PlusJakartaSans-Bold.ttf
//             weight: 700
//       - family: NotoSansDevanagari
//         fonts:
//           - asset: assets/fonts/NotoSansDevanagari-Regular.ttf
//             weight: 400
//           - asset: assets/fonts/NotoSansDevanagari-SemiBold.ttf
//             weight: 600
//           - asset: assets/fonts/NotoSansDevanagari-Bold.ttf
//             weight: 700

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Brand seeds.
///
/// [brandBlue] and [brandGreen] are accents: fills, large graphics,
/// selected states. Never use them as normal text on light surfaces.
/// [accessibleBlue] and [accessibleGreen] carry actions, text, and icons.
class NepalBrandSeeds {
  static const brandBlue = Color(0xFF3B82F6);
  static const accessibleBlue = Color(0xFF1D4ED8);
  static const brandGreen = Color(0xFF4FD166);
  static const accessibleGreen = Color(0xFF15803D);

  /// Dark ink for text on brand-accent fills (5.09:1 on #3B82F6,
  /// 9.49:1 on #4FD166). White text fails on both.
  static const ink = Color(0xFF0B1220);

  // --- v2 compatibility (v2 seeds are retired; values remap to v3) ---
  @Deprecated('Use brandBlue / accessibleBlue. v3 retired the navy seed.')
  static const navy = accessibleBlue;
  @Deprecated('Use brandGreen (fills only) or accessibleGreen (text).')
  static const green = brandGreen;
}

/// Primitive tokens — design-system internals only.
///
/// Feature widgets must read Material roles
/// (Theme.of(context).colorScheme) or semantic extensions
/// (NbSemanticColors), never primitives.
abstract final class NbPrimitives {
  // Blue ramp
  static const blue50 = Color(0xFFEFF6FF);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue300 = Color(0xFF93C5FD);
  static const blue500 = Color(0xFF3B82F6);
  static const blue700 = Color(0xFF1D4ED8);
  static const blue800 = Color(0xFF1E40AF);
  static const blue900 = Color(0xFF1E3A8A);

  // Green ramp
  static const green50 = Color(0xFFF0FDF4);
  static const green100 = Color(0xFFDCFCE7);
  static const green300 = Color(0xFF86EFAC);
  static const green500 = Color(0xFF4FD166);
  static const green700 = Color(0xFF15803D);
  static const green900 = Color(0xFF14532D);
  static const green950 = Color(0xFF052E16);

  // Stone neutrals (warm grey — surfaces and borders)
  static const neutral0 = Color(0xFFFFFFFF);
  static const neutral50 = Color(0xFFFAFAF9);
  static const neutral100 = Color(0xFFF5F5F4);
  static const neutral200 = Color(0xFFE7E5E4);
  static const neutral300 = Color(0xFFD6D3D1);
  static const neutral400 = Color(0xFFA8A29E);
  static const neutral600 = Color(0xFF57534E);
  static const neutral900 = Color(0xFF1C1917);
  static const neutral950 = Color(0xFF0C0A09);

  // Ink + status
  static const ink = Color(0xFF0B1220);
  static const red300 = Color(0xFFFCA5A5);
  static const red700 = Color(0xFFB91C1C);
  static const amber300 = Color(0xFFFCD34D);
  static const amber800 = Color(0xFF92400E);
  static const white = Color(0xFFFFFFFF);
}

/// Material 3 schemes.
///
/// ColorScheme.fromSeed is a palette generator: the generated primary is
/// a tone of the seed, not the seed itself. We seed with brand blue for
/// harmony, then copyWith the roles that must be exact and accessible.
///
/// - primary   = accessible blue (main actions, links, focus)
/// - secondary = accessible green (success, attestation, progress)
/// - tertiary  = brand blue accent with ink text (never white on #3B82F6)
/// - surfaces  = stone neutrals, not blue-tinted
class NepalBrandScheme {
  static final _baseLight = ColorScheme.fromSeed(
    seedColor: NepalBrandSeeds.brandBlue,
    brightness: Brightness.light,
  );
  static final _baseDark = ColorScheme.fromSeed(
    seedColor: NepalBrandSeeds.brandBlue,
    brightness: Brightness.dark,
  );

  static final light = _baseLight.copyWith(
    primary: NbPrimitives.blue700,
    onPrimary: NbPrimitives.white,
    primaryContainer: NbPrimitives.blue50,
    onPrimaryContainer: NbPrimitives.blue900,
    secondary: NbPrimitives.green700,
    onSecondary: NbPrimitives.white,
    secondaryContainer: NbPrimitives.green50,
    onSecondaryContainer: NbPrimitives.green900,
    tertiary: NbPrimitives.blue500,
    onTertiary: NbPrimitives.ink,
    error: NbPrimitives.red700,
    onError: NbPrimitives.white,
    surface: NbPrimitives.neutral50,
    onSurface: NbPrimitives.neutral900,
    onSurfaceVariant: NbPrimitives.neutral600,
    outline: NbPrimitives.neutral400,
    outlineVariant: NbPrimitives.neutral200,
    surfaceContainerLowest: NbPrimitives.neutral0,
    surfaceContainerLow: NbPrimitives.neutral50,
    surfaceContainer: NbPrimitives.neutral100,
    surfaceContainerHigh: NbPrimitives.neutral200,
    surfaceContainerHighest: NbPrimitives.neutral300,
    inverseSurface: NbPrimitives.neutral900,
    onInverseSurface: NbPrimitives.neutral50,
    inversePrimary: NbPrimitives.blue300,
  );

  static final dark = _baseDark.copyWith(
    primary: NbPrimitives.blue300,
    onPrimary: NbPrimitives.ink,
    primaryContainer: NbPrimitives.blue900,
    onPrimaryContainer: NbPrimitives.blue100,
    secondary: NbPrimitives.green300,
    onSecondary: NbPrimitives.ink,
    secondaryContainer: NbPrimitives.green900,
    onSecondaryContainer: NbPrimitives.green100,
    tertiary: const Color(0xFF60A5FA),
    onTertiary: NbPrimitives.ink,
    error: NbPrimitives.red300,
    onError: NbPrimitives.ink,
    surface: NbPrimitives.neutral950,
    onSurface: NbPrimitives.neutral50,
    onSurfaceVariant: const Color(0xFFD6D3D1),
    outline: const Color(0xFF78716C),
    outlineVariant: const Color(0xFF44403C),
    surfaceContainerLowest: NbPrimitives.neutral950,
    surfaceContainerLow: NbPrimitives.neutral900,
    surfaceContainer: const Color(0xFF292524),
    surfaceContainerHigh: const Color(0xFF44403C),
    surfaceContainerHighest: NbPrimitives.neutral600,
    inverseSurface: NbPrimitives.neutral50,
    onInverseSurface: NbPrimitives.neutral900,
    inversePrimary: NbPrimitives.blue700,
  );
}

/// Semantic roles Material does not model: trust states, owner-stated
/// claims, focus ring, brand accent. Register via ThemeData.extensions
/// and read with:
///
///   final nb = Theme.of(context).extension<NbSemanticColors>()!;
///
/// Rules: verified is a scoped statement (blue), not success green;
/// owner-stated is neutral; expired is neutral, not danger.
@immutable
class NbSemanticColors extends ThemeExtension<NbSemanticColors> {
  const NbSemanticColors({
    required this.brandAccent,
    required this.focusRing,
    required this.trustVerified,
    required this.trustOwnerStated,
    required this.trustPending,
    required this.trustExpired,
    required this.trustRevoked,
  });

  final Color brandAccent;
  final Color focusRing;
  final Color trustVerified;
  final Color trustOwnerStated;
  final Color trustPending;
  final Color trustExpired;
  final Color trustRevoked;

  static const light = NbSemanticColors(
    brandAccent: NbPrimitives.blue500,
    focusRing: NbPrimitives.blue700,
    trustVerified: NbPrimitives.blue700,
    trustOwnerStated: NbPrimitives.neutral600,
    trustPending: NbPrimitives.amber800,
    trustExpired: NbPrimitives.neutral600,
    trustRevoked: NbPrimitives.red700,
  );

  static const dark = NbSemanticColors(
    brandAccent: Color(0xFF60A5FA),
    focusRing: NbPrimitives.blue300,
    trustVerified: NbPrimitives.blue300,
    trustOwnerStated: Color(0xFFD6D3D1),
    trustPending: NbPrimitives.amber300,
    trustExpired: NbPrimitives.neutral400,
    trustRevoked: NbPrimitives.red300,
  );

  @override
  NbSemanticColors copyWith({
    Color? brandAccent,
    Color? focusRing,
    Color? trustVerified,
    Color? trustOwnerStated,
    Color? trustPending,
    Color? trustExpired,
    Color? trustRevoked,
  }) {
    return NbSemanticColors(
      brandAccent: brandAccent ?? this.brandAccent,
      focusRing: focusRing ?? this.focusRing,
      trustVerified: trustVerified ?? this.trustVerified,
      trustOwnerStated: trustOwnerStated ?? this.trustOwnerStated,
      trustPending: trustPending ?? this.trustPending,
      trustExpired: trustExpired ?? this.trustExpired,
      trustRevoked: trustRevoked ?? this.trustRevoked,
    );
  }

  @override
  NbSemanticColors lerp(NbSemanticColors? other, double t) {
    if (other is! NbSemanticColors) return this;
    return NbSemanticColors(
      brandAccent: Color.lerp(brandAccent, other.brandAccent, t)!,
      focusRing: Color.lerp(focusRing, other.focusRing, t)!,
      trustVerified: Color.lerp(trustVerified, other.trustVerified, t)!,
      trustOwnerStated:
          Color.lerp(trustOwnerStated, other.trustOwnerStated, t)!,
      trustPending: Color.lerp(trustPending, other.trustPending, t)!,
      trustExpired: Color.lerp(trustExpired, other.trustExpired, t)!,
      trustRevoked: Color.lerp(trustRevoked, other.trustRevoked, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is NbSemanticColors &&
      other.brandAccent == brandAccent &&
      other.focusRing == focusRing &&
      other.trustVerified == trustVerified &&
      other.trustOwnerStated == trustOwnerStated &&
      other.trustPending == trustPending &&
      other.trustExpired == trustExpired &&
      other.trustRevoked == trustRevoked;

  @override
  int get hashCode => Object.hash(
        brandAccent,
        focusRing,
        trustVerified,
        trustOwnerStated,
        trustPending,
        trustExpired,
        trustRevoked,
      );
}

/// Spacing: 4-point base, 8-point rhythm.
abstract final class NbSpacing {
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double x10 = 40;
  static const double x12 = 48;
  static const double x16 = 64;
}

/// Shape, motion, and touch targets.
abstract final class NbShape {
  static const double radiusSm = 8; // inputs, small cards
  static const double radiusMd = 12; // buttons, fields
  static const double radiusLg = 16; // cards, dialogs
  static const double radiusXl = 24; // bottom sheets
  static const double touchTarget = 48; // recommended; 44 absolute min
  static const Duration motionFast = Duration(milliseconds: 150);
  static const Duration motionStandard = Duration(milliseconds: 200);
  static const Duration motionEmphasized = Duration(milliseconds: 300);
}

/// Mixed-script text theme: Plus Jakarta Sans for Latin with Noto Sans
/// Devanagari fallback. Nepali line heights are looser (matras need
/// room); never apply uppercase or letter-spacing to Devanagari.
const String _latin = 'PlusJakartaSans';
const String _devanagari = 'NotoSansDevanagari';

TextTheme nbTextTheme(ColorScheme scheme) {
  const base = TextStyle(
    fontFamily: _latin,
    fontFamilyFallback: [_devanagari],
  );
  return TextTheme(
    displaySmall:
        base.copyWith(fontSize: 32, height: 1.25, fontWeight: FontWeight.w700),
    headlineLarge:
        base.copyWith(fontSize: 28, height: 1.3, fontWeight: FontWeight.w700),
    headlineMedium:
        base.copyWith(fontSize: 24, height: 1.35, fontWeight: FontWeight.w600),
    titleLarge:
        base.copyWith(fontSize: 20, height: 1.4, fontWeight: FontWeight.w600),
    titleMedium:
        base.copyWith(fontSize: 18, height: 1.45, fontWeight: FontWeight.w600),
    bodyLarge:
        base.copyWith(fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
    bodyMedium:
        base.copyWith(fontSize: 14, height: 1.55, fontWeight: FontWeight.w400),
    bodySmall:
        base.copyWith(fontSize: 12, height: 1.5, fontWeight: FontWeight.w400),
    labelLarge:
        base.copyWith(fontSize: 14, height: 1.45, fontWeight: FontWeight.w600),
    labelMedium:
        base.copyWith(fontSize: 12, height: 1.35, fontWeight: FontWeight.w600),
  ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
}

/// Full v3 [ThemeData] with component themes and the semantic extension.
///
///   MaterialApp(
///     theme: NepalBrandTheme.light(),
///     darkTheme: NepalBrandTheme.dark(),
///   )
class NepalBrandTheme {
  static ThemeData light() =>
      _build(NepalBrandScheme.light, NbSemanticColors.light);

  static ThemeData dark() =>
      _build(NepalBrandScheme.dark, NbSemanticColors.dark);

  static ThemeData _build(ColorScheme scheme, NbSemanticColors semantics) {
    final isDark = scheme.brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: InkSparkle.splashFactory,
      extensions: [semantics],
      textTheme: nbTextTheme(scheme),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? scheme.surfaceContainer : scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
          color: scheme.onSurface,
        ),
      ),
      // Primary CTA = accessible blue; secondary = accessible green.
      // Brand accents (#3B82F6 / #4FD166) are fills/graphics only.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.surfaceContainerHigh,
          disabledForegroundColor: scheme.onSurfaceVariant,
          minimumSize: const Size(64, NbShape.touchTarget),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(NbShape.radiusMd)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.secondary,
          foregroundColor: scheme.onSecondary,
          minimumSize: const Size(64, NbShape.touchTarget),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(NbShape.radiusMd)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.outline),
          minimumSize: const Size(64, NbShape.touchTarget),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(NbShape.radiusMd)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.primaryContainer,
        labelStyle: TextStyle(
            color: scheme.onPrimaryContainer, fontWeight: FontWeight.w600),
        secondaryLabelStyle: TextStyle(color: scheme.onPrimaryContainer),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      cardTheme: CardThemeData(
        color: isDark ? scheme.surfaceContainer : scheme.surfaceContainerLowest,
        shadowColor: scheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NbShape.radiusLg),
          side: BorderSide(color: scheme.outlineVariant),
        ),
        elevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(NbShape.radiusMd),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(NbShape.radiusMd),
          borderSide: BorderSide(color: semantics.focusRing, width: 2),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        linearTrackColor: scheme.surfaceContainerHighest,
        color: scheme.secondary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
        actionTextColor: scheme.inversePrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(NbShape.radiusSm)),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: scheme.secondaryContainer,
        textColor: scheme.onSecondaryContainer,
      ),
      dividerTheme:
          DividerThemeData(color: scheme.outlineVariant, thickness: 1),
    );
  }

  /// Hero gradient (marketing only — never a text container).
  /// White text stays >= 5:1 on every stop.
  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E3A8A), Color(0xFF1D4ED8), Color(0xFF15803D)],
    stops: [0.0, 0.45, 1.0],
  );
}
