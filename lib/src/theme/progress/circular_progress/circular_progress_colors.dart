import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCircularProgressColors extends ThemeExtension<MoonCircularProgressColors> with DiagnosticableTreeMixin {
  static final light = MoonCircularProgressColors(
    color: MoonColors.light.piccolo,
    backgroundColor: MoonColors.light.trunks,
  );

  static final dark = MoonCircularProgressColors(
    color: MoonColors.dark.piccolo,
    backgroundColor: MoonColors.dark.trunks,
  );

  /// Circular progress color.
  final Color color;

  /// Circular progress background color.
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
  MoonCircularProgressColors lerp(ThemeExtension<MoonCircularProgressColors>? other, double t) {
    if (other is! MoonCircularProgressColors) return this;

    return MoonCircularProgressColors(
      color: colorPremulLerp(color, other.color, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
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
