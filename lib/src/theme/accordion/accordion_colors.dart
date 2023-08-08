import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAccordionColors extends ThemeExtension<MoonAccordionColors> with DiagnosticableTreeMixin {
  /// Collapsed accordion item header text color.
  final Color textColor;

  /// Expanded accordion item header text color.
  final Color expandedTextColor;

  /// Accordion item content slot widget's text and icon color.
  final Color contentColor;

  /// Collapsed accordion item header icon color.
  final Color iconColor;

  /// Expanded accordion item header icon color.
  final Color expandedIconColor;

  /// Collapsed accordion item default pre-set trailing icon color.
  final Color trailingIconColor;

  /// Expanded accordion item default pre-set trailing icon color.
  final Color expandedTrailingIconColor;

  /// Collapsed accordion item background color.
  final Color backgroundColor;

  /// Expanded accordion item background color.
  final Color expandedBackgroundColor;

  /// Accordion item border color.
  final Color borderColor;

  /// Accordion item divider color.
  final Color dividerColor;

  const MoonAccordionColors({
    required this.textColor,
    required this.expandedTextColor,
    required this.contentColor,
    required this.iconColor,
    required this.expandedIconColor,
    required this.trailingIconColor,
    required this.expandedTrailingIconColor,
    required this.backgroundColor,
    required this.expandedBackgroundColor,
    required this.borderColor,
    required this.dividerColor,
  });

  @override
  MoonAccordionColors copyWith({
    Color? textColor,
    Color? expandedTextColor,
    Color? contentColor,
    Color? iconColor,
    Color? expandedIconColor,
    Color? trailingIconColor,
    Color? expandedTrailingIconColor,
    Color? backgroundColor,
    Color? expandedBackgroundColor,
    Color? borderColor,
    Color? dividerColor,
  }) {
    return MoonAccordionColors(
      textColor: textColor ?? this.textColor,
      expandedTextColor: expandedTextColor ?? this.expandedTextColor,
      contentColor: contentColor ?? this.contentColor,
      iconColor: iconColor ?? this.iconColor,
      expandedIconColor: expandedIconColor ?? this.expandedIconColor,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      expandedTrailingIconColor: expandedTrailingIconColor ?? this.expandedTrailingIconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      expandedBackgroundColor: expandedBackgroundColor ?? this.expandedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  @override
  MoonAccordionColors lerp(ThemeExtension<MoonAccordionColors>? other, double t) {
    if (other is! MoonAccordionColors) return this;

    return MoonAccordionColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      expandedTextColor: colorPremulLerp(expandedTextColor, other.expandedTextColor, t)!,
      contentColor: colorPremulLerp(contentColor, other.contentColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      expandedIconColor: colorPremulLerp(expandedIconColor, other.expandedIconColor, t)!,
      trailingIconColor: colorPremulLerp(trailingIconColor, other.trailingIconColor, t)!,
      expandedTrailingIconColor: colorPremulLerp(expandedTrailingIconColor, other.expandedTrailingIconColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      expandedBackgroundColor: colorPremulLerp(expandedBackgroundColor, other.expandedBackgroundColor, t)!,
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("expandedTextColor", expandedTextColor))
      ..add(ColorProperty("contentColor", contentColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("expandedIconColor", expandedIconColor))
      ..add(ColorProperty("trailingIconColor", trailingIconColor))
      ..add(ColorProperty("expandedTrailingIconColor", expandedTrailingIconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("expandedBackgroundColor", expandedBackgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("dividerColor", dividerColor));
  }
}
