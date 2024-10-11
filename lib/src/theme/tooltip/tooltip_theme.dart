import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_colors.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_properties.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_shadows.dart';

@immutable
class MoonTooltipTheme extends ThemeExtension<MoonTooltipTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonTooltip.
  final MoonTooltipColors colors;

  /// The properties of the MoonTooltip.
  final MoonTooltipProperties properties;

  /// The shadows of the MoonTooltip.
  final MoonTooltipShadows shadows;

  MoonTooltipTheme({
    required this.tokens,
    MoonTooltipColors? colors,
    MoonTooltipProperties? properties,
    MoonTooltipShadows? shadows,
  })  : colors = colors ??
            MoonTooltipColors(
              textColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              backgroundColor: tokens.colors.goku,
            ),
        properties = properties ??
            MoonTooltipProperties(
              borderRadius: tokens.borders.interactiveXs,
              arrowBaseWidth: tokens.sizes.x2s,
              arrowLength: tokens.sizes.x4s,
              arrowTipDistance: tokens.sizes.x4s,
              transitionDuration: const Duration(milliseconds: 150),
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              contentPadding: EdgeInsets.all(tokens.sizes.x3s),
              textStyle: tokens.typography.body.text12,
            ),
        shadows =
            shadows ?? MoonTooltipShadows(tooltipShadows: tokens.shadows.sm);

  @override
  MoonTooltipTheme copyWith({
    MoonTokens? tokens,
    MoonTooltipColors? colors,
    MoonTooltipProperties? properties,
    MoonTooltipShadows? shadows,
  }) {
    return MoonTooltipTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonTooltipTheme lerp(ThemeExtension<MoonTooltipTheme>? other, double t) {
    if (other is! MoonTooltipTheme) return this;

    return MoonTooltipTheme(
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
      ..add(
        DiagnosticsProperty("type", "MoonTooltipTheme"),
      )
      ..add(
        DiagnosticsProperty<MoonTokens>("tokens", tokens),
      )
      ..add(
        DiagnosticsProperty<MoonTooltipColors>("colors", colors),
      )
      ..add(
        DiagnosticsProperty<MoonTooltipProperties>("properties", properties),
      )
      ..add(
        DiagnosticsProperty<MoonTooltipShadows>("shadows", shadows),
      );
  }
}
