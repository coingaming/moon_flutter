import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/circular_progress/circular_progress_sizes.dart';

@immutable
class MoonCircularProgressTheme extends ThemeExtension<MoonCircularProgressTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonCircularProgressTheme(
    x2s: MoonCircularProgressSizes.x2s,
    xs: MoonCircularProgressSizes.xs,
    sm: MoonCircularProgressSizes.sm,
    md: MoonCircularProgressSizes.md,
    lg: MoonCircularProgressSizes.lg,
  );

  /// (2x) Extra small circular progress properties.
  final MoonCircularProgressSizes x2s;

  /// Extra small circular progress properties.
  final MoonCircularProgressSizes xs;

  /// Small circular progress properties.
  final MoonCircularProgressSizes sm;

  /// Medium circular progress properties.
  final MoonCircularProgressSizes md;

  /// Large circular progress properties.
  final MoonCircularProgressSizes lg;

  const MoonCircularProgressTheme({
    required this.x2s,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  @override
  MoonCircularProgressTheme copyWith({
    MoonCircularProgressSizes? x2s,
    MoonCircularProgressSizes? xs,
    MoonCircularProgressSizes? sm,
    MoonCircularProgressSizes? md,
    MoonCircularProgressSizes? lg,
  }) {
    return MoonCircularProgressTheme(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonCircularProgressTheme lerp(ThemeExtension<MoonCircularProgressTheme>? other, double t) {
    if (other is! MoonCircularProgressTheme) return this;

    return MoonCircularProgressTheme(
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressTheme"))
      ..add(DiagnosticsProperty<MoonCircularProgressSizes>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonCircularProgressSizes>("xs", xs))
      ..add(DiagnosticsProperty<MoonCircularProgressSizes>("sm", sm))
      ..add(DiagnosticsProperty<MoonCircularProgressSizes>("md", md))
      ..add(DiagnosticsProperty<MoonCircularProgressSizes>("lg", lg));
  }
}
