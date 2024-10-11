import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonChipColors extends ThemeExtension<MoonChipColors>
    with DiagnosticableTreeMixin {
  /// The text and border color of the MoonChip in active state.
  final Color activeColor;

  /// The background color of the MoonChip.
  final Color backgroundColor;

  /// The background color of the MoonChip in active state.
  final Color activeBackgroundColor;

  /// The text color of the MoonChip.
  final Color textColor;

  const MoonChipColors({
    required this.activeColor,
    required this.backgroundColor,
    required this.activeBackgroundColor,
    required this.textColor,
  });

  @override
  MoonChipColors copyWith({
    Color? activeColor,
    Color? backgroundColor,
    Color? activeBackgroundColor,
    Color? textColor,
  }) {
    return MoonChipColors(
      activeColor: activeColor ?? this.activeColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBackgroundColor:
          activeBackgroundColor ?? this.activeBackgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonChipColors lerp(ThemeExtension<MoonChipColors>? other, double t) {
    if (other is! MoonChipColors) return this;

    return MoonChipColors(
      activeColor: colorPremulLerp(activeColor, other.activeColor, t)!,
      backgroundColor:
          colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      activeBackgroundColor: colorPremulLerp(
        activeBackgroundColor,
        other.activeBackgroundColor,
        t,
      )!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipColors"))
      ..add(ColorProperty("activeColor", activeColor))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("activeBackgroundColor", activeBackgroundColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
