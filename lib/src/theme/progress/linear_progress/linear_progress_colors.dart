import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonLinearProgressColors extends ThemeExtension<MoonLinearProgressColors> with DiagnosticableTreeMixin {
  /// The color of the MoonLinearProgress.
  final Color color;

  /// The text color of the MoonLinearProgress.
  final Color textColor;

  /// The background color of the MoonLinearProgress.
  final Color backgroundColor;

  const MoonLinearProgressColors({
    required this.color,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  MoonLinearProgressColors copyWith({
    Color? color,
    Color? textColor,
    Color? backgroundColor,
  }) {
    return MoonLinearProgressColors(
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonLinearProgressColors lerp(ThemeExtension<MoonLinearProgressColors>? other, double t) {
    if (other is! MoonLinearProgressColors) return this;

    return MoonLinearProgressColors(
      color: colorPremulLerp(color, other.color, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
