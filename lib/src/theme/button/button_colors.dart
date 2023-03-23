import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonButtonColors extends ThemeExtension<MoonButtonColors> with DiagnosticableTreeMixin {
  static final light = MoonButtonColors(
    borderColor: MoonColors.light.trunks,
    filledVariantBackgroundColor: MoonColors.light.piccolo,
    textVariantTextColor: MoonColors.light.trunks,
    textVariantFocusColor: MoonColors.light.piccolo,
    textVariantHoverColor: MoonColors.light.jiren,
  );

  static final dark = MoonButtonColors(
    borderColor: MoonColors.dark.trunks,
    filledVariantBackgroundColor: MoonColors.dark.piccolo,
    textVariantTextColor: MoonColors.dark.trunks,
    textVariantFocusColor: MoonColors.dark.piccolo,
    textVariantHoverColor: MoonColors.dark.jiren,
  );

  /// Button border color.
  final Color borderColor;

  /// Filled button background color.
  final Color filledVariantBackgroundColor;

  /// Text button text color.
  final Color textVariantTextColor;

  /// Text button focus effect color.
  final Color textVariantFocusColor;

  /// Text button hover effect color.
  final Color textVariantHoverColor;

  const MoonButtonColors({
    required this.borderColor,
    required this.filledVariantBackgroundColor,
    required this.textVariantTextColor,
    required this.textVariantFocusColor,
    required this.textVariantHoverColor,
  });

  @override
  MoonButtonColors copyWith({
    Color? borderColor,
    Color? filledVariantBackgroundColor,
    Color? textVariantTextColor,
    Color? textVariantFocusColor,
    Color? textVariantHoverColor,
  }) {
    return MoonButtonColors(
      borderColor: borderColor ?? this.borderColor,
      filledVariantBackgroundColor: filledVariantBackgroundColor ?? this.filledVariantBackgroundColor,
      textVariantTextColor: textVariantTextColor ?? this.textVariantTextColor,
      textVariantFocusColor: textVariantFocusColor ?? this.textVariantFocusColor,
      textVariantHoverColor: textVariantHoverColor ?? this.textVariantHoverColor,
    );
  }

  @override
  MoonButtonColors lerp(ThemeExtension<MoonButtonColors>? other, double t) {
    if (other is! MoonButtonColors) return this;

    return MoonButtonColors(
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      filledVariantBackgroundColor: Color.lerp(filledVariantBackgroundColor, other.filledVariantBackgroundColor, t)!,
      textVariantTextColor: Color.lerp(textVariantTextColor, other.textVariantTextColor, t)!,
      textVariantFocusColor: Color.lerp(textVariantFocusColor, other.textVariantFocusColor, t)!,
      textVariantHoverColor: Color.lerp(textVariantHoverColor, other.textVariantHoverColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonColors"))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("filledVariantBackgroundColor", filledVariantBackgroundColor))
      ..add(ColorProperty("textVariantTextColor", textVariantTextColor))
      ..add(ColorProperty("textVariantFocusColor", textVariantFocusColor))
      ..add(ColorProperty("textVariantHoverColor", textVariantHoverColor));
  }
}
