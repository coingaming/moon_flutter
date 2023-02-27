import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/linear_loader_sizes.dart';

@immutable
class MoonLinearLoaderTheme extends ThemeExtension<MoonLinearLoaderTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonLinearLoaderTheme(
    x6s: MoonLinearLoaderSizes.x6s,
    x5s: MoonLinearLoaderSizes.x5s,
    x4s: MoonLinearLoaderSizes.x4s,
    x3s: MoonLinearLoaderSizes.x3s,
    x2s: MoonLinearLoaderSizes.x2s,
  );

  /// (6x) Extra small linear loader properties.
  final MoonLinearLoaderSizes x6s;

  /// (5x) Extra small linear loader properties.
  final MoonLinearLoaderSizes x5s;

  /// (4x) Extra small linear loader properties.
  final MoonLinearLoaderSizes x4s;

  /// (3x) Extra small linear loader properties.
  final MoonLinearLoaderSizes x3s;

  /// (2x) Extra small linear loader properties.
  final MoonLinearLoaderSizes x2s;

  const MoonLinearLoaderTheme({
    required this.x6s,
    required this.x5s,
    required this.x4s,
    required this.x3s,
    required this.x2s,
  });

  @override
  MoonLinearLoaderTheme copyWith({
    MoonLinearLoaderSizes? x6s,
    MoonLinearLoaderSizes? x5s,
    MoonLinearLoaderSizes? x4s,
    MoonLinearLoaderSizes? x3s,
    MoonLinearLoaderSizes? x2s,
  }) {
    return MoonLinearLoaderTheme(
      x6s: x6s ?? this.x6s,
      x5s: x5s ?? this.x5s,
      x4s: x4s ?? this.x4s,
      x3s: x3s ?? this.x3s,
      x2s: x2s ?? this.x2s,
    );
  }

  @override
  MoonLinearLoaderTheme lerp(ThemeExtension<MoonLinearLoaderTheme>? other, double t) {
    if (other is! MoonLinearLoaderTheme) return this;

    return MoonLinearLoaderTheme(
      x6s: x6s.lerp(other.x6s, t),
      x5s: x5s.lerp(other.x5s, t),
      x4s: x4s.lerp(other.x4s, t),
      x3s: x3s.lerp(other.x3s, t),
      x2s: x2s.lerp(other.x2s, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderTheme"))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizes>("x6s", x6s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizes>("x5s", x5s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizes>("x4s", x4s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizes>("x3s", x3s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizes>("x2s", x2s));
  }
}
