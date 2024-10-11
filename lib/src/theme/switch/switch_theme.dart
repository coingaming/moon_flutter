import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/switch/switch_colors.dart';
import 'package:moon_design/src/theme/switch/switch_properties.dart';
import 'package:moon_design/src/theme/switch/switch_shadows.dart';
import 'package:moon_design/src/theme/switch/switch_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonSwitchTheme extends ThemeExtension<MoonSwitchTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonSwitch.
  final MoonSwitchColors colors;

  /// The properties of the MoonSwitch.
  final MoonSwitchProperties properties;

  /// The shadows of the MoonSwitch.
  final MoonSwitchShadows shadows;

  /// The sizes of the MoonSwitch.
  final MoonSwitchSizes sizes;

  MoonSwitchTheme({
    required this.tokens,
    MoonSwitchColors? colors,
    MoonSwitchProperties? properties,
    MoonSwitchShadows? shadows,
    MoonSwitchSizes? sizes,
  })  : colors = colors ??
            MoonSwitchColors(
              activeTrackColor: tokens.colors.piccolo,
              inactiveTrackColor: tokens.colors.beerus,
              activeTextColor: tokens.colors.goten,
              inactiveTextColor: tokens.colors.bulma,
              activeIconColor: tokens.colors.goten,
              inactiveIconColor: tokens.colors.bulma,
              thumbIconColor: tokens.colors.popo,
              thumbColor: tokens.colors.goten,
            ),
        properties = properties ??
            MoonSwitchProperties(
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
            ),
        shadows = shadows ??
            MoonSwitchShadows(
              thumbShadows: tokens.shadows.sm,
            ),
        sizes = sizes ?? MoonSwitchSizes(tokens: tokens);

  @override
  MoonSwitchTheme copyWith({
    MoonTokens? tokens,
    MoonSwitchColors? colors,
    MoonSwitchProperties? properties,
    MoonSwitchShadows? shadows,
    MoonSwitchSizes? sizes,
  }) {
    return MoonSwitchTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonSwitchTheme lerp(ThemeExtension<MoonSwitchTheme>? other, double t) {
    if (other is! MoonSwitchTheme) return this;

    return MoonSwitchTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonSwitchTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonSwitchColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonSwitchProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonSwitchShadows>("shadows", shadows))
      ..add(DiagnosticsProperty<MoonSwitchSizes>("sizes", sizes));
  }
}
