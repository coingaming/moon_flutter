import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonLinearLoaderSizeProperties extends ThemeExtension<MoonLinearLoaderSizeProperties>
    with DiagnosticableTreeMixin {
  static final x6s = MoonLinearLoaderSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x6s,
    loaderHeight: MoonSizes.sizes.x6s,
  );

  static final x5s = MoonLinearLoaderSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x5s,
    loaderHeight: MoonSizes.sizes.x5s,
  );

  static final x4s = MoonLinearLoaderSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x4s,
    loaderHeight: MoonSizes.sizes.x4s,
  );

  static final x3s = MoonLinearLoaderSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x3s,
    loaderHeight: MoonSizes.sizes.x3s,
  );

  static final x2s = MoonLinearLoaderSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x2s,
    loaderHeight: MoonSizes.sizes.x2s,
  );

  /// Linear loader border radius value.
  final double borderRadiusValue;

  /// Linear loader height.
  final double loaderHeight;

  const MoonLinearLoaderSizeProperties({
    required this.borderRadiusValue,
    required this.loaderHeight,
  });

  @override
  MoonLinearLoaderSizeProperties copyWith({
    double? borderRadiusValue,
    double? loaderHeight,
  }) {
    return MoonLinearLoaderSizeProperties(
      borderRadiusValue: borderRadiusValue ?? this.borderRadiusValue,
      loaderHeight: loaderHeight ?? this.loaderHeight,
    );
  }

  @override
  MoonLinearLoaderSizeProperties lerp(ThemeExtension<MoonLinearLoaderSizeProperties>? other, double t) {
    if (other is! MoonLinearLoaderSizeProperties) return this;

    return MoonLinearLoaderSizeProperties(
      borderRadiusValue: lerpDouble(borderRadiusValue, other.borderRadiusValue, t)!,
      loaderHeight: lerpDouble(loaderHeight, other.loaderHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderSizeProperties"))
      ..add(DoubleProperty("borderRadiusValue", borderRadiusValue))
      ..add(DoubleProperty("loaderHeight", loaderHeight));
  }
}
