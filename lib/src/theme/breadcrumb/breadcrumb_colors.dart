import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonBreadcrumbColors extends ThemeExtension<MoonBreadcrumbColors> with DiagnosticableTreeMixin {
  /// The default text color of MoonBreadcrumb item.
  final Color textColor;

  /// The text color when MoonBreadcrumb item is hovered.
  final Color? hoverTextColor;

  /// The text color of MoonBreadcrumb current item.
  final Color? currentItemTextColor;

  /// The default divider color.
  final Color? dividerColor;

  /// The background color of the MoonBreadcrumb expanded menu.
  final Color? menuBackgroundColor;

  /// The text color of the MoonBreadcrumb expanded menu item.
  final Color? menuItemTextColor;

  const MoonBreadcrumbColors({
    required this.textColor,
    this.hoverTextColor,
    this.currentItemTextColor,
    this.dividerColor,
    this.menuBackgroundColor,
    this.menuItemTextColor,
  });

  @override
  MoonBreadcrumbColors copyWith({
    Color? textColor,
    Color? hoverTextColor,
    Color? currentItemTextColor,
    Color? dividerColor,
    Color? menuBackgroundColor,
    Color? menuItemTextColor,
  }) {
    return MoonBreadcrumbColors(
      textColor: textColor ?? this.textColor,
      hoverTextColor: hoverTextColor ?? this.hoverTextColor,
      currentItemTextColor: currentItemTextColor ?? this.currentItemTextColor,
      dividerColor: dividerColor ?? this.dividerColor,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
      menuItemTextColor: menuItemTextColor ?? this.menuItemTextColor,
    );
  }

  @override
  MoonBreadcrumbColors lerp(
    ThemeExtension<MoonBreadcrumbColors>? other,
    double t,
  ) {
    if (other is! MoonBreadcrumbColors) return this;

    return MoonBreadcrumbColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      hoverTextColor: colorPremulLerp(hoverTextColor, other.hoverTextColor, t),
      currentItemTextColor: colorPremulLerp(currentItemTextColor, other.currentItemTextColor, t),
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t),
      menuBackgroundColor: Color.lerp(menuBackgroundColor, other.menuBackgroundColor, t),
      menuItemTextColor: colorPremulLerp(menuItemTextColor, other.menuItemTextColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBreadcrumbColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("hoverTextColor", hoverTextColor))
      ..add(ColorProperty("currentItemTextColor", currentItemTextColor))
      ..add(ColorProperty("dividerColor", dividerColor))
      ..add(ColorProperty("menuBackgroundColor", menuBackgroundColor))
      ..add(ColorProperty("menuItemTextColor", menuItemTextColor));
  }
}
