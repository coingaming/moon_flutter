import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_colors.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonCircularLoaderTheme extends ThemeExtension<MoonCircularLoaderTheme> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonCircularLoader.
  final MoonCircularLoaderColors colors;

  /// The sizes of the MoonCircularLoader.
  final MoonCircularLoaderSizes sizes;

  MoonCircularLoaderTheme({
    required this.tokens,
    MoonCircularLoaderColors? colors,
    MoonCircularLoaderSizes? sizes,
  })  : colors = colors ??
            MoonCircularLoaderColors(
              color: tokens.colors.piccolo,
              backgroundColor: Colors.transparent,
            ),
        sizes = sizes ?? MoonCircularLoaderSizes(tokens: tokens);

  @override
  MoonCircularLoaderTheme copyWith({
    MoonTokens? tokens,
    MoonCircularLoaderColors? colors,
    MoonCircularLoaderSizes? sizes,
  }) {
    return MoonCircularLoaderTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonCircularLoaderTheme lerp(ThemeExtension<MoonCircularLoaderTheme>? other, double t) {
    if (other is! MoonCircularLoaderTheme) return this;

    return MoonCircularLoaderTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderTheme"))
      ..add(DiagnosticsProperty<MoonCircularLoaderColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizes>("sizes", sizes));
  }
}
