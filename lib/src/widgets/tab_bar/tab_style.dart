import 'package:flutter/material.dart';

class MoonTabStyle {
  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of tab indicator.
  final Color? indicatorColor;

  /// The default text color of the tab.
  final Color? textColor;

  /// The text color of selected tab.
  final Color? selectedTextColor;

  /// Custom decoration for the tab.
  final Decoration? decoration;

  /// The height of the tab indicator.
  final double? indicatorHeight;

  /// The gap between the leading, label and trailing widgets of tab.
  final double? tabGap;

  /// The padding of the tab.
  final EdgeInsetsGeometry? tabPadding;

  /// The text style of the tab.
  ///
  /// If [TextStyle] color is used, then it overrides the [textColor] and [selectedTextColor].
  final TextStyle? textStyle;

  const MoonTabStyle({
    this.focusEffectColor,
    this.indicatorColor,
    this.textColor,
    this.selectedTextColor,
    this.decoration,
    this.indicatorHeight,
    this.tabGap,
    this.tabPadding,
    this.textStyle,
  });
}
