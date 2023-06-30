import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCarouselItemColors extends ThemeExtension<MoonCarouselItemColors> with DiagnosticableTreeMixin {
  static final light = MoonCarouselItemColors(
    backgroundColor: MoonColors.light.gohan,
    textColor: MoonTypography.light.colors.bodyPrimary,
  );

  static final dark = MoonCarouselItemColors(
    backgroundColor: MoonColors.dark.gohan,
    textColor: MoonTypography.dark.colors.bodyPrimary,
  );

  /// Background color of Carousel item.
  final Color backgroundColor;

  /// Default text color of Carousel items.
  final Color textColor;

  const MoonCarouselItemColors({
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  MoonCarouselItemColors copyWith({
    Color? backgroundColor,
    Color? textColor,
  }) {
    return MoonCarouselItemColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonCarouselItemColors lerp(ThemeExtension<MoonCarouselItemColors>? other, double t) {
    if (other is! MoonCarouselItemColors) return this;

    return MoonCarouselItemColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCarouselItemColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
