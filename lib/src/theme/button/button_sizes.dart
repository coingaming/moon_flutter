import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/button/button_size_properties.dart';

@immutable
class MoonButtonSizes extends ThemeExtension<MoonButtonSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonButtonSizes(
    xs: MoonButtonSizeProperties.xs,
    sm: MoonButtonSizeProperties.sm,
    md: MoonButtonSizeProperties.md,
    lg: MoonButtonSizeProperties.lg,
    xl: MoonButtonSizeProperties.xl,
  );

  /// Extra small button properties.
  final MoonButtonSizeProperties xs;

  /// Small button properties.
  final MoonButtonSizeProperties sm;

  /// Medium button properties.
  final MoonButtonSizeProperties md;

  /// Large button properties.
  final MoonButtonSizeProperties lg;

  /// Extra large button properties.
  final MoonButtonSizeProperties xl;

  const MoonButtonSizes({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  @override
  MoonButtonSizes copyWith({
    MoonButtonSizeProperties? xs,
    MoonButtonSizeProperties? sm,
    MoonButtonSizeProperties? md,
    MoonButtonSizeProperties? lg,
    MoonButtonSizeProperties? xl,
  }) {
    return MoonButtonSizes(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonButtonSizes lerp(ThemeExtension<MoonButtonSizes>? other, double t) {
    if (other is! MoonButtonSizes) return this;

    return MoonButtonSizes(
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonSizes"))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("xl", xl));
  }
}
