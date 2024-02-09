import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTabBarColors extends ThemeExtension<MoonTabBarColors> with DiagnosticableTreeMixin {
  /// The color of the MoonTabBar tab indicator.
  final Color indicatorColor;

  /// The text color of the MoonTabBar.
  final Color textColor;

  /// The text color of the selected MoonTabBar tab.
  final Color selectedTextColor;

  /// The text color of the selected MoonTabBar pill tab.
  final Color selectedPillTextColor;

  /// The background color of the selected MoonTabBar pill tab.
  final Color selectedPillTabColor;

  const MoonTabBarColors({
    required this.indicatorColor,
    required this.textColor,
    required this.selectedTextColor,
    required this.selectedPillTextColor,
    required this.selectedPillTabColor,
  });

  @override
  MoonTabBarColors copyWith({
    Color? indicatorColor,
    Color? textColor,
    Color? selectedTextColor,
    Color? selectedPillTextColor,
    Color? selectedPillTabColor,
  }) {
    return MoonTabBarColors(
      indicatorColor: indicatorColor ?? this.indicatorColor,
      textColor: textColor ?? this.textColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      selectedPillTextColor: selectedPillTextColor ?? this.selectedPillTextColor,
      selectedPillTabColor: selectedPillTabColor ?? this.selectedPillTabColor,
    );
  }

  @override
  MoonTabBarColors lerp(ThemeExtension<MoonTabBarColors>? other, double t) {
    if (other is! MoonTabBarColors) return this;

    return MoonTabBarColors(
      indicatorColor: colorPremulLerp(indicatorColor, other.indicatorColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      selectedTextColor: colorPremulLerp(selectedTextColor, other.selectedTextColor, t)!,
      selectedPillTextColor: colorPremulLerp(selectedPillTextColor, other.selectedPillTextColor, t)!,
      selectedPillTabColor: colorPremulLerp(selectedPillTabColor, other.selectedPillTabColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTabBarColors"))
      ..add(ColorProperty("indicatorColor", indicatorColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("selectedTextColor", selectedTextColor))
      ..add(ColorProperty("selectedPillTextColor", selectedPillTextColor))
      ..add(ColorProperty("selectedPillTabColor", selectedPillTabColor));
  }
}
