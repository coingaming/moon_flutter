import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/sizes.dart';

@immutable
class MoonCircularLoaderSizeProperties extends ThemeExtension<MoonCircularLoaderSizeProperties>
    with DiagnosticableTreeMixin {
  static final x2s = MoonCircularLoaderSizeProperties(
    loaderSizeValue: MoonSizes.sizes.x2s,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final xs = MoonCircularLoaderSizeProperties(
    loaderSizeValue: MoonSizes.sizes.xs,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final sm = MoonCircularLoaderSizeProperties(
    loaderSizeValue: MoonSizes.sizes.sm,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final md = MoonCircularLoaderSizeProperties(
    loaderSizeValue: MoonSizes.sizes.md,
    loaderStrokeWidth: MoonSizes.sizes.x5s,
  );

  static final lg = MoonCircularLoaderSizeProperties(
    loaderSizeValue: MoonSizes.sizes.lg,
    loaderStrokeWidth: MoonSizes.sizes.x5s,
  );

  /// Circular loader size value.
  final double loaderSizeValue;

  /// Circular loader stroke width.
  final double loaderStrokeWidth;

  const MoonCircularLoaderSizeProperties({
    required this.loaderSizeValue,
    required this.loaderStrokeWidth,
  });

  @override
  MoonCircularLoaderSizeProperties copyWith({
    double? loaderSizeValue,
    double? loaderStrokeWidth,
  }) {
    return MoonCircularLoaderSizeProperties(
      loaderSizeValue: loaderSizeValue ?? this.loaderSizeValue,
      loaderStrokeWidth: loaderStrokeWidth ?? this.loaderStrokeWidth,
    );
  }

  @override
  MoonCircularLoaderSizeProperties lerp(ThemeExtension<MoonCircularLoaderSizeProperties>? other, double t) {
    if (other is! MoonCircularLoaderSizeProperties) return this;

    return MoonCircularLoaderSizeProperties(
      loaderSizeValue: lerpDouble(loaderSizeValue, other.loaderSizeValue, t)!,
      loaderStrokeWidth: lerpDouble(loaderStrokeWidth, other.loaderStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderSizeProperties"))
      ..add(DoubleProperty("loaderSizeValue", loaderSizeValue))
      ..add(DoubleProperty("loaderStrokeWidth", loaderStrokeWidth));
  }
}
