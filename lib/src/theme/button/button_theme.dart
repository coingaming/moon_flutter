import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/button/button_sizes.dart';

@immutable
class MoonButtonTheme extends ThemeExtension<MoonButtonTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonButtonTheme(
    xs: MoonButtonSizes.xs,
    sm: MoonButtonSizes.sm,
    md: MoonButtonSizes.md,
    lg: MoonButtonSizes.lg,
    xl: MoonButtonSizes.xl,
  );

  /// Extra small button properties.
  final MoonButtonSizes xs;

  /// Small button properties.
  final MoonButtonSizes sm;

  /// Medium button properties.
  final MoonButtonSizes md;

  /// Large button properties.
  final MoonButtonSizes lg;

  /// Extra large button properties.
  final MoonButtonSizes xl;

  const MoonButtonTheme({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  @override
  MoonButtonTheme copyWith({
    MoonButtonSizes? xs,
    MoonButtonSizes? sm,
    MoonButtonSizes? md,
    MoonButtonSizes? lg,
    MoonButtonSizes? xl,
  }) {
    return MoonButtonTheme(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonButtonTheme lerp(ThemeExtension<MoonButtonTheme>? other, double t) {
    if (other is! MoonButtonTheme) return this;

    return MoonButtonTheme(
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonTheme"))
      ..add(DiagnosticsProperty<MoonButtonSizes>("xs", xs))
      ..add(DiagnosticsProperty<MoonButtonSizes>("sm", sm))
      ..add(DiagnosticsProperty<MoonButtonSizes>("md", md))
      ..add(DiagnosticsProperty<MoonButtonSizes>("lg", lg))
      ..add(DiagnosticsProperty<MoonButtonSizes>("xl", xl));
  }
}
