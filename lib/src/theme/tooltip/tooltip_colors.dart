import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTooltipColors extends ThemeExtension<MoonTooltipColors> with DiagnosticableTreeMixin {
  static final light = MoonTooltipColors(
    textColor: MoonTypography.light.colors.bodyPrimary,
    iconColor: MoonIconTheme.light.colors.primaryColor,
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonTooltipColors(
    textColor: MoonTypography.dark.colors.bodyPrimary,
    iconColor: MoonIconTheme.dark.colors.primaryColor,
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Tooltip text color.
  final Color textColor;

  /// Tooltip icon color.
  final Color iconColor;

  /// Tooltip background color.
  final Color backgroundColor;

  const MoonTooltipColors({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  MoonTooltipColors copyWith({
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return MoonTooltipColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonTooltipColors lerp(ThemeExtension<MoonTooltipColors>? other, double t) {
    if (other is! MoonTooltipColors) return this;

    return MoonTooltipColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTooltipColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
