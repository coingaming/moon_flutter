import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTabBarSizeProperties extends ThemeExtension<MoonTabBarSizeProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonTabBar pill tab.
  final BorderRadiusGeometry borderRadius;

  /// The height of the MoonTabBar.
  final double height;

  /// The size value of the MoonTabBar icon.
  final double iconSizeValue;

  /// The height of the MoonTabBar tab indicator.
  final double indicatorHeight;

  /// The horizontal gap between the leading, label and trailing widgets of the
  /// MoonTabBar tab.
  final double tabGap;

  /// The padding of the MoonTabBar tab.
  final EdgeInsetsGeometry tabPadding;

  /// The text style of the MoonTabBar.
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
  MoonTabBarSizeProperties lerp(
    ThemeExtension<MoonTabBarSizeProperties>? other,
    double t,
  ) {
    if (other is! MoonTabBarSizeProperties) return this;

    return MoonTabBarSizeProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
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
      ..add(
        DiagnosticsProperty("type", "MoonTabBarSizeProperties"),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      )
      ..add(
        DoubleProperty("height", height),
      )
      ..add(
        DoubleProperty("iconSizeValue", iconSizeValue),
      )
      ..add(
        DoubleProperty("indicatorHeight", indicatorHeight),
      )
      ..add(
        DoubleProperty("tabGap", tabGap),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>("tabPadding", tabPadding),
      )
      ..add(
        DiagnosticsProperty<TextStyle>("textStyle", textStyle),
      );
  }
}
