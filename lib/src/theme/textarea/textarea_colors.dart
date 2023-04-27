import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonTextAreaColors extends ThemeExtension<MoonTextAreaColors> with DiagnosticableTreeMixin {
  static final light = MoonTextAreaColors(
    backgroundColor: MoonColors.light.gohan,
    activeBorderColor: MoonColors.light.piccolo,
    inactiveBorderColor: MoonColors.light.beerus,
    errorBorderColor: MoonColors.light.chiChi100,
    hintTextColor: MoonColors.light.trunks,
  );

  static final dark = MoonTextAreaColors(
    backgroundColor: MoonColors.dark.gohan,
    activeBorderColor: MoonColors.dark.piccolo,
    inactiveBorderColor: MoonColors.dark.beerus,
    errorBorderColor: MoonColors.dark.chiChi100,
    hintTextColor: MoonColors.dark.trunks,
  );

  /// TextArea background color.
  final Color backgroundColor;

  /// TextArea active border color.
  final Color activeBorderColor;

  /// TextArea inactive border color.
  final Color inactiveBorderColor;

  /// TextArea error border color.
  final Color errorBorderColor;

  /// TextArea hint text color.
  final Color hintTextColor;

  const MoonTextAreaColors({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorBorderColor,
    required this.hintTextColor,
  });

  @override
  MoonTextAreaColors copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorBorderColor,
    Color? hintTextColor,
  }) {
    return MoonTextAreaColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
    );
  }

  @override
  MoonTextAreaColors lerp(ThemeExtension<MoonTextAreaColors>? other, double t) {
    if (other is! MoonTextAreaColors) return this;

    return MoonTextAreaColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeBorderColor: Color.lerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: Color.lerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t)!,
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t)!,
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
      ..add(ColorProperty("errorBorderColor", errorBorderColor))
      ..add(ColorProperty("hintTextColor", hintTextColor));
  }
}
