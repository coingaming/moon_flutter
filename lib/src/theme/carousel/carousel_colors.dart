import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonCarouselColors extends ThemeExtension<MoonCarouselColors> with DiagnosticableTreeMixin {
  static final light = MoonCarouselColors(
    itemBackgroundColor: MoonColors.light.goku,
    textColor: MoonTypography.light.colors.bodyPrimary,
  );

  static final dark = MoonCarouselColors(
    itemBackgroundColor: MoonColors.dark.goku,
    textColor: MoonTypography.dark.colors.bodyPrimary,
  );

  /// Background color of Carousel item.
  final Color itemBackgroundColor;

  /// Default text color of Carousel items.
  final Color textColor;

  const MoonCarouselColors({
    required this.itemBackgroundColor,
    required this.textColor,
  });

  @override
  MoonCarouselColors copyWith({
    Color? itemBackgroundColor,
    Color? textColor,
  }) {
    return MoonCarouselColors(
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonCarouselColors lerp(ThemeExtension<MoonCarouselColors>? other, double t) {
    if (other is! MoonCarouselColors) return this;

    return MoonCarouselColors(
      itemBackgroundColor: colorPremulLerp(itemBackgroundColor, other.itemBackgroundColor, t)!,
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCarouselColors"))
      ..add(ColorProperty("itemBackgroundColor", itemBackgroundColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
