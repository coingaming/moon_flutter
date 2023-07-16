import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonCircularProgressSizeProperties extends ThemeExtension<MoonCircularProgressSizeProperties>
    with DiagnosticableTreeMixin {
  /// Circular progress size value.
  final double progressSizeValue;

  /// Circular progress stroke width.
  final double progressStrokeWidth;

  const MoonCircularProgressSizeProperties({
    required this.progressSizeValue,
    required this.progressStrokeWidth,
  });

  @override
  MoonCircularProgressSizeProperties copyWith({
    double? progressSizeValue,
    double? progressStrokeWidth,
  }) {
    return MoonCircularProgressSizeProperties(
      progressSizeValue: progressSizeValue ?? this.progressSizeValue,
      progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
    );
  }

  @override
  MoonCircularProgressSizeProperties lerp(ThemeExtension<MoonCircularProgressSizeProperties>? other, double t) {
    if (other is! MoonCircularProgressSizeProperties) return this;

    return MoonCircularProgressSizeProperties(
      progressSizeValue: lerpDouble(progressSizeValue, other.progressSizeValue, t)!,
      progressStrokeWidth: lerpDouble(progressStrokeWidth, other.progressStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressSizeProperties"))
      ..add(DoubleProperty("progressSizeValue", progressSizeValue))
      ..add(DoubleProperty("progressStrokeWidth", progressStrokeWidth));
  }
}
