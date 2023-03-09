import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tag/tag_colors.dart';
import 'package:moon_design/src/theme/tag/tag_sizes.dart';

@immutable
class MoonTagTheme extends ThemeExtension<MoonTagTheme> with DiagnosticableTreeMixin {
  static final light = MoonTagTheme(
    colors: MoonTagColors.light,
    sizes: MoonTagSizes.sizes,
  );

  static final dark = MoonTagTheme(
    colors: MoonTagColors.dark,
    sizes: MoonTagSizes.sizes,
  );

  /// Tag colors.
  final MoonTagColors colors;

  /// Tag sizes.
  final MoonTagSizes sizes;

  const MoonTagTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonTagTheme copyWith({
    MoonTagColors? colors,
    MoonTagSizes? sizes,
  }) {
    return MoonTagTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonTagTheme lerp(ThemeExtension<MoonTagTheme>? other, double t) {
    if (other is! MoonTagTheme) return this;

    return MoonTagTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagTheme"))
      ..add(DiagnosticsProperty<MoonTagColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTagSizes>("sizes", sizes));
  }
}
