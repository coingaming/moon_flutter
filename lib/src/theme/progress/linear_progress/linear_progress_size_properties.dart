import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonLinearProgressSizeProperties extends ThemeExtension<MoonLinearProgressSizeProperties>
    with DiagnosticableTreeMixin {
  /// Linear progress border radius.
  final BorderRadiusGeometry borderRadius;

  /// Linear progress height.
  final double progressHeight;

  /// Linear progress thumb size value.
  final double thumbSizeValue;

  const MoonLinearProgressSizeProperties({
    required this.borderRadius,
    required this.progressHeight,
    required this.thumbSizeValue,
  });

  @override
  MoonLinearProgressSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? progressHeight,
    double? thumbSizeValue,
  }) {
    return MoonLinearProgressSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      progressHeight: progressHeight ?? this.progressHeight,
      thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
    );
  }

  @override
  MoonLinearProgressSizeProperties lerp(ThemeExtension<MoonLinearProgressSizeProperties>? other, double t) {
    if (other is! MoonLinearProgressSizeProperties) return this;

    return MoonLinearProgressSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      progressHeight: lerpDouble(progressHeight, other.progressHeight, t)!,
      thumbSizeValue: lerpDouble(thumbSizeValue, other.thumbSizeValue, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("progressHeight", progressHeight))
      ..add(DoubleProperty("thumbSizeValue", thumbSizeValue));
  }
}
