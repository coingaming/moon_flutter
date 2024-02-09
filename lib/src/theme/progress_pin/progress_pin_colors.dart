import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonProgressPinColors extends ThemeExtension<MoonProgressPinColors> with DiagnosticableTreeMixin {
  /// The color of the MoonProgressPin.
  final Color pinColor;

  /// The border color of the MoonProgressPin.
  final Color pinBorderColor;

  /// The color of the MoonProgressPin thumb.
  final Color thumbColor;

  /// The shadow color of the MoonProgressPin.
  final Color shadowColor;

  /// The text color of the MoonProgressPin.
  final Color textColor;

  const MoonProgressPinColors({
    required this.pinColor,
    required this.pinBorderColor,
    required this.thumbColor,
    required this.shadowColor,
    required this.textColor,
  });

  @override
  MoonProgressPinColors copyWith({
    Color? pinColor,
    Color? pinBorderColor,
    Color? thumbColor,
    Color? shadowColor,
    Color? textColor,
  }) {
    return MoonProgressPinColors(
      pinColor: pinColor ?? this.pinColor,
      pinBorderColor: pinBorderColor ?? this.pinBorderColor,
      thumbColor: thumbColor ?? this.thumbColor,
      shadowColor: shadowColor ?? this.shadowColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonProgressPinColors lerp(ThemeExtension<MoonProgressPinColors>? other, double t) {
    if (other is! MoonProgressPinColors) return this;

    return MoonProgressPinColors(
      pinColor: colorPremulLerp(pinColor, other.pinColor, t)!,
      pinBorderColor: colorPremulLerp(pinBorderColor, other.pinBorderColor, t)!,
      thumbColor: colorPremulLerp(thumbColor, other.thumbColor, t)!,
      shadowColor: colorPremulLerp(shadowColor, other.shadowColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonProgressPinColors"))
      ..add(ColorProperty("pinColor", pinColor))
      ..add(ColorProperty("pinBorderColor", pinBorderColor))
      ..add(ColorProperty("thumbColor", thumbColor))
      ..add(ColorProperty("shadowColor", shadowColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
