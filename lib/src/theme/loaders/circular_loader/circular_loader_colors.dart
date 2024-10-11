import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCircularLoaderColors extends ThemeExtension<MoonCircularLoaderColors>
    with DiagnosticableTreeMixin {
  /// The color of the MoonCircularLoader.
  final Color color;

  /// The background color of the MoonCircularLoader.
  final Color backgroundColor;

  const MoonCircularLoaderColors({
    required this.color,
    required this.backgroundColor,
  });

  @override
  MoonCircularLoaderColors copyWith({
    Color? color,
    Color? backgroundColor,
  }) {
    return MoonCircularLoaderColors(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonCircularLoaderColors lerp(
    ThemeExtension<MoonCircularLoaderColors>? other,
    double t,
  ) {
    if (other is! MoonCircularLoaderColors) return this;

    return MoonCircularLoaderColors(
      color: colorPremulLerp(color, other.color, t)!,
      backgroundColor:
          colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
