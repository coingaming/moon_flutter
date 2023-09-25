import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/alert/alert_colors.dart';
import 'package:moon_design/src/theme/alert/alert_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonAlertTheme extends ThemeExtension<MoonAlertTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Alert colors.
  final MoonAlertColors colors;

  /// Alert properties.
  final MoonAlertProperties properties;

  MoonAlertTheme({
    required this.tokens,
    MoonAlertColors? colors,
    MoonAlertProperties? properties,
  })  : colors = colors ??
            MoonAlertColors(
              backgroundColor: tokens.colors.goku,
              borderColor: tokens.colors.textSecondary,
              iconColor: tokens.colors.iconPrimary,
              textColor: tokens.colors.textPrimary,
            ),
        properties = properties ??
            MoonAlertProperties(
              borderRadius: tokens.borders.interactiveSm,
              horizontalGap: tokens.sizes.x3s,
              minimumHeight: tokens.sizes.xl,
              verticalGap: tokens.sizes.x4s,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              padding: EdgeInsets.all(tokens.sizes.x2s),
              bodyTextStyle: tokens.typography.body.textDefault,
              titleTextStyle: tokens.typography.heading.textDefault,
            );

  @override
  MoonAlertTheme copyWith({
    MoonTokens? tokens,
    MoonAlertColors? colors,
    MoonAlertProperties? properties,
  }) {
    return MoonAlertTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonAlertTheme lerp(ThemeExtension<MoonAlertTheme>? other, double t) {
    if (other is! MoonAlertTheme) return this;

    return MoonAlertTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAlertTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonAlertColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAlertProperties>("properties", properties));
  }
}
