import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAccordionColors extends ThemeExtension<MoonAccordionColors> with DiagnosticableTreeMixin {
  /// Collapsed accordion item leading slot widget's text and icon color.
  final Color leadingColor;

  /// Expanded accordion item leading slot widget's text and icon color.
  final Color expandedLeadingColor;

  /// Collapsed accordion item title slot widget's text and icon color.
  final Color titleColor;

  /// Expanded accordion item title slot widget's text and icon color.
  final Color expandedTitleColor;

  /// Collapsed accordion item trailing slot widget's text and icon color.
  final Color trailingColor;

  /// Expanded accordion item trailing slot widget's text and icon color.
  final Color expandedTrailingColor;

  /// Accordion item content slot widget's text and icon color.
  final Color contentColor;

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
    required this.leadingColor,
    required this.expandedLeadingColor,
    required this.titleColor,
    required this.expandedTitleColor,
    required this.trailingColor,
    required this.expandedTrailingColor,
    required this.contentColor,
    required this.trailingIconColor,
    required this.expandedTrailingIconColor,
    required this.backgroundColor,
    required this.expandedBackgroundColor,
    required this.borderColor,
    required this.dividerColor,
  });

  @override
  MoonAccordionColors copyWith({
    Color? leadingColor,
    Color? expandedLeadingColor,
    Color? titleColor,
    Color? expandedTitleColor,
    Color? trailingColor,
    Color? expandedTrailingColor,
    Color? contentColor,
    Color? trailingIconColor,
    Color? expandedTrailingIconColor,
    Color? backgroundColor,
    Color? expandedBackgroundColor,
    Color? borderColor,
    Color? dividerColor,
  }) {
    return MoonAccordionColors(
      leadingColor: leadingColor ?? this.leadingColor,
      expandedLeadingColor: expandedLeadingColor ?? this.expandedLeadingColor,
      titleColor: titleColor ?? this.titleColor,
      expandedTitleColor: expandedTitleColor ?? this.expandedTitleColor,
      trailingColor: trailingColor ?? this.trailingColor,
      expandedTrailingColor: expandedTrailingColor ?? this.expandedTrailingColor,
      contentColor: contentColor ?? this.contentColor,
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
      leadingColor: colorPremulLerp(leadingColor, other.leadingColor, t)!,
      expandedLeadingColor: colorPremulLerp(expandedLeadingColor, other.expandedLeadingColor, t)!,
      titleColor: colorPremulLerp(titleColor, other.titleColor, t)!,
      expandedTitleColor: colorPremulLerp(expandedTitleColor, other.expandedTitleColor, t)!,
      trailingColor: colorPremulLerp(trailingColor, other.trailingColor, t)!,
      expandedTrailingColor: colorPremulLerp(expandedTrailingColor, other.expandedTrailingColor, t)!,
      contentColor: colorPremulLerp(contentColor, other.contentColor, t)!,
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
      ..add(ColorProperty("leadingColor", leadingColor))
      ..add(ColorProperty("expandedLeadingColor", expandedLeadingColor))
      ..add(ColorProperty("titleColor", titleColor))
      ..add(ColorProperty("expandedTitleColor", expandedTitleColor))
      ..add(ColorProperty("trailingColor", trailingColor))
      ..add(ColorProperty("expandedTrailingColor", expandedTrailingColor))
      ..add(ColorProperty("contentColor", contentColor))
      ..add(ColorProperty("trailingIconColor", trailingIconColor))
      ..add(ColorProperty("expandedTrailingIconColor", expandedTrailingIconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("expandedBackgroundColor", expandedBackgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("dividerColor", dividerColor));
  }
}
