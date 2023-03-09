import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_size_properties.dart';

@immutable
class MoonCircularLoaderSizes extends ThemeExtension<MoonCircularLoaderSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonCircularLoaderSizes(
    x2s: MoonCircularLoaderSizeProperties.x2s,
    xs: MoonCircularLoaderSizeProperties.xs,
    sm: MoonCircularLoaderSizeProperties.sm,
    md: MoonCircularLoaderSizeProperties.md,
    lg: MoonCircularLoaderSizeProperties.lg,
  );

  /// (2x) Extra small circular loader properties.
  final MoonCircularLoaderSizeProperties x2s;

  /// Extra small circular loader properties.
  final MoonCircularLoaderSizeProperties xs;

  /// Small circular loader properties.
  final MoonCircularLoaderSizeProperties sm;

  /// Medium circular loader properties.
  final MoonCircularLoaderSizeProperties md;

  /// Large circular loader properties.
  final MoonCircularLoaderSizeProperties lg;

  const MoonCircularLoaderSizes({
    required this.x2s,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  @override
  MoonCircularLoaderSizes copyWith({
    MoonCircularLoaderSizeProperties? x2s,
    MoonCircularLoaderSizeProperties? xs,
    MoonCircularLoaderSizeProperties? sm,
    MoonCircularLoaderSizeProperties? md,
    MoonCircularLoaderSizeProperties? lg,
  }) {
    return MoonCircularLoaderSizes(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonCircularLoaderSizes lerp(ThemeExtension<MoonCircularLoaderSizes>? other, double t) {
    if (other is! MoonCircularLoaderSizes) return this;

    return MoonCircularLoaderSizes(
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
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderSizes"))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("lg", lg));
  }
}
