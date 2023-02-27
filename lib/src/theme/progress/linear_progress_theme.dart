import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/linear_progress_sizes.dart';

@immutable
class MoonLinearProgressTheme extends ThemeExtension<MoonLinearProgressTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonLinearProgressTheme(
    x6s: MoonLinearProgressSizes.x6s,
    x5s: MoonLinearProgressSizes.x5s,
    x4s: MoonLinearProgressSizes.x4s,
    x3s: MoonLinearProgressSizes.x3s,
    x2s: MoonLinearProgressSizes.x2s,
  );

  /// (6x) Extra small linear progress properties.
  final MoonLinearProgressSizes x6s;

  /// (5x) Extra small linear progress properties.
  final MoonLinearProgressSizes x5s;

  /// (4x) Extra small linear progress properties.
  final MoonLinearProgressSizes x4s;

  /// (3x) Extra small linear progress properties.
  final MoonLinearProgressSizes x3s;

  /// (2x) Extra small linear progress properties.
  final MoonLinearProgressSizes x2s;

  const MoonLinearProgressTheme({
    required this.x6s,
    required this.x5s,
    required this.x4s,
    required this.x3s,
    required this.x2s,
  });

  @override
  MoonLinearProgressTheme copyWith({
    MoonLinearProgressSizes? x6s,
    MoonLinearProgressSizes? x5s,
    MoonLinearProgressSizes? x4s,
    MoonLinearProgressSizes? x3s,
    MoonLinearProgressSizes? x2s,
  }) {
    return MoonLinearProgressTheme(
      x6s: x6s ?? this.x6s,
      x5s: x5s ?? this.x5s,
      x4s: x4s ?? this.x4s,
      x3s: x3s ?? this.x3s,
      x2s: x2s ?? this.x2s,
    );
  }

  @override
  MoonLinearProgressTheme lerp(ThemeExtension<MoonLinearProgressTheme>? other, double t) {
    if (other is! MoonLinearProgressTheme) return this;

    return MoonLinearProgressTheme(
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
      ..add(DiagnosticsProperty("type", "MoonLinearProgressTheme"))
      ..add(DiagnosticsProperty<MoonLinearProgressSizes>("x6s", x6s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizes>("x5s", x5s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizes>("x4s", x4s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizes>("x3s", x3s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizes>("x2s", x2s));
  }
}
