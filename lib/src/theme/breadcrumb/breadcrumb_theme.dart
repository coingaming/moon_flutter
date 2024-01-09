import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/breadcrumb/breadcrumb_colors.dart';
import 'package:moon_design/src/theme/breadcrumb/breadcrumb_properties.dart';

@immutable
class MoonBreadcrumbTheme extends ThemeExtension<MoonBreadcrumbTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Breadcrumb colors.
  final MoonBreadcrumbColors colors;

  /// Breadcrumb properties.
  final MoonBreadcrumbProperties properties;

  MoonBreadcrumbTheme({
    required this.tokens,
    MoonBreadcrumbColors? colors,
    MoonBreadcrumbProperties? properties,
  })  : colors = colors ??
            MoonBreadcrumbColors(
              textColor: tokens.colors.trunks,
              hoverTextColor: tokens.colors.bulma,
              currentItemTextColor: tokens.colors.textPrimary,
              dividerColor: tokens.colors.trunks,
              menuBackgroundColor: tokens.colors.goku,
            ),
        properties = properties ??
            MoonBreadcrumbProperties(
              gap: tokens.sizes.x4s,
              padding: EdgeInsets.zero,
              dividerIcon: MoonIcons.arrows_right_24_light,
              itemTextStyle: tokens.typography.body.text14,
              currentItemTextStyle: tokens.typography.body.text14,
              menuItemTextStyle: tokens.typography.body.text14.copyWith(color: tokens.colors.bulma),
              menuMaxHeight: 300,
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
  MoonBreadcrumbTheme lerp(ThemeExtension<MoonBreadcrumbTheme>? other, double t) {
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
