import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTableColors extends ThemeExtension<MoonTableColors> with DiagnosticableTreeMixin {
  /// Table column text color.
  final Color columnTextColor;

  /// Table row text color.
  final Color rowTextColor;

  /// Table row title text color.
  final Color rowTitleTextColor;

  /// Table row pinned and animated title text color.
  final Color rowPinnedAnimatedTitleTextColor;

  /// Table icon color.
  final Color iconColor;

  /// Table row background color.
  final Color rowBackgroundColor;

  const MoonTableColors({
    required this.columnTextColor,
    required this.rowTextColor,
    required this.rowTitleTextColor,
    required this.rowPinnedAnimatedTitleTextColor,
    required this.iconColor,
    required this.rowBackgroundColor,
  });

  @override
  MoonTableColors copyWith({
    Color? columnTextColor,
    Color? rowTextColor,
    Color? rowTitleTextColor,
    Color? rowPinnedAnimatedTitleTextColor,
    Color? iconColor,
    Color? rowBackgroundColor,
  }) {
    return MoonTableColors(
      columnTextColor: columnTextColor ?? this.columnTextColor,
      rowTextColor: rowTextColor ?? this.rowTextColor,
      rowTitleTextColor: rowTitleTextColor ?? this.rowTitleTextColor,
      rowPinnedAnimatedTitleTextColor: rowPinnedAnimatedTitleTextColor ?? this.rowPinnedAnimatedTitleTextColor,
      iconColor: iconColor ?? this.iconColor,
      rowBackgroundColor: rowBackgroundColor ?? this.rowBackgroundColor,
    );
  }

  @override
  MoonTableColors lerp(ThemeExtension<MoonTableColors>? other, double t) {
    if (other is! MoonTableColors) return this;

    return MoonTableColors(
      columnTextColor: colorPremulLerp(columnTextColor, other.columnTextColor, t)!,
      rowTextColor: colorPremulLerp(rowTextColor, other.rowTextColor, t)!,
      rowTitleTextColor:
          colorPremulLerp(rowTitleTextColor, other.rowTitleTextColor, t)!,
      rowPinnedAnimatedTitleTextColor:
          colorPremulLerp(rowPinnedAnimatedTitleTextColor, other.rowPinnedAnimatedTitleTextColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      rowBackgroundColor: colorPremulLerp(rowBackgroundColor, other.rowBackgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTableColors"))
      ..add(ColorProperty("columnTextColor", columnTextColor))
      ..add(ColorProperty("rowTextColor", rowTextColor))
      ..add(ColorProperty("rowTitleTextColor", rowTitleTextColor))
      ..add(ColorProperty("rowPinnedAnimatedTitleTextColor", rowPinnedAnimatedTitleTextColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("rowBackgroundColor", rowBackgroundColor));
  }
}
