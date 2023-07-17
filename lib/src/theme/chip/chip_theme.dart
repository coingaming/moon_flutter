import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/chip/chip_colors.dart';
import 'package:moon_design/src/theme/chip/chip_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonChipTheme extends ThemeExtension<MoonChipTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Chip colors.
  final MoonChipColors colors;

  /// Chip sizes.
  final MoonChipSizes sizes;

  MoonChipTheme({
    required this.tokens,
    MoonChipColors? colors,
    MoonChipSizes? sizes,
  })  : colors = colors ??
            MoonChipColors(
              activeColor: tokens.colors.piccolo,
              backgroundColor: tokens.colors.gohan,
              activeBackgroundColor: tokens.colors.jiren,
              textColor: tokens.colors.bodyTextPrimary,
            ),
        sizes = sizes ?? MoonChipSizes(tokens: tokens);

  @override
  MoonChipTheme copyWith({
    MoonTokens? tokens,
    MoonChipColors? colors,
    MoonChipSizes? sizes,
  }) {
    return MoonChipTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonChipTheme lerp(ThemeExtension<MoonChipTheme>? other, double t) {
    if (other is! MoonChipTheme) return this;

    return MoonChipTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonChipColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonChipSizes>("sizes", sizes));
  }
}
