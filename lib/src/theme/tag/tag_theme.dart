import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tag/tag_colors.dart';
import 'package:moon_design/src/theme/tag/tag_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTagTheme extends ThemeExtension<MoonTagTheme> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonTag.
  final MoonTagColors colors;

  /// The sizes of the MoonTag.
  final MoonTagSizes sizes;

  MoonTagTheme({
    required this.tokens,
    MoonTagColors? colors,
    MoonTagSizes? sizes,
  })  : colors = colors ??
            MoonTagColors(
              textColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              backgroundColor: tokens.colors.goku,
            ),
        sizes = sizes ?? MoonTagSizes(tokens: tokens);

  @override
  MoonTagTheme copyWith({
    MoonTokens? tokens,
    MoonTagColors? colors,
    MoonTagSizes? sizes,
  }) {
    return MoonTagTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonTagTheme lerp(ThemeExtension<MoonTagTheme>? other, double t) {
    if (other is! MoonTagTheme) return this;

    return MoonTagTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTagColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTagSizes>("sizes", sizes));
  }
}
