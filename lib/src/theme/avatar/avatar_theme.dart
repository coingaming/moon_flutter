import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_colors.dart';
import 'package:moon_design/src/theme/avatar/avatar_sizes.dart';

@immutable
class MoonAvatarTheme extends ThemeExtension<MoonAvatarTheme> with DiagnosticableTreeMixin {
  static final light = MoonAvatarTheme(
    colors: MoonAvatarColors.light,
    sizes: MoonAvatarSizes.sizes,
  );

  static final dark = MoonAvatarTheme(
    colors: MoonAvatarColors.dark,
    sizes: MoonAvatarSizes.sizes,
  );

  /// Avatar colors.
  final MoonAvatarColors colors;

  /// Avatar sizes.
  final MoonAvatarSizes sizes;

  const MoonAvatarTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonAvatarTheme copyWith({
    MoonAvatarColors? colors,
    MoonAvatarSizes? sizes,
  }) {
    return MoonAvatarTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonAvatarTheme lerp(ThemeExtension<MoonAvatarTheme>? other, double t) {
    if (other is! MoonAvatarTheme) return this;

    return MoonAvatarTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarTheme"))
      ..add(DiagnosticsProperty<MoonAvatarColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("sizes", sizes));
  }
}
