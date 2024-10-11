import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCarouselColors extends ThemeExtension<MoonCarouselColors>
    with DiagnosticableTreeMixin {
  /// The text color of the MoonCarousel items.
  final Color textColor;

  /// The icon color of the MoonCarousel items.
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
