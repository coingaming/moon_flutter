import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_colors.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_sizes.dart';

@immutable
class MoonLinearProgressTheme extends ThemeExtension<MoonLinearProgressTheme> with DiagnosticableTreeMixin {
  static final light = MoonLinearProgressTheme(
    colors: MoonLinearProgressColors.light,
    sizes: MoonLinearProgressSizes.sizes,
  );

  static final dark = MoonLinearProgressTheme(
    colors: MoonLinearProgressColors.dark,
    sizes: MoonLinearProgressSizes.sizes,
  );

  /// Linear progress colors.
  final MoonLinearProgressColors colors;

  /// Linear progress sizes.
  final MoonLinearProgressSizes sizes;

  const MoonLinearProgressTheme({
    required this.colors,
    required this.sizes,
  });

  @override
  MoonLinearProgressTheme copyWith({
    MoonLinearProgressColors? colors,
    MoonLinearProgressSizes? sizes,
  }) {
    return MoonLinearProgressTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonLinearProgressTheme lerp(ThemeExtension<MoonLinearProgressTheme>? other, double t) {
    if (other is! MoonLinearProgressTheme) return this;

    return MoonLinearProgressTheme(
      colors: colors.lerp(other.colors, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressTheme"))
      ..add(DiagnosticsProperty<MoonLinearProgressColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonLinearProgressSizes>("sizes", sizes));
  }
}
