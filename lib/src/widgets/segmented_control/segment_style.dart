import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/segmented_control/segment.dart';

class SegmentStyle {
  /// The border radius of the segment.
  final BorderRadiusGeometry? segmentBorderRadius;

  /// The color of the segment focus effect.
  final Color? focusEffectColor;

  /// The color of the selected segment.
  final Color? selectedSegmentColor;

  /// The default text color of the segment.
  final Color? textColor;

  /// The text color of the selected segment.
  final Color? selectedTextColor;

  /// The custom decoration of the segment.
  final Decoration? decoration;

  /// The gap between the [Segment.leading], [Segment.label] and
  /// [Segment.trailing] widgets of the segment.
  final double? segmentGap;

  /// The padding of the segment.
  final EdgeInsetsGeometry? segmentPadding;

  /// The text style of the segment.
  ///
  /// If [TextStyle] color is used, then it overrides the [textColor] and
  /// [selectedTextColor].
  final TextStyle? textStyle;

  /// Defines a Moon Design segment style.
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
