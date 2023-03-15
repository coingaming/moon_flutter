import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonCheckboxColors extends ThemeExtension<MoonCheckboxColors> with DiagnosticableTreeMixin {
  static final light = MoonCheckboxColors(
    activeColor: MoonColors.light.piccolo,
    fillColor: Colors.transparent,
    iconColor: MoonColors.light.goten,
    borderColor: MoonColors.light.trunks,
  );

  static final dark = MoonCheckboxColors(
    activeColor: MoonColors.dark.piccolo,
    fillColor: Colors.transparent,
    iconColor: MoonColors.dark.goten,
    borderColor: MoonColors.dark.trunks,
  );

  /// Checkbox active color.
  final Color activeColor;

  /// Checkbox border color.
  final Color borderColor;

  /// Checkbox fill (inactive) color.
  final Color fillColor;

  /// Checkbox icon color.
  final Color iconColor;

  const MoonCheckboxColors({
    required this.activeColor,
    required this.borderColor,
    required this.fillColor,
    required this.iconColor,
  });

  @override
  MoonCheckboxColors copyWith({
    Color? activeColor,
    Color? borderColor,
    Color? fillColor,
    Color? iconColor,
  }) {
    return MoonCheckboxColors(
      activeColor: activeColor ?? this.activeColor,
      borderColor: borderColor ?? this.borderColor,
      fillColor: fillColor ?? this.fillColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  MoonCheckboxColors lerp(ThemeExtension<MoonCheckboxColors>? other, double t) {
    if (other is! MoonCheckboxColors) return this;

    return MoonCheckboxColors(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCheckboxColors"))
      ..add(ColorProperty("activeColor", activeColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("fillColor", fillColor))
      ..add(ColorProperty("iconColor", iconColor));
  }
}
