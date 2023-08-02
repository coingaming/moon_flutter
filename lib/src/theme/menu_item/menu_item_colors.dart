import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonMenuItemColors extends ThemeExtension<MoonMenuItemColors> with DiagnosticableTreeMixin {
  /// MenuItem background color.
  final Color backgroundColor;

  /// MenuItem divider color.
  final Color dividerColor;

  /// MenuItem icon color.
  final Color iconColor;

  /// MenuItem title text color.
  final Color titleTextColor;

  /// MenuItem description text color.
  final Color descriptionTextColor;

  const MoonMenuItemColors({
    required this.backgroundColor,
    required this.dividerColor,
    required this.iconColor,
    required this.titleTextColor,
    required this.descriptionTextColor,
  });

  @override
  MoonMenuItemColors copyWith({
    Color? backgroundColor,
    Color? dividerColor,
    Color? iconColor,
    Color? titleTextColor,
    Color? descriptionTextColor,
  }) {
    return MoonMenuItemColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
      iconColor: iconColor ?? this.iconColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      descriptionTextColor: descriptionTextColor ?? this.descriptionTextColor,
    );
  }

  @override
  MoonMenuItemColors lerp(ThemeExtension<MoonMenuItemColors>? other, double t) {
    if (other is! MoonMenuItemColors) return this;

    return MoonMenuItemColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      titleTextColor: colorPremulLerp(titleTextColor, other.titleTextColor, t)!,
      descriptionTextColor: colorPremulLerp(descriptionTextColor, other.descriptionTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonMenuItemColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("dividerColor", dividerColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("titleTextColor", titleTextColor))
      ..add(ColorProperty("descriptionTextColor", descriptionTextColor));
  }
}
