import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/radio/radio_colors.dart';
import 'package:moon_design/src/theme/radio/radio_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonRadioTheme extends ThemeExtension<MoonRadioTheme> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonRadio.
  final MoonRadioColors colors;

  /// The properties of the MoonRadio.
  final MoonRadioProperties properties;

  MoonRadioTheme({
    required this.tokens,
    MoonRadioColors? colors,
    MoonRadioProperties? properties,
  })  : colors = colors ??
            MoonRadioColors(
              activeColor: tokens.colors.piccolo,
              inactiveColor: tokens.colors.trunks,
              textColor: tokens.colors.textPrimary,
            ),
        properties = properties ??
            MoonRadioProperties(
              textStyle: tokens.typography.body.textDefault,
            );

  @override
  MoonRadioTheme copyWith({
    MoonTokens? tokens,
    MoonRadioColors? colors,
    MoonRadioProperties? properties,
  }) {
    return MoonRadioTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonRadioTheme lerp(ThemeExtension<MoonRadioTheme>? other, double t) {
    if (other is! MoonRadioTheme) return this;

    return MoonRadioTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonRadioTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonRadioColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonRadioProperties>("properties", properties));
  }
}
