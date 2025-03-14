import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonInputGroupColors extends ThemeExtension<MoonInputGroupColors>
    with DiagnosticableTreeMixin {
  /// The background color of the MoonInputGroup.
  final Color backgroundColor;

  /// The color of the MoonInputGroup in error state.
  final Color errorColor;

  /// The text color of the MoonInputGroup helper widget.
  final Color helperTextColor;

  /// The border color of the MoonInputGroup.
  final Color borderColor;

  /// The hover effect color of the MoonInputGroup children.
  final Color hoverColor;

  const MoonInputGroupColors({
    required this.backgroundColor,
    required this.errorColor,
    required this.helperTextColor,
    required this.borderColor,
    required this.hoverColor,
  });

  @override
  MoonInputGroupColors copyWith({
    Color? backgroundColor,
    Color? errorColor,
    Color? helperTextColor,
    Color? borderColor,
    Color? hoverColor,
  }) {
    return MoonInputGroupColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorColor: errorColor ?? this.errorColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
      borderColor: borderColor ?? this.borderColor,
      hoverColor: hoverColor ?? this.hoverColor,
    );
  }

  @override
  MoonInputGroupColors lerp(
    ThemeExtension<MoonInputGroupColors>? other,
    double t,
  ) {
    if (other is! MoonInputGroupColors) return this;

    return MoonInputGroupColors(
      backgroundColor:
          colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      errorColor: colorPremulLerp(errorColor, other.errorColor, t)!,
      helperTextColor:
          colorPremulLerp(helperTextColor, other.helperTextColor, t)!,
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      hoverColor: colorPremulLerp(hoverColor, other.hoverColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonInputGroupColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("errorColor", errorColor))
      ..add(ColorProperty("helperTextColor", helperTextColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("hoverColor", hoverColor));
  }
}
