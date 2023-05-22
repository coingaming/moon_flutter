import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonModalColors extends ThemeExtension<MoonModalColors> with DiagnosticableTreeMixin {
  static final light = MoonModalColors(
    backgroundColor: MoonColors.light.gohan,
    barrierColor: MoonColors.light.zeno,
  );

  static final dark = MoonModalColors(
    backgroundColor: MoonColors.dark.gohan,
    barrierColor: MoonColors.dark.zeno,
  );

  /// Modal background color.
  final Color backgroundColor;

  /// Modal barrier color.
  final Color barrierColor;

  const MoonModalColors({
    required this.backgroundColor,
    required this.barrierColor,
  });

  @override
  MoonModalColors copyWith({
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return MoonModalColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierColor: barrierColor ?? this.barrierColor,
    );
  }

  @override
  MoonModalColors lerp(ThemeExtension<MoonModalColors>? other, double t) {
    if (other is! MoonModalColors) return this;

    return MoonModalColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      barrierColor: colorPremulLerp(barrierColor, other.barrierColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonModalColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("barrierColor", barrierColor));
  }
}
