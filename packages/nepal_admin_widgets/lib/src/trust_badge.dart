import 'package:flutter/material.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';

/// Renders how much evidence stands behind a palika's CBS code.
///
/// Design System v3 made trust a first-class visual role: a verification
/// claim must never look stronger than the evidence behind it, and "verified"
/// is scoped information rendered in the action colour — never success green.
/// This widget is that rule, executable:
///
/// * [CbsCodeConfidence.verified] — 'Doubly attested' (primary).
/// * [CbsCodeConfidence.singleSource] — 'Single source' (tertiary).
/// * [CbsCodeConfidence.unverified] — 'Not coded' (neutral).
///
/// A palika with no code is a documented fact, not an error state, so the
/// neutral badge says exactly that instead of turning red.
///
/// ```dart
/// TrustBadge.forLocalBody(body: body)
/// TrustBadge.confidence(confidence: body.cbsCodeConfidence, compact: true)
/// ```
class TrustBadge extends StatelessWidget {
  /// Renders the tier of [body]'s CBS code.
  const TrustBadge.forLocalBody({
    super.key,
    required LocalBody body,
    this.compact = false,
  }) : confidence = body.cbsCodeConfidence;

  /// Renders a tier directly, without a body in hand.
  const TrustBadge.confidence({
    super.key,
    required this.confidence,
    this.compact = false,
  });

  /// The evidence tier to render.
  final CbsCodeConfidence confidence;

  /// Icon-only rendering, for dense tables. The tier name stays available to
  /// screen readers and as a tooltip.
  final bool compact;

  /// The short label for a tier.
  static String labelFor(CbsCodeConfidence confidence) => switch (confidence) {
        CbsCodeConfidence.verified => 'Doubly attested',
        CbsCodeConfidence.singleSource => 'Single source',
        CbsCodeConfidence.unverified => 'Not coded',
      };

  /// The one-sentence story behind a tier, for tooltips and screen readers.
  static String tooltipFor(CbsCodeConfidence confidence) =>
      switch (confidence) {
        CbsCodeConfidence.verified =>
          'The postal-2025 code list and the CBS harvest name the same code '
              'for the same entity.',
        CbsCodeConfidence.singleSource =>
          'One authoritative roster attests this code. Usable for joins, but '
              'not doubly attested.',
        CbsCodeConfidence.unverified =>
          'No defensible CBS code. The dataset publishes null rather than '
              'guessing.',
      };

  /// The icon for a tier.
  static IconData iconFor(CbsCodeConfidence confidence) =>
      switch (confidence) {
        CbsCodeConfidence.verified => Icons.verified,
        CbsCodeConfidence.singleSource => Icons.fact_check,
        CbsCodeConfidence.unverified => Icons.help_outline,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = switch (confidence) {
      CbsCodeConfidence.verified => scheme.primary,
      CbsCodeConfidence.singleSource => scheme.tertiary,
      CbsCodeConfidence.unverified => scheme.onSurfaceVariant,
    };
    final label = labelFor(confidence);

    Widget pill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconFor(confidence), size: 13, color: accent),
          if (!compact) ...[
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
        ],
      ),
    );

    pill = Tooltip(message: tooltipFor(confidence), child: pill);

    return Semantics(label: label, child: pill);
  }
}
