import 'package:flutter/material.dart';

class PinStyle {
  /// Whether to show a shadow around the progress pin.
  final bool? showShadow;

  /// The color of the progress pin.
  final Color? pinColor;

  /// The border color of the progress pin.
  final Color? pinBorderColor;

  /// The color of the progress thumb.
  final Color? thumbColor;

  /// The shadow color of the progress pin.
  final Color? shadowColor;

  /// The height of the progress pin arrow.
  final double? arrowHeight;

  /// The width of the progress pin arrow.
  final double? arrowWidth;

  /// The width of the progress thumb.
  @Deprecated("Use thumbSizeValue instead")
  final double? thumbWidth;

  /// The size value of the progress thumb.
  final double? thumbSizeValue;

  /// The width of the progress pin.
  final double? pinWidth;

  /// The border width of the progress pin.
  final double? pinBorderWidth;

  /// The vertical distance between the progress pin and the linear progress widget.
  final double? pinDistance;

  /// The shadow elevation of the progress pin.
  final double? shadowElevation;

  /// The text style of the progress pin.
  final TextStyle? textStyle;

  /// Defines a Moon Design linear progress pin style.
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
      // ignore: deprecated_member_use_from_same_package
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
