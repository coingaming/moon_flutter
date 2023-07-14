import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonTextInputSizeProperties extends ThemeExtension<MoonTextInputSizeProperties> with DiagnosticableTreeMixin {
  static final sm = MoonTextInputSizeProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    height: MoonSizes.sizes.sm,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(
      horizontal: MoonSizes.sizes.x4s,
      vertical: MoonSizes.sizes.x6s,
    ),
    textStyle: MoonTextStyles.body.textDefault,
  );

  static final md = MoonTextInputSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    height: MoonSizes.sizes.md,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(
      horizontal: MoonSizes.sizes.x3s,
      vertical: 6,
    ),
    textStyle: MoonTextStyles.body.textDefault,
  );

  static final lg = MoonTextInputSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    height: MoonSizes.sizes.lg,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(
      horizontal: MoonSizes.sizes.x3s,
      vertical: MoonSizes.sizes.x4s,
    ),
    textStyle: MoonTextStyles.body.text16,
  );

  static final xl = MoonTextInputSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    height: MoonSizes.sizes.xl,
    gap: MoonSizes.sizes.x2s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(
      horizontal: MoonSizes.sizes.x2s,
      vertical: MoonSizes.sizes.x3s,
    ),
    textStyle: MoonTextStyles.body.text16,
  );

  /// TextInput border radius.
  final BorderRadiusGeometry borderRadius;

  /// TextInput height.
  final double height;

  /// Space between TextInput children.
  final double gap;

  /// TextInput icon size value.
  final double iconSizeValue;

  /// Padding around TextInput children.
  final EdgeInsetsGeometry padding;

  /// TextInput text style.
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
