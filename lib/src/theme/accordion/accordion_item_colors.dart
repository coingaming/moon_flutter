import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonAccordionItemColors extends ThemeExtension<MoonAccordionItemColors> with DiagnosticableTreeMixin {
  static final light = MoonAccordionItemColors(
    backgroundColor: MoonColors.light.gohan,
    expandedBackgroundColor: MoonColors.light.gohan,
    borderColor: MoonColors.light.beerus,
    dividerColor: MoonColors.light.beerus,
    expandedIconColor: MoonColors.light.bulma,
    iconColor: MoonColors.light.trunks,
  );

  static final dark = MoonAccordionItemColors(
    backgroundColor: MoonColors.dark.gohan,
    expandedBackgroundColor: MoonColors.dark.gohan,
    borderColor: MoonColors.dark.beerus,
    dividerColor: MoonColors.dark.beerus,
    iconColor: MoonColors.dark.trunks,
    expandedIconColor: MoonColors.dark.bulma,
  );

  /// Accordion item background color.
  final Color backgroundColor;

  /// Expanded accordion item background color.
  final Color expandedBackgroundColor;

  /// Accordion item border color.
  final Color borderColor;

  /// Accordion item divider color.
  final Color dividerColor;

  /// Accordion item icon color.
  final Color iconColor;

  /// Expanded accordion item icon color.
  final Color expandedIconColor;

  const MoonAccordionItemColors({
    required this.backgroundColor,
    required this.expandedBackgroundColor,
    required this.borderColor,
    required this.dividerColor,
    required this.expandedIconColor,
    required this.iconColor,
  });

  @override
  MoonAccordionItemColors copyWith({
    Color? backgroundColor,
    Color? expandedBackgroundColor,
    Color? borderColor,
    Color? dividerColor,
    Color? expandedIconColor,
    Color? iconColor,
  }) {
    return MoonAccordionItemColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      expandedBackgroundColor: expandedBackgroundColor ?? this.expandedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      expandedIconColor: expandedIconColor ?? this.expandedIconColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  MoonAccordionItemColors lerp(ThemeExtension<MoonAccordionItemColors>? other, double t) {
    if (other is! MoonAccordionItemColors) return this;

    return MoonAccordionItemColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      expandedBackgroundColor: Color.lerp(expandedBackgroundColor, other.expandedBackgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      expandedIconColor: Color.lerp(expandedIconColor, other.expandedIconColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionItemColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("expandedBackgroundColor", expandedBackgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("dividerColor", dividerColor))
      ..add(ColorProperty("expandedIconColor", expandedIconColor))
      ..add(ColorProperty("iconColor", iconColor));
  }
}
