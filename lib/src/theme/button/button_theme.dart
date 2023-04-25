import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/button/button_colors.dart';
import 'package:moon_design/src/theme/button/button_sizes.dart';

@immutable
class MoonButtonTheme extends ThemeExtension<MoonButtonTheme> with DiagnosticableTreeMixin {
  static final light = MoonButtonTheme(
    colors: MoonButtonColors.light,
    sizes: MoonButtonSizes.sizes,
  );

  static final dark = MoonButtonTheme(
    colors: MoonButtonColors.dark,
    sizes: MoonButtonSizes.sizes,
  );

  /// Button colors.
  final MoonButtonColors colors;

  /// Button sizes.
  final MoonButtonSizes sizes;

  const MoonButtonTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonButtonTheme copyWith({
    MoonButtonColors? colors,
    MoonButtonSizes? sizes,
  }) {
    return MoonButtonTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonButtonTheme lerp(ThemeExtension<MoonButtonTheme>? other, double t) {
    if (other is! MoonButtonTheme) return this;

    return MoonButtonTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonTheme"))
      ..add(DiagnosticsProperty<MoonButtonColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonButtonSizes>("sizes", sizes));
  }
}
