// Component gallery for nepal_admin_widgets: every widget the package
// ships, runnable, in light and dark.
//
//   cd packages/nepal_admin_widgets/example
//   flutter pub get
//   flutter run
//
// Everything renders offline from the verified dataset compiled into the
// package — no network, no asset loading, no location permissions.
import 'package:flutter/material.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

void main() => runApp(const GalleryApp());

/// Seeds with brand blue #3B82F6 for harmony (see doc/brand-system.md §6);
/// the light/dark toggle exercises both themes for every component.
class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  ThemeMode _mode = ThemeMode.light;

  void _toggle() => setState(() {
        _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nepal_admin_widgets gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6)),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _mode,
      home: GalleryHome(onToggleTheme: _toggle),
    );
  }
}

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key, required this.onToggleTheme});

  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('nepal_admin_widgets'),
          actions: [
            IconButton(
              tooltip: 'Toggle light / dark',
              icon: const Icon(Icons.brightness_6_outlined),
              onPressed: onToggleTheme,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Picker'),
              Tab(text: 'Components'),
              Tab(text: 'Dataset'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PickerTab(),
            ComponentsTab(),
            DatasetTab(),
          ],
        ),
      ),
    );
  }
}

class PickerTab extends StatefulWidget {
  const PickerTab({super.key});

  @override
  State<PickerTab> createState() => _PickerTabState();
}

class _PickerTabState extends State<PickerTab> {
  final _cascade = AdministrativeCascade();
  AdministrativeSelection? _selection;

  @override
  void dispose() {
    _cascade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = _selection?.localBody;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AdministrativePickerCard(
          cascade: _cascade,
          onChanged: (selection) => setState(() => _selection = selection),
        ),
        const SizedBox(height: 16),
        if (body == null)
          Text(
            'A complete selection lands here — choosing a province or a '
            'district alone is not an answer.',
            style: Theme.of(context).textTheme.bodySmall,
          )
        else ...[
          Text('Selected', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _DetailRow('Full path', body.fullPath),
          _DetailRow('Type', body.typeName),
          _DetailRow('Devanagari', body.nameNeOrName),
          _DetailRow(
            'CBS code',
            body.cbsCode == null
                ? 'not coded'
                : '${body.cbsCodeString} '
                    '(${body.cbsCodeConfidence.wireName})',
          ),
          _DetailRow(
            'Wards',
            body.wards == null
                ? 'not recorded'
                : '${body.wards} '
                    '(${body.wardsVerified ? 'verified' : 'unverified'})',
          ),
          if (body.website != null) _DetailRow('Website', body.website!),
        ],
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child:
                Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class ComponentsTab extends StatelessWidget {
  const ComponentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final verified = NepalAdminApi.getVerifiedLocalBodies();
    final singleSource = NepalAdminApi.getSingleSourceLocalBodies();
    final uncoded = NepalAdminApi.getUncodedLocalBodies();
    final metro =
        NepalAdminApi.getLocalBodiesByType(LocalBodyType.metropolitan);
    final rural =
        NepalAdminApi.getLocalBodiesByType(LocalBodyType.ruralMunicipality);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionTitle('LocalBodyTypeChip — every palika type'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in LocalBodyType.values)
              LocalBodyTypeChip(type: type),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in LocalBodyType.values)
              LocalBodyTypeChip(type: type, compact: true),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle('TrustBadge — every CBS confidence tier'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (verified.isNotEmpty)
              TrustBadge.forLocalBody(body: verified.first),
            if (singleSource.isNotEmpty)
              TrustBadge.forLocalBody(body: singleSource.first),
            if (uncoded.isNotEmpty)
              TrustBadge.forLocalBody(body: uncoded.first),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle('AdministrativeSummaryCard'),
        if (metro.isNotEmpty) AdministrativeSummaryCard(body: metro.first),
        const SizedBox(height: 8),
        if (rural.isNotEmpty) AdministrativeSummaryCard(body: rural.first),
        const SizedBox(height: 8),
        const AdministrativeSummaryCard(
          body: null,
          emptyText: 'Nothing selected — the empty state',
        ),
      ],
    );
  }
}

class DatasetTab extends StatelessWidget {
  const DatasetTab({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = NepalAdminApi.getNationalStats();
    final verified = NepalAdminApi.getVerifiedLocalBodies().length;
    final singleSource = NepalAdminApi.getSingleSourceLocalBodies().length;
    final uncoded = NepalAdminApi.getUncodedLocalBodies().length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionTitle('National structure — computed live'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatChip('${stats.provinces} provinces'),
            _StatChip('${stats.districts} districts'),
            _StatChip('${stats.total} local bodies'),
            _StatChip('${stats.wards} declared wards'),
            _StatChip('${stats.verifiedWards} verified wards'),
            if (stats.wardGaps > 0) _StatChip('${stats.wardGaps} ward gaps'),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle('By palika type'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatChip('${stats.metro} metropolitan'),
            _StatChip('${stats.subMetro} sub-metropolitan'),
            _StatChip('${stats.municipalities} municipalities'),
            _StatChip('${stats.ruralMunicipalities} rural municipalities'),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle('CBS trust tiers'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatChip('$verified doubly attested'),
            _StatChip('$singleSource single-source'),
            _StatChip('$uncoded not coded'),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Every number on this tab is computed from the dataset at run '
          'time — the same offline roster the widgets query.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(color: scheme.onSecondaryContainer, fontSize: 13),
      ),
    );
  }
}
