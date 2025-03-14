import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTextAreaColors extends ThemeExtension<MoonTextAreaColors>
    with DiagnosticableTreeMixin {
  /// The background color of the MoonTextArea.
  final Color backgroundColor;

  /// The border color of the active or focused MoonTextArea.
  final Color activeBorderColor;

  /// The border color of the inactive MoonTextArea.
  final Color inactiveBorderColor;

  /// The color of the MoonTextArea in error state.
  final Color errorColor;

  /// The hover effect color of the MoonTextArea.
  final Color hoverColor;

  /// The text color of the MoonTextArea.
  final Color textColor;

  /// The text color of the MoonTextArea helper widget.
  final Color helperTextColor;

  const MoonTextAreaColors({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorColor,
    required this.hoverColor,
    required this.textColor,
    required this.helperTextColor,
  });

  @override
  MoonTextAreaColors copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorColor,
    Color? hoverColor,
    Color? textColor,
    Color? helperTextColor,
  }) {
    return MoonTextAreaColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorColor: errorColor ?? this.errorColor,
      hoverColor: hoverColor ?? this.hoverColor,
      textColor: textColor ?? this.textColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
    );
  }

  @override
  MoonTextAreaColors lerp(ThemeExtension<MoonTextAreaColors>? other, double t) {
    if (other is! MoonTextAreaColors) return this;

    return MoonTextAreaColors(
      backgroundColor:
          colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      activeBorderColor:
          colorPremulLerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor:
          colorPremulLerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorColor: colorPremulLerp(errorColor, other.errorColor, t)!,
      hoverColor: colorPremulLerp(hoverColor, other.hoverColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      helperTextColor:
          colorPremulLerp(helperTextColor, other.helperTextColor, t)!,
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
      ..add(ColorProperty("hoverColor", hoverColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("helperTextColor", helperTextColor));
  }
}
