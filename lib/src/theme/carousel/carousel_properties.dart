import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';

@immutable
class MoonCarouselProperties extends ThemeExtension<MoonCarouselProperties> with DiagnosticableTreeMixin {
  static final properties = MoonCarouselProperties(
    itemBorderRadius: MoonBorders.borders.interactiveMd,
    gap: MoonSizes.sizes.x5s,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Carousel item border radius.
  final BorderRadiusGeometry itemBorderRadius;

  /// Gap between Carousel items.
  final double gap;

  /// Carousel transition duration.
  final Duration transitionDuration;

  /// Carousel transition curve.
  final Curve transitionCurve;

  const MoonCarouselProperties({
    required this.itemBorderRadius,
    required this.gap,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonCarouselProperties copyWith({
    BorderRadiusGeometry? itemBorderRadius,
    double? gap,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonCarouselProperties(
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      gap: gap ?? this.gap,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonCarouselProperties lerp(ThemeExtension<MoonCarouselProperties>? other, double t) {
    if (other is! MoonCarouselProperties) return this;

    return MoonCarouselProperties(
      itemBorderRadius: BorderRadiusGeometry.lerp(itemBorderRadius, other.itemBorderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCarouselProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("itemBorderRadius", itemBorderRadius))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
