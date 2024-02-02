import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonProgressPinProperties extends ThemeExtension<MoonProgressPinProperties> with DiagnosticableTreeMixin {
  /// Progress pin shadow elevation.
  final double shadowElevation;

  /// Progress pin arrow height.
  final double arrowHeight;

  /// Progress pin arrow width.
  final double arrowWidth;

  /// Vertical space between pin and linear progress.
  final double pinDistance;

  /// Progress pin width.
  final double pinWidth;

  /// Progress pin border width.
  final double pinBorderWidth;

  /// Progress pin text style.
  final TextStyle textStyle;

  const MoonProgressPinProperties({
    required this.shadowElevation,
    required this.arrowHeight,
    required this.arrowWidth,
    required this.pinDistance,
    required this.pinWidth,
    required this.pinBorderWidth,
    required this.textStyle,
  });

  @override
  MoonProgressPinProperties copyWith({
    double? shadowElevation,
    double? arrowHeight,
    double? arrowWidth,
    double? pinDistance,
    double? pinWidth,
    double? pinBorderWidth,
    TextStyle? textStyle,
  }) {
    return MoonProgressPinProperties(
      shadowElevation: shadowElevation ?? this.shadowElevation,
      arrowHeight: arrowHeight ?? this.arrowHeight,
      arrowWidth: arrowWidth ?? this.arrowWidth,
      pinDistance: pinDistance ?? this.pinDistance,
      pinWidth: pinWidth ?? this.pinWidth,
      pinBorderWidth: pinBorderWidth ?? this.pinBorderWidth,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonProgressPinProperties lerp(ThemeExtension<MoonProgressPinProperties>? other, double t) {
    if (other is! MoonProgressPinProperties) return this;

    return MoonProgressPinProperties(
      shadowElevation: lerpDouble(shadowElevation, other.shadowElevation, t)!,
      arrowHeight: lerpDouble(arrowHeight, other.arrowHeight, t)!,
      arrowWidth: lerpDouble(arrowWidth, other.arrowWidth, t)!,
      pinDistance: lerpDouble(pinDistance, other.pinDistance, t)!,
      pinWidth: lerpDouble(pinWidth, other.pinWidth, t)!,
      pinBorderWidth: lerpDouble(pinBorderWidth, other.pinBorderWidth, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonProgressPinProperties"))
      ..add(DoubleProperty("shadowElevation", shadowElevation))
      ..add(DoubleProperty("arrowHeight", arrowHeight))
      ..add(DoubleProperty("arrowWidth", arrowWidth))
      ..add(DoubleProperty("pinDistance", pinDistance))
      ..add(DoubleProperty("pinWidth", pinWidth))
      ..add(DoubleProperty("pinBorderWidth", pinBorderWidth))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
