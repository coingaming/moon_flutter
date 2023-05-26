import 'package:flutter/material.dart';

class SegmentStyle {
  /// The border radius of segment.
  final BorderRadiusGeometry? segmentBorderRadius;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the selected segment.
  final Color? selectedSegmentColor;

  /// The default text color of segments.
  final Color? textColor;

  /// The text color of selected segment.
  final Color? selectedTextColor;

  /// Custom decoration for the segment.
  final Decoration? decoration;

  /// The gap between the leading, label and trailing widgets of segment.
  final double? segmentGap;

  /// The padding of the segment.
  final EdgeInsetsGeometry? segmentPadding;

  /// The text style of the segment.
  ///
  /// If [TextStyle] color is used, then it overrides the [textColor] and [selectedTextColor].
  final TextStyle? textStyle;

  const SegmentStyle({
    this.segmentBorderRadius,
    this.focusEffectColor,
    this.selectedSegmentColor,
    this.textColor,
    this.selectedTextColor,
    this.decoration,
    this.segmentGap,
    this.segmentPadding,
    this.textStyle,
  });
}
