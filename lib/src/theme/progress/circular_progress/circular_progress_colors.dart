import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCircularProgressColors
    extends ThemeExtension<MoonCircularProgressColors>
    with DiagnosticableTreeMixin {
  /// The color of the MoonCircularProgress.
  final Color color;

  /// The background color of the MoonCircularProgress.
  final Color backgroundColor;

  const MoonCircularProgressColors({
    required this.color,
    required this.backgroundColor,
  });

  @override
  MoonCircularProgressColors copyWith({
    Color? color,
    Color? backgroundColor,
  }) {
    return MoonCircularProgressColors(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonCircularProgressColors lerp(
    ThemeExtension<MoonCircularProgressColors>? other,
    double t,
  ) {
    if (other is! MoonCircularProgressColors) return this;

    return MoonCircularProgressColors(
      color: colorPremulLerp(color, other.color, t)!,
      backgroundColor:
          colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
