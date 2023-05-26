import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAccordionItemColors extends ThemeExtension<MoonAccordionItemColors> with DiagnosticableTreeMixin {
  static final light = MoonAccordionItemColors(
    backgroundColor: MoonColors.light.gohan,
    expandedBackgroundColor: MoonColors.light.gohan,
    borderColor: MoonColors.light.beerus,
    dividerColor: MoonColors.light.beerus,
    textColor: MoonTypography.light.colors.bodyPrimary,
    expandedTextColor: MoonTypography.light.colors.bodyPrimary,
    trailingIconColor: MoonTypography.light.colors.bodySecondary,
    expandedTrailingIconColor: MoonTypography.light.colors.bodyPrimary,
  );

  static final dark = MoonAccordionItemColors(
    backgroundColor: MoonColors.dark.gohan,
    expandedBackgroundColor: MoonColors.dark.gohan,
    borderColor: MoonColors.dark.beerus,
    dividerColor: MoonColors.dark.beerus,
    textColor: MoonTypography.dark.colors.bodyPrimary,
    expandedTextColor: MoonTypography.dark.colors.bodyPrimary,
    trailingIconColor: MoonTypography.dark.colors.bodySecondary,
    expandedTrailingIconColor: MoonTypography.dark.colors.bodyPrimary,
  );

  /// Accordion item background color.
  final Color backgroundColor;

  /// Expanded accordion item background color.
  final Color expandedBackgroundColor;

  /// Accordion item border color.
  final Color borderColor;

  /// Accordion item divider color.
  final Color dividerColor;

  /// Accordion item text color.
  final Color textColor;

  /// Accordion item expanded text color.
  final Color expandedTextColor;

  /// Accordion item trailing icon color.
  final Color trailingIconColor;

  /// Expanded accordion item trailing icon color.
  final Color expandedTrailingIconColor;

  const MoonAccordionItemColors({
    required this.backgroundColor,
    required this.expandedBackgroundColor,
    required this.borderColor,
    required this.dividerColor,
    required this.textColor,
    required this.expandedTextColor,
    required this.trailingIconColor,
    required this.expandedTrailingIconColor,
  });

  @override
  MoonAccordionItemColors copyWith({
    Color? backgroundColor,
    Color? expandedBackgroundColor,
    Color? borderColor,
    Color? dividerColor,
    Color? textColor,
    Color? expandedTextColor,
    Color? trailingIconColor,
    Color? expandedTrailingIconColor,
  }) {
    return MoonAccordionItemColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      expandedBackgroundColor: expandedBackgroundColor ?? this.expandedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      textColor: textColor ?? this.textColor,
      expandedTextColor: expandedTextColor ?? this.expandedTextColor,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      expandedTrailingIconColor: expandedTrailingIconColor ?? this.expandedTrailingIconColor,
    );
  }

  @override
  MoonAccordionItemColors lerp(ThemeExtension<MoonAccordionItemColors>? other, double t) {
    if (other is! MoonAccordionItemColors) return this;

    return MoonAccordionItemColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      expandedBackgroundColor: colorPremulLerp(expandedBackgroundColor, other.expandedBackgroundColor, t)!,
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      expandedTextColor: colorPremulLerp(expandedTextColor, other.expandedTextColor, t)!,
      trailingIconColor: colorPremulLerp(trailingIconColor, other.trailingIconColor, t)!,
      expandedTrailingIconColor: colorPremulLerp(expandedTrailingIconColor, other.expandedTrailingIconColor, t)!,
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
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("expandedTextColor", expandedTextColor))
      ..add(ColorProperty("trailingIconColor", trailingIconColor))
      ..add(ColorProperty("expandedTrailingIconColor", expandedTrailingIconColor));
  }
}
