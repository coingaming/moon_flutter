import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/popover/popover_colors.dart';
import 'package:moon_design/src/theme/popover/popover_properties.dart';
import 'package:moon_design/src/theme/popover/popover_shadows.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonPopoverTheme extends ThemeExtension<MoonPopoverTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Popover colors.
  final MoonPopoverColors colors;

  /// Popover properties.
  final MoonPopoverProperties properties;

  /// Popover shadows.
  final MoonPopoverShadows shadows;

  MoonPopoverTheme({
    required this.tokens,
    MoonPopoverColors? colors,
    MoonPopoverProperties? properties,
    MoonPopoverShadows? shadows,
  })  : colors = colors ??
            MoonPopoverColors(
              textColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              backgroundColor: tokens.colors.goku,
            ),
        properties = properties ??
            MoonPopoverProperties(
              borderRadius: tokens.borders.interactiveMd,
              distanceToTarget: tokens.sizes.x4s,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              contentPadding: EdgeInsets.all(tokens.sizes.x3s),
              textStyle: tokens.typography.body.textDefault,
            ),
        shadows = shadows ?? MoonPopoverShadows(popoverShadows: tokens.shadows.sm);

  @override
  MoonPopoverTheme copyWith({
    MoonTokens? tokens,
    MoonPopoverColors? colors,
    MoonPopoverProperties? properties,
    MoonPopoverShadows? shadows,
  }) {
    return MoonPopoverTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonPopoverTheme lerp(ThemeExtension<MoonPopoverTheme>? other, double t) {
    if (other is! MoonPopoverTheme) return this;

    return MoonPopoverTheme(
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
      ..add(DiagnosticsProperty("type", "MoonPopoverTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonPopoverColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonPopoverProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonPopoverShadows>("shadows", shadows));
  }
}
