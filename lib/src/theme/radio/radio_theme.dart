import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/radio/radio_colors.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonRadioTheme extends ThemeExtension<MoonRadioTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonRadio.
  final MoonRadioColors colors;

  MoonRadioTheme({
    required this.tokens,
    MoonRadioColors? colors,
  }) : colors = colors ??
            MoonRadioColors(
              activeColor: tokens.colors.piccolo,
              inactiveColor: tokens.colors.trunks,
            );

  @override
  MoonRadioTheme copyWith({
    MoonTokens? tokens,
    MoonRadioColors? colors,
  }) {
    return MoonRadioTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonRadioTheme lerp(ThemeExtension<MoonRadioTheme>? other, double t) {
    if (other is! MoonRadioTheme) return this;

    return MoonRadioTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonRadioTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonRadioColors>("colors", colors));
  }
}
