import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonSegmentedControlColors extends ThemeExtension<MoonSegmentedControlColors> with DiagnosticableTreeMixin {
  static final light = MoonSegmentedControlColors(
    backgroundColor: MoonColors.light.goku,
    selectedSegmentColor: MoonColors.light.gohan,
    textColor: MoonColors.light.bulma,
    selectedTextColor: MoonColors.light.bulma,
  );

  static final dark = MoonSegmentedControlColors(
    backgroundColor: MoonColors.dark.goku,
    selectedSegmentColor: MoonColors.dark.gohan,
    textColor: MoonColors.dark.bulma,
    selectedTextColor: MoonColors.dark.bulma,
  );

  /// Background color of SegmentedControl.
  final Color backgroundColor;

  /// Color of selected segment.
  final Color selectedSegmentColor;

  /// Default text color of segments.
  final Color textColor;

  /// Text color of selected segment.
  final Color selectedTextColor;

  const MoonSegmentedControlColors({
    required this.backgroundColor,
    required this.selectedSegmentColor,
    required this.textColor,
    required this.selectedTextColor,
  });

  @override
  MoonSegmentedControlColors copyWith({
    Color? backgroundColor,
    Color? selectedSegmentColor,
    Color? textColor,
    Color? selectedTextColor,
  }) {
    return MoonSegmentedControlColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedSegmentColor: selectedSegmentColor ?? this.selectedSegmentColor,
      textColor: textColor ?? this.textColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
    );
  }

  @override
  MoonSegmentedControlColors lerp(ThemeExtension<MoonSegmentedControlColors>? other, double t) {
    if (other is! MoonSegmentedControlColors) return this;

    return MoonSegmentedControlColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      selectedSegmentColor: colorPremulLerp(selectedSegmentColor, other.selectedSegmentColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      selectedTextColor: colorPremulLerp(selectedTextColor, other.selectedTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSegmentedControlColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("selectedSegmentColor", selectedSegmentColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("selectedTextColor", selectedTextColor));
  }
}
