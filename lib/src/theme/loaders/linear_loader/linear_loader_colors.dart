import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonLinearLoaderColors extends ThemeExtension<MoonLinearLoaderColors> with DiagnosticableTreeMixin {
  /// The color of the MoonLinearLoader.
  final Color color;

  /// The background color of the MoonLinearLoader.
  final Color backgroundColor;

  const MoonLinearLoaderColors({
    required this.color,
    required this.backgroundColor,
  });

  @override
  MoonLinearLoaderColors copyWith({
    Color? color,
    Color? backgroundColor,
  }) {
    return MoonLinearLoaderColors(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonLinearLoaderColors lerp(ThemeExtension<MoonLinearLoaderColors>? other, double t) {
    if (other is! MoonLinearLoaderColors) return this;

    return MoonLinearLoaderColors(
      color: colorPremulLerp(color, other.color, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
