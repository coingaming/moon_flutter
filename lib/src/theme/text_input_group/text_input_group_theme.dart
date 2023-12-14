import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_input_group/text_input_group_colors.dart';
import 'package:moon_design/src/theme/text_input_group/text_input_group_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTextInputGroupTheme extends ThemeExtension<MoonTextInputGroupTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// TextInputGroup colors.
  final MoonTextInputGroupColors colors;

  /// TextInputGroup properties.
  final MoonTextInputGroupProperties properties;

  MoonTextInputGroupTheme({
    required this.tokens,
    MoonTextInputGroupColors? colors,
    MoonTextInputGroupProperties? properties,
  })  : colors = colors ??
            MoonTextInputGroupColors(
              backgroundColor: tokens.colors.goku,
              errorColor: tokens.colors.chichi,
              helperTextColor: tokens.colors.trunks,
              borderColor: tokens.colors.beerus,
              hoverBorderColor: tokens.colors.beerus,
            ),
        properties = properties ??
            MoonTextInputGroupProperties(
              borderRadius: tokens.borders.interactiveSm,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              helperPadding: EdgeInsets.only(top: tokens.sizes.x4s),
              textPadding: EdgeInsets.all(tokens.sizes.x2s),
              textStyle: tokens.typography.body.text16,
              helperTextStyle: tokens.typography.body.text12,
            );

  @override
  MoonTextInputGroupTheme copyWith({
    MoonTokens? tokens,
    MoonTextInputGroupColors? colors,
    MoonTextInputGroupProperties? properties,
  }) {
    return MoonTextInputGroupTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonTextInputGroupTheme lerp(ThemeExtension<MoonTextInputGroupTheme>? other, double t) {
    if (other is! MoonTextInputGroupTheme) return this;

    return MoonTextInputGroupTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTextInputGroupTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTextInputGroupColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTextInputGroupProperties>("properties", properties));
  }
}
