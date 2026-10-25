import 'package:flutter/material.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

/// The drop-in composition: cascading dropdowns, bilingual search and a live
/// summary card in one [Card], with a clear-selection action.
///
/// This is the fastest way to a fully functional Nepal address picker:
///
/// ```dart
/// AdministrativePickerCard(
///   onChanged: (selection) {
///     if (selection.isComplete) save(selection.localBody!);
///   },
/// );
/// ```
///
/// Pass a [cascade] to observe it from outside. Omit it and one is created
/// internally — the same ownership rule as [AdministrativeDropdown].
class AdministrativePickerCard extends StatefulWidget {
  const AdministrativePickerCard({
    super.key,
    this.cascade,
    this.onChanged,
    this.title = 'Address in Nepal',
    this.labelStyle = LabelStyle.both,
    this.showSearch = true,
    this.showSummary = true,
    this.showClearButton = true,
  });

  /// The cascade to drive. One is created internally when omitted.
  final AdministrativeCascade? cascade;

  /// Called on every change, including the clear action. Check
  /// [AdministrativeSelection.isComplete] before treating it as an answer.
  final ValueChanged<AdministrativeSelection>? onChanged;

  /// Header above the dropdowns.
  final String title;

  /// Which script(s) the option labels use.
  final LabelStyle labelStyle;

  /// Show the bilingual search field.
  final bool showSearch;

  /// Show the live [AdministrativeSummaryCard] beneath the dropdowns.
  final bool showSummary;

  /// Show the clear-selection action in the header.
  final bool showClearButton;

  @override
  State<AdministrativePickerCard> createState() =>
      _AdministrativePickerCardState();
}

class _AdministrativePickerCardState extends State<AdministrativePickerCard> {
  AdministrativeCascade? _internal;

  AdministrativeCascade get _cascade =>
      widget.cascade ?? (_internal ??= AdministrativeCascade());

  @override
  void dispose() {
    // Only dispose what we created; a caller-supplied cascade is theirs.
    _internal?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cascade = _cascade;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(widget.title, style: theme.textTheme.titleMedium),
                ),
                if (widget.showClearButton)
                  IconButton(
                    tooltip: 'Clear selection',
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      cascade.clear();
                      widget.onChanged?.call(cascade.selection);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            AdministrativeDropdown(
              cascade: cascade,
              onChanged: (_) => widget.onChanged?.call(_cascade.selection),
              labelStyle: widget.labelStyle,
              showSearch: widget.showSearch,
            ),
            if (widget.showSummary) ...[
              const SizedBox(height: 16),
              AnimatedBuilder(
                animation: cascade,
                builder: (context, _) =>
                    AdministrativeSummaryCard(body: cascade.localBody),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
