import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonCarouselItemProperties extends ThemeExtension<MoonCarouselItemProperties> with DiagnosticableTreeMixin {
  static final properties = MoonCarouselItemProperties(
    itemBorderRadius: MoonBorders.borders.interactiveMd,
    gap: MoonSizes.sizes.x2s,
  );

  /// Carousel item border radius.
  final BorderRadiusGeometry itemBorderRadius;

  /// Gap between Carousel items.
  final double gap;

  const MoonCarouselItemProperties({
    required this.itemBorderRadius,
    required this.gap,
  });

  @override
  MoonCarouselItemProperties copyWith({
    BorderRadiusGeometry? itemBorderRadius,
    double? gap,
  }) {
    return MoonCarouselItemProperties(
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      gap: gap ?? this.gap,
    );
  }

  @override
  MoonCarouselItemProperties lerp(ThemeExtension<MoonCarouselItemProperties>? other, double t) {
    if (other is! MoonCarouselItemProperties) return this;

    return MoonCarouselItemProperties(
      itemBorderRadius: BorderRadiusGeometry.lerp(itemBorderRadius, other.itemBorderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCarouselItemProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("itemBorderRadius", itemBorderRadius))
      ..add(DoubleProperty("gap", gap));
  }
}
