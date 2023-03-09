import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonLinearProgressSizeProperties extends ThemeExtension<MoonLinearProgressSizeProperties>
    with DiagnosticableTreeMixin {
  static final x6s = MoonLinearProgressSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x6s,
    progressHeight: MoonSizes.sizes.x6s,
  );

  static final x5s = MoonLinearProgressSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x5s,
    progressHeight: MoonSizes.sizes.x5s,
  );

  static final x4s = MoonLinearProgressSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x4s,
    progressHeight: MoonSizes.sizes.x4s,
  );

  static final x3s = MoonLinearProgressSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x3s,
    progressHeight: MoonSizes.sizes.x3s,
  );

  static final x2s = MoonLinearProgressSizeProperties(
    borderRadiusValue: MoonSizes.sizes.x2s,
    progressHeight: MoonSizes.sizes.x2s,
  );

  /// Linear progress border radius value.
  final double borderRadiusValue;

  /// Linear progress height.
  final double progressHeight;

  const MoonLinearProgressSizeProperties({
    required this.borderRadiusValue,
    required this.progressHeight,
  });

  @override
  MoonLinearProgressSizeProperties copyWith({
    double? borderRadiusValue,
    double? progressHeight,
  }) {
    return MoonLinearProgressSizeProperties(
      borderRadiusValue: borderRadiusValue ?? this.borderRadiusValue,
      progressHeight: progressHeight ?? this.progressHeight,
    );
  }

  @override
  MoonLinearProgressSizeProperties lerp(ThemeExtension<MoonLinearProgressSizeProperties>? other, double t) {
    if (other is! MoonLinearProgressSizeProperties) return this;

    return MoonLinearProgressSizeProperties(
      borderRadiusValue: lerpDouble(borderRadiusValue, other.borderRadiusValue, t)!,
      progressHeight: lerpDouble(progressHeight, other.progressHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressSizeProperties"))
      ..add(DoubleProperty("borderRadiusValue", borderRadiusValue))
      ..add(DoubleProperty("progressHeight", progressHeight));
  }
}
