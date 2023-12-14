import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_area/text_area_colors.dart';
import 'package:moon_design/src/theme/text_area/text_area_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTextAreaTheme extends ThemeExtension<MoonTextAreaTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// TextArea colors.
  final MoonTextAreaColors colors;

  /// TextArea properties.
  final MoonTextAreaProperties properties;

  MoonTextAreaTheme({
    required this.tokens,
    MoonTextAreaColors? colors,
    MoonTextAreaProperties? properties,
  })  : colors = colors ??
            MoonTextAreaColors(
              backgroundColor: tokens.colors.goku,
              activeBorderColor: tokens.colors.piccolo,
              inactiveBorderColor: tokens.colors.beerus,
              errorColor: tokens.colors.chichi,
              hoverBorderColor: tokens.colors.beerus,
              textColor: tokens.colors.textPrimary,
              helperTextColor: tokens.colors.trunks,
            ),
        properties = properties ??
            MoonTextAreaProperties(
              borderRadius: tokens.borders.interactiveSm,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              helperPadding: EdgeInsets.only(top: tokens.sizes.x4s),
              textPadding: EdgeInsets.all(tokens.sizes.x2s),
              textStyle: tokens.typography.body.text16,
              helperTextStyle: tokens.typography.body.text12,
            );

  @override
  MoonTextAreaTheme copyWith({
    MoonTokens? tokens,
    MoonTextAreaColors? colors,
    MoonTextAreaProperties? properties,
  }) {
    return MoonTextAreaTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonTextAreaTheme lerp(ThemeExtension<MoonTextAreaTheme>? other, double t) {
    if (other is! MoonTextAreaTheme) return this;

    return MoonTextAreaTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTextAreaTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTextAreaColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTextAreaProperties>("properties", properties));
  }
}
