import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_size_properties.dart';

@immutable
class MoonCircularProgressSizes extends ThemeExtension<MoonCircularProgressSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonCircularProgressSizes(
    x2s: MoonCircularProgressSizeProperties.x2s,
    xs: MoonCircularProgressSizeProperties.xs,
    sm: MoonCircularProgressSizeProperties.sm,
    md: MoonCircularProgressSizeProperties.md,
    lg: MoonCircularProgressSizeProperties.lg,
  );

  /// (2x) Extra small circular progress properties.
  final MoonCircularProgressSizeProperties x2s;

  /// Extra small circular progress properties.
  final MoonCircularProgressSizeProperties xs;

  /// Small circular progress properties.
  final MoonCircularProgressSizeProperties sm;

  /// Medium circular progress properties.
  final MoonCircularProgressSizeProperties md;

  /// Large circular progress properties.
  final MoonCircularProgressSizeProperties lg;

  const MoonCircularProgressSizes({
    required this.x2s,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  @override
  MoonCircularProgressSizes copyWith({
    MoonCircularProgressSizeProperties? x2s,
    MoonCircularProgressSizeProperties? xs,
    MoonCircularProgressSizeProperties? sm,
    MoonCircularProgressSizeProperties? md,
    MoonCircularProgressSizeProperties? lg,
  }) {
    return MoonCircularProgressSizes(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonCircularProgressSizes lerp(ThemeExtension<MoonCircularProgressSizes>? other, double t) {
    if (other is! MoonCircularProgressSizes) return this;

    return MoonCircularProgressSizes(
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
      ..add(DiagnosticsProperty("type", "MoonCircularProgressSizes"))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("lg", lg));
  }
}
