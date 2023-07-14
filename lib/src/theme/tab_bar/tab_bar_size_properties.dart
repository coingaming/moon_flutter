import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonTabBarSizeProperties extends ThemeExtension<MoonTabBarSizeProperties> with DiagnosticableTreeMixin {
  static final sm = MoonTabBarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    tabGap: MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.sm,
    iconSizeValue: MoonSizes.sizes.xs,
    indicatorHeight: MoonSizes.sizes.x6s,
    tabPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.textDefault,
  );

  static final md = MoonTabBarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    tabGap: MoonSizes.sizes.x4s,
    height: MoonSizes.sizes.md,
    iconSizeValue: MoonSizes.sizes.xs,
    indicatorHeight: MoonSizes.sizes.x6s,
    tabPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    textStyle: MoonTextStyles.heading.textDefault,
  );

  /// TabBar pill tab border radius.
  final BorderRadiusGeometry borderRadius;

  /// TabBar height.
  final double height;

  /// TabBar tab icon size value.
  final double iconSizeValue;

  /// TabBar tab indicator height.
  final double indicatorHeight;

  /// Gap between leading, label and trailing widgets of tab.
  final double tabGap;

  /// TabBar tab padding.
  final EdgeInsetsGeometry tabPadding;

  /// TabBar default text style.
  final TextStyle textStyle;

  const MoonTabBarSizeProperties({
    required this.borderRadius,
    required this.height,
    required this.iconSizeValue,
    required this.indicatorHeight,
    required this.tabGap,
    required this.tabPadding,
    required this.textStyle,
  });

  @override
  MoonTabBarSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? height,
    double? iconSizeValue,
    double? indicatorHeight,
    double? tabGap,
    EdgeInsetsGeometry? tabPadding,
    TextStyle? textStyle,
  }) {
    return MoonTabBarSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      indicatorHeight: indicatorHeight ?? this.indicatorHeight,
      tabGap: tabGap ?? this.tabGap,
      tabPadding: tabPadding ?? this.tabPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonTabBarSizeProperties lerp(ThemeExtension<MoonTabBarSizeProperties>? other, double t) {
    if (other is! MoonTabBarSizeProperties) return this;

    return MoonTabBarSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      indicatorHeight: lerpDouble(indicatorHeight, other.indicatorHeight, t)!,
      tabGap: lerpDouble(tabGap, other.tabGap, t)!,
      tabPadding: EdgeInsetsGeometry.lerp(tabPadding, other.tabPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTabBarSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DoubleProperty("indicatorHeight", indicatorHeight))
      ..add(DoubleProperty("tabGap", tabGap))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("tabPadding", tabPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
