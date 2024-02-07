import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTextInputGroupColors extends ThemeExtension<MoonTextInputGroupColors> with DiagnosticableTreeMixin {
  /// The background color of the MoonTextInputGroup.
  final Color backgroundColor;

  /// The color of the MoonTextInputGroup in error state.
  final Color errorColor;

  /// The text color of the MoonTextInputGroup helper and errorBuilder widgets.
  final Color helperTextColor;

  /// The border color of the MoonTextInputGroup.
  final Color borderColor;

  /// The border color of the MoonTextInputGroup on hover.
  final Color hoverBorderColor;

  const MoonTextInputGroupColors({
    required this.backgroundColor,
    required this.errorColor,
    required this.helperTextColor,
    required this.borderColor,
    required this.hoverBorderColor,
  });

  @override
  MoonTextInputGroupColors copyWith({
    Color? backgroundColor,
    Color? errorColor,
    Color? helperTextColor,
    Color? borderColor,
    Color? hoverBorderColor,
  }) {
    return MoonTextInputGroupColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorColor: errorColor ?? this.errorColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
      borderColor: borderColor ?? this.borderColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
    );
  }

  @override
  MoonTextInputGroupColors lerp(ThemeExtension<MoonTextInputGroupColors>? other, double t) {
    if (other is! MoonTextInputGroupColors) return this;

    return MoonTextInputGroupColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      errorColor: colorPremulLerp(errorColor, other.errorColor, t)!,
      helperTextColor: colorPremulLerp(helperTextColor, other.helperTextColor, t)!,
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      hoverBorderColor: colorPremulLerp(hoverBorderColor, other.hoverBorderColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputGroupColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("errorColor", errorColor))
      ..add(ColorProperty("helperTextColor", helperTextColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("hoverBorderColor", hoverBorderColor));
  }
}
