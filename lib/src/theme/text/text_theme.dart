import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text/text_colors.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTextTheme extends ThemeExtension<MoonTextTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Colors for text.
  final MoonTextColors colors;

  MoonTextTheme({
    required this.tokens,
    MoonTextColors? colors,
  }) : colors = colors ??
            MoonTextColors(
              bodyPrimary: tokens.colors.bulma,
              bodySecondary: tokens.colors.trunks,
              controlPrimary: tokens.colors.goten,
              controlSecondary: tokens.colors.popo,
            );

  @override
  MoonTextTheme copyWith({
    MoonTokens? tokens,
    MoonTextColors? colors,
  }) {
    return MoonTextTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonTextTheme lerp(ThemeExtension<MoonTextTheme>? other, double t) {
    if (other is! MoonTextTheme) return this;

    return MoonTextTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextTheme"))
      ..add(DiagnosticsProperty("tokens", tokens))
      ..add(DiagnosticsProperty("colors", colors));
  }
}
