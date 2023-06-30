import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/carousel/carousel_item_colors.dart';
import 'package:moon_design/src/theme/carousel/carousel_item_properties.dart';
import 'package:moon_design/src/theme/carousel/carousel_properties.dart';

@immutable
class MoonCarouselTheme extends ThemeExtension<MoonCarouselTheme> with DiagnosticableTreeMixin {
  static final light = MoonCarouselTheme(
    properties: MoonCarouselProperties.properties,
    itemColors: MoonCarouselItemColors.light,
    itemProperties: MoonCarouselItemProperties.properties,
  );

  static final dark = MoonCarouselTheme(
    properties: MoonCarouselProperties.properties,
    itemColors: MoonCarouselItemColors.dark,
    itemProperties: MoonCarouselItemProperties.properties,
  );

  /// Carousel properties.
  final MoonCarouselProperties properties;

  /// Carousel item colors.
  final MoonCarouselItemColors itemColors;

  /// Carousel item properties.
  final MoonCarouselItemProperties itemProperties;

  const MoonCarouselTheme({
    required this.properties,
    required this.itemColors,
    required this.itemProperties,
  });

  @override
  MoonCarouselTheme copyWith({
    MoonCarouselProperties? properties,
    MoonCarouselItemColors? itemColors,
    MoonCarouselItemProperties? itemProperties,
  }) {
    return MoonCarouselTheme(
      properties: properties ?? this.properties,
      itemColors: itemColors ?? this.itemColors,
      itemProperties: itemProperties ?? this.itemProperties,
    );
  }

  @override
  MoonCarouselTheme lerp(ThemeExtension<MoonCarouselTheme>? other, double t) {
    if (other is! MoonCarouselTheme) return this;

    return MoonCarouselTheme(
      properties: properties.lerp(other.properties, t),
      itemColors: itemColors.lerp(other.itemColors, t),
      itemProperties: itemProperties.lerp(other.itemProperties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonCarouselTheme"))
      ..add(DiagnosticsProperty<MoonCarouselProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonCarouselItemColors>("itemColors", itemColors))
      ..add(DiagnosticsProperty<MoonCarouselItemProperties>("itemProperties", itemProperties));
  }
}
