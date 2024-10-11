import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/button/button_colors.dart';
import 'package:moon_design/src/theme/button/button_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonButtonTheme extends ThemeExtension<MoonButtonTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonButton.
  final MoonButtonColors colors;

  /// The sizes of the MoonButton.
  final MoonButtonSizes sizes;

  MoonButtonTheme({
    required this.tokens,
    MoonButtonColors? colors,
    MoonButtonSizes? sizes,
  })  : colors = colors ??
            MoonButtonColors(
              borderColor: tokens.colors.trunks,
              textColor: tokens.colors.textPrimary,
              filledVariantBackgroundColor: tokens.colors.piccolo,
              filledVariantTextColor: tokens.colors.goten,
              textVariantTextColor: tokens.colors.textSecondary,
              textVariantFocusColor: tokens.colors.piccolo,
              textVariantHoverColor: tokens.colors.jiren,
            ),
        sizes = sizes ?? MoonButtonSizes(tokens: tokens);

  @override
  MoonButtonTheme copyWith({
    MoonTokens? tokens,
    MoonButtonColors? colors,
    MoonButtonSizes? sizes,
  }) {
    return MoonButtonTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonButtonTheme lerp(ThemeExtension<MoonButtonTheme>? other, double t) {
    if (other is! MoonButtonTheme) return this;

    return MoonButtonTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonButtonColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonButtonSizes>("sizes", sizes));
  }
}
