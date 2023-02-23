import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loader/loader_sizes.dart';

@immutable
class MoonLoaderTheme extends ThemeExtension<MoonLoaderTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonLoaderTheme(
    x2s: MoonLoaderSizes.x2s,
    xs: MoonLoaderSizes.xs,
    sm: MoonLoaderSizes.sm,
    md: MoonLoaderSizes.md,
    lg: MoonLoaderSizes.lg,
  );

  /// (2x) Extra small loader properties.
  final MoonLoaderSizes x2s;

  /// Extra small loader properties.
  final MoonLoaderSizes xs;

  /// Small loader properties.
  final MoonLoaderSizes sm;

  /// Medium loader properties.
  final MoonLoaderSizes md;

  /// Large loader properties.
  final MoonLoaderSizes lg;

  const MoonLoaderTheme({
    required this.x2s,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  @override
  MoonLoaderTheme copyWith({
    MoonLoaderSizes? x2s,
    MoonLoaderSizes? xs,
    MoonLoaderSizes? sm,
    MoonLoaderSizes? md,
    MoonLoaderSizes? lg,
  }) {
    return MoonLoaderTheme(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonLoaderTheme lerp(ThemeExtension<MoonLoaderTheme>? other, double t) {
    if (other is! MoonLoaderTheme) return this;

    return MoonLoaderTheme(
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
      ..add(DiagnosticsProperty("type", "MoonLoaderTheme"))
      ..add(DiagnosticsProperty<MoonLoaderSizes>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonLoaderSizes>("xs", xs))
      ..add(DiagnosticsProperty<MoonLoaderSizes>("sm", sm))
      ..add(DiagnosticsProperty<MoonLoaderSizes>("md", md))
      ..add(DiagnosticsProperty<MoonLoaderSizes>("lg", lg));
  }
}
