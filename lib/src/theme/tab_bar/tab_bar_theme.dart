import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tab_bar/tab_bar_colors.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_properties.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTabBarTheme extends ThemeExtension<MoonTabBarTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonTabBar.
  final MoonTabBarColors colors;

  /// The properties of the MoonTabBar.
  final MoonTabBarProperties properties;

  /// The sizes of the MoonTabBar.
  final MoonTabBarSizes sizes;

  MoonTabBarTheme({
    required this.tokens,
    MoonTabBarColors? colors,
    MoonTabBarProperties? properties,
    MoonTabBarSizes? sizes,
  })  : colors = colors ??
            MoonTabBarColors(
              indicatorColor: tokens.colors.piccolo,
              textColor: tokens.colors.textPrimary,
              selectedTextColor: tokens.colors.piccolo,
              selectedPillTextColor: tokens.colors.textPrimary,
              selectedPillTabColor: tokens.colors.goku,
            ),
        properties = properties ??
            MoonTabBarProperties(
              gap: tokens.sizes.x5s,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
            ),
        sizes = sizes ?? MoonTabBarSizes(tokens: tokens);

  @override
  MoonTabBarTheme copyWith({
    MoonTokens? tokens,
    MoonTabBarColors? colors,
    MoonTabBarProperties? properties,
    MoonTabBarSizes? sizes,
  }) {
    return MoonTabBarTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonTabBarTheme lerp(ThemeExtension<MoonTabBarTheme>? other, double t) {
    if (other is! MoonTabBarTheme) return this;

    return MoonTabBarTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTabBarTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTabBarColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTabBarProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonTabBarSizes>("sizes", sizes));
  }
}
