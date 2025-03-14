import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/input_group/input_group_colors.dart';
import 'package:moon_design/src/theme/input_group/input_group_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonInputGroupTheme extends ThemeExtension<MoonInputGroupTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonInputGroup.
  final MoonInputGroupColors colors;

  /// The properties of the MoonInputGroup.
  final MoonInputGroupProperties properties;

  MoonInputGroupTheme({
    required this.tokens,
    MoonInputGroupColors? colors,
    MoonInputGroupProperties? properties,
  })  : colors = colors ??
            MoonInputGroupColors(
              backgroundColor: tokens.colors.goku,
              errorColor: tokens.colors.chichi,
              helperTextColor: tokens.colors.trunks,
              borderColor: tokens.colors.beerus,
              hoverColor: tokens.colors.beerus,
            ),
        properties = properties ??
            MoonInputGroupProperties(
              borderRadius: tokens.borders.interactiveSm,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              helperPadding: EdgeInsets.only(top: tokens.sizes.x4s),
              textPadding: EdgeInsets.all(tokens.sizes.x2s),
              textStyle: tokens.typography.body.text16,
              helperTextStyle: tokens.typography.body.text12,
            );

  @override
  MoonInputGroupTheme copyWith({
    MoonTokens? tokens,
    MoonInputGroupColors? colors,
    MoonInputGroupProperties? properties,
  }) {
    return MoonInputGroupTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonInputGroupTheme lerp(
    ThemeExtension<MoonInputGroupTheme>? other,
    double t,
  ) {
    if (other is! MoonInputGroupTheme) return this;

    return MoonInputGroupTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonInputGroupTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonInputGroupColors>("colors", colors))
      ..add(
        DiagnosticsProperty<MoonInputGroupProperties>("properties", properties),
      );
  }
}
