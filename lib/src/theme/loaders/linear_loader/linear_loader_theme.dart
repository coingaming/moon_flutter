import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_colors.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_sizes.dart';

@immutable
class MoonLinearLoaderTheme extends ThemeExtension<MoonLinearLoaderTheme> with DiagnosticableTreeMixin {
  static final light = MoonLinearLoaderTheme(
    colors: MoonLinearLoaderColors.light,
    sizes: MoonLinearLoaderSizes.sizes,
  );

  static final dark = MoonLinearLoaderTheme(
    colors: MoonLinearLoaderColors.dark,
    sizes: MoonLinearLoaderSizes.sizes,
  );

  /// Circular loader colors.
  final MoonLinearLoaderColors colors;

  /// Circular loader sizes.
  final MoonLinearLoaderSizes sizes;

  const MoonLinearLoaderTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonLinearLoaderTheme copyWith({
    MoonLinearLoaderColors? colors,
    MoonLinearLoaderSizes? sizes,
  }) {
    return MoonLinearLoaderTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonLinearLoaderTheme lerp(ThemeExtension<MoonLinearLoaderTheme>? other, double t) {
    if (other is! MoonLinearLoaderTheme) return this;

    return MoonLinearLoaderTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderTheme"))
      ..add(DiagnosticsProperty<MoonLinearLoaderColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizes>("sizes", sizes));
  }
}
