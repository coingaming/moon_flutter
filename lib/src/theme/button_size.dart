import 'dart:ui';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonButtonSize extends ThemeExtension<MoonButtonSize> with DiagnosticableTreeMixin {
  static const xs = MoonButtonSize(
    height: 24,
    gap: 4,
    padding: EdgeInsets.symmetric(horizontal: 8),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );

  static const sm = MoonButtonSize(
    height: 32,
    gap: 4,
    padding: EdgeInsets.symmetric(horizontal: 12),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const md = MoonButtonSize(
    height: 40,
    gap: 8,
    padding: EdgeInsets.symmetric(horizontal: 16),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const lg = MoonButtonSize(
    height: 48,
    gap: 12,
    padding: EdgeInsets.symmetric(horizontal: 16),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const xl = MoonButtonSize(
    height: 56,
    gap: 16,
    padding: EdgeInsets.symmetric(horizontal: 24),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  /// Button height.
  final double height;

  /// Space between button children.
  final double gap;

  /// Padding around button children.
  final EdgeInsets padding;

  /// Button border radius.
  final BorderRadiusGeometry borderRadius;

  const MoonButtonSize({
    required this.height,
    required this.gap,
    required this.padding,
    required this.borderRadius,
  });

  @override
  MoonButtonSize copyWith({
    double? height,
    double? gap,
    EdgeInsets? padding,
    BorderRadiusGeometry? borderRadius,
  }) {
    return MoonButtonSize(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  MoonButtonSize lerp(ThemeExtension<MoonButtonSize>? other, double t) {
    if (other is! MoonButtonSize) return this;

    return MoonButtonSize(
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonSize"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius));
  }
}
