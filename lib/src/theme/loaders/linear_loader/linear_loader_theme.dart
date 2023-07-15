import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_colors.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonLinearLoaderTheme extends ThemeExtension<MoonLinearLoaderTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Circular loader colors.
  final MoonLinearLoaderColors colors;

  /// Circular loader sizes.
  final MoonLinearLoaderSizes sizes;

  MoonLinearLoaderTheme({
    required this.tokens,
    MoonLinearLoaderColors? colors,
    MoonLinearLoaderSizes? sizes,
  })  : colors = colors ??
            MoonLinearLoaderColors(
              color: tokens.colors.hit,
              backgroundColor: Colors.transparent,
            ),
        sizes = sizes ?? MoonLinearLoaderSizes(tokens: tokens);

  @override
  MoonLinearLoaderTheme copyWith({
    MoonTokens? tokens,
    MoonLinearLoaderColors? colors,
    MoonLinearLoaderSizes? sizes,
  }) {
    return MoonLinearLoaderTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonLinearLoaderTheme lerp(ThemeExtension<MoonLinearLoaderTheme>? other, double t) {
    if (other is! MoonLinearLoaderTheme) return this;

    return MoonLinearLoaderTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonLinearLoaderColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizes>("sizes", sizes));
  }
}
