import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonRadioColors extends ThemeExtension<MoonRadioColors>
    with DiagnosticableTreeMixin {
  /// The color of the selected MoonRadio button.
  final Color activeColor;

  /// The background color of the unselected MoonRadio button.
  final Color inactiveColor;

  const MoonRadioColors({
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  MoonRadioColors copyWith({Color? activeColor, Color? inactiveColor}) {
    return MoonRadioColors(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }

  @override
  MoonRadioColors lerp(ThemeExtension<MoonRadioColors>? other, double t) {
    if (other is! MoonRadioColors) return this;

    return MoonRadioColors(
      activeColor: colorPremulLerp(activeColor, other.activeColor, t)!,
      inactiveColor: colorPremulLerp(inactiveColor, other.inactiveColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonRadioColors"))
      ..add(ColorProperty("activeColor", activeColor))
      ..add(ColorProperty("inactiveColor", inactiveColor));
  }
}
