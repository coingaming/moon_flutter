import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAccordionColors extends ThemeExtension<MoonAccordionColors> with DiagnosticableTreeMixin {
  /// Accordion background color.
  final Color backgroundColor;

  /// Expanded accordion background color.
  final Color expandedBackgroundColor;

  /// Accordion border color.
  final Color borderColor;

  /// Accordion divider color.
  final Color dividerColor;

  /// Accordion header text color.
  final Color headerTextColor;

  /// Expanded accordion header text color.
  final Color expandedHeaderTextColor;

  /// Accordion content text color.
  final Color contentTextColor;

  /// Accordion trailing icon color.
  final Color trailingIconColor;

  /// Expanded accordion trailing icon color.
  final Color expandedTrailingIconColor;

  const MoonAccordionColors({
    required this.backgroundColor,
    required this.expandedBackgroundColor,
    required this.borderColor,
    required this.dividerColor,
    required this.headerTextColor,
    required this.expandedHeaderTextColor,
    required this.contentTextColor,
    required this.trailingIconColor,
    required this.expandedTrailingIconColor,
  });

  @override
  MoonAccordionColors copyWith({
    Color? backgroundColor,
    Color? expandedBackgroundColor,
    Color? borderColor,
    Color? dividerColor,
    Color? headerTextColor,
    Color? expandedHeaderTextColor,
    Color? contentTextColor,
    Color? trailingIconColor,
    Color? expandedTrailingIconColor,
  }) {
    return MoonAccordionColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      expandedBackgroundColor: expandedBackgroundColor ?? this.expandedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      expandedHeaderTextColor: expandedHeaderTextColor ?? this.expandedHeaderTextColor,
      contentTextColor: contentTextColor ?? this.contentTextColor,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      expandedTrailingIconColor: expandedTrailingIconColor ?? this.expandedTrailingIconColor,
    );
  }

  @override
  MoonAccordionColors lerp(ThemeExtension<MoonAccordionColors>? other, double t) {
    if (other is! MoonAccordionColors) return this;

    return MoonAccordionColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      expandedBackgroundColor: colorPremulLerp(expandedBackgroundColor, other.expandedBackgroundColor, t)!,
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      dividerColor: colorPremulLerp(dividerColor, other.dividerColor, t)!,
      headerTextColor: colorPremulLerp(headerTextColor, other.headerTextColor, t)!,
      expandedHeaderTextColor: colorPremulLerp(expandedHeaderTextColor, other.expandedHeaderTextColor, t)!,
      contentTextColor: colorPremulLerp(contentTextColor, other.contentTextColor, t)!,
      trailingIconColor: colorPremulLerp(trailingIconColor, other.trailingIconColor, t)!,
      expandedTrailingIconColor: colorPremulLerp(expandedTrailingIconColor, other.expandedTrailingIconColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("expandedBackgroundColor", expandedBackgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("dividerColor", dividerColor))
      ..add(ColorProperty("headerTextColor", headerTextColor))
      ..add(ColorProperty("expandedHeaderTextColor", expandedHeaderTextColor))
      ..add(ColorProperty("contentTextColor", contentTextColor))
      ..add(ColorProperty("trailingIconColor", trailingIconColor))
      ..add(ColorProperty("expandedTrailingIconColor", expandedTrailingIconColor));
  }
}
