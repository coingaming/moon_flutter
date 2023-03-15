import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonCheckboxColors extends ThemeExtension<MoonCheckboxColors> with DiagnosticableTreeMixin {
  static final light = MoonCheckboxColors(
    activeColor: MoonColors.light.piccolo,
    checkColor: MoonColors.light.goten,
    fillColor: Colors.transparent,
    borderColor: MoonColors.light.trunks,
  );

  static final dark = MoonCheckboxColors(
    activeColor: MoonColors.dark.piccolo,
    checkColor: MoonColors.dark.goten,
    fillColor: Colors.transparent,
    borderColor: MoonColors.dark.trunks,
  );

  /// Checkbox active color.
  final Color activeColor;

  /// Checkbox border color.
  final Color borderColor;

  /// Checkbox icon color.
  final Color checkColor;

  /// Checkbox fill (inactive) color.
  final Color fillColor;

  const MoonCheckboxColors({
    required this.activeColor,
    required this.borderColor,
    required this.checkColor,
    required this.fillColor,
  });

  @override
  MoonCheckboxColors copyWith({
    Color? activeColor,
    Color? borderColor,
    Color? checkColor,
    Color? fillColor,
  }) {
    return MoonCheckboxColors(
      activeColor: activeColor ?? this.activeColor,
      borderColor: borderColor ?? this.borderColor,
      checkColor: checkColor ?? this.checkColor,
      fillColor: fillColor ?? this.fillColor,
    );
  }

  @override
  MoonCheckboxColors lerp(ThemeExtension<MoonCheckboxColors>? other, double t) {
    if (other is! MoonCheckboxColors) return this;

    return MoonCheckboxColors(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      checkColor: Color.lerp(checkColor, other.checkColor, t)!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCheckboxColors"))
      ..add(ColorProperty("activeColor", activeColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("checkColor", checkColor))
      ..add(ColorProperty("fillColor", fillColor));
  }
}
