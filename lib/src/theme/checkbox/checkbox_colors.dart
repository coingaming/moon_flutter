import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCheckboxColors extends ThemeExtension<MoonCheckboxColors> with DiagnosticableTreeMixin {
  static final light = MoonCheckboxColors(
    activeColor: MoonColors.light.piccolo,
    borderColor: MoonColors.light.trunks,
    checkColor: MoonColors.light.goten,
    inactiveColor: Colors.transparent,
    textColor: MoonTypography.light.colors.bodyPrimary,
  );

  static final dark = MoonCheckboxColors(
    activeColor: MoonColors.dark.piccolo,
    borderColor: MoonColors.dark.trunks,
    checkColor: MoonColors.dark.goten,
    inactiveColor: Colors.transparent,
    textColor: MoonTypography.dark.colors.bodyPrimary,
  );

  /// Checkbox active color.
  final Color activeColor;

  /// Checkbox border color.
  final Color borderColor;

  /// Checkbox icon color.
  final Color checkColor;

  /// Checkbox inactive color.
  final Color inactiveColor;

  /// Checkbox text color.
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
