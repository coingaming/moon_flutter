import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAvatarColors extends ThemeExtension<MoonAvatarColors> with DiagnosticableTreeMixin {
  /// Avatar background color.
  final Color backgroundColor;

  /// Avatar badge color.
  final Color badgeColor;

  /// Avatar icon color.
  final Color iconColor;

  /// Avatar text color.
  final Color textColor;

  const MoonAvatarColors({
    required this.backgroundColor,
    required this.badgeColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  MoonAvatarColors copyWith({
    Color? backgroundColor,
    Color? badgeColor,
    Color? iconColor,
    Color? textColor,
  }) {
    return MoonAvatarColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      badgeColor: badgeColor ?? this.badgeColor,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonAvatarColors lerp(ThemeExtension<MoonAvatarColors>? other, double t) {
    if (other is! MoonAvatarColors) return this;

    return MoonAvatarColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      badgeColor: colorPremulLerp(badgeColor, other.badgeColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("badgeColor", badgeColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
