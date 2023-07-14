import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/iconography/icon_colors.dart';

@immutable
class MoonIconography extends ThemeExtension<MoonIconography> with DiagnosticableTreeMixin {
  static final light = MoonIconography(
    colors: MoonIconColors.light,
  );

  static final dark = MoonIconography(
    colors: MoonIconColors.dark,
  );

  /// Colors for icons.
  final MoonIconColors colors;

  const MoonIconography({
    required this.colors,
  });

  @override
  MoonIconography copyWith({
    MoonIconColors? colors,
  }) {
    return MoonIconography(
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonIconography lerp(ThemeExtension<MoonIconography>? other, double t) {
    if (other is! MoonIconography) return this;

    return MoonIconography(
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
