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
  final Color titleColor;

  /// MenuItem description text color.
  final Color descriptionColor;

  const MoonMenuItemColors({
    required this.backgroundColor,
    required this.dividerColor,
    required this.iconColor,
    required this.titleColor,
    required this.descriptionColor,
  });

  @override
  MoonMenuItemColors copyWith({
    Color? backgroundColor,
    Color? dividerColor,
    Color? iconColor,
    Color? titleColor,
    Color? descriptionColor,
  }) {
    return MoonMenuItemColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
      iconColor: iconColor ?? this.iconColor,
      titleColor: titleColor ?? this.titleColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
    );
  }

  @override
  MoonMenuItemColors lerp(ThemeExtension<MoonMenuItemColors>? other, double t) {
    if (other is! MoonMenuItemColors) return this;

    return MoonMenuItemColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      titleColor: colorPremulLerp(titleColor, other.titleColor, t)!,
      descriptionColor: colorPremulLerp(descriptionColor, other.descriptionColor, t)!,
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
      ..add(ColorProperty("title", titleColor))
      ..add(ColorProperty("description", descriptionColor));
  }
}
