// Design token generator - the flagship "web and Flutter can't disagree"
// move, Phase A. brand/tokens.json is the single source of truth for every
// design token, and docs/brand-tokens.css becomes a generated artifact.
//
// The JSON is DTCG-flavoured: tokens carry $type/$value, and a value like
// {blue.700} is an alias that renders as var(--blue-700). Three themes are
// captured: light (:root), dark (html.dark / [data-theme="dark"]) and
// systemDark (the prefers-color-scheme media block for first visits).
//
// This tool owns the emission layout - selectors, comments and line
// packing - so the CSS it writes is byte-identical to the hand-authored
// original. CI regenerates and diff-gates the file, so the CSS can never
// silently drift from the token source.
//
// Usage:
//   dart run tool/generate_design_tokens.dart          regenerate the CSS
//   dart run tool/generate_design_tokens.dart --check  exit 2 on drift

import 'dart:convert';
import 'dart:io';

const _tokensPath = 'brand/tokens.json';
const _cssPath = 'docs/brand-tokens.css';
const _themes = ['light', 'dark', 'systemDark'];
final RegExp _alias = RegExp(r'\{([^{}]+)\}');

// The emission script, one directive per output line:
//   T <theme>   switch the theme that L/X/S directives read from
//   R <text>    raw line; a bare "R" emits a blank line
//   C2 <text>   block comment at indent 2
//   L2 <token>  long declaration at indent 2 ("--name: value;")
//   X2/X4 ...   packed declarations without a space after the colon
//   S2 ...      packed declarations with one space after the colon
const _layout = <String>[
    'R /* ==========================================================================',
    'R    Design System v3 — Himalayan Trust × Everest Growth',
    'R    Brand blue #3B82F6 (accent) · accessible blue #1D4ED8 (primary)',
    'R    Brand green #4FD166 (fill) · accessible green #15803D (success)',
    'R    Import AFTER styles.css:',
    'R      <link rel="stylesheet" href="brand-tokens.css">',
    'R    Light = :root, Dark = html.dark / [data-theme="dark"]',
    'R    Contrast pairs measured (doc/brand-system.md §2). Do not use primitives',
    'R    in feature markup; consume --nb-* semantic tokens.',
    'R    ========================================================================== */',
    'R',
    'R :root {',
    'T light',
    'C2 ---- Seeds ----',
    'L2 brand.blue-seed',
    'L2 brand.green-seed',
    'R',
    'C2 ---- Primitive ramp: blue ----',
    'X2 blue.50 blue.100 blue.200 blue.300',
    'X2 blue.400 blue.500 blue.600 blue.700',
    'X2 blue.800 blue.900 blue.950',
    'R',
    'C2 ---- Primitive ramp: green ----',
    'X2 green.50 green.100 green.200 green.300',
    'X2 green.400 green.500 green.600 green.700',
    'X2 green.800 green.900 green.950',
    'R',
    'C2 ---- Primitive ramp: stone (surfaces) ----',
    'X2 stone.0 stone.50 stone.100 stone.200',
    'X2 stone.300 stone.400 stone.500 stone.550',
    'X2 stone.600 stone.700 stone.800 stone.900',
    'X2 stone.950',
    'R',
    'C2 ---- Ink + status primitives ----',
    'X2 ink.900',
    'X2 red.50 red.100 red.600 red.700 red.800',
    'X2 amber.50 amber.100 amber.300 amber.600',
    'X2 amber.700 amber.800 amber.900',
    'R',
    'C2 ---- Semantic — actions (light) ----',
    'L2 nb.action.primary',
    'L2 nb.action.primary-fg',
    'L2 nb.action.primary-hover',
    'L2 nb.action.primary-pressed',
    'L2 nb.action.primary-subtle',
    'L2 nb.action.secondary',
    'L2 nb.action.secondary-fg',
    'L2 nb.action.secondary-subtle',
    'L2 nb.accent.brand',
    'L2 nb.accent.brand-fg',
    'L2 nb.accent.green',
    'L2 nb.accent.green-fg',
    'R',
    'C2 ---- Semantic — surfaces, text, borders (light) ----',
    'L2 nb.surface.canvas',
    'L2 nb.surface.raised',
    'L2 nb.surface.subtle',
    'L2 nb.surface.muted',
    'L2 nb.text.primary',
    'L2 nb.text.secondary',
    'L2 nb.text.tertiary',
    'L2 nb.text.on-brand-blue',
    'L2 nb.text.on-brand-green',
    'L2 nb.border.default',
    'L2 nb.border.strong',
    'L2 nb.border.focus',
    'R',
    'C2 ---- Semantic — status (light) ----',
    'L2 nb.status.success',
    'L2 nb.status.success-container',
    'L2 nb.status.on-success-container',
    'L2 nb.status.warning',
    'L2 nb.status.warning-container',
    'L2 nb.status.on-warning-container',
    'L2 nb.status.danger',
    'L2 nb.status.danger-container',
    'L2 nb.status.on-danger-container',
    'L2 nb.status.info',
    'L2 nb.status.info-container',
    'L2 nb.status.on-info-container',
    'R',
    'C2 ---- Semantic — trust (light). Verified is scoped blue info, never success green. ----',
    'L2 nb.trust.verified',
    'L2 nb.trust.verified-container',
    'L2 nb.trust.on-verified-container',
    'L2 nb.trust.owner-stated',
    'L2 nb.trust.owner-stated-container',
    'L2 nb.trust.on-owner-stated-container',
    'L2 nb.trust.pending',
    'L2 nb.trust.pending-container',
    'L2 nb.trust.on-pending-container',
    'L2 nb.trust.expired',
    'L2 nb.trust.revoked',
    'R',
    'C2 ---- M3 roles: LIGHT (seed #3B82F6 + overrides, doc/brand-system.md §6) ----',
    'X2 md.primary md.on-primary',
    'X2 md.primary-container md.on-primary-container',
    'X2 md.secondary md.on-secondary',
    'X2 md.secondary-container md.on-secondary-container',
    'X2 md.tertiary md.on-tertiary',
    'X2 md.tertiary-container md.on-tertiary-container',
    'X2 md.error md.on-error',
    'X2 md.error-container md.on-error-container',
    'X2 md.surface-dim md.surface md.surface-bright',
    'X2 md.lowest md.low md.container',
    'X2 md.high md.highest',
    'X2 md.on-surface md.on-surface-variant',
    'X2 md.outline md.outline-variant',
    'X2 md.inverse-surface md.inverse-on-surface',
    'X2 md.inverse-primary md.surface-tint',
    'X2 md.scrim md.shadow',
    'R',
    'C2 ---- Spacing / radius / motion (4-pt base, 8-pt rhythm) ----',
    'S2 nb.space.1 nb.space.2 nb.space.3 nb.space.4',
    'S2 nb.space.6 nb.space.8 nb.space.12 nb.space.16',
    'S2 nb.radius.sm nb.radius.md nb.radius.lg nb.radius.xl',
    'S2 nb.motion.fast nb.motion.standard nb.motion.emphasized',
    'R',
    'C2 ---- Brand gradient / premium surfaces ----',
    'L2 brand.hero-gradient',
    'L2 brand.glow-blue',
    'L2 brand.glow-green',
    'R',
    'C2 ---- Map: category remap (rural=green, mun=blue) ----',
    'X2 map.metro map.sub map.mun map.rural',
    'R',
    'C2 ---- Bridge onto site Design System v1 semantic tokens ----',
    'L2 color.primary',
    'L2 color.primary-dark',
    'L2 color.primary-light',
    'L2 color.border-focus',
    'L2 color.success',
    'L2 color.success-bg',
    'L2 focus.ring',
    'R }',
    'R',
    'R html.dark,',
    'R html[data-theme="dark"] {',
    'T dark',
    'C2 ---- Semantic — dark (built separately, never inverted) ----',
    'S2 nb.action.primary nb.action.primary-fg',
    'S2 nb.action.primary-hover nb.action.primary-pressed',
    'S2 nb.action.primary-subtle',
    'S2 nb.action.secondary nb.action.secondary-fg',
    'S2 nb.action.secondary-subtle',
    'S2 nb.accent.brand nb.accent.brand-fg',
    'S2 nb.accent.green nb.accent.green-fg',
    'S2 nb.surface.canvas nb.surface.raised',
    'S2 nb.surface.subtle nb.surface.muted',
    'S2 nb.text.primary nb.text.secondary nb.text.tertiary',
    'S2 nb.border.default nb.border.strong nb.border.focus',
    'S2 nb.status.success nb.status.success-container nb.status.on-success-container',
    'S2 nb.status.warning nb.status.warning-container nb.status.on-warning-container',
    'S2 nb.status.danger nb.status.danger-container nb.status.on-danger-container',
    'S2 nb.status.info nb.status.info-container nb.status.on-info-container',
    'S2 nb.trust.verified nb.trust.verified-container nb.trust.on-verified-container',
    'S2 nb.trust.owner-stated nb.trust.owner-stated-container nb.trust.on-owner-stated-container',
    'S2 nb.trust.pending nb.trust.pending-container nb.trust.on-pending-container',
    'S2 nb.trust.expired nb.trust.revoked',
    'R',
    'C2 ---- M3 roles: DARK ----',
    'X2 md.primary md.on-primary',
    'X2 md.primary-container md.on-primary-container',
    'X2 md.secondary md.on-secondary',
    'X2 md.secondary-container md.on-secondary-container',
    'X2 md.tertiary md.on-tertiary',
    'X2 md.tertiary-container md.on-tertiary-container',
    'X2 md.error md.on-error',
    'X2 md.error-container md.on-error-container',
    'X2 md.surface-dim md.surface md.surface-bright',
    'X2 md.lowest md.low md.container',
    'X2 md.high md.highest',
    'X2 md.on-surface md.on-surface-variant',
    'X2 md.outline md.outline-variant',
    'X2 md.inverse-surface md.inverse-on-surface',
    'X2 md.inverse-primary md.surface-tint',
    'R',
    'C2 ---- Bridge (dark) ----',
    'X2 color.primary color.primary-dark color.primary-light',
    'X2 color.border-focus',
    'X2 color.success color.success-bg',
    'L2 brand.hero-gradient',
    'R }',
    'R',
    'R /* First-visit system preference (only when no explicit choice stored) */',
    'R @media (prefers-color-scheme: dark) {',
    'R   html:not([data-theme]) {',
    'T systemDark',
    'X4 md.primary md.on-primary',
    'X4 md.primary-container md.on-primary-container',
    'X4 md.secondary md.on-secondary',
    'X4 md.secondary-container md.on-secondary-container',
    'X4 md.surface md.on-surface',
    'X4 nb.action.primary nb.action.primary-fg',
    'X4 color.primary color.border-focus',
    'R   }',
    'R }',
    'R',
    'R /* ---- Premium helpers (opt-in, no breaking change) ---- */',
    'R .brand-hero {',
    'R   background: var(--brand-hero-gradient);',
    'R   color: #fff;',
    'R }',
    'R .brand-hero :is(h1,h2,h3,p) { color: #fff; }',
    'R .brand-hero .stat-value { color: var(--nb-accent-green); }',
    'R .btn-brand-green {',
    'R   background: var(--md-secondary); color: var(--md-on-secondary);',
    'R   box-shadow: var(--brand-glow-green);',
    'R }',
    'R .btn-brand-green:hover { filter: brightness(1.08); color: var(--md-on-secondary); }',
    'R /* Trust labels: scoped, blue info treatment — never a green "verified" chip. */',
    'R .badge-verified {',
    'R   background: var(--nb-trust-verified-container);',
    'R   color: var(--nb-trust-on-verified-container);',
    'R   border: 1px solid color-mix(in srgb, var(--nb-trust-verified) 40%, transparent);',
    'R }',
    'R .card-premium {',
    'R   background: var(--md-lowest, var(--color-surface));',
    'R   border: 1px solid var(--md-outline-variant);',
    'R   box-shadow: var(--brand-glow-blue);',
    'R }',
    'R .dot-mun { background: var(--map-mun); }',
    'R .dot-rural { background: var(--map-rural); }',
    'R .type-mun { background: var(--blue-100); color: var(--blue-900); }',
    'R .type-rural { background: var(--green-100); color: var(--green-900); }',
    'R html.dark .type-mun, html[data-theme="dark"] .type-mun { background: #1E3A8A; color: #93C5FD; }',
    'R html.dark .type-rural, html[data-theme="dark"] .type-rural { background: #14532D; color: #86EFAC; }',
];

