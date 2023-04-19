import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonInputSizeProperties extends ThemeExtension<MoonInputSizeProperties> with DiagnosticableTreeMixin {
  static final sm = MoonInputSizeProperties(
    height: MoonSizes.sizes.sm,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final md = MoonInputSizeProperties(
    height: MoonSizes.sizes.md,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonInputSizeProperties(
    height: MoonSizes.sizes.lg,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text16,
  );

  static final xl = MoonInputSizeProperties(
    height: MoonSizes.sizes.xl,
    gap: MoonSizes.sizes.x2s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text16,
  );

  /// Input height.
  final double height;

  /// Space between input children.
  final double gap;

  /// Input icon size value.
  final double iconSizeValue;

  /// Padding around input children.
  final EdgeInsetsGeometry padding;

  /// Input border radius.
  final BorderRadius borderRadius;

  /// Input text style.
  final TextStyle textStyle;

  const MoonInputSizeProperties({
    required this.height,
    required this.gap,
    required this.iconSizeValue,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonInputSizeProperties copyWith({
    double? height,
    double? gap,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonInputSizeProperties(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonInputSizeProperties lerp(ThemeExtension<MoonInputSizeProperties>? other, double t) {
    if (other is! MoonInputSizeProperties) return this;

    return MoonInputSizeProperties(
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
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
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
