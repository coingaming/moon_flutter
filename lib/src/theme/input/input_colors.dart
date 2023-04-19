import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonInputColors extends ThemeExtension<MoonInputColors> with DiagnosticableTreeMixin {
  static final light = MoonInputColors(
    backgroundColor: MoonColors.light.gohan,
    activeBorderColor: MoonColors.light.piccolo,
    inactiveBorderColor: MoonColors.light.beerus,
    errorBorderColor: MoonColors.light.chiChi100,
    hintTextColor: MoonColors.light.trunks,
  );

  static final dark = MoonInputColors(
    backgroundColor: MoonColors.dark.gohan,
    activeBorderColor: MoonColors.dark.piccolo,
    inactiveBorderColor: MoonColors.dark.beerus,
    errorBorderColor: MoonColors.dark.chiChi100,
    hintTextColor: MoonColors.dark.trunks,
  );

  /// Input background color.
  final Color backgroundColor;

  /// Input active border color.
  final Color activeBorderColor;

  /// Input inactive border color.
  final Color inactiveBorderColor;

  /// Input error border color.
  final Color errorBorderColor;

  /// Input hint text color.
  final Color hintTextColor;

  const MoonInputColors({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorBorderColor,
    required this.hintTextColor,
  });

  @override
  MoonInputColors copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorBorderColor,
    Color? hoverBorderColor,
    Color? hintTextColor,
  }) {
    return MoonInputColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
    );
  }

  @override
  MoonInputColors lerp(ThemeExtension<MoonInputColors>? other, double t) {
    if (other is! MoonInputColors) return this;

    return MoonInputColors(
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
      ..add(DiagnosticsProperty("type", "MoonInputColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("errorBorderColor", errorBorderColor))
      ..add(ColorProperty("hintTextColor", hintTextColor));
  }
}
