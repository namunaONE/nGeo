import 'package:flutter/material.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

/// A self-contained visual summary of one palika.
///
/// Renders everything a selected local body means in one glance: the
/// bilingual name, a [LocalBodyTypeChip], a [TrustBadge] for the CBS code,
/// the ward count, the code itself, and the district → province breadcrumb —
/// with an honest empty state when nothing is selected.
///
/// ```dart
/// AdministrativeSummaryCard(body: cascade.localBody)
/// ```
///
/// Pairs with [AdministrativePickerCard], or drives it straight off your own
/// cascade, a search hit, or a list of results.
class AdministrativeSummaryCard extends StatelessWidget {
  const AdministrativeSummaryCard({
    super.key,
    required this.body,
    this.labelStyle = LabelStyle.both,
    this.onTap,
    this.showTrust = true,
    this.showCodes = true,
    this.emptyText = 'Pick a province, then a district, then a local body.',
  });

  /// The palika to summarize. Null renders the empty state.
  final LocalBody? body;

  /// Which script(s) the name line uses.
  final LabelStyle labelStyle;

  /// Called when the user taps the card. Null disables the tap affordance.
  final VoidCallback? onTap;

  /// Show the CBS trust badge.
  final bool showTrust;

  /// Show the CBS code and ward-count line.
  final bool showCodes;

  /// Label used when [body] is null.
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final b = body;

    if (b == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.location_city_outlined,
                  color: scheme.onSurfaceVariant),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  emptyText,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget content = Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(b.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      AdministrativeCascade.formatLocalBody(b,
                          style: labelStyle),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              LocalBodyTypeChip(type: b.type),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.place_outlined,
                  size: 16, color: scheme.onSurfaceVariant),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${b.districtName} · ${b.provinceName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              if (showTrust) ...[
                const SizedBox(width: 8),
                TrustBadge.forLocalBody(body: b),
              ],
            ],
          ),
          if (showCodes) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.grid_on_outlined,
                    size: 16, color: scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(
                  'CBS ${b.cbsCodeString ?? '—'}',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(Icons.home_work_outlined,
                    size: 16, color: scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(
                  b.wards != null ? '${b.wards} wards' : 'wards not recorded',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      content = InkWell(onTap: onTap, child: content);
    }

    return Semantics(
      label: 'Local body ${b.fullPath}',
      child: Card(child: content),
    );
  }
}
