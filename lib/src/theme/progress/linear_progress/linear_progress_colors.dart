import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonLinearProgressColors extends ThemeExtension<MoonLinearProgressColors> with DiagnosticableTreeMixin {
  /// Linear progress color.
  final Color color;

  /// Linear progress background color.
  final Color backgroundColor;

  const MoonLinearProgressColors({
    required this.color,
    required this.backgroundColor,
  });

  @override
  MoonLinearProgressColors copyWith({
    Color? color,
    Color? backgroundColor,
  }) {
    return MoonLinearProgressColors(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonLinearProgressColors lerp(ThemeExtension<MoonLinearProgressColors>? other, double t) {
    if (other is! MoonLinearProgressColors) return this;

    return MoonLinearProgressColors(
      color: colorPremulLerp(color, other.color, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
