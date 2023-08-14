import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTextAreaColors extends ThemeExtension<MoonTextAreaColors> with DiagnosticableTreeMixin {
  /// TextArea background color.
  final Color backgroundColor;

  /// TextArea error color.
  final Color errorColor;

  /// TextArea active border color.
  final Color activeBorderColor;

  /// TextArea inactive border color.
  final Color inactiveBorderColor;

  /// TextArea hover border color.
  final Color hoverBorderColor;

  /// TextArea helper text color.
  final Color helperTextColor;

  const MoonTextAreaColors({
    required this.backgroundColor,
    required this.errorColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.hoverBorderColor,
    required this.helperTextColor,
  });

  @override
  MoonTextAreaColors copyWith({
    Color? backgroundColor,
    Color? errorColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? hoverBorderColor,
    Color? helperTextColor,
  }) {
    return MoonTextAreaColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorColor: errorColor ?? this.errorColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
    );
  }

  @override
  MoonTextAreaColors lerp(ThemeExtension<MoonTextAreaColors>? other, double t) {
    if (other is! MoonTextAreaColors) return this;

    return MoonTextAreaColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      errorColor: colorPremulLerp(errorColor, other.errorColor, t)!,
      activeBorderColor: colorPremulLerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: colorPremulLerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      hoverBorderColor: colorPremulLerp(hoverBorderColor, other.hoverBorderColor, t)!,
      helperTextColor: colorPremulLerp(helperTextColor, other.helperTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextAreaColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("errorColor", errorColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("hoverBorderColor", hoverBorderColor))
      ..add(ColorProperty("helperTextColor", helperTextColor));
  }
}
