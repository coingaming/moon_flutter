import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonAccordionColors extends ThemeExtension<MoonAccordionColors> with DiagnosticableTreeMixin {
  static final light = MoonAccordionColors(
    backgroundColor: MoonColors.light.gohan,
    collapsedBackgroundColor: MoonColors.light.gohan,
    borderColor: MoonColors.light.beerus,
    dividerColor: MoonColors.light.beerus,
    iconColor: MoonColors.light.bulma,
    collapsedIconColor: MoonColors.light.trunks,
  );

  static final dark = MoonAccordionColors(
    backgroundColor: MoonColors.dark.gohan,
    collapsedBackgroundColor: MoonColors.dark.gohan,
    borderColor: MoonColors.dark.beerus,
    dividerColor: MoonColors.dark.beerus,
    iconColor: MoonColors.dark.bulma,
    collapsedIconColor: MoonColors.dark.trunks,
  );

  /// Accordion background color.
  final Color backgroundColor;

  /// Accordion background color.
  final Color collapsedBackgroundColor;

  /// Accordion border color.
  final Color borderColor;

  /// Accordion divider color.
  final Color dividerColor;

  /// Accordion icon color.
  final Color iconColor;

  /// Accordion collapsed icon color.
  final Color collapsedIconColor;

  const MoonAccordionColors({
    required this.backgroundColor,
    required this.collapsedBackgroundColor,
    required this.borderColor,
    required this.dividerColor,
    required this.iconColor,
    required this.collapsedIconColor,
  });

  @override
  MoonAccordionColors copyWith({
    Color? backgroundColor,
    Color? collapsedBackgroundColor,
    Color? borderColor,
    Color? dividerColor,
    Color? iconColor,
    Color? collapsedIconColor,
  }) {
    return MoonAccordionColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      collapsedBackgroundColor: collapsedBackgroundColor ?? this.collapsedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      iconColor: iconColor ?? this.iconColor,
      collapsedIconColor: collapsedIconColor ?? this.collapsedIconColor,
    );
  }

  @override
  MoonAccordionColors lerp(ThemeExtension<MoonAccordionColors>? other, double t) {
    if (other is! MoonAccordionColors) return this;

    return MoonAccordionColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      collapsedBackgroundColor: Color.lerp(collapsedBackgroundColor, other.collapsedBackgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      collapsedIconColor: Color.lerp(collapsedIconColor, other.collapsedIconColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("collapsedBackgroundColor", collapsedBackgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("dividerColor", dividerColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("collapsedIconColor", collapsedIconColor));
  }
}
