import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_colors.dart';
import 'package:moon_design/src/theme/accordion/accordion_properties.dart';
import 'package:moon_design/src/theme/accordion/accordion_shadows.dart';
import 'package:moon_design/src/theme/accordion/accordion_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonAccordionTheme extends ThemeExtension<MoonAccordionTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonAccordion.
  final MoonAccordionColors colors;

  /// The properties of the MoonAccordion.
  final MoonAccordionProperties properties;

  /// The shadows of the MoonAccordion.
  final MoonAccordionShadows shadows;

  /// The sizes of the MoonAccordion.
  final MoonAccordionSizes sizes;

  MoonAccordionTheme({
    required this.tokens,
    MoonAccordionColors? colors,
    MoonAccordionProperties? properties,
    MoonAccordionShadows? shadows,
    MoonAccordionSizes? sizes,
  })  : colors = colors ??
            MoonAccordionColors(
              textColor: tokens.colors.textPrimary,
              expandedTextColor: tokens.colors.textPrimary,
              contentColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              expandedIconColor: tokens.colors.iconPrimary,
              trailingIconColor: tokens.colors.iconPrimary,
              expandedTrailingIconColor: tokens.colors.iconSecondary,
              backgroundColor: tokens.colors.goku,
              expandedBackgroundColor: tokens.colors.goku,
              borderColor: tokens.colors.beerus,
              dividerColor: tokens.colors.beerus,
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
      ..add(
        DiagnosticsProperty<MoonAccordionProperties>("properties", properties),
      )
      ..add(
        DiagnosticsProperty<MoonAccordionShadows>("shadows", shadows),
      )
      ..add(
        DiagnosticsProperty<MoonAccordionSizes>("sizes", sizes),
      );
  }
}
