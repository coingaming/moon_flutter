import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonToastColors extends ThemeExtension<MoonToastColors> with DiagnosticableTreeMixin {
  static final light = MoonToastColors(
    lightVariantBackgroundColor: MoonColors.light.gohan,
    darkVariantBackgroundColor: MoonColors.dark.gohan,
    lightVariantTextColor: MoonTypography.light.colors.bodyPrimary,
    darkVariantTextColor: MoonTypography.dark.colors.bodyPrimary,
  );

  static final dark = MoonToastColors(
    lightVariantBackgroundColor: MoonColors.dark.gohan,
    darkVariantBackgroundColor: MoonColors.light.gohan,
    lightVariantTextColor: MoonTypography.dark.colors.bodyPrimary,
    darkVariantTextColor: MoonTypography.light.colors.bodyPrimary,
  );

  /// Toast light variant background color.
  final Color lightVariantBackgroundColor;

  /// Toast dark variant background color.
  final Color darkVariantBackgroundColor;

  /// Toast light variant text color.
  final Color lightVariantTextColor;

  /// Toast dark variant text color.
  final Color darkVariantTextColor;

  const MoonToastColors({
    required this.lightVariantBackgroundColor,
    required this.darkVariantBackgroundColor,
    required this.lightVariantTextColor,
    required this.darkVariantTextColor,
  });

  @override
  MoonToastColors copyWith({
    Color? lightVariantBackgroundColor,
    Color? darkVariantBackgroundColor,
    Color? lightVariantTextColor,
    Color? darkVariantTextColor,
  }) {
    return MoonToastColors(
      lightVariantBackgroundColor: lightVariantBackgroundColor ?? this.lightVariantBackgroundColor,
      darkVariantBackgroundColor: darkVariantBackgroundColor ?? this.darkVariantBackgroundColor,
      lightVariantTextColor: lightVariantTextColor ?? this.lightVariantTextColor,
      darkVariantTextColor: darkVariantTextColor ?? this.darkVariantTextColor,
    );
  }

  @override
  MoonToastColors lerp(ThemeExtension<MoonToastColors>? other, double t) {
    if (other is! MoonToastColors) return this;

    return MoonToastColors(
      lightVariantBackgroundColor: colorPremulLerp(lightVariantBackgroundColor, other.lightVariantBackgroundColor, t)!,
      darkVariantBackgroundColor: colorPremulLerp(darkVariantBackgroundColor, other.darkVariantBackgroundColor, t)!,
      lightVariantTextColor: colorPremulLerp(lightVariantTextColor, other.lightVariantTextColor, t)!,
      darkVariantTextColor: colorPremulLerp(darkVariantTextColor, other.darkVariantTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonToastColors"))
      ..add(ColorProperty("lightVariantBackgroundColor", lightVariantBackgroundColor))
      ..add(ColorProperty("darkVariantBackgroundColor", darkVariantBackgroundColor))
      ..add(ColorProperty("lightVariantTextColor", lightVariantTextColor))
      ..add(ColorProperty("darkVariantTextColor", darkVariantTextColor));
  }
}
