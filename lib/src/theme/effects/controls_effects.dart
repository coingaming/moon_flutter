import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonControlsEffects extends ThemeExtension<MoonControlsEffects> with DiagnosticableTreeMixin {
  static const controlScaleEffect = MoonControlsEffects(
    effectDuration: Duration(milliseconds: 150),
    effectCurve: Curves.easeInOutCubic,
    effectScalar: 0.95,
  );

  static final controlPulseEffect = MoonControlsEffects(
    effectDuration: const Duration(milliseconds: 1400),
    effectCurve: Curves.easeInOutCubic,
    effectColor: MoonColors.light.piccolo,
    effectExtent: 24,
  );

  /// Controls effect duration.
  final Duration effectDuration;

  /// Controls effect curve.
  final Curve effectCurve;

  /// Controls effect color.
  final Color? effectColor;

  /// Controls effect width.
  final double? effectExtent;

  /// Controls effect final scale.
  final double? effectScalar;

  const MoonControlsEffects({
    required this.effectDuration,
    required this.effectCurve,
    this.effectColor,
    this.effectExtent,
    this.effectScalar,
  });

  @override
  MoonControlsEffects copyWith({
    Duration? effectDuration,
    Curve? effectCurve,
    Color? effectColor,
    double? effectExtent,
    double? effectScalar,
  }) {
    return MoonControlsEffects(
      effectDuration: effectDuration ?? this.effectDuration,
      effectCurve: effectCurve ?? this.effectCurve,
      effectColor: effectColor ?? this.effectColor,
      effectExtent: effectExtent ?? this.effectExtent,
      effectScalar: effectScalar ?? this.effectScalar,
    );
  }

  @override
  MoonControlsEffects lerp(ThemeExtension<MoonControlsEffects>? other, double t) {
    if (other is! MoonControlsEffects) return this;

    return MoonControlsEffects(
      effectDuration: lerpDuration(effectDuration, other.effectDuration, t),
      effectCurve: other.effectCurve,
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
      ..add(DiagnosticsProperty<Duration>("effectDuration", effectDuration))
      ..add(DiagnosticsProperty<Curve>("effectCurve", effectCurve))
      ..add(ColorProperty("effectColor", effectColor))
      ..add(DoubleProperty("effectExtent", effectExtent))
      ..add(DoubleProperty("transitionLowerBound", effectScalar));
  }
}
