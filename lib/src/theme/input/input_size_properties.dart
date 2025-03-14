import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonInputSizeProperties extends ThemeExtension<MoonInputSizeProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonInput.
  final BorderRadiusGeometry borderRadius;

  /// The height of the MoonInput.
  final double height;

  /// The gap between the leading, label and trailing widgets of the MoonInput.
  final double gap;

  /// The size value of the MoonInput icon.
  final double iconSizeValue;

  /// The padding of the MoonInput.
  final EdgeInsetsGeometry padding;

  /// The text style of the MoonInput.
  final TextStyle textStyle;

  const MoonInputSizeProperties({
    required this.borderRadius,
    required this.height,
    required this.gap,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
  });

  @override
  MoonInputSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? height,
    double? gap,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return MoonInputSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
      gap: gap ?? this.gap,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonInputSizeProperties lerp(
    ThemeExtension<MoonInputSizeProperties>? other,
    double t,
  ) {
    if (other is! MoonInputSizeProperties) return this;

    return MoonInputSizeProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonInputSizeProperties"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      );
  }
}
