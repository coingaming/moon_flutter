import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonToastColors extends ThemeExtension<MoonToastColors> with DiagnosticableTreeMixin {
  static final light = MoonToastColors(
    lightVariantBackgroundColor: MoonColors.light.gohan,
    darkVariantBackgroundColor: MoonColors.dark.gohan,
  );

  static final dark = MoonToastColors(
    lightVariantBackgroundColor: MoonColors.dark.gohan,
    darkVariantBackgroundColor: MoonColors.light.gohan,
  );

  /// Toast light variant background color.
  final Color lightVariantBackgroundColor;

  /// Toast dark variant background color.
  final Color darkVariantBackgroundColor;

  const MoonToastColors({
    required this.lightVariantBackgroundColor,
    required this.darkVariantBackgroundColor,
  });

  @override
  MoonToastColors copyWith({
    Color? lightVariantBackgroundColor,
    Color? darkVariantBackgroundColor,
  }) {
    return MoonToastColors(
      lightVariantBackgroundColor: lightVariantBackgroundColor ?? this.lightVariantBackgroundColor,
      darkVariantBackgroundColor: darkVariantBackgroundColor ?? this.darkVariantBackgroundColor,
    );
  }

  @override
  MoonToastColors lerp(ThemeExtension<MoonToastColors>? other, double t) {
    if (other is! MoonToastColors) return this;

    return MoonToastColors(
      lightVariantBackgroundColor: colorPremulLerp(lightVariantBackgroundColor, other.lightVariantBackgroundColor, t)!,
      darkVariantBackgroundColor: colorPremulLerp(darkVariantBackgroundColor, other.darkVariantBackgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonToastColors"))
      ..add(ColorProperty("lightVariantBackgroundColor", lightVariantBackgroundColor))
      ..add(ColorProperty("darkVariantBackgroundColor", darkVariantBackgroundColor));
  }
}
