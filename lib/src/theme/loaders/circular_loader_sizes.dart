import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonCircularLoaderSizes extends ThemeExtension<MoonCircularLoaderSizes> with DiagnosticableTreeMixin {
  static final x2s = MoonCircularLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.x2s,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final xs = MoonCircularLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.xs,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final sm = MoonCircularLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.sm,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final md = MoonCircularLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.md,
    loaderStrokeWidth: MoonSizes.sizes.x5s,
  );

  static final lg = MoonCircularLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.lg,
    loaderStrokeWidth: MoonSizes.sizes.x5s,
  );

  /// Circular loader size value.
  final double loaderSizeValue;

  /// Circular loader stroke width.
  final double loaderStrokeWidth;

  const MoonCircularLoaderSizes({
    required this.loaderSizeValue,
    required this.loaderStrokeWidth,
  });

  @override
  MoonCircularLoaderSizes copyWith({
    double? loaderSizeValue,
    double? loaderStrokeWidth,
  }) {
    return MoonCircularLoaderSizes(
      loaderSizeValue: loaderSizeValue ?? this.loaderSizeValue,
      loaderStrokeWidth: loaderStrokeWidth ?? this.loaderStrokeWidth,
    );
  }

  @override
  MoonCircularLoaderSizes lerp(ThemeExtension<MoonCircularLoaderSizes>? other, double t) {
    if (other is! MoonCircularLoaderSizes) return this;

    return MoonCircularLoaderSizes(
      loaderSizeValue: lerpDouble(loaderSizeValue, other.loaderSizeValue, t)!,
      loaderStrokeWidth: lerpDouble(loaderStrokeWidth, other.loaderStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderSizes"))
      ..add(DoubleProperty("loaderSizeValue", loaderSizeValue))
      ..add(DoubleProperty("loaderStrokeWidth", loaderStrokeWidth));
  }
}
