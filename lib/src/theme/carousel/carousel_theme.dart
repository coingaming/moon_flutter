import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/carousel/carousel_colors.dart';
import 'package:moon_design/src/theme/carousel/carousel_properties.dart';

@immutable
class MoonCarouselTheme extends ThemeExtension<MoonCarouselTheme> with DiagnosticableTreeMixin {
  static final light = MoonCarouselTheme(
    colors: MoonCarouselColors.light,
    properties: MoonCarouselProperties.properties,
  );

  static final dark = MoonCarouselTheme(
    colors: MoonCarouselColors.dark,
    properties: MoonCarouselProperties.properties,
  );

  /// Carousel colors.
  final MoonCarouselColors colors;

  /// Carousel properties.
  final MoonCarouselProperties properties;

  const MoonCarouselTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonCarouselTheme copyWith({
    MoonCarouselColors? colors,
    MoonCarouselProperties? properties,
  }) {
    return MoonCarouselTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonCarouselTheme lerp(ThemeExtension<MoonCarouselTheme>? other, double t) {
    if (other is! MoonCarouselTheme) return this;

    return MoonCarouselTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonCarouselTheme"))
      ..add(DiagnosticsProperty<MoonCarouselColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCarouselProperties>("properties", properties));
  }
}
