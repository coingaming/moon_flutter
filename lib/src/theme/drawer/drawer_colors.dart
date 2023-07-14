import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/iconography/iconography.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonDrawerColors extends ThemeExtension<MoonDrawerColors> with DiagnosticableTreeMixin {
  static final light = MoonDrawerColors(
    textColor: MoonTypography.light.colors.bodyPrimary,
    iconColor: MoonIconography.light.colors.primaryColor,
    backgroundColor: MoonColors.light.gohan,
    barrierColor: MoonColors.light.zeno,
  );

  static final dark = MoonDrawerColors(
    textColor: MoonTypography.dark.colors.bodyPrimary,
    iconColor: MoonIconography.dark.colors.primaryColor,
    backgroundColor: MoonColors.dark.gohan,
    barrierColor: MoonColors.dark.zeno,
  );

  /// Drawer text color.
  final Color textColor;

  /// Drawer icon color.
  final Color iconColor;

  /// Drawer background color.
  final Color backgroundColor;

  /// Drawer barrier color.
  final Color barrierColor;

  const MoonDrawerColors({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.barrierColor,
  });

  @override
  MoonDrawerColors copyWith({
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return MoonDrawerColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierColor: barrierColor ?? this.barrierColor,
    );
  }

  @override
  MoonDrawerColors lerp(ThemeExtension<MoonDrawerColors>? other, double t) {
    if (other is! MoonDrawerColors) return this;

    return MoonDrawerColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      barrierColor: colorPremulLerp(barrierColor, other.barrierColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonDrawerColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("barrierColor", barrierColor));
  }
}
