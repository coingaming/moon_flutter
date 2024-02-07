import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCheckboxColors extends ThemeExtension<MoonCheckboxColors> with DiagnosticableTreeMixin {
  /// The background color of the checked MoonCheckbox.
  final Color activeColor;

  /// The border color of the unchecked MoonCheckbox.
  final Color borderColor;

  /// The color of the check icon when the MoonCheckbox is checked.
  final Color checkColor;

  /// The background color of the unchecked MoonCheckbox.
  final Color inactiveColor;

  /// The text color of the MoonCheckbox with label.
  final Color textColor;

  const MoonCheckboxColors({
    required this.activeColor,
    required this.borderColor,
    required this.checkColor,
    required this.inactiveColor,
    required this.textColor,
  });

  @override
  MoonCheckboxColors copyWith({
    Color? activeColor,
    Color? borderColor,
    Color? checkColor,
    Color? inactiveColor,
    Color? textColor,
  }) {
    return MoonCheckboxColors(
      activeColor: activeColor ?? this.activeColor,
      borderColor: borderColor ?? this.borderColor,
      checkColor: checkColor ?? this.checkColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonCheckboxColors lerp(ThemeExtension<MoonCheckboxColors>? other, double t) {
    if (other is! MoonCheckboxColors) return this;

    return MoonCheckboxColors(
      activeColor: colorPremulLerp(activeColor, other.activeColor, t)!,
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      checkColor: colorPremulLerp(checkColor, other.checkColor, t)!,
      inactiveColor: colorPremulLerp(inactiveColor, other.inactiveColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCheckboxColors"))
      ..add(ColorProperty("activeColor", activeColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("checkColor", checkColor))
      ..add(ColorProperty("inactiveColor", inactiveColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