Never _fail(String message) {
  stderr.writeln('generate_design_tokens: $message');
  exit(1);
}

String _cssName(String token) => '--${token.replaceAll('.', '-')}';

Map<String, String> _flatten(Map node, String prefix) {
  final out = <String, String>{};
  node.forEach((key, value) {
    if (key.startsWith(r'$')) {
      return;
    }
    final name = prefix.isEmpty ? '$key' : '$prefix.$key';
    if (value is Map && value.containsKey(r'$value')) {
      out[name] = '${value[r'$value']}';
    } else if (value is Map) {
      out.addAll(_flatten(value, name));
    } else {
      _fail('$_tokensPath: "$name" must be a token or a group');
    }
  });
  return out;
}

String _renderValue(String value, Map<String, String> raw) {
  return value.replaceAllMapped(_alias, (match) {
    final ref = match.group(1)!;
    if (!raw.containsKey(ref)) {
      _fail('unknown alias target: $ref');
    }
    return 'var(--${ref.replaceAll('.', '-')})';
  });
}

String _lookup(
  String theme,
  String token,
  Map<String, Map<String, String>> flat,
  Set<String> referenced,
) {
  final values = flat[theme] ?? const <String, String>{};
  if (!values.containsKey(token)) {
    _fail('unknown token in $theme: $token');
  }
  referenced.add('$theme:$token');
  return values[token] ?? '';
}

