import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTextInputSizeProperties extends ThemeExtension<MoonTextInputSizeProperties> with DiagnosticableTreeMixin {
  /// The border radius of the MoonTextInput.
  final BorderRadiusGeometry borderRadius;

  /// The height of the MoonTextInput.
  final double height;

  /// The gap between the leading, label and trailing widgets of the MoonTextInput.
  final double gap;

  /// The size value of the MoonTextInput icon.
  final double iconSizeValue;

  /// The padding of the MoonTextInput.
  final EdgeInsetsGeometry padding;

  /// The text style of the MoonTextInput.
  final TextStyle textStyle;

  const MoonTextInputSizeProperties({
    required this.borderRadius,
    required this.height,
    required this.gap,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
  });

  @override
  MoonTextInputSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? height,
    double? gap,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return MoonTextInputSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
      gap: gap ?? this.gap,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonTextInputSizeProperties lerp(ThemeExtension<MoonTextInputSizeProperties>? other, double t) {
    if (other is! MoonTextInputSizeProperties) return this;

    return MoonTextInputSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
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
      ..add(DiagnosticsProperty("type", "MoonTextInputSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
