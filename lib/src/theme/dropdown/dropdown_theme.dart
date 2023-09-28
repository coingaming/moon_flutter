import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/dropdown/dropdown_colors.dart';
import 'package:moon_design/src/theme/dropdown/dropdown_properties.dart';
import 'package:moon_design/src/theme/dropdown/dropdown_shadows.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonDropdownTheme extends ThemeExtension<MoonDropdownTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Dropdown colors.
  final MoonDropdownColors colors;

  /// Dropdown properties.
  final MoonDropdownProperties properties;

  /// Dropdown shadows.
  final MoonDropdownShadows shadows;

  MoonDropdownTheme({
    required this.tokens,
    MoonDropdownColors? colors,
    MoonDropdownProperties? properties,
    MoonDropdownShadows? shadows,
  })  : colors = colors ??
            MoonDropdownColors(
              textColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              backgroundColor: tokens.colors.goku,
            ),
        properties = properties ??
            MoonDropdownProperties(
              borderRadius: tokens.borders.interactiveMd,
              distanceToTarget: tokens.sizes.x4s,
              transitionDuration: Duration.zero,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              contentPadding: EdgeInsets.all(tokens.sizes.x5s),
              dropdownMargin: EdgeInsets.all(tokens.sizes.x4s),
              textStyle: tokens.typography.body.textDefault,
            ),
        shadows = shadows ?? MoonDropdownShadows(dropdownShadows: tokens.shadows.sm);

  @override
  MoonDropdownTheme copyWith({
    MoonTokens? tokens,
    MoonDropdownColors? colors,
    MoonDropdownProperties? properties,
    MoonDropdownShadows? shadows,
  }) {
    return MoonDropdownTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonDropdownTheme lerp(ThemeExtension<MoonDropdownTheme>? other, double t) {
    if (other is! MoonDropdownTheme) return this;

    return MoonDropdownTheme(
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
      ..add(DiagnosticsProperty("type", "MoonDropdownTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonDropdownColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonDropdownProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonDropdownShadows>("shadows", shadows));
  }
}
