import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonBreadcrumbColors extends ThemeExtension<MoonBreadcrumbColors> with DiagnosticableTreeMixin {
  /// Default text color of MoonBreadcrumb item.
  final Color textColor;

  /// The text color when MoonBreadcrumb item hovered.
  final Color? hoverTextColor;

  /// Text color of current MoonBreadcrumb item.
  final Color? currentItemTextColor;

  /// Default divider color.
  final Color? dividerColor;

  /// Menu background color.
  final Color? menuBackgroundColor;

  const MoonBreadcrumbColors({
    required this.textColor,
    this.menuBackgroundColor,
    this.dividerColor,
    this.currentItemTextColor,
    this.hoverTextColor,
  });

  @override
  MoonBreadcrumbColors copyWith({
    Color? currentItemTextColor,
    Color? hoverTextColor,
    Color? textColor,
    Color? dividerColor,
    Color? menuBackgroundColor,
    Color? menuHoverBackgroundColor,
  }) {
    return MoonBreadcrumbColors(
      currentItemTextColor: currentItemTextColor ?? this.currentItemTextColor,
      hoverTextColor: hoverTextColor ?? this.hoverTextColor,
      textColor: textColor ?? this.textColor,
      dividerColor: dividerColor ?? this.dividerColor,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
    );
  }

  @override
  MoonBreadcrumbColors lerp(
    ThemeExtension<MoonBreadcrumbColors>? other,
    double t,
  ) {
    if (other is! MoonBreadcrumbColors) return this;

    return MoonBreadcrumbColors(
      currentItemTextColor: colorPremulLerp(currentItemTextColor, other.currentItemTextColor, t),
      hoverTextColor: colorPremulLerp(hoverTextColor, other.hoverTextColor, t),
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t),
      menuBackgroundColor: Color.lerp(menuBackgroundColor, other.menuBackgroundColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBreadcrumbColors"))
      ..add(ColorProperty("currentItemTextColor", currentItemTextColor))
      ..add(ColorProperty("hoverTextColor", hoverTextColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("dividerColor", dividerColor))
      ..add(ColorProperty("menuBackgroundColor", menuBackgroundColor));
  }
}
