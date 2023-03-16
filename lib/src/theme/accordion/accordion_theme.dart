import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_colors.dart';
import 'package:moon_design/src/theme/accordion/accordion_properties.dart';
import 'package:moon_design/src/theme/accordion/accordion_sizes.dart';

@immutable
class MoonAccordionTheme extends ThemeExtension<MoonAccordionTheme> with DiagnosticableTreeMixin {
  static final light = MoonAccordionTheme(
    colors: MoonAccordionColors.light,
    properties: MoonAccordionProperties.properties,
    sizes: MoonAccordionSizes.sizes,
  );

  static final dark = MoonAccordionTheme(
    colors: MoonAccordionColors.dark,
    properties: MoonAccordionProperties.properties,
    sizes: MoonAccordionSizes.sizes,
  );

  /// Accordion colors.
  final MoonAccordionColors colors;

  /// Accordion properties.
  final MoonAccordionProperties properties;

  /// Accordion sizes.
  final MoonAccordionSizes sizes;

  const MoonAccordionTheme({
    required this.colors,
    required this.properties,
    required this.sizes,
  });

  @override
  MoonAccordionTheme copyWith({
    MoonAccordionColors? colors,
    MoonAccordionProperties? properties,
    MoonAccordionSizes? sizes,
  }) {
    return MoonAccordionTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonAccordionTheme lerp(ThemeExtension<MoonAccordionTheme>? other, double t) {
    if (other is! MoonAccordionTheme) return this;

    return MoonAccordionTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAccordionTheme"))
      ..add(DiagnosticsProperty<MoonAccordionColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAccordionProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonAccordionSizes>("sizes", sizes));
  }
}
