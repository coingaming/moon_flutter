import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_colors.dart';
import 'package:moon_design/src/theme/accordion/accordion_properties.dart';
import 'package:moon_design/src/theme/accordion/accordion_shadows.dart';
import 'package:moon_design/src/theme/accordion/accordion_sizes.dart';
import 'package:moon_design/src/theme/text/text_theme.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonAccordionTheme extends ThemeExtension<MoonAccordionTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Accordion colors.
  final MoonAccordionColors colors;

  /// Accordion properties.
  final MoonAccordionProperties properties;

  /// Accordion shadows.
  final MoonAccordionShadows shadows;

  /// Accordion sizes.
  final MoonAccordionSizes sizes;

  MoonAccordionTheme({
    required this.tokens,
    MoonAccordionColors? colors,
    MoonAccordionProperties? properties,
    MoonAccordionShadows? shadows,
    MoonAccordionSizes? sizes,
  })  : colors = colors ??
            MoonAccordionColors(
              backgroundColor: tokens.colors.gohan,
              expandedBackgroundColor: tokens.colors.gohan,
              borderColor: tokens.colors.beerus,
              dividerColor: tokens.colors.beerus,
              headerTextColor: MoonTextTheme(tokens: tokens).colors.bodyPrimary,
              expandedHeaderTextColor: MoonTextTheme(tokens: tokens).colors.bodyPrimary,
              contentTextColor: MoonTextTheme(tokens: tokens).colors.bodyPrimary,
              trailingIconColor: MoonTextTheme(tokens: tokens).colors.bodySecondary,
              expandedTrailingIconColor: MoonTextTheme(tokens: tokens).colors.bodyPrimary,
            ),
        properties = properties ??
            MoonAccordionProperties(
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
            ),
        shadows = shadows ?? MoonAccordionShadows(shadows: tokens.shadows.sm),
        sizes = sizes ?? MoonAccordionSizes(tokens: tokens);

  @override
  MoonAccordionTheme copyWith({
    MoonTokens? tokens,
    MoonAccordionColors? colors,
    MoonAccordionProperties? properties,
    MoonAccordionShadows? shadows,
    MoonAccordionSizes? sizes,
  }) {
    return MoonAccordionTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonAccordionTheme lerp(ThemeExtension<MoonAccordionTheme>? other, double t) {
    if (other is! MoonAccordionTheme) return this;

    return MoonAccordionTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAccordionTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonAccordionColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAccordionProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonAccordionShadows>("shadows", shadows))
      ..add(DiagnosticsProperty<MoonAccordionSizes>("sizes", sizes));
  }
}
