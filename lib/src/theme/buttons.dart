import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import 'package:moon_design/src/theme/button_size.dart';

@immutable
class MoonButtons extends ThemeExtension<MoonButtons> with DiagnosticableTreeMixin {
  /// Extra small button.
  final MoonButtonSize xs;

  /// Small button.
  final MoonButtonSize sm;

  /// Medium button.
  final MoonButtonSize md;

  /// Large button.
  final MoonButtonSize lg;

  /// Extra large button.
  final MoonButtonSize xl;

  const MoonButtons({
    this.xs = MoonButtonSize.xs,
    this.sm = MoonButtonSize.sm,
    this.md = MoonButtonSize.md,
    this.lg = MoonButtonSize.lg,
    this.xl = MoonButtonSize.xl,
  });

  @override
  MoonButtons copyWith({
    MoonButtonSize? xs,
    MoonButtonSize? sm,
    MoonButtonSize? md,
    MoonButtonSize? lg,
    MoonButtonSize? xl,
  }) {
    return MoonButtons(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonButtons lerp(ThemeExtension<MoonButtons>? other, double t) {
    if (other is! MoonButtons) return this;

    return MoonButtons(
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
      ..add(DiagnosticsProperty("type", "MoonButtons"))
      ..add(DiagnosticsProperty<MoonButtonSize>("xs", xs))
      ..add(DiagnosticsProperty<MoonButtonSize>("sm", sm))
      ..add(DiagnosticsProperty<MoonButtonSize>("md", md))
      ..add(DiagnosticsProperty<MoonButtonSize>("lg", lg))
      ..add(DiagnosticsProperty<MoonButtonSize>("xl", xl));
  }
}
