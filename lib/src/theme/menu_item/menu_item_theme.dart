import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/menu_item/menu_item_colors.dart';
import 'package:moon_design/src/theme/menu_item/menu_item_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonMenuItemTheme extends ThemeExtension<MoonMenuItemTheme> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonMenuItem.
  final MoonMenuItemColors colors;

  /// The properties of the MoonMenuItem.
  final MoonMenuItemProperties properties;

  MoonMenuItemTheme({
    required this.tokens,
    MoonMenuItemColors? colors,
    MoonMenuItemProperties? properties,
  })  : colors = colors ??
            MoonMenuItemColors(
              backgroundColor: Colors.transparent,
              dividerColor: tokens.colors.beerus,
              iconColor: tokens.colors.iconPrimary,
              labelTextColor: tokens.colors.textPrimary,
              contentTextColor: tokens.colors.textSecondary,
            ),
        properties = properties ??
            MoonMenuItemProperties(
              borderRadius: tokens.borders.interactiveSm,
              verticalGap: tokens.sizes.x5s,
              minimumHeight: tokens.sizes.md,
              padding: EdgeInsets.all(tokens.sizes.x3s),
              labelTextStyle: tokens.typography.body.textDefault,
              contentTextStyle: tokens.typography.body.text12,
            );

  @override
  MoonMenuItemTheme copyWith({
    MoonTokens? tokens,
    MoonMenuItemColors? colors,
    MoonMenuItemProperties? properties,
  }) {
    return MoonMenuItemTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonMenuItemTheme lerp(ThemeExtension<MoonMenuItemTheme>? other, double t) {
    if (other is! MoonMenuItemTheme) return this;

    return MoonMenuItemTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonMenuItemTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonMenuItemColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonMenuItemProperties>("properties", properties));
  }
}
