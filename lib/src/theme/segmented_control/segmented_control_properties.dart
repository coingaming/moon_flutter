import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';

@immutable
class MoonSegmentedControlProperties extends ThemeExtension<MoonSegmentedControlProperties>
    with DiagnosticableTreeMixin {
  static final properties = MoonSegmentedControlProperties(
    borderRadius: MoonBorders.borders.interactiveMd,
    gap: MoonSizes.sizes.x5s,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    padding: const EdgeInsets.all(4),
  );

  /// SegmentedControl border radius.
  final BorderRadiusGeometry borderRadius;

  /// Gap between SegmentControl segments.
  final double gap;

  /// SegmentedControl transition duration.
  final Duration transitionDuration;

  /// SegmentedControl transition curve.
  final Curve transitionCurve;

  /// SegmentedControl padding.
  final EdgeInsetsGeometry padding;

  const MoonSegmentedControlProperties({
    required this.borderRadius,
    required this.gap,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.padding,
  });

  @override
  MoonSegmentedControlProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? padding,
  }) {
    return MoonSegmentedControlProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      padding: padding ?? this.padding,
    );
  }

  @override
  MoonSegmentedControlProperties lerp(ThemeExtension<MoonSegmentedControlProperties>? other, double t) {
    if (other is! MoonSegmentedControlProperties) return this;

    return MoonSegmentedControlProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSegmentedControlProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding));
  }
}
