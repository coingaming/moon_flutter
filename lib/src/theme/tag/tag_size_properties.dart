import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTagSizeProperties extends ThemeExtension<MoonTagSizeProperties> with DiagnosticableTreeMixin {
  static final x2s = MoonTagSizeProperties(
    height: MoonSizes.sizes.x2s,
    gap: MoonSizes.sizes.x5s,
    iconSizeValue: MoonSizes.sizes.x3s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.body.text10.copyWith(fontWeight: FontWeight.w400),
    upperCaseTextStyle: MoonTextStyles.caption.text9,
  );

  static final xs = MoonTagSizeProperties(
    height: MoonSizes.sizes.xs,
    gap: MoonSizes.sizes.x5s,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.body.text12.copyWith(fontWeight: FontWeight.w400),
    upperCaseTextStyle: MoonTextStyles.caption.text10,
  );

  /// Tag height.
  final double height;

  /// Space between tag children.
  final double gap;

  /// Tag icon size value.
  final double iconSizeValue;

  /// Padding around tag children.
  final EdgeInsetsGeometry padding;

  /// Tag border radius.
  final BorderRadius borderRadius;

  /// Tag body style.
  final TextStyle textStyle;

  /// Tag upper case body style.
  final TextStyle upperCaseTextStyle;

  const MoonTagSizeProperties({
    required this.height,
    required this.gap,
    required this.iconSizeValue,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
    required this.upperCaseTextStyle,
  });

  @override
  MoonTagSizeProperties copyWith({
    double? height,
    double? gap,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    TextStyle? upperCaseTextStyle,
  }) {
    return MoonTagSizeProperties(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
      upperCaseTextStyle: upperCaseTextStyle ?? this.upperCaseTextStyle,
    );
  }

  @override
  MoonTagSizeProperties lerp(ThemeExtension<MoonTagSizeProperties>? other, double t) {
    if (other is! MoonTagSizeProperties) return this;

    return MoonTagSizeProperties(
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      upperCaseTextStyle: TextStyle.lerp(upperCaseTextStyle, other.upperCaseTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagSizeProperties"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("upperCaseTextStyle", upperCaseTextStyle));
  }
}
