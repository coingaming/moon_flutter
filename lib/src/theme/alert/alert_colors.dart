import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/iconography/iconography.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAlertColors extends ThemeExtension<MoonAlertColors> with DiagnosticableTreeMixin {
  static final light = MoonAlertColors(
    backgroundColor: MoonColors.light.gohan,
    borderColor: MoonTypography.light.colors.bodySecondary,
    iconColor: MoonIconography.light.colors.primaryColor,
    textColor: MoonTypography.light.colors.bodyPrimary,
  );

  static final dark = MoonAlertColors(
    backgroundColor: MoonColors.dark.gohan,
    borderColor: MoonTypography.dark.colors.bodySecondary,
    iconColor: MoonIconography.dark.colors.primaryColor,
    textColor: MoonTypography.dark.colors.bodyPrimary,
  );

  /// Alert background color.
  final Color backgroundColor;

  /// Alert border color.
  final Color borderColor;

  /// Alert icon color.
  final Color iconColor;

  /// Alert text color.
  final Color textColor;

  const MoonAlertColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  MoonAlertColors copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    Color? textColor,
  }) {
    return MoonAlertColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonAlertColors lerp(ThemeExtension<MoonAlertColors>? other, double t) {
    if (other is! MoonAlertColors) return this;

    return MoonAlertColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
