import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_colors.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonLinearProgressTheme extends ThemeExtension<MoonLinearProgressTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Linear progress colors.
  final MoonLinearProgressColors colors;

  /// Linear progress sizes.
  final MoonLinearProgressSizes sizes;

  MoonLinearProgressTheme({
    required this.tokens,
    MoonLinearProgressColors? colors,
    MoonLinearProgressSizes? sizes,
  })  : colors = colors ??
            MoonLinearProgressColors(
              color: tokens.colors.piccolo,
              backgroundColor: tokens.colors.beerus,
              textColor: tokens.colors.textPrimary,
            ),
        sizes = sizes ?? MoonLinearProgressSizes(tokens: tokens);

  @override
  MoonLinearProgressTheme copyWith({
    MoonTokens? tokens,
    MoonLinearProgressColors? colors,
    MoonLinearProgressSizes? sizes,
  }) {
    return MoonLinearProgressTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonLinearProgressTheme lerp(ThemeExtension<MoonLinearProgressTheme>? other, double t) {
    if (other is! MoonLinearProgressTheme) return this;

    return MoonLinearProgressTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonLinearProgressColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonLinearProgressSizes>("sizes", sizes));
  }
}
