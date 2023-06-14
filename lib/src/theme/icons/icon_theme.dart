import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/icons/icon_colors.dart';

@immutable
class MoonIconTheme extends ThemeExtension<MoonIconTheme> with DiagnosticableTreeMixin {
  static final light = MoonIconTheme(
    colors: MoonIconColors.light,
  );

  static final dark = MoonIconTheme(
    colors: MoonIconColors.dark,
  );

  /// Colors for icons.
  final MoonIconColors colors;

  const MoonIconTheme({
    required this.colors,
  });

  @override
  MoonIconTheme copyWith({
    MoonIconColors? colors,
  }) {
    return MoonIconTheme(
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonIconTheme lerp(ThemeExtension<MoonIconTheme>? other, double t) {
    if (other is! MoonIconTheme) return this;

    return MoonIconTheme(
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonIcons"))
      ..add(DiagnosticsProperty("colors", colors));
  }
}
