import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/checkbox/checkbox_colors.dart';
import 'package:moon_design/src/theme/checkbox/checkbox_properties.dart';
import 'package:moon_design/src/theme/text/text_theme.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonCheckboxTheme extends ThemeExtension<MoonCheckboxTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Checkbox colors.
  final MoonCheckboxColors colors;

  /// Checkbox properties.
  final MoonCheckboxProperties properties;

  MoonCheckboxTheme({
    required this.tokens,
    MoonCheckboxColors? colors,
    MoonCheckboxProperties? properties,
  })  : colors = colors ??
            MoonCheckboxColors(
              activeColor: tokens.colors.piccolo,
              borderColor: tokens.colors.trunks,
              checkColor: tokens.colors.goten,
              inactiveColor: Colors.transparent,
              textColor: MoonTextTheme(tokens: tokens).colors.bodyPrimary,
            ),
        properties = properties ??
            MoonCheckboxProperties(
              borderRadius: tokens.borders.interactiveXs,
              textStyle: tokens.typography.body.textDefault,
            );

  @override
  MoonCheckboxTheme copyWith({
    MoonTokens? tokens,
    MoonCheckboxColors? colors,
    MoonCheckboxProperties? properties,
  }) {
    return MoonCheckboxTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonCheckboxTheme lerp(ThemeExtension<MoonCheckboxTheme>? other, double t) {
    if (other is! MoonCheckboxTheme) return this;

    return MoonCheckboxTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonCheckboxTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonCheckboxColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCheckboxProperties>("properties", properties));
  }
}
