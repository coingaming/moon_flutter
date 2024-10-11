import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/modal/modal_colors.dart';
import 'package:moon_design/src/theme/modal/modal_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonModalTheme extends ThemeExtension<MoonModalTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonModal.
  final MoonModalColors colors;

  /// The properties of the MoonModal.
  final MoonModalProperties properties;

  MoonModalTheme({
    required this.tokens,
    MoonModalColors? colors,
    MoonModalProperties? properties,
  })  : colors = colors ??
            MoonModalColors(
              textColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              backgroundColor: tokens.colors.goku,
              barrierColor: tokens.colors.zeno,
            ),
        properties = properties ??
            MoonModalProperties(
              borderRadius: tokens.borders.surfaceSm,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              textStyle: tokens.typography.body.textDefault,
            );

  @override
  MoonModalTheme copyWith({
    MoonTokens? tokens,
    MoonModalColors? colors,
    MoonModalProperties? properties,
  }) {
    return MoonModalTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonModalTheme lerp(ThemeExtension<MoonModalTheme>? other, double t) {
    if (other is! MoonModalTheme) return this;

    return MoonModalTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonModalTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonModalColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonModalProperties>("properties", properties));
  }
}
