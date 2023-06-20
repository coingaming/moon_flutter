import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonPopoverColors extends ThemeExtension<MoonPopoverColors> with DiagnosticableTreeMixin {
  static final light = MoonPopoverColors(
    textColor: MoonTypography.light.colors.bodyPrimary,
    iconColor: MoonIconTheme.light.colors.primaryColor,
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonPopoverColors(
    textColor: MoonTypography.dark.colors.bodyPrimary,
    iconColor: MoonIconTheme.dark.colors.primaryColor,
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Popover text color.
  final Color textColor;

  /// Popover icon color.
  final Color iconColor;

  /// Popover background color.
  final Color backgroundColor;

  const MoonPopoverColors({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  MoonPopoverColors copyWith({
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return MoonPopoverColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonPopoverColors lerp(ThemeExtension<MoonPopoverColors>? other, double t) {
    if (other is! MoonPopoverColors) return this;

    return MoonPopoverColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonPopoverColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
