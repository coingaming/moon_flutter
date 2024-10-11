import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_colors.dart';
import 'package:moon_design/src/theme/avatar/avatar_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonAvatarTheme extends ThemeExtension<MoonAvatarTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonAvatar.
  final MoonAvatarColors colors;

  /// The sizes of the MoonAvatar.
  final MoonAvatarSizes sizes;

  MoonAvatarTheme({
    required this.tokens,
    MoonAvatarColors? colors,
    MoonAvatarSizes? sizes,
  })  : colors = colors ??
            MoonAvatarColors(
              backgroundColor: tokens.colors.goku,
              badgeColor: tokens.colors.roshi,
              iconColor: tokens.colors.iconPrimary,
              textColor: tokens.colors.textPrimary,
            ),
        sizes = sizes ?? MoonAvatarSizes(tokens: tokens);

  @override
  MoonAvatarTheme copyWith({
    MoonTokens? tokens,
    MoonAvatarColors? colors,
    MoonAvatarSizes? sizes,
  }) {
    return MoonAvatarTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonAvatarTheme lerp(ThemeExtension<MoonAvatarTheme>? other, double t) {
    if (other is! MoonAvatarTheme) return this;

    return MoonAvatarTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonAvatarColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("sizes", sizes));
  }
}
