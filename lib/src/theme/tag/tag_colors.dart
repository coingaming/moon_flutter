import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTagColors extends ThemeExtension<MoonTagColors> with DiagnosticableTreeMixin {
  /// The text color of the MoonTag.
  final Color textColor;

  /// The icon color of the MoonTag.
  final Color iconColor;

  /// The background color of the MoonTag.
  final Color backgroundColor;

  const MoonTagColors({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  MoonTagColors copyWith({
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return MoonTagColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonTagColors lerp(ThemeExtension<MoonTagColors>? other, double t) {
    if (other is! MoonTagColors) return this;

    return MoonTagColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
