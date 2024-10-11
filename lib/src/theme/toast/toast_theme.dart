import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/toast/toast_colors.dart';
import 'package:moon_design/src/theme/toast/toast_properties.dart';
import 'package:moon_design/src/theme/toast/toast_shadows.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonToastTheme extends ThemeExtension<MoonToastTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonToast.
  final MoonToastColors colors;

  /// The properties of the MoonToast.
  final MoonToastProperties properties;

  /// The shadows of the MoonToast.
  final MoonToastShadows shadows;

  MoonToastTheme({
    required this.tokens,
    MoonToastColors? colors,
    MoonToastProperties? properties,
    MoonToastShadows? shadows,
  })  : colors = colors ??
            MoonToastColors(
              lightVariantBackgroundColor: tokens.colors.goku,
              darkVariantBackgroundColor: tokens.complementaryColors.goku,
              lightVariantTextColor: tokens.colors.bulma,
              darkVariantTextColor: tokens.complementaryColors.bulma,
              lightVariantIconColor: tokens.colors.bulma,
              darkVariantIconColor: tokens.complementaryColors.bulma,
            ),
        properties = properties ??
            MoonToastProperties(
              borderRadius: tokens.borders.surfaceSm,
              horizontalGap: tokens.sizes.x2s,
              verticalGap: tokens.sizes.x3s,
              displayDuration: const Duration(seconds: 3),
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              contentPadding: EdgeInsets.all(tokens.sizes.x2s),
              textStyle: tokens.typography.body.textDefault,
            ),
        shadows = shadows ?? MoonToastShadows(toastShadows: tokens.shadows.lg);

  @override
  MoonToastTheme copyWith({
    MoonTokens? tokens,
    MoonToastColors? colors,
    MoonToastProperties? properties,
    MoonToastShadows? shadows,
  }) {
    return MoonToastTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonToastTheme lerp(ThemeExtension<MoonToastTheme>? other, double t) {
    if (other is! MoonToastTheme) return this;

    return MoonToastTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonToastTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonToastColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonToastProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonToastShadows>("shadows", shadows));
  }
}
