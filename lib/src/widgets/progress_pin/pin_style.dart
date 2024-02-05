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

  /// The height of the pin arrow.
  final double? arrowHeight;

  /// The width of the pin arrow.
  final double? arrowWidth;

  /// The width of the thumb.
  @Deprecated("Use thumbSizeValue instead")
  final double? thumbWidth;

  /// The size value of the thumb.
  final double? thumbSizeValue;

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
    this.arrowHeight,
    this.arrowWidth,
    @Deprecated("Use thumbSizeValue instead") this.thumbWidth,
    this.thumbSizeValue,
    this.pinWidth,
    this.pinBorderWidth,
    this.pinDistance,
    this.shadowElevation,
    this.textStyle,
  });

  PinStyle copyWith({
    bool? showShadow,
    Color? pinColor,
    Color? pinBorderColor,
    Color? thumbColor,
    Color? shadowColor,
    double? arrowHeight,
    double? arrowWidth,
    double? thumbWidth,
    double? thumbSizeValue,
    double? pinWidth,
    double? pinBorderWidth,
    double? pinDistance,
    double? shadowElevation,
    TextStyle? textStyle,
  }) {
    return PinStyle(
      showShadow: showShadow ?? this.showShadow,
      pinColor: pinColor ?? this.pinColor,
      pinBorderColor: pinBorderColor ?? this.pinBorderColor,
      thumbColor: thumbColor ?? this.thumbColor,
      shadowColor: shadowColor ?? this.shadowColor,
      arrowHeight: arrowHeight ?? this.arrowHeight,
      arrowWidth: arrowWidth ?? this.arrowWidth,
      thumbWidth: thumbWidth ?? this.thumbWidth,
      thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
      pinWidth: pinWidth ?? this.pinWidth,
      pinBorderWidth: pinBorderWidth ?? this.pinBorderWidth,
      pinDistance: pinDistance ?? this.pinDistance,
      shadowElevation: shadowElevation ?? this.shadowElevation,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