String _render(Map<String, Map<String, String>> flat) {
  final lines = <String>[];
  final referenced = <String>{};
  var theme = 'light';
  for (final directive in _layout) {
    if (directive.startsWith('T ')) {
      theme = directive.substring(2).trim();
      continue;
    }
    if (directive.startsWith('R')) {
      lines.add(directive.length > 1 ? directive.substring(2) : '');
      continue;
    }
    if (directive.startsWith('C2 ')) {
      lines.add('  /* ${directive.substring(3)} */');
      continue;
    }
    if (directive.startsWith('L2 ')) {
      final token = directive.substring(3).trim();
      final value = _lookup(theme, token, flat, referenced);
      lines.add('  ${_cssName(token)}: $value;');
      continue;
    }
    if (directive.startsWith('X2 ') || directive.startsWith('X4 ')) {
      _packed(directive, false, theme, flat, lines, referenced);
      continue;
    }
    if (directive.startsWith('S2 ')) {
      _packed(directive, true, theme, flat, lines, referenced);
      continue;
    }
    _fail('bad layout directive: $directive');
  }
  // Completeness: a token that exists in the JSON but is never emitted
  // would rot silently, so the layout must reference every token.
  for (final name in _themes) {
    for (final token in flat[name]!.keys) {
      if (!referenced.contains('$name:$token')) {
        _fail('token defined but never emitted: $name:$token');
      }
    }
  }
  return '${lines.join('\n')}\n';
}

