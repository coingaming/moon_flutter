import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTabBarColors extends ThemeExtension<MoonTabBarColors> with DiagnosticableTreeMixin {
  static final light = MoonTabBarColors(
    indicatorColor: MoonColors.light.piccolo,
    textColor: MoonTypography.light.colors.bodyPrimary,
    selectedTextColor: MoonColors.light.piccolo,
    selectedPillTextColor: MoonTypography.light.colors.bodyPrimary,
    selectedPillTabColor: MoonColors.light.gohan,
  );

  static final dark = MoonTabBarColors(
    indicatorColor: MoonColors.dark.piccolo,
    textColor: MoonTypography.dark.colors.bodyPrimary,
    selectedTextColor: MoonColors.dark.piccolo,
    selectedPillTextColor: MoonTypography.dark.colors.bodyPrimary,
    selectedPillTabColor: MoonColors.dark.gohan,
  );

  /// TabBar tab indicator color.
  final Color indicatorColor;

  /// TabBar default text color.
  final Color textColor;

  /// TabBar selected tab text color.
  final Color selectedTextColor;

  /// TabBar selected pill tab text color.
  final Color selectedPillTextColor;

  /// TabBar selected pill tab color.
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
