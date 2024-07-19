import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/drawer/drawer_colors.dart';
import 'package:moon_design/src/theme/drawer/drawer_properties.dart';
import 'package:moon_design/src/theme/drawer/drawer_shadows.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonDrawerTheme extends ThemeExtension<MoonDrawerTheme> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonDrawer.
  final MoonDrawerColors colors;

  /// The properties of the MoonDrawer.
  final MoonDrawerProperties properties;

  /// The shadows of the MoonDrawer.
  final MoonDrawerShadows shadows;

  MoonDrawerTheme({
    required this.tokens,
    MoonDrawerColors? colors,
    MoonDrawerProperties? properties,
    MoonDrawerShadows? shadows,
  })  : colors = colors ??
            MoonDrawerColors(
              textColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              backgroundColor: tokens.colors.goku,
            ),
        properties = properties ??
            MoonDrawerProperties(
              borderRadius: BorderRadius.zero,
              width: 448,
              textStyle: tokens.typography.body.textDefault,
            ),
        shadows = shadows ?? MoonDrawerShadows(drawerShadows: tokens.shadows.lg);

  @override
  MoonDrawerTheme copyWith({
    MoonTokens? tokens,
    MoonDrawerColors? colors,
    MoonDrawerProperties? properties,
    MoonDrawerShadows? shadows,
  }) {
    return MoonDrawerTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonDrawerTheme lerp(ThemeExtension<MoonDrawerTheme>? other, double t) {
    if (other is! MoonDrawerTheme) return this;

    return MoonDrawerTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonDrawerTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonDrawerColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonDrawerProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonDrawerShadows>("shadows", shadows));
  }
}
