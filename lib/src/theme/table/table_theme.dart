import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/table/table_colors.dart';
import 'package:moon_design/src/theme/table/table_properties.dart';
import 'package:moon_design/src/theme/table/table_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTableTheme extends ThemeExtension<MoonTableTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Table colors.
  final MoonTableColors colors;

  /// Table properties.
  final MoonTableProperties properties;

  /// Table sizes.
  final MoonTableSizes sizes;

  MoonTableTheme({
    required this.tokens,
    MoonTableColors? colors,
    MoonTableProperties? properties,
    MoonTableSizes? sizes,
  })  : colors = colors ??
            MoonTableColors(
              columnTextColor: tokens.colors.textPrimary,
              rowTextColor: tokens.colors.textPrimary,
              rowTitleTextColor: tokens.colors.textPrimary,
              rowPinnedAnimatedTitleTextColor: tokens.colors.trunks,
              iconColor: tokens.colors.iconPrimary,
              rowBackgroundColor: tokens.colors.goku,
            ),
        properties = properties ??
            MoonTableProperties(
              transitionDuration: const Duration(milliseconds: 400),
              transitionCurve: tokens.transitions.defaultTransitionCurve,
            ),
        sizes = sizes ?? MoonTableSizes(tokens: tokens);

  @override
  MoonTableTheme copyWith({
    MoonTokens? tokens,
    MoonTableColors? colors,
    MoonTableProperties? properties,
    MoonTableSizes? sizes,
  }) {
    return MoonTableTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonTableTheme lerp(ThemeExtension<MoonTableTheme>? other, double t) {
    if (other is! MoonTableTheme) return this;

    return MoonTableTheme(
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
      ..add(DiagnosticsProperty("type", "MoonTableTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTableColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTableProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonTableSizes>("sizes", sizes));
  }
}
