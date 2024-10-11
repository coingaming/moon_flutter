import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_colors.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonCircularProgressTheme
    extends ThemeExtension<MoonCircularProgressTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonCircularProgress.
  final MoonCircularProgressColors colors;

  /// The sizes of the MoonCircularProgress.
  final MoonCircularProgressSizes sizes;

  MoonCircularProgressTheme({
    required this.tokens,
    MoonCircularProgressColors? colors,
    MoonCircularProgressSizes? sizes,
  })  : colors = colors ??
            MoonCircularProgressColors(
              color: tokens.colors.piccolo,
              backgroundColor: tokens.colors.beerus,
            ),
        sizes = sizes ?? MoonCircularProgressSizes(tokens: tokens);

  @override
  MoonCircularProgressTheme copyWith({
    MoonTokens? tokens,
    MoonCircularProgressColors? colors,
    MoonCircularProgressSizes? sizes,
  }) {
    return MoonCircularProgressTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonCircularProgressTheme lerp(
    ThemeExtension<MoonCircularProgressTheme>? other,
    double t,
  ) {
    if (other is! MoonCircularProgressTheme) return this;

    return MoonCircularProgressTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonCircularProgressColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCircularProgressSizes>("sizes", sizes));
  }
}
