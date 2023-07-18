import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTextInputColors extends ThemeExtension<MoonTextInputColors> with DiagnosticableTreeMixin {
  /// TextInput background color.
  final Color backgroundColor;

  /// TextInput active border color.
  final Color activeBorderColor;

  /// TextInput inactive border color.
  final Color inactiveBorderColor;

  /// TextInput error border color.
  final Color errorBorderColor;

  /// TextInput hover border color.
  final Color hoverBorderColor;

  /// TextInput hint text color.
  final Color labelTextColor;

  /// TextInput hint text color.
  final Color supportingTextColor;

  const MoonTextInputColors({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorBorderColor,
    required this.hoverBorderColor,
    required this.labelTextColor,
    required this.supportingTextColor,
  });

  @override
  MoonTextInputColors copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorBorderColor,
    Color? hoverBorderColor,
    Color? labelTextColor,
    Color? supportingTextColor,
  }) {
    return MoonTextInputColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
      labelTextColor: labelTextColor ?? this.labelTextColor,
      supportingTextColor: supportingTextColor ?? this.supportingTextColor,
    );
  }

  @override
  MoonTextInputColors lerp(ThemeExtension<MoonTextInputColors>? other, double t) {
    if (other is! MoonTextInputColors) return this;

    return MoonTextInputColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      activeBorderColor: colorPremulLerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: colorPremulLerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorBorderColor: colorPremulLerp(errorBorderColor, other.errorBorderColor, t)!,
      hoverBorderColor: colorPremulLerp(hoverBorderColor, other.hoverBorderColor, t)!,
      labelTextColor: colorPremulLerp(labelTextColor, other.labelTextColor, t)!,
      supportingTextColor: colorPremulLerp(supportingTextColor, other.supportingTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("errorBorderColor", errorBorderColor))
      ..add(ColorProperty("hoverBorderColor", hoverBorderColor))
      ..add(ColorProperty("labelTextColor", labelTextColor))
      ..add(ColorProperty("supportingTextColor", supportingTextColor));
  }
}
