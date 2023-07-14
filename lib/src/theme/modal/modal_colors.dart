import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonModalColors extends ThemeExtension<MoonModalColors> with DiagnosticableTreeMixin {
  static final light = MoonModalColors(
    textColor: MoonTypography.light.colors.bodyPrimary,
    iconColor: MoonIconTheme.light.colors.primaryColor,
    backgroundColor: MoonColors.light.gohan,
    barrierColor: MoonColors.light.zeno,
  );

  static final dark = MoonModalColors(
    textColor: MoonTypography.dark.colors.bodyPrimary,
    iconColor: MoonIconTheme.dark.colors.primaryColor,
    backgroundColor: MoonColors.dark.gohan,
    barrierColor: MoonColors.dark.zeno,
  );

  /// Modal text color.
  final Color textColor;

  /// Modal icon color.
  final Color iconColor;

  /// Modal background color.
  final Color backgroundColor;

  /// Modal barrier color.
  final Color barrierColor;

  const MoonModalColors({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.barrierColor,
  });

  @override
  MoonModalColors copyWith({
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return MoonModalColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierColor: barrierColor ?? this.barrierColor,
    );
  }

  @override
  MoonModalColors lerp(ThemeExtension<MoonModalColors>? other, double t) {
    if (other is! MoonModalColors) return this;

    return MoonModalColors(
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
      ..add(DiagnosticsProperty("type", "MoonModalColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("barrierColor", barrierColor));
  }
}
