import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/authcode/authcode_colors.dart';
import 'package:moon_design/src/theme/authcode/authcode_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonAuthCodeTheme extends ThemeExtension<MoonAuthCodeTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// AuthCode colors.
  final MoonAuthCodeColors colors;

  /// AuthCode properties.
  final MoonAuthCodeProperties properties;

  MoonAuthCodeTheme({
    required this.tokens,
    MoonAuthCodeColors? colors,
    MoonAuthCodeProperties? properties,
  })  : colors = colors ??
            MoonAuthCodeColors(
              selectedBorderColor: tokens.colors.piccolo,
              activeBorderColor: tokens.colors.beerus,
              inactiveBorderColor: tokens.colors.beerus,
              errorBorderColor: tokens.colors.chichi,
              selectedFillColor: tokens.colors.goku,
              activeFillColor: tokens.colors.goku,
              inactiveFillColor: tokens.colors.goku,
              textColor: tokens.colors.textPrimary,
            ),
        properties = properties ??
            MoonAuthCodeProperties(
              borderRadius: tokens.borders.interactiveSm,
              gap: tokens.sizes.x4s,
              height: tokens.sizes.xl,
              width: tokens.sizes.lg,
              animationDuration: tokens.transitions.defaultTransitionDuration,
              errorAnimationDuration: tokens.transitions.defaultTransitionDuration,
              peekDuration: tokens.transitions.defaultTransitionDuration,
              animationCurve: tokens.transitions.defaultTransitionCurve,
              errorAnimationCurve: tokens.transitions.defaultTransitionCurve,
              textStyle: tokens.typography.body.text24,
              errorTextStyle: tokens.typography.body.text12,
            );

  @override
  MoonAuthCodeTheme copyWith({
    MoonTokens? tokens,
    MoonAuthCodeColors? colors,
    MoonAuthCodeProperties? properties,
  }) {
    return MoonAuthCodeTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonAuthCodeTheme lerp(ThemeExtension<MoonAuthCodeTheme>? other, double t) {
    if (other is! MoonAuthCodeTheme) return this;

    return MoonAuthCodeTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAuthCodeTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonAuthCodeColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAuthCodeProperties>("properties", properties));
  }
}
