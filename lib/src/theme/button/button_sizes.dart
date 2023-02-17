import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonButtonSizes extends ThemeExtension<MoonButtonSizes> with DiagnosticableTreeMixin {
  static final xs = MoonButtonSizes(
    height: MoonSizes.sizes.xs,
    gap: MoonSizes.sizes.x5s,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.heading.text12,
  );

  static final sm = MoonButtonSizes(
    height: MoonSizes.sizes.sm,
    gap: MoonSizes.sizes.x5s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final md = MoonButtonSizes(
    height: MoonSizes.sizes.md,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonButtonSizes(
    height: MoonSizes.sizes.lg,
    gap: MoonSizes.sizes.x3s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text16,
  );

  static final xl = MoonButtonSizes(
    height: MoonSizes.sizes.xl,
    gap: MoonSizes.sizes.x2s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.xs),
    borderRadius: MoonBorders.borders.interactiveMd,
    textStyle: MoonTextStyles.heading.text16,
  );

  /// Button height.
  final double height;

  /// Space between button children.
  final double gap;

  /// Button icon size value.
  final double iconSizeValue;

  /// Padding around button children.
  final EdgeInsets padding;

  /// Button border radius.
  final BorderRadius borderRadius;

  /// Button text style.
  final TextStyle textStyle;

  const MoonButtonSizes({
    required this.height,
    required this.gap,
    required this.iconSizeValue,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonButtonSizes copyWith({
    double? height,
    double? gap,
    double? iconSizeValue,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonButtonSizes(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonButtonSizes lerp(ThemeExtension<MoonButtonSizes>? other, double t) {
    if (other is! MoonButtonSizes) return this;

    return MoonButtonSizes(
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonSizes"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
