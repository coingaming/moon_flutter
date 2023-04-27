import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonCheckboxColors extends ThemeExtension<MoonCheckboxColors> with DiagnosticableTreeMixin {
  static final light = MoonCheckboxColors(
    activeColor: MoonColors.light.piccolo,
    borderColor: MoonColors.light.trunks,
    checkColor: MoonColors.light.goten,
    inactiveColor: Colors.transparent,
  );

  static final dark = MoonCheckboxColors(
    activeColor: MoonColors.dark.piccolo,
    borderColor: MoonColors.dark.trunks,
    checkColor: MoonColors.dark.goten,
    inactiveColor: Colors.transparent,
  );

  /// Checkbox active color.
  final Color activeColor;

  /// Checkbox border color.
  final Color borderColor;

  /// Checkbox icon color.
  final Color checkColor;

  /// Checkbox inactive color.
  final Color inactiveColor;

  const MoonCheckboxColors({
    required this.activeColor,
    required this.borderColor,
    required this.checkColor,
    required this.inactiveColor,
  });

  @override
  MoonCheckboxColors copyWith({
    Color? activeColor,
    Color? borderColor,
    Color? checkColor,
    Color? inactiveColor,
  }) {
    return MoonCheckboxColors(
      activeColor: activeColor ?? this.activeColor,
      borderColor: borderColor ?? this.borderColor,
      checkColor: checkColor ?? this.checkColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }

  @override
  MoonCheckboxColors lerp(ThemeExtension<MoonCheckboxColors>? other, double t) {
    if (other is! MoonCheckboxColors) return this;

    return MoonCheckboxColors(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      checkColor: Color.lerp(checkColor, other.checkColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
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
      ..add(ColorProperty("inactiveColor", inactiveColor));
  }
}
