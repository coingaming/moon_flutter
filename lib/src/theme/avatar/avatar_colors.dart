import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAvatarColors extends ThemeExtension<MoonAvatarColors> with DiagnosticableTreeMixin {
  static final light = MoonAvatarColors(
    textColor: MoonTypography.light.colors.bodyPrimary,
    iconColor: MoonIconTheme.light.colors.primaryColor,
    backgroundColor: MoonColors.light.gohan,
    badgeColor: MoonColors.light.roshi100,
  );

  static final dark = MoonAvatarColors(
    textColor: MoonTypography.dark.colors.bodyPrimary,
    iconColor: MoonIconTheme.dark.colors.primaryColor,
    backgroundColor: MoonColors.dark.gohan,
    badgeColor: MoonColors.dark.roshi100,
  );

  /// Avatar text color.
  final Color textColor;

  /// Avatar icon color.
  final Color iconColor;

  /// Avatar background color.
  final Color backgroundColor;

  /// Avatar badge color.
  final Color badgeColor;

  const MoonAvatarColors({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.badgeColor,
  });

  @override
  MoonAvatarColors copyWith({
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? badgeColor,
  }) {
    return MoonAvatarColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      badgeColor: badgeColor ?? this.badgeColor,
    );
  }

  @override
  MoonAvatarColors lerp(ThemeExtension<MoonAvatarColors>? other, double t) {
    if (other is! MoonAvatarColors) return this;

    return MoonAvatarColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      badgeColor: colorPremulLerp(badgeColor, other.badgeColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("badgeColor", badgeColor));
  }
}
