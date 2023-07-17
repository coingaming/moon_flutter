import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/icon/icon_colors.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonIconTheme extends ThemeExtension<MoonIconTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Colors for icons.
  final MoonIconColors colors;

  MoonIconTheme({
    required this.tokens,
    MoonIconColors? colors,
  }) : colors = colors ?? MoonIconColors(primaryColor: tokens.colors.bulma);

  @override
  MoonIconTheme copyWith({
    MoonTokens? tokens,
    MoonIconColors? colors,
  }) {
    return MoonIconTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonIconTheme lerp(ThemeExtension<MoonIconTheme>? other, double t) {
    if (other is! MoonIconTheme) return this;

    return MoonIconTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonIconTheme"))
      ..add(DiagnosticsProperty("tokens", tokens))
      ..add(DiagnosticsProperty("colors", colors));
  }
}
