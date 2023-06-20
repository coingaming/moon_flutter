import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonButtonSizeProperties extends ThemeExtension<MoonButtonSizeProperties> with DiagnosticableTreeMixin {
  static final xs = MoonButtonSizeProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    gap: MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.xs,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    textStyle: MoonTextStyles.heading.text12,
  );

  static final sm = MoonButtonSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    gap: MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.sm,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.textDefault,
  );

  static final md = MoonButtonSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    gap: MoonSizes.sizes.x4s,
    height: MoonSizes.sizes.md,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    textStyle: MoonTextStyles.heading.textDefault,
  );

  static final lg = MoonButtonSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    gap: MoonSizes.sizes.x3s,
    height: MoonSizes.sizes.lg,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    textStyle: MoonTextStyles.heading.text16,
  );

  static final xl = MoonButtonSizeProperties(
    borderRadius: MoonBorders.borders.interactiveMd,
    gap: MoonSizes.sizes.x2s,
    height: MoonSizes.sizes.xl,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.xs),
    textStyle: MoonTextStyles.heading.text16,
  );

  /// Button border radius.
  final BorderRadiusGeometry borderRadius;

  /// Space between button children.
  final double gap;

  /// Button height.
  final double height;

  /// Button icon size value.
  final double iconSizeValue;

  /// Padding around button children.
  final EdgeInsetsGeometry padding;

  /// Button text style.
  final TextStyle textStyle;

  const MoonButtonSizeProperties({
    required this.borderRadius,
    required this.gap,
    required this.height,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
  });

  @override
  MoonButtonSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    double? height,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return MoonButtonSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      height: height ?? this.height,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonButtonSizeProperties lerp(ThemeExtension<MoonButtonSizeProperties>? other, double t) {
    if (other is! MoonButtonSizeProperties) return this;

    return MoonButtonSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
