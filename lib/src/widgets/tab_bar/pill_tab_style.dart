import 'package:flutter/material.dart';

class MoonPillTabStyle {
  /// The border radius of tab.
  final BorderRadiusGeometry? borderRadius;

  /// The color of the tab focus effect.
  final Color? focusEffectColor;

  /// The color of the selected tab.
  final Color? selectedTabColor;

  /// The default text color of the tab.
  final Color? textColor;

  /// The text color of selected tab.
  final Color? selectedTextColor;

  /// Custom decoration of the tab.
  final Decoration? decoration;

  /// The gap between the leading, label and trailing widgets of tab.
  final double? tabGap;

  /// The padding of the tab.
  final EdgeInsetsGeometry? tabPadding;

  /// The text style of the tab.
  ///
  /// If [TextStyle] color is used, then it overrides the [textColor] and [selectedTextColor].
  final TextStyle? textStyle;

  const MoonPillTabStyle({
    this.borderRadius,
    this.focusEffectColor,
    this.selectedTabColor,
    this.textColor,
    this.selectedTextColor,
    this.decoration,
    this.tabGap,
    this.tabPadding,
    this.textStyle,
  });
}
