import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonProgressPinProperties extends ThemeExtension<MoonProgressPinProperties> with DiagnosticableTreeMixin {
  /// Progress pin shadow elevation.
  final double shadowElevation;

  /// Vertical space between pin and linear progress.
  final double pinDistance;

  /// Progress pin width.
  final double pinWidth;

  /// Progress pin border width.
  final double pinBorderWidth;

  /// Thumb width multiplier for linear progress.
  final double thumbWidthMultiplier;

  /// Progress pin text style.
  final TextStyle textStyle;

  const MoonProgressPinProperties({
    required this.shadowElevation,
    required this.pinDistance,
    required this.pinWidth,
    required this.pinBorderWidth,
    required this.thumbWidthMultiplier,
    required this.textStyle,
  });

  @override
  MoonProgressPinProperties copyWith({
    double? shadowElevation,
    double? pinDistance,
    double? pinWidth,
    double? pinBorderWidth,
    double? thumbWidthMultiplier,
    TextStyle? textStyle,
  }) {
    return MoonProgressPinProperties(
      shadowElevation: shadowElevation ?? this.shadowElevation,
      pinDistance: pinDistance ?? this.pinDistance,
      pinWidth: pinWidth ?? this.pinWidth,
      pinBorderWidth: pinBorderWidth ?? this.pinBorderWidth,
      thumbWidthMultiplier: thumbWidthMultiplier ?? this.thumbWidthMultiplier,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonProgressPinProperties lerp(ThemeExtension<MoonProgressPinProperties>? other, double t) {
    if (other is! MoonProgressPinProperties) return this;

    return MoonProgressPinProperties(
      shadowElevation: lerpDouble(shadowElevation, other.shadowElevation, t)!,
      pinDistance: lerpDouble(pinDistance, other.pinDistance, t)!,
      pinWidth: lerpDouble(pinWidth, other.pinWidth, t)!,
      pinBorderWidth: lerpDouble(pinBorderWidth, other.pinBorderWidth, t)!,
      thumbWidthMultiplier: lerpDouble(thumbWidthMultiplier, other.thumbWidthMultiplier, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonProgressPinProperties"))
      ..add(DoubleProperty("shadowElevation", shadowElevation))
      ..add(DoubleProperty("pinDistance", pinDistance))
      ..add(DoubleProperty("pinWidth", pinWidth))
      ..add(DoubleProperty("pinBorderWidth", pinBorderWidth))
      ..add(DoubleProperty("thumbWidthMultiplier", thumbWidthMultiplier))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
