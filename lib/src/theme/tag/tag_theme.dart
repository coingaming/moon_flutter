import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tag/tag_sizes.dart';

@immutable
class MoonTagTheme extends ThemeExtension<MoonTagTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonTagTheme(
    x2s: MoonTagSizes.x2s,
    xs: MoonTagSizes.xs,
  );

  /// (2x) Extra small tag properties.
  final MoonTagSizes x2s;

  /// Extra small tag properties.
  final MoonTagSizes xs;

  const MoonTagTheme({
    required this.x2s,
    required this.xs,
  });

  @override
  MoonTagTheme copyWith({
    MoonTagSizes? x2s,
    MoonTagSizes? xs,
  }) {
    return MoonTagTheme(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
    );
  }

  @override
  MoonTagTheme lerp(ThemeExtension<MoonTagTheme>? other, double t) {
    if (other is! MoonTagTheme) return this;

    return MoonTagTheme(
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagTheme"))
      ..add(DiagnosticsProperty<MoonTagSizes>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonTagSizes>("xs", xs));
  }
}
