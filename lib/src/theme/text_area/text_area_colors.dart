import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTextAreaColors extends ThemeExtension<MoonTextAreaColors> with DiagnosticableTreeMixin {
  /// TextArea background color.
  final Color backgroundColor;

  /// TextArea active border color.
  final Color activeBorderColor;

  /// TextArea inactive border color.
  final Color inactiveBorderColor;

  /// TextArea error color.
  final Color errorColor;

  /// TextArea hover border color.
  final Color hoverBorderColor;

  /// TextArea text color.
  final Color textColor;

  /// TextArea helper text color.
  final Color helperTextColor;

  const MoonTextAreaColors({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorColor,
    required this.hoverBorderColor,
    required this.textColor,
    required this.helperTextColor,
  });

  @override
  MoonTextAreaColors copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorColor,
    Color? hoverBorderColor,
    Color? textColor,
    Color? helperTextColor,
  }) {
    return MoonTextAreaColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorColor: errorColor ?? this.errorColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
      textColor: textColor ?? this.textColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
    );
  }

  @override
  MoonTextAreaColors lerp(ThemeExtension<MoonTextAreaColors>? other, double t) {
    if (other is! MoonTextAreaColors) return this;

    return MoonTextAreaColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      activeBorderColor: colorPremulLerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: colorPremulLerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorColor: colorPremulLerp(errorColor, other.errorColor, t)!,
      hoverBorderColor: colorPremulLerp(hoverBorderColor, other.hoverBorderColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      helperTextColor: colorPremulLerp(helperTextColor, other.helperTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextAreaColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("errorColor", errorColor))
      ..add(ColorProperty("hoverBorderColor", hoverBorderColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("helperTextColor", helperTextColor));
  }
}
