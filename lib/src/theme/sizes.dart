import 'dart:ui';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonSizes extends ThemeExtension<MoonSizes> with DiagnosticableTreeMixin {
  /// (5x) Extra small size, default value 4.
  final double x5s;

  /// (4x) Extra small size, default value 8.
  final double x4s;

  /// (3x) Extra small size, default value 12.
  final double x3s;

  /// (2x) Extra small size, default value 16.
  final double x2s;

  /// Extra small size, default value 24.
  final double xs;

  /// Small size, default value 32.
  final double sm;

  /// Medium size, default value 40.
  final double md;

  /// Large size, default value 48.
  final double lg;

  /// Extra large size, default value 56.
  final double xl;

  /// (2x) Extra large size, default value 64.
  final double x2l;

  const MoonSizes({
    this.x5s = 4,
    this.x4s = 8,
    this.x3s = 12,
    this.x2s = 16,
    this.xs = 24,
    this.sm = 32,
    this.md = 40,
    this.lg = 48,
    this.xl = 56,
    this.x2l = 64,
  });

  @override
  MoonSizes copyWith({
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
