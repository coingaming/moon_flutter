import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonLinearProgressColors extends ThemeExtension<MoonLinearProgressColors> with DiagnosticableTreeMixin {
  /// Linear progress color.
  final Color color;

  /// Linear progress background color.
  final Color backgroundColor;

  /// Linear progress minWidget and maxWidget text color.
  final Color textColor;

  const MoonLinearProgressColors({
    required this.color,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  MoonLinearProgressColors copyWith({
    Color? color,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return MoonLinearProgressColors(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonLinearProgressColors lerp(ThemeExtension<MoonLinearProgressColors>? other, double t) {
    if (other is! MoonLinearProgressColors) return this;

    return MoonLinearProgressColors(
      color: colorPremulLerp(color, other.color, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
