import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonLoaderSizes extends ThemeExtension<MoonLoaderSizes> with DiagnosticableTreeMixin {
  static final x2s = MoonLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.x2s,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final xs = MoonLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.xs,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final sm = MoonLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.sm,
    loaderStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final md = MoonLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.md,
    loaderStrokeWidth: MoonSizes.sizes.x5s,
  );

  static final lg = MoonLoaderSizes(
    loaderSizeValue: MoonSizes.sizes.lg,
    loaderStrokeWidth: MoonSizes.sizes.x5s,
  );

  /// Loader size value.
  final double loaderSizeValue;

  /// Loader stroke width.
  final double loaderStrokeWidth;

  const MoonLoaderSizes({
    required this.loaderSizeValue,
    required this.loaderStrokeWidth,
  });

  @override
  MoonLoaderSizes copyWith({
    double? loaderSizeValue,
    double? loaderStrokeWidth,
  }) {
    return MoonLoaderSizes(
      loaderSizeValue: loaderSizeValue ?? this.loaderSizeValue,
      loaderStrokeWidth: loaderStrokeWidth ?? this.loaderStrokeWidth,
    );
  }

  @override
  MoonLoaderSizes lerp(ThemeExtension<MoonLoaderSizes>? other, double t) {
    if (other is! MoonLoaderSizes) return this;

    return MoonLoaderSizes(
      loaderSizeValue: lerpDouble(loaderSizeValue, other.loaderSizeValue, t)!,
      loaderStrokeWidth: lerpDouble(loaderStrokeWidth, other.loaderStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLoaderSizes"))
      ..add(DoubleProperty("loaderSizeValue", loaderSizeValue))
      ..add(DoubleProperty("loaderStrokeWidth", loaderStrokeWidth));
  }
}
