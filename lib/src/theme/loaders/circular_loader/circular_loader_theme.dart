import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_colors.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_sizes.dart';

@immutable
class MoonCircularLoaderTheme extends ThemeExtension<MoonCircularLoaderTheme> with DiagnosticableTreeMixin {
  static final light = MoonCircularLoaderTheme(
    colors: MoonCircularLoaderColors.light,
    sizes: MoonCircularLoaderSizes.sizes,
  );

  static final dark = MoonCircularLoaderTheme(
    colors: MoonCircularLoaderColors.dark,
    sizes: MoonCircularLoaderSizes.sizes,
  );

  /// Circular loader colors.
  final MoonCircularLoaderColors colors;

  /// Circular loader sizes.
  final MoonCircularLoaderSizes sizes;

  const MoonCircularLoaderTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonCircularLoaderTheme copyWith({
    MoonCircularLoaderColors? colors,
    MoonCircularLoaderSizes? sizes,
  }) {
    return MoonCircularLoaderTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonCircularLoaderTheme lerp(ThemeExtension<MoonCircularLoaderTheme>? other, double t) {
    if (other is! MoonCircularLoaderTheme) return this;

    return MoonCircularLoaderTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderTheme"))
      ..add(DiagnosticsProperty<MoonCircularLoaderColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizes>("sizes", sizes));
  }
}
