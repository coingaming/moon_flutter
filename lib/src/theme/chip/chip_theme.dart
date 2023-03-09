import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/chip/chip_colors.dart';
import 'package:moon_design/src/theme/chip/chip_sizes.dart';

@immutable
class MoonChipTheme extends ThemeExtension<MoonChipTheme> with DiagnosticableTreeMixin {
  static final light = MoonChipTheme(
    colors: MoonChipColors.light,
    sizes: MoonChipSizes.sizes,
  );

  static final dark = MoonChipTheme(
    colors: MoonChipColors.dark,
    sizes: MoonChipSizes.sizes,
  );

  /// Chip colors.
  final MoonChipColors colors;

  /// Chip sizes.
  final MoonChipSizes sizes;

  const MoonChipTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonChipTheme copyWith({
    MoonChipColors? colors,
    MoonChipSizes? sizes,
  }) {
    return MoonChipTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonChipTheme lerp(ThemeExtension<MoonChipTheme>? other, double t) {
    if (other is! MoonChipTheme) return this;

    return MoonChipTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipTheme"))
      ..add(DiagnosticsProperty<MoonChipColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonChipSizes>("sizes", sizes));
  }
}
