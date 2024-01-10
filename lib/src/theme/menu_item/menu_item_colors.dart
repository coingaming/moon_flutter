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

  /// MenuItem label text color.
  final Color labelTextColor;

  /// MenuItem content text color.
  final Color contentTextColor;

  const MoonMenuItemColors({
    required this.backgroundColor,
    required this.dividerColor,
    required this.iconColor,
    required this.labelTextColor,
    required this.contentTextColor,
  });

  @override
  MoonMenuItemColors copyWith({
    Color? backgroundColor,
    Color? dividerColor,
    Color? iconColor,
    Color? labelTextColor,
    Color? contentTextColor,
  }) {
    return MoonMenuItemColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
      iconColor: iconColor ?? this.iconColor,
      labelTextColor: labelTextColor ?? this.labelTextColor,
      contentTextColor: contentTextColor ?? this.contentTextColor,
    );
  }

  @override
  MoonMenuItemColors lerp(ThemeExtension<MoonMenuItemColors>? other, double t) {
    if (other is! MoonMenuItemColors) return this;

    return MoonMenuItemColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      labelTextColor: colorPremulLerp(labelTextColor, other.labelTextColor, t)!,
      contentTextColor: colorPremulLerp(contentTextColor, other.contentTextColor, t)!,
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
      ..add(ColorProperty("labelTextColor", labelTextColor))
      ..add(ColorProperty("contentTextColor", contentTextColor));
  }
}
