import 'dart:ui';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonSizes extends ThemeExtension<MoonSizes> with DiagnosticableTreeMixin {
  final double xs2;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xl2;

  const MoonSizes({
    this.xs2 = 16,
    this.xs = 24,
    this.sm = 32,
    this.md = 40,
    this.lg = 48,
    this.xl = 56,
    this.xl2 = 64,
  });

  @override
  MoonSizes copyWith({
    double? xs2,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xl2,
  }) {
    return MoonSizes(
      xs2: xs2 ?? this.xs2,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xl2: xl2 ?? this.xl2,
    );
  }

  @override
  MoonSizes lerp(ThemeExtension<MoonSizes>? other, double t) {
    if (other is! MoonSizes) return this;

    return MoonSizes(
      xs2: lerpDouble(xs2, other.xs2, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xl2: lerpDouble(xl2, other.xl2, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSizes"))
      ..add(DoubleProperty("xs2", xs2))
      ..add(DoubleProperty("xs", xs))
      ..add(DoubleProperty("sm", sm))
      ..add(DoubleProperty("md", md))
      ..add(DoubleProperty("lg", lg))
      ..add(DoubleProperty("xl", xl))
      ..add(DoubleProperty("xl2", xl2));
  }
}
