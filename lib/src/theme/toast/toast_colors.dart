import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonToastColors extends ThemeExtension<MoonToastColors> with DiagnosticableTreeMixin {
  /// Toast light variant background color.
  final Color lightVariantBackgroundColor;

  /// Toast dark variant background color.
  final Color darkVariantBackgroundColor;

  /// Toast light variant text color.
  final Color lightVariantTextColor;

  /// Toast dark variant text color.
  final Color darkVariantTextColor;

  /// Toast light variant icon color.
  final Color lightVariantIconColor;

  /// Toast dark variant icon color.
  final Color darkVariantIconColor;

  const MoonToastColors({
    required this.lightVariantBackgroundColor,
    required this.darkVariantBackgroundColor,
    required this.lightVariantTextColor,
    required this.darkVariantTextColor,
    required this.lightVariantIconColor,
    required this.darkVariantIconColor,
  });

  @override
  MoonToastColors copyWith({
    Color? lightVariantBackgroundColor,
    Color? darkVariantBackgroundColor,
    Color? lightVariantTextColor,
    Color? darkVariantTextColor,
    Color? lightVariantIconColor,
    Color? darkVariantIconColor,
  }) {
    return MoonToastColors(
      lightVariantBackgroundColor: lightVariantBackgroundColor ?? this.lightVariantBackgroundColor,
      darkVariantBackgroundColor: darkVariantBackgroundColor ?? this.darkVariantBackgroundColor,
      lightVariantTextColor: lightVariantTextColor ?? this.lightVariantTextColor,
      darkVariantTextColor: darkVariantTextColor ?? this.darkVariantTextColor,
      lightVariantIconColor: lightVariantIconColor ?? this.lightVariantIconColor,
      darkVariantIconColor: darkVariantIconColor ?? this.darkVariantIconColor,
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
      lightVariantIconColor: colorPremulLerp(lightVariantIconColor, other.lightVariantIconColor, t)!,
      darkVariantIconColor: colorPremulLerp(darkVariantIconColor, other.darkVariantIconColor, t)!,
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
      ..add(ColorProperty("darkVariantTextColor", darkVariantTextColor))
      ..add(ColorProperty("lightVariantIconColor", lightVariantIconColor))
      ..add(ColorProperty("darkVariantIconColor", darkVariantIconColor));
  }
}
