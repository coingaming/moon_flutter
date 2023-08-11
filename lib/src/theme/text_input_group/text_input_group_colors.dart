import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTextInputGroupColors extends ThemeExtension<MoonTextInputGroupColors> with DiagnosticableTreeMixin {
  /// TextInputGroup background color.
  final Color backgroundColor;

  /// TextInputGroup error color.
  final Color errorColor;

  /// TextInputGroup active border color.
  final Color activeBorderColor;

  /// TextInputGroup inactive border color.
  final Color inactiveBorderColor;

  /// TextInputGroup hover border color.
  final Color hoverBorderColor;

  /// TextInputGroup hint text color.
  final Color hintTextColor;

  const MoonTextInputGroupColors({
    required this.backgroundColor,
    required this.errorColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.hoverBorderColor,
    required this.hintTextColor,
  });

  @override
  MoonTextInputGroupColors copyWith({
    Color? backgroundColor,
    Color? errorColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? hoverBorderColor,
    Color? hintTextColor,
  }) {
    return MoonTextInputGroupColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorColor: errorColor ?? this.errorColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
    );
  }

  @override
  MoonTextInputGroupColors lerp(ThemeExtension<MoonTextInputGroupColors>? other, double t) {
    if (other is! MoonTextInputGroupColors) return this;

    return MoonTextInputGroupColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      errorColor: colorPremulLerp(errorColor, other.errorColor, t)!,
      activeBorderColor: colorPremulLerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: colorPremulLerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      hoverBorderColor: colorPremulLerp(hoverBorderColor, other.hoverBorderColor, t)!,
      hintTextColor: colorPremulLerp(hintTextColor, other.hintTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputGroupColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("errorColor", errorColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("hoverBorderColor", hoverBorderColor))
      ..add(ColorProperty("hintTextColor", hintTextColor));
  }
}
