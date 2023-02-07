import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonControlsEffects extends ThemeExtension<MoonControlsEffects> with DiagnosticableTreeMixin {
  static const controlScaleEffect = MoonControlsEffects(
    effectCurve: Curves.easeInOutCubic,
    effectDuration: Duration(milliseconds: 150),
    effectScalar: 0.95,
  );

  static final controlPulseEffect = MoonControlsEffects(
    effectCurve: Curves.easeInOutCubic,
    effectDuration: const Duration(milliseconds: 1400),
    effectColor: MoonColors.light.piccolo,
    effectExtent: 24,
  );

  /// Controls effect curve.
  final Curve effectCurve;

  /// Controls effect duration.
  final Duration effectDuration;

  /// Controls effect color.
  final Color? effectColor;

  /// Controls effect width.
  final double? effectExtent;

  /// Controls effect final scale.
  final double? effectScalar;

  const MoonControlsEffects({
    required this.effectCurve,
    required this.effectDuration,
    this.effectColor,
    this.effectExtent,
    this.effectScalar,
  });

  @override
  MoonControlsEffects copyWith({
    Curve? effectCurve,
    Duration? effectDuration,
    Color? effectColor,
    double? effectExtent,
    double? effectScalar,
  }) {
    return MoonControlsEffects(
      effectCurve: effectCurve ?? this.effectCurve,
      effectDuration: effectDuration ?? this.effectDuration,
      effectColor: effectColor ?? this.effectColor,
      effectExtent: effectExtent ?? this.effectExtent,
      effectScalar: effectScalar ?? this.effectScalar,
    );
  }

  @override
  MoonControlsEffects lerp(ThemeExtension<MoonControlsEffects>? other, double t) {
    if (other is! MoonControlsEffects) return this;

    return MoonControlsEffects(
      effectCurve: other.effectCurve,
      effectDuration: lerpDuration(effectDuration, other.effectDuration, t),
      effectColor: Color.lerp(effectColor, other.effectColor, t),
      effectExtent: lerpDouble(effectExtent, other.effectExtent, t),
      effectScalar: lerpDouble(effectScalar, other.effectScalar, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonControlsEffects"))
      ..add(DiagnosticsProperty<Curve>("effectCurve", effectCurve))
      ..add(DiagnosticsProperty<Duration>("effectDuration", effectDuration))
      ..add(ColorProperty("effectColor", effectColor))
      ..add(DoubleProperty("effectExtent", effectExtent))
      ..add(DoubleProperty("transitionLowerBound", effectScalar));
  }
}
