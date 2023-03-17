import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_colors.dart';
import 'package:moon_design/src/theme/accordion/accordion_properties.dart';
import 'package:moon_design/src/theme/accordion/accordion_shadows.dart';
import 'package:moon_design/src/theme/accordion/accordion_sizes.dart';

@immutable
class MoonAccordionTheme extends ThemeExtension<MoonAccordionTheme> with DiagnosticableTreeMixin {
  static final light = MoonAccordionTheme(
    colors: MoonAccordionColors.light,
    properties: MoonAccordionProperties.properties,
    sizes: MoonAccordionSizes.sizes,
    shadows: MoonAccordionShadows.light,
  );

  static final dark = MoonAccordionTheme(
    colors: MoonAccordionColors.dark,
    properties: MoonAccordionProperties.properties,
    sizes: MoonAccordionSizes.sizes,
    shadows: MoonAccordionShadows.dark,
  );

  /// Accordion colors.
  final MoonAccordionColors colors;

  /// Accordion properties.
  final MoonAccordionProperties properties;

  /// Accordion sizes.
  final MoonAccordionSizes sizes;

  /// Accordion shadows.
  final MoonAccordionShadows shadows;

  const MoonAccordionTheme({
    required this.colors,
    required this.properties,
    required this.sizes,
    required this.shadows,
  });

  @override
  MoonAccordionTheme copyWith({
    MoonAccordionColors? colors,
    MoonAccordionProperties? properties,
    MoonAccordionSizes? sizes,
    MoonAccordionShadows? shadows,
  }) {
    return MoonAccordionTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonAccordionTheme lerp(ThemeExtension<MoonAccordionTheme>? other, double t) {
    if (other is! MoonAccordionTheme) return this;

    return MoonAccordionTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAccordionTheme"))
      ..add(DiagnosticsProperty<MoonAccordionColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAccordionProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonAccordionSizes>("sizes", sizes))
      ..add(DiagnosticsProperty<MoonAccordionShadows>("shadows", shadows));
  }
}
