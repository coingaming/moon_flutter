import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/dot_indicator/dot_indicator_colors.dart';
import 'package:moon_design/src/theme/dot_indicator/dot_indicator_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonDotIndicatorTheme extends ThemeExtension<MoonDotIndicatorTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonDotIndicator.
  final MoonDotIndicatorColors colors;

  /// The properties of the MoonDotIndicator.
  final MoonDotIndicatorProperties properties;

  MoonDotIndicatorTheme({
    required this.tokens,
    MoonDotIndicatorColors? colors,
    MoonDotIndicatorProperties? properties,
  })  : colors = colors ??
            MoonDotIndicatorColors(
              selectedColor: tokens.colors.piccolo,
              unselectedColor: tokens.colors.beerus,
            ),
        properties = properties ??
            MoonDotIndicatorProperties(
              gap: tokens.sizes.x4s,
              size: tokens.sizes.x4s,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
            );

  @override
  MoonDotIndicatorTheme copyWith({
    MoonTokens? tokens,
    MoonDotIndicatorColors? colors,
    MoonDotIndicatorProperties? properties,
  }) {
    return MoonDotIndicatorTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonDotIndicatorTheme lerp(
    ThemeExtension<MoonDotIndicatorTheme>? other,
    double t,
  ) {
    if (other is! MoonDotIndicatorTheme) return this;

    return MoonDotIndicatorTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonDotIndicatorTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonDotIndicatorColors>("colors", colors))
      ..add(
        DiagnosticsProperty<MoonDotIndicatorProperties>(
          "properties",
          properties,
        ),
      );
  }
}
