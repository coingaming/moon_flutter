import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonControlsEffects extends ThemeExtension<MoonControlsEffects> with DiagnosticableTreeMixin {
  static const controlScaleEffect = MoonControlsEffects(
    effectCurve: Curves.easeInOut,
    effectDuration: Duration(milliseconds: 150),
    effectLowerBound: 0.9,
  );

  static final controlFocusEffect = MoonControlsEffects(
    effectCurve: Curves.easeInOut,
    effectDuration: const Duration(milliseconds: 150),
    effectColor: MoonColors.light.jiren,
    effectWidth: 4,
  );

  static final controlPulseEffect = MoonControlsEffects(
    effectCurve: Curves.easeOutQuart,
    effectDuration: const Duration(milliseconds: 1500),
    effectColor: MoonColors.light.jiren,
    effectWidth: 30,
  );

  /// Controls effect curve.
  final Curve effectCurve;

  /// Controls effect duration.
  final Duration effectDuration;

  /// Controls effect color.
  final Color? effectColor;

  /// Controls effect width.
  final double? effectWidth;

  /// Controls effect AnimationController lower bound value.
  final double? effectLowerBound;

  const MoonControlsEffects({
    required this.effectCurve,
    required this.effectDuration,
    this.effectColor,
    this.effectWidth,
    this.effectLowerBound,
  });

  @override
  MoonControlsEffects copyWith({
    Curve? effectCurve,
    Duration? effectDuration,
    Color? effectColor,
    double? effectWidth,
    double? effectLowerBound,
  }) {
    return MoonControlsEffects(
      effectCurve: effectCurve ?? this.effectCurve,
      effectDuration: effectDuration ?? this.effectDuration,
      effectColor: effectColor ?? this.effectColor,
      effectWidth: effectWidth ?? this.effectWidth,
      effectLowerBound: effectLowerBound ?? this.effectLowerBound,
    );
  }

  @override
  MoonControlsEffects lerp(ThemeExtension<MoonControlsEffects>? other, double t) {
    if (other is! MoonControlsEffects) return this;

    return MoonControlsEffects(
      effectCurve: other.effectCurve,
      effectDuration: lerpDuration(effectDuration, other.effectDuration, t),
      effectColor: Color.lerp(effectColor, other.effectColor, t),
      effectWidth: lerpDouble(effectWidth, other.effectWidth, t),
      effectLowerBound: lerpDouble(effectLowerBound, other.effectLowerBound, t),
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
      ..add(DoubleProperty("effectWidth", effectWidth))
      ..add(DoubleProperty("transitionLowerBound", effectLowerBound));
  }
}
