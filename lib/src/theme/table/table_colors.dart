import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonTableColors extends ThemeExtension<MoonTableColors> with DiagnosticableTreeMixin {
  /// Table column text color.
  final Color columnTextColor;

  /// Table row text color.
  final Color rowTextColor;

  /// Table row label text color.
  final Color rowLabelTextColor;

  /// Table row pinned and animated label text color.
  final Color rowPinnedAnimatedLabelTextColor;

  /// Table icon color.
  final Color iconColor;

  /// Table row background color.
  final Color rowBackgroundColor;

  const MoonTableColors({
    required this.columnTextColor,
    required this.rowTextColor,
    required this.rowLabelTextColor,
    required this.rowPinnedAnimatedLabelTextColor,
    required this.iconColor,
    required this.rowBackgroundColor,
  });

  @override
  MoonTableColors copyWith({
    Color? columnTextColor,
    Color? rowTextColor,
    Color? rowLabelTextColor,
    Color? rowPinnedAnimatedLabelTextColor,
    Color? iconColor,
    Color? rowBackgroundColor,
  }) {
    return MoonTableColors(
      columnTextColor: columnTextColor ?? this.columnTextColor,
      rowTextColor: rowTextColor ?? this.rowTextColor,
      rowLabelTextColor: rowLabelTextColor ?? this.rowLabelTextColor,
      rowPinnedAnimatedLabelTextColor: rowPinnedAnimatedLabelTextColor ?? this.rowPinnedAnimatedLabelTextColor,
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
      rowLabelTextColor: colorPremulLerp(rowLabelTextColor, other.rowLabelTextColor, t)!,
      rowPinnedAnimatedLabelTextColor:
          colorPremulLerp(rowPinnedAnimatedLabelTextColor, other.rowPinnedAnimatedLabelTextColor, t)!,
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
      ..add(ColorProperty("rowLabelTextColor", rowLabelTextColor))
      ..add(ColorProperty("rowPinnedAnimatedLabelTextColor", rowPinnedAnimatedLabelTextColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("rowBackgroundColor", rowBackgroundColor));
  }
}
