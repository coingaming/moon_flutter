import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/iconography/iconography.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCarouselColors extends ThemeExtension<MoonCarouselColors> with DiagnosticableTreeMixin {
  static final light = MoonCarouselColors(
    textColor: MoonTypography.light.colors.bodyPrimary,
    iconColor: MoonIconography.light.colors.primaryColor,
  );

  static final dark = MoonCarouselColors(
    textColor: MoonTypography.dark.colors.bodyPrimary,
    iconColor: MoonIconography.dark.colors.primaryColor,
  );

  /// Default text color of Carousel items.
  final Color textColor;

  /// Carousel item icon color.
  final Color iconColor;

  const MoonCarouselColors({
    required this.textColor,
    required this.iconColor,
  });

  @override
  MoonCarouselColors copyWith({
    Color? textColor,
    Color? iconColor,
  }) {
    return MoonCarouselColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  MoonCarouselColors lerp(ThemeExtension<MoonCarouselColors>? other, double t) {
    if (other is! MoonCarouselColors) return this;

    return MoonCarouselColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCarouselColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor));
  }
}
