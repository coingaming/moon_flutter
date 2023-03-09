import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_colors.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_sizes.dart';

@immutable
class MoonCircularProgressTheme extends ThemeExtension<MoonCircularProgressTheme> with DiagnosticableTreeMixin {
  static final light = MoonCircularProgressTheme(
    colors: MoonCircularProgressColors.light,
    sizes: MoonCircularProgressSizes.sizes,
  );

  static final dark = MoonCircularProgressTheme(
    colors: MoonCircularProgressColors.dark,
    sizes: MoonCircularProgressSizes.sizes,
  );

  /// Circular progress colors.
  final MoonCircularProgressColors colors;

  /// Circular progress sizes.
  final MoonCircularProgressSizes sizes;

  const MoonCircularProgressTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonCircularProgressTheme copyWith({
    MoonCircularProgressColors? colors,
    MoonCircularProgressSizes? sizes,
  }) {
    return MoonCircularProgressTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonCircularProgressTheme lerp(ThemeExtension<MoonCircularProgressTheme>? other, double t) {
    if (other is! MoonCircularProgressTheme) return this;

    return MoonCircularProgressTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressTheme"))
      ..add(DiagnosticsProperty<MoonCircularProgressColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCircularProgressSizes>("sizes", sizes));
  }
}
