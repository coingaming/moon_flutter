import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonControlsEffects extends ThemeExtension<MoonControlsEffects> with DiagnosticableTreeMixin {
  static const controlScaleEffect = MoonControlsEffects(
    effectDuration: Duration(milliseconds: 150),
    effectCurve: Curves.easeInOutCubic,
    effectScalar: 0.95,
  );

  static final controlPulseEffect = MoonControlsEffects(
    effectColor: MoonColors.light.piccolo,
    effectDuration: const Duration(milliseconds: 1400),
    effectCurve: Curves.easeInOutCubic,
    effectExtent: 24,
  );

  /// Controls effect color.
  final Color? effectColor;

  /// Controls effect duration.
  final Duration effectDuration;

  /// Controls effect curve.
  final Curve effectCurve;

  /// Controls effect width.
  final double? effectExtent;

  /// Controls effect final scale.
  final double? effectScalar;

  const MoonControlsEffects({
    this.effectColor,
    required this.effectDuration,
    required this.effectCurve,
    this.effectExtent,
    this.effectScalar,
  });

  @override
  MoonControlsEffects copyWith({
    Color? effectColor,
    Duration? effectDuration,
    Curve? effectCurve,
    double? effectExtent,
    double? effectScalar,
  }) {
    return MoonControlsEffects(
      effectColor: effectColor ?? this.effectColor,
      effectDuration: effectDuration ?? this.effectDuration,
      effectCurve: effectCurve ?? this.effectCurve,
      effectExtent: effectExtent ?? this.effectExtent,
      effectScalar: effectScalar ?? this.effectScalar,
    );
  }

  @override
  MoonControlsEffects lerp(ThemeExtension<MoonControlsEffects>? other, double t) {
    if (other is! MoonControlsEffects) return this;

    return MoonControlsEffects(
      effectColor: colorPremulLerp(effectColor, other.effectColor, t),
      effectDuration: lerpDuration(effectDuration, other.effectDuration, t),
      effectCurve: other.effectCurve,
      effectExtent: lerpDouble(effectExtent, other.effectExtent, t),
      effectScalar: lerpDouble(effectScalar, other.effectScalar, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonControlsEffects"))
      ..add(ColorProperty("effectColor", effectColor))
      ..add(DiagnosticsProperty<Duration>("effectDuration", effectDuration))
      ..add(DiagnosticsProperty<Curve>("effectCurve", effectCurve))
      ..add(DoubleProperty("effectExtent", effectExtent))
      ..add(DoubleProperty("effectScalar", effectScalar));
  }
}
