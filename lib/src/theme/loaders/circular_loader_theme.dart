import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/circular_loader_sizes.dart';

@immutable
class MoonCircularLoaderTheme extends ThemeExtension<MoonCircularLoaderTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonCircularLoaderTheme(
    x2s: MoonCircularLoaderSizes.x2s,
    xs: MoonCircularLoaderSizes.xs,
    sm: MoonCircularLoaderSizes.sm,
    md: MoonCircularLoaderSizes.md,
    lg: MoonCircularLoaderSizes.lg,
  );

  /// (2x) Extra small circular loader properties.
  final MoonCircularLoaderSizes x2s;

  /// Extra small circular loader properties.
  final MoonCircularLoaderSizes xs;

  /// Small circular loader properties.
  final MoonCircularLoaderSizes sm;

  /// Medium circular loader properties.
  final MoonCircularLoaderSizes md;

  /// Large circular loader properties.
  final MoonCircularLoaderSizes lg;

  const MoonCircularLoaderTheme({
    required this.x2s,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  @override
  MoonCircularLoaderTheme copyWith({
    MoonCircularLoaderSizes? x2s,
    MoonCircularLoaderSizes? xs,
    MoonCircularLoaderSizes? sm,
    MoonCircularLoaderSizes? md,
    MoonCircularLoaderSizes? lg,
  }) {
    return MoonCircularLoaderTheme(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonCircularLoaderTheme lerp(ThemeExtension<MoonCircularLoaderTheme>? other, double t) {
    if (other is! MoonCircularLoaderTheme) return this;

    return MoonCircularLoaderTheme(
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderTheme"))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizes>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizes>("xs", xs))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizes>("sm", sm))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizes>("md", md))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizes>("lg", lg));
  }
}
