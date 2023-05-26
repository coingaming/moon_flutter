import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonButtonColors extends ThemeExtension<MoonButtonColors> with DiagnosticableTreeMixin {
  static final light = MoonButtonColors(
    borderColor: MoonColors.light.trunks,
    textColor: MoonTypography.light.colors.bodyPrimary,
    filledVariantBackgroundColor: MoonColors.light.piccolo,
    filledVariantTextColor: MoonTypography.light.colors.controlPrimary,
    textVariantTextColor: MoonTypography.light.colors.bodySecondary,
    textVariantFocusColor: MoonColors.light.piccolo,
    textVariantHoverColor: MoonColors.light.jiren,
  );

  static final dark = MoonButtonColors(
    borderColor: MoonColors.dark.trunks,
    textColor: MoonTypography.dark.colors.bodyPrimary,
    filledVariantBackgroundColor: MoonColors.dark.piccolo,
    filledVariantTextColor: MoonTypography.dark.colors.controlPrimary,
    textVariantTextColor: MoonTypography.dark.colors.bodySecondary,
    textVariantFocusColor: MoonColors.dark.piccolo,
    textVariantHoverColor: MoonColors.dark.jiren,
  );

  /// Button border color.
  final Color borderColor;

  /// Button text color.
  final Color textColor;

  /// Filled button background color.
  final Color filledVariantBackgroundColor;

  /// Filled button text color.
  final Color filledVariantTextColor;

  /// Text button focus effect color.
  final Color textVariantFocusColor;

  /// Text button hover effect color.
  final Color textVariantHoverColor;

  /// Text button text color.
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
