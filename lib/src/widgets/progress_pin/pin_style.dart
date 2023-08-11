import 'package:flutter/material.dart';

class PinStyle {
  /// Whether to show shadow around progress pin. Defaults to true.
  final bool? showShadow;

  /// The color of the pin.
  final Color? pinColor;

  /// The color of the pin border.
  final Color? pinBorderColor;

  /// The color of the thumb.
  final Color? thumbColor;

  /// The color of the pin shadow.
  final Color? shadowColor;

  /// The width of the thumb.
  final double? thumbWidth;

  /// The width of the pin.
  final double? pinWidth;

  /// The border width of the pin.
  final double? pinBorderWidth;

  /// The vertical distance between pin and linear progress.
  final double? pinDistance;

  /// The pin shadow elevation.
  final double? shadowElevation;

  /// The text style of the pin.
  final TextStyle? textStyle;

  const PinStyle({
    this.showShadow = true,
    this.pinColor,
    this.pinBorderColor,
    this.thumbColor,
    this.shadowColor,
    this.thumbWidth,
    this.pinWidth,
    this.pinBorderWidth,
    this.pinDistance,
    this.shadowElevation,
    this.textStyle,
  });
}
