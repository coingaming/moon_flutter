import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonInputColors extends ThemeExtension<MoonInputColors>
    with DiagnosticableTreeMixin {
  /// The background color of the MoonInput.
  final Color backgroundColor;

  /// The border color of the active or focused MoonInput.
  final Color activeBorderColor;

  /// The border color of the inactive MoonInput.
  final Color inactiveBorderColor;

  /// The color of the MoonInput in error state.
  final Color errorColor;

  /// The hover effect color of the MoonInput.
  final Color hoverColor;

  /// The text color of the MoonInput.
  final Color textColor;

  /// The text color of the MoonInput helper widget.
  final Color helperTextColor;

  const MoonInputColors({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorColor,
    required this.hoverColor,
    required this.textColor,
    required this.helperTextColor,
  });

  @override
  MoonInputColors copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorColor,
    Color? hoverColor,
    Color? textColor,
    Color? helperTextColor,
  }) {
    return MoonInputColors(
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
  MoonInputColors lerp(
    ThemeExtension<MoonInputColors>? other,
    double t,
  ) {
    if (other is! MoonInputColors) return this;

    return MoonInputColors(
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
      ..add(DiagnosticsProperty("type", "MoonInputColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("errorColor", errorColor))
      ..add(ColorProperty("hoverColor", hoverColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("helperTextColor", helperTextColor));
  }
}
