import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/segmented_control/segmented_control_colors.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_properties.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonSegmentedControlTheme
    extends ThemeExtension<MoonSegmentedControlTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonSegmentedControl.
  final MoonSegmentedControlColors colors;

  /// The properties of the MoonSegmentedControl.
  final MoonSegmentedControlProperties properties;

  /// The sizes of the MoonSegmentedControl.
  final MoonSegmentedControlSizes sizes;

  MoonSegmentedControlTheme({
    required this.tokens,
    MoonSegmentedControlColors? colors,
    MoonSegmentedControlProperties? properties,
    MoonSegmentedControlSizes? sizes,
  })  : colors = colors ??
            MoonSegmentedControlColors(
              backgroundColor: tokens.colors.gohan,
              selectedSegmentColor: tokens.colors.goku,
              textColor: tokens.colors.textPrimary,
              selectedTextColor: tokens.colors.textPrimary,
            ),
        properties = properties ??
            MoonSegmentedControlProperties(
              borderRadius: tokens.borders.interactiveMd,
              gap: tokens.sizes.x5s,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              padding: EdgeInsets.all(tokens.sizes.x5s),
            ),
        sizes = sizes ?? MoonSegmentedControlSizes(tokens: tokens);

  @override
  MoonSegmentedControlTheme copyWith({
    MoonTokens? tokens,
    MoonSegmentedControlColors? colors,
    MoonSegmentedControlProperties? properties,
    MoonSegmentedControlSizes? sizes,
  }) {
    return MoonSegmentedControlTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonSegmentedControlTheme lerp(
    ThemeExtension<MoonSegmentedControlTheme>? other,
    double t,
  ) {
    if (other is! MoonSegmentedControlTheme) return this;

    return MoonSegmentedControlTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonSegmentedControlTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonSegmentedControlColors>("colors", colors))
      ..add(
        DiagnosticsProperty<MoonSegmentedControlProperties>(
          "properties",
          properties,
        ),
      )
      ..add(
        DiagnosticsProperty<MoonSegmentedControlSizes>(
          "sizes",
          sizes,
        ),
      );
  }
}
