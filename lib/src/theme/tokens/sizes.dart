import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonSizes extends ThemeExtension<MoonSizes> with DiagnosticableTreeMixin {
  static const sizes = MoonSizes(
    x6s: 2,
    x5s: 4,
    x4s: 8,
    x3s: 12,
    x2s: 16,
    xs: 24,
    sm: 32,
    md: 40,
    lg: 48,
    xl: 56,
    x2l: 64,
  );

  /// The (6x) extra small size.
  final double x6s;

  /// The (5x) extra small size.
  final double x5s;

  /// The (4x) extra small size.
  final double x4s;

  /// The (3x) extra small size.
  final double x3s;

  /// The (2x) extra small size.
  final double x2s;

  /// The extra small size.
  final double xs;

  /// The small size.
  final double sm;

  /// The medium size.
  final double md;

  /// The large size.
  final double lg;

  /// The extra large size.
  final double xl;

  /// The (2x) extra large size.
  final double x2l;

  const MoonSizes({
    required this.x6s,
    required this.x5s,
    required this.x4s,
    required this.x3s,
    required this.x2s,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.x2l,
  });

  @override
  MoonSizes copyWith({
    double? x6s,
    double? x5s,
    double? x4s,
    double? x3s,
    double? x2s,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? x2l,
  }) {
    return MoonSizes(
      x6s: x6s ?? this.x6s,
      x5s: x5s ?? this.x5s,
      x4s: x4s ?? this.x4s,
      x3s: x3s ?? this.x3s,
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
    );
  }

  @override
  MoonSizes lerp(ThemeExtension<MoonSizes>? other, double t) {
    if (other is! MoonSizes) return this;

    return MoonSizes(
      x6s: lerpDouble(x6s, other.x6s, t)!,
      x5s: lerpDouble(x5s, other.x5s, t)!,
      x4s: lerpDouble(x4s, other.x4s, t)!,
      x3s: lerpDouble(x3s, other.x3s, t)!,
      x2s: lerpDouble(x2s, other.x2s, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      x2l: lerpDouble(x2l, other.x2l, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSizes"))
      ..add(DoubleProperty("x6s", x6s))
      ..add(DoubleProperty("x5s", x5s))
      ..add(DoubleProperty("x4s", x4s))
      ..add(DoubleProperty("x3s", x3s))
      ..add(DoubleProperty("x2s", x2s))
      ..add(DoubleProperty("xs", xs))
      ..add(DoubleProperty("sm", sm))
      ..add(DoubleProperty("md", md))
      ..add(DoubleProperty("lg", lg))
      ..add(DoubleProperty("xl", xl))
      ..add(DoubleProperty("x2l", x2l));
  }
}
