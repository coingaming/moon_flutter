import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonAuthCodeColors extends ThemeExtension<MoonAuthCodeColors> with DiagnosticableTreeMixin {
  /// The border color of the selected MoonAuthCode input field.
  final Color selectedBorderColor;

  /// The border color of the MoonAuthCode input field with input.
  final Color activeBorderColor;

  /// The border color of the MoonAuthCode input field without input.
  final Color inactiveBorderColor;

  /// The border color of the MoonAuthCode input field in error state.
  final Color errorBorderColor;

  /// The fill color of the selected MoonAuthCode input field.
  final Color selectedFillColor;

  /// The fill color of the MoonAuthCode input field with input.
  final Color activeFillColor;

  /// The fill color of the MoonAuthCode input field without input.
  final Color inactiveFillColor;

  /// The text color of the MoonAuthCode.
  final Color textColor;

  const MoonAuthCodeColors({
    required this.selectedBorderColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorBorderColor,
    required this.selectedFillColor,
    required this.activeFillColor,
    required this.inactiveFillColor,
    required this.textColor,
  });

  @override
  MoonAuthCodeColors copyWith({
    Color? selectedBorderColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorBorderColor,
    Color? selectedFillColor,
    Color? activeFillColor,
    Color? inactiveFillColor,
    Color? textColor,
  }) {
    return MoonAuthCodeColors(
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      selectedFillColor: selectedFillColor ?? this.selectedFillColor,
      activeFillColor: activeFillColor ?? this.activeFillColor,
      inactiveFillColor: inactiveFillColor ?? this.inactiveFillColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonAuthCodeColors lerp(ThemeExtension<MoonAuthCodeColors>? other, double t) {
    if (other is! MoonAuthCodeColors) return this;

    return MoonAuthCodeColors(
      selectedBorderColor: colorPremulLerp(selectedBorderColor, other.selectedBorderColor, t)!,
      activeBorderColor: colorPremulLerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: colorPremulLerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorBorderColor: colorPremulLerp(errorBorderColor, other.errorBorderColor, t)!,
      selectedFillColor: colorPremulLerp(selectedFillColor, other.selectedFillColor, t)!,
      activeFillColor: colorPremulLerp(activeFillColor, other.activeFillColor, t)!,
      inactiveFillColor: colorPremulLerp(inactiveFillColor, other.inactiveFillColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAuthCodeColors"))
      ..add(ColorProperty("selectedBorderColor", selectedBorderColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("errorBorderColor", errorBorderColor))
      ..add(ColorProperty("selectedFillColor", selectedFillColor))
      ..add(ColorProperty("activeFillColor", activeFillColor))
      ..add(ColorProperty("inactiveFillColor", inactiveFillColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
