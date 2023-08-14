import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTextInputColors extends ThemeExtension<MoonTextInputColors> with DiagnosticableTreeMixin {
  /// TextInput background color.
  final Color backgroundColor;

  /// TextInput active border color.
  final Color activeBorderColor;

  /// TextInput error color.
  final Color errorColor;

  /// TextInput inactive border color.
  final Color inactiveBorderColor;

  /// TextInput hover border color.
  final Color hoverBorderColor;

  /// TextInput hint text color.
  final Color labelTextColor;

  /// TextInput helper text color.
  final Color helperTextColor;

  const MoonTextInputColors({
    required this.backgroundColor,
    required this.errorColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.hoverBorderColor,
    required this.labelTextColor,
    required this.helperTextColor,
  });

  @override
  MoonTextInputColors copyWith({
    Color? backgroundColor,
    Color? errorColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? hoverBorderColor,
    Color? labelTextColor,
    Color? helperTextColor,
  }) {
    return MoonTextInputColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorColor: errorColor ?? this.errorColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
      labelTextColor: labelTextColor ?? this.labelTextColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
    );
  }

  @override
  MoonTextInputColors lerp(ThemeExtension<MoonTextInputColors>? other, double t) {
    if (other is! MoonTextInputColors) return this;

    return MoonTextInputColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      errorColor: colorPremulLerp(errorColor, other.errorColor, t)!,
      activeBorderColor: colorPremulLerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: colorPremulLerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      hoverBorderColor: colorPremulLerp(hoverBorderColor, other.hoverBorderColor, t)!,
      labelTextColor: colorPremulLerp(labelTextColor, other.labelTextColor, t)!,
      helperTextColor: colorPremulLerp(helperTextColor, other.helperTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("errorColor", errorColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("hoverBorderColor", hoverBorderColor))
      ..add(ColorProperty("labelTextColor", labelTextColor))
      ..add(ColorProperty("helperTextColor", helperTextColor));
  }
}
