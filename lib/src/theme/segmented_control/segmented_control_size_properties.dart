import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonSegmentedControlSizeProperties extends ThemeExtension<MoonSegmentedControlSizeProperties>
    with DiagnosticableTreeMixin {
  /// SegmentedControl segment border radius.
  final BorderRadiusGeometry segmentBorderRadius;

  /// Gap between segment leading, label and trailing widgets.
  final double segmentGap;

  /// SegmentedControl height.
  final double height;

  /// SegmentedControl icon size value.
  final double iconSizeValue;

  /// SegmentedControl segment segmentPadding.
  final EdgeInsetsGeometry segmentPadding;

  /// SegmentedControl default text style.
  final TextStyle textStyle;

  const MoonSegmentedControlSizeProperties({
    required this.segmentBorderRadius,
    required this.segmentGap,
    required this.height,
    required this.iconSizeValue,
    required this.segmentPadding,
    required this.textStyle,
  });

  @override
  MoonSegmentedControlSizeProperties copyWith({
    BorderRadiusGeometry? segmentBorderRadius,
    double? segmentGap,
    double? height,
    double? iconSizeValue,
    EdgeInsetsGeometry? segmentPadding,
    TextStyle? textStyle,
  }) {
    return MoonSegmentedControlSizeProperties(
      segmentBorderRadius: segmentBorderRadius ?? this.segmentBorderRadius,
      segmentGap: segmentGap ?? this.segmentGap,
      height: height ?? this.height,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      segmentPadding: segmentPadding ?? this.segmentPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonSegmentedControlSizeProperties lerp(ThemeExtension<MoonSegmentedControlSizeProperties>? other, double t) {
    if (other is! MoonSegmentedControlSizeProperties) return this;

    return MoonSegmentedControlSizeProperties(
      segmentBorderRadius: BorderRadiusGeometry.lerp(segmentBorderRadius, other.segmentBorderRadius, t)!,
      segmentGap: lerpDouble(segmentGap, other.segmentGap, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      segmentPadding: EdgeInsetsGeometry.lerp(segmentPadding, other.segmentPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSegmentedControlSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("segmentBorderRadius", segmentBorderRadius))
      ..add(DoubleProperty("segmentGap", segmentGap))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("segmentPadding", segmentPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
