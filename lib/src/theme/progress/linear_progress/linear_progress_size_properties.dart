import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonLinearProgressSizeProperties extends ThemeExtension<MoonLinearProgressSizeProperties>
    with DiagnosticableTreeMixin {
  static final x6s = MoonLinearProgressSizeProperties(
    borderRadius: MoonBorders.borders.surfaceXs,
    progressHeight: MoonSizes.sizes.x6s,
  );

  static final x5s = MoonLinearProgressSizeProperties(
    borderRadius: MoonBorders.borders.surfaceXs,
    progressHeight: MoonSizes.sizes.x5s,
  );

  static final x4s = MoonLinearProgressSizeProperties(
    borderRadius: MoonBorders.borders.surfaceSm,
    progressHeight: MoonSizes.sizes.x4s,
  );

  static final x3s = MoonLinearProgressSizeProperties(
    borderRadius: MoonBorders.borders.surfaceMd,
    progressHeight: MoonSizes.sizes.x3s,
  );

  static final x2s = MoonLinearProgressSizeProperties(
    borderRadius: MoonBorders.borders.surfaceLg,
    progressHeight: MoonSizes.sizes.x2s,
  );

  /// Linear progress border radius.
  final BorderRadius borderRadius;

  /// Linear progress height.
  final double progressHeight;

  const MoonLinearProgressSizeProperties({
    required this.borderRadius,
    required this.progressHeight,
  });

  @override
  MoonLinearProgressSizeProperties copyWith({
    BorderRadius? borderRadius,
    double? progressHeight,
  }) {
    return MoonLinearProgressSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      progressHeight: progressHeight ?? this.progressHeight,
    );
  }

  @override
  MoonLinearProgressSizeProperties lerp(ThemeExtension<MoonLinearProgressSizeProperties>? other, double t) {
    if (other is! MoonLinearProgressSizeProperties) return this;

    return MoonLinearProgressSizeProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      progressHeight: lerpDouble(progressHeight, other.progressHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DoubleProperty("progressHeight", progressHeight));
  }
}
