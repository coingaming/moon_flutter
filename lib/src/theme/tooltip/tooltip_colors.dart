import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTooltipColors extends ThemeExtension<MoonTooltipColors>
    with DiagnosticableTreeMixin {
  /// The text color of the MoonTooltip.
  final Color textColor;

  /// The icon color of the MoonTooltip.
  final Color iconColor;

  /// The background color of the MoonTooltip.
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
      backgroundColor: colorPremulLerp(
        backgroundColor,
        other.backgroundColor,
        t,
      )!,
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
