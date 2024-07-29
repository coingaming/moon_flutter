import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/breadcrumb/breadcrumb_colors.dart';
import 'package:moon_design/src/theme/breadcrumb/breadcrumb_properties.dart';

@immutable
class MoonBreadcrumbTheme extends ThemeExtension<MoonBreadcrumbTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonBreadcrumb.
  final MoonBreadcrumbColors colors;

  /// The properties of the MoonBreadcrumb.
  final MoonBreadcrumbProperties properties;

  MoonBreadcrumbTheme({
    required this.tokens,
    MoonBreadcrumbColors? colors,
    MoonBreadcrumbProperties? properties,
  })  : colors = colors ??
            MoonBreadcrumbColors(
              itemColor: tokens.colors.textSecondary,
              currentItemColor: tokens.colors.textPrimary,
              hoverEffectColor: tokens.colors.textPrimary,
            ),
        properties = properties ??
            MoonBreadcrumbProperties(
              gap: tokens.sizes.x4s,
              itemGap: tokens.sizes.x6s,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              itemTextStyle: tokens.typography.body.textDefault,
              currentItemTextStyle: tokens.typography.body.textDefault,
              showMoreItemTextStyle: tokens.typography.body.textDefault,
            );

  @override
  MoonBreadcrumbTheme copyWith({
    MoonTokens? tokens,
    MoonBreadcrumbColors? colors,
    MoonBreadcrumbProperties? properties,
  }) {
    return MoonBreadcrumbTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonBreadcrumbTheme lerp(
    ThemeExtension<MoonBreadcrumbTheme>? other,
    double t,
  ) {
    if (other is! MoonBreadcrumbTheme) return this;

    return MoonBreadcrumbTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonBreadcrumbTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonBreadcrumbColors>("colors", colors));
  }
}
