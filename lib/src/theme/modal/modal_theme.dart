import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/icon/icon_theme.dart';

import 'package:moon_design/src/theme/modal/modal_colors.dart';
import 'package:moon_design/src/theme/modal/modal_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonModalTheme extends ThemeExtension<MoonModalTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Modal colors.
  final MoonModalColors colors;

  /// Modal properties.
  final MoonModalProperties properties;

  MoonModalTheme({
    required this.tokens,
    MoonModalColors? colors,
    MoonModalProperties? properties,
  })  : colors = colors ??
            MoonModalColors(
              textColor: tokens.typography.colors.bodyPrimary,
              iconColor: MoonIconTheme(tokens: tokens).colors.primaryColor,
              backgroundColor: tokens.colors.gohan,
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
