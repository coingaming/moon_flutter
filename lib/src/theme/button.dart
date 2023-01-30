import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/button_sizes.dart';

@immutable
class MoonButton extends ThemeExtension<MoonButton> with DiagnosticableTreeMixin {
  static final sizes = MoonButton(
    xs: MoonButtonSizes.xs,
    sm: MoonButtonSizes.sm,
    md: MoonButtonSizes.md,
    lg: MoonButtonSizes.lg,
    xl: MoonButtonSizes.xl,
  );

  /// Extra small button properties.
  final MoonButtonSizes xs;

  /// Small button properties.
  final MoonButtonSizes sm;

  /// Medium button properties.
  final MoonButtonSizes md;

  /// Large button properties.
  final MoonButtonSizes lg;

  /// Extra large button properties.
  final MoonButtonSizes xl;

  const MoonButton({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  @override
  MoonButton copyWith({
    MoonButtonSizes? xs,
    MoonButtonSizes? sm,
    MoonButtonSizes? md,
    MoonButtonSizes? lg,
    MoonButtonSizes? xl,
  }) {
    return MoonButton(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonButton lerp(ThemeExtension<MoonButton>? other, double t) {
    if (other is! MoonButton) return this;

    return MoonButton(
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
      ..add(DiagnosticsProperty("type", "MoonButton"))
      ..add(DiagnosticsProperty<MoonButtonSizes>("xs", xs))
      ..add(DiagnosticsProperty<MoonButtonSizes>("sm", sm))
      ..add(DiagnosticsProperty<MoonButtonSizes>("md", md))
      ..add(DiagnosticsProperty<MoonButtonSizes>("lg", lg))
      ..add(DiagnosticsProperty<MoonButtonSizes>("xl", xl));
  }
}
