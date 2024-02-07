import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/tab_bar/tab.dart';

class MoonTabStyle {
  /// The color of the tab focus effect.
  final Color? focusEffectColor;

  /// The color of the tab indicator.
  final Color? indicatorColor;

  /// The default text color of the tab.
  final Color? textColor;

  /// The text color of the selected tab.
  final Color? selectedTextColor;

  /// The custom decoration of the tab.
  final Decoration? decoration;

  /// The height of the tab indicator.
  final double? indicatorHeight;

  /// The gap between the [MoonTab.leading], [MoonTab.label] and [MoonTab.trailing] widgets of the tab.
  final double? tabGap;

  /// The padding of the tab.
  final EdgeInsetsGeometry? tabPadding;

  /// The text style of the tab.
  ///
  /// If [TextStyle] color is used, then it overrides the [textColor] and [selectedTextColor].
  final TextStyle? textStyle;

  /// Defines a Moon Design tab style.
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
