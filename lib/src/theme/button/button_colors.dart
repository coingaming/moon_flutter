import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonButtonColors extends ThemeExtension<MoonButtonColors> with DiagnosticableTreeMixin {
  /// The border color of the MoonButton.
  final Color borderColor;

  /// The text color of the MoonButton.
  final Color textColor;

  /// The background color of the MoonButton filled variant.
  final Color filledVariantBackgroundColor;

  /// The text color of the MoonButton filled variant.
  final Color filledVariantTextColor;

  /// The focus effect color of the MoonButton text variant.
  final Color textVariantFocusColor;

  /// The hover effect color of the MoonButton text variant.
  final Color textVariantHoverColor;

  /// The text color of the MoonButton text variant.
  final Color textVariantTextColor;

  const MoonButtonColors({
    required this.borderColor,
    required this.textColor,
    required this.filledVariantBackgroundColor,
    required this.filledVariantTextColor,
    required this.textVariantFocusColor,
    required this.textVariantHoverColor,
    required this.textVariantTextColor,
  });

  @override
  MoonButtonColors copyWith({
    Color? borderColor,
    Color? textColor,
    Color? filledVariantBackgroundColor,
    Color? filledVariantTextColor,
    Color? textVariantFocusColor,
    Color? textVariantHoverColor,
    Color? textVariantTextColor,
  }) {
    return MoonButtonColors(
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      filledVariantBackgroundColor: filledVariantBackgroundColor ?? this.filledVariantBackgroundColor,
      filledVariantTextColor: filledVariantTextColor ?? this.filledVariantTextColor,
      textVariantFocusColor: textVariantFocusColor ?? this.textVariantFocusColor,
      textVariantHoverColor: textVariantHoverColor ?? this.textVariantHoverColor,
      textVariantTextColor: textVariantTextColor ?? this.textVariantTextColor,
    );
  }

  @override
  MoonButtonColors lerp(ThemeExtension<MoonButtonColors>? other, double t) {
    if (other is! MoonButtonColors) return this;

    return MoonButtonColors(
      borderColor: colorPremulLerp(borderColor, other.borderColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      filledVariantBackgroundColor:
          colorPremulLerp(filledVariantBackgroundColor, other.filledVariantBackgroundColor, t)!,
      filledVariantTextColor: colorPremulLerp(filledVariantTextColor, other.filledVariantTextColor, t)!,
      textVariantFocusColor: colorPremulLerp(textVariantFocusColor, other.textVariantFocusColor, t)!,
      textVariantHoverColor: colorPremulLerp(textVariantHoverColor, other.textVariantHoverColor, t)!,
      textVariantTextColor: colorPremulLerp(textVariantTextColor, other.textVariantTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonColors"))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("filledVariantBackgroundColor", filledVariantBackgroundColor))
      ..add(ColorProperty("filledVariantTextColor", filledVariantTextColor))
      ..add(ColorProperty("textVariantFocusColor", textVariantFocusColor))
      ..add(ColorProperty("textVariantHoverColor", textVariantHoverColor))
      ..add(ColorProperty("textVariantTextColor", textVariantTextColor));
  }
}