void _packed(
  String directive,
  bool spaced,
  String theme,
  Map<String, Map<String, String>> flat,
  List<String> lines,
  Set<String> referenced,
) {
  final indent = directive.startsWith('X4') ? '    ' : '  ';
  final tokens = directive.substring(3).trim().split(RegExp(r'\s+'));
  final parts = <String>[];
  for (final token in tokens) {
    final value = _lookup(theme, token, flat, referenced);
    final separator = spaced ? ': ' : ':';
    parts.add('${_cssName(token)}$separator$value');
  }
  lines.add('$indent${parts.join('; ')};');
}

void main(List<String> arguments) {
  final checkOnly = arguments.contains('--check');
  final source = File(_tokensPath);
  if (!source.existsSync()) {
    _fail('missing $_tokensPath');
  }
  final decoded = jsonDecode(source.readAsStringSync());
  if (decoded is! Map) {
    _fail('$_tokensPath must contain a JSON object');
  }
  final flat = <String, Map<String, String>>{};
  for (final theme in _themes) {
    final node = decoded[theme];
    if (node is! Map) {
      _fail('$_tokensPath: missing the "$theme" theme');
    }
    final raw = _flatten(node, '');
    flat[theme] = {
      for (final entry in raw.entries)
        entry.key: _renderValue(entry.value, raw),
    };
  }
  final css = _render(flat);
  if (checkOnly) {
    final target = File(_cssPath);
    if (!target.existsSync()) {
      _fail('missing $_cssPath');
    }
    if (target.readAsStringSync() != css) {
      stderr.writeln('generate_design_tokens: $_cssPath is out of date.');
      stderr.writeln('run: dart run tool/generate_design_tokens.dart');
      exit(2);
    }
    return;
  }
  File(_cssPath).writeAsStringSync(css);
  stdout.writeln('wrote $_cssPath (${css.length} bytes)');
}
