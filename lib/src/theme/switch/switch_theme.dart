import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/switch/switch_colors.dart';
import 'package:moon_design/src/theme/switch/switch_sizes.dart';

@immutable
class MoonSwitchTheme extends ThemeExtension<MoonSwitchTheme> with DiagnosticableTreeMixin {
  static final light = MoonSwitchTheme(
    colors: MoonSwitchColors.light,
    sizes: MoonSwitchSizes.sizes,
  );

  static final dark = MoonSwitchTheme(
    colors: MoonSwitchColors.dark,
    sizes: MoonSwitchSizes.sizes,
  );

  /// Switch colors.
  final MoonSwitchColors colors;

  /// Switch sizes.
  final MoonSwitchSizes sizes;

  const MoonSwitchTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonSwitchTheme copyWith({
    MoonSwitchColors? colors,
    MoonSwitchSizes? sizes,
  }) {
    return MoonSwitchTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonSwitchTheme lerp(ThemeExtension<MoonSwitchTheme>? other, double t) {
    if (other is! MoonSwitchTheme) return this;

    return MoonSwitchTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchTheme"))
      ..add(DiagnosticsProperty<MoonSwitchColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonSwitchSizes>("sizes", sizes));
  }
}
