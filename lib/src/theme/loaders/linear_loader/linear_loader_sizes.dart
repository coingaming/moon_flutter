import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_size_properties.dart';

@immutable
class MoonLinearLoaderSizes extends ThemeExtension<MoonLinearLoaderSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonLinearLoaderSizes(
    x6s: MoonLinearLoaderSizeProperties.x6s,
    x5s: MoonLinearLoaderSizeProperties.x5s,
    x4s: MoonLinearLoaderSizeProperties.x4s,
    x3s: MoonLinearLoaderSizeProperties.x3s,
    x2s: MoonLinearLoaderSizeProperties.x2s,
  );

  /// (6x) Extra small linear loader properties.
  final MoonLinearLoaderSizeProperties x6s;

  /// (5x) Extra small linear loader properties.
  final MoonLinearLoaderSizeProperties x5s;

  /// (4x) Extra small linear loader properties.
  final MoonLinearLoaderSizeProperties x4s;

  /// (3x) Extra small linear loader properties.
  final MoonLinearLoaderSizeProperties x3s;

  /// (2x) Extra small linear loader properties.
  final MoonLinearLoaderSizeProperties x2s;

  const MoonLinearLoaderSizes({
    required this.x6s,
    required this.x5s,
    required this.x4s,
    required this.x3s,
    required this.x2s,
  });

  @override
  MoonLinearLoaderSizes copyWith({
    MoonLinearLoaderSizeProperties? x6s,
    MoonLinearLoaderSizeProperties? x5s,
    MoonLinearLoaderSizeProperties? x4s,
    MoonLinearLoaderSizeProperties? x3s,
    MoonLinearLoaderSizeProperties? x2s,
  }) {
    return MoonLinearLoaderSizes(
      x6s: x6s ?? this.x6s,
      x5s: x5s ?? this.x5s,
      x4s: x4s ?? this.x4s,
      x3s: x3s ?? this.x3s,
      x2s: x2s ?? this.x2s,
    );
  }

  @override
  MoonLinearLoaderSizes lerp(ThemeExtension<MoonLinearLoaderSizes>? other, double t) {
    if (other is! MoonLinearLoaderSizes) return this;

    return MoonLinearLoaderSizes(
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
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderSizes"))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x6s", x6s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x5s", x5s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x4s", x4s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x3s", x3s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x2s", x2s));
  }
}
