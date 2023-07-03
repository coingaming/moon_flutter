import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonDotIndicatorColors extends ThemeExtension<MoonDotIndicatorColors> with DiagnosticableTreeMixin {
  static final light = MoonDotIndicatorColors(
    selectedColor: MoonColors.light.piccolo,
    unselectedColor: MoonColors.light.beerus,
  );

  static final dark = MoonDotIndicatorColors(
    selectedColor: MoonColors.dark.piccolo,
    unselectedColor: MoonColors.dark.beerus,
  );

  /// DotIndicator text color.
  final Color selectedColor;

  /// DotIndicator icon color.
  final Color unselectedColor;

  const MoonDotIndicatorColors({
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  MoonDotIndicatorColors copyWith({
    Color? selectedColor,
    Color? unselectedColor,
  }) {
    return MoonDotIndicatorColors(
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
    );
  }

  @override
  MoonDotIndicatorColors lerp(ThemeExtension<MoonDotIndicatorColors>? other, double t) {
    if (other is! MoonDotIndicatorColors) return this;

    return MoonDotIndicatorColors(
      selectedColor: colorPremulLerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: colorPremulLerp(unselectedColor, other.unselectedColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonDotIndicatorColors"))
      ..add(ColorProperty("selectedColor", selectedColor))
      ..add(ColorProperty("unselectedColor", unselectedColor));
  }
}
