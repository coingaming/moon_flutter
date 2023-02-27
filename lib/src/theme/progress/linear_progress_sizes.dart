import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonLinearProgressSizes extends ThemeExtension<MoonLinearProgressSizes> with DiagnosticableTreeMixin {
  static final x6s = MoonLinearProgressSizes(
    borderRadiusValue: MoonSizes.sizes.x6s,
    progressHeight: MoonSizes.sizes.x6s,
  );

  static final x5s = MoonLinearProgressSizes(
    borderRadiusValue: MoonSizes.sizes.x5s,
    progressHeight: MoonSizes.sizes.x5s,
  );

  static final x4s = MoonLinearProgressSizes(
    borderRadiusValue: MoonSizes.sizes.x4s,
    progressHeight: MoonSizes.sizes.x4s,
  );

  static final x3s = MoonLinearProgressSizes(
    borderRadiusValue: MoonSizes.sizes.x3s,
    progressHeight: MoonSizes.sizes.x3s,
  );

  static final x2s = MoonLinearProgressSizes(
    borderRadiusValue: MoonSizes.sizes.x2s,
    progressHeight: MoonSizes.sizes.x2s,
  );

  /// Linear progress border radius value.
  final double borderRadiusValue;

  /// Linear progress height.
  final double progressHeight;

  const MoonLinearProgressSizes({
    required this.borderRadiusValue,
    required this.progressHeight,
  });

  @override
  MoonLinearProgressSizes copyWith({
    double? borderRadiusValue,
    double? progressHeight,
  }) {
    return MoonLinearProgressSizes(
      borderRadiusValue: borderRadiusValue ?? this.borderRadiusValue,
      progressHeight: progressHeight ?? this.progressHeight,
    );
  }

  @override
  MoonLinearProgressSizes lerp(ThemeExtension<MoonLinearProgressSizes>? other, double t) {
    if (other is! MoonLinearProgressSizes) return this;

    return MoonLinearProgressSizes(
      borderRadiusValue: lerpDouble(borderRadiusValue, other.borderRadiusValue, t)!,
      progressHeight: lerpDouble(progressHeight, other.progressHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressSizes"))
      ..add(DoubleProperty("borderRadiusValue", borderRadiusValue))
      ..add(DoubleProperty("progressHeight", progressHeight));
  }
}
