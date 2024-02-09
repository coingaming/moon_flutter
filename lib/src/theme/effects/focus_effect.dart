import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonFocusEffect extends ThemeExtension<MoonFocusEffect> with DiagnosticableTreeMixin {
  /// The color of the focus effect.
  final Color effectColor;

  /// The extent of the focus effect.
  final double effectExtent;

  /// The duration of the focus effect.
  final Duration effectDuration;

  /// The curve of the focus effect.
  final Curve effectCurve;

  const MoonFocusEffect({
    required this.effectColor,
    required this.effectExtent,
    required this.effectDuration,
    required this.effectCurve,
  });

  @override
  MoonFocusEffect copyWith({
    Color? effectColor,
    double? effectExtent,
    Duration? effectDuration,
    Curve? effectCurve,
  }) {
    return MoonFocusEffect(
      effectColor: effectColor ?? this.effectColor,
      effectExtent: effectExtent ?? this.effectExtent,
      effectDuration: effectDuration ?? this.effectDuration,
      effectCurve: effectCurve ?? this.effectCurve,
    );
  }

  @override
  MoonFocusEffect lerp(ThemeExtension<MoonFocusEffect>? other, double t) {
    if (other is! MoonFocusEffect) return this;

    return MoonFocusEffect(
      effectColor: colorPremulLerp(effectColor, other.effectColor, t)!,
      effectExtent: lerpDouble(effectExtent, other.effectExtent, t)!,
      effectDuration: lerpDuration(effectDuration, other.effectDuration, t),
      effectCurve: other.effectCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonFocusEffects"))
      ..add(ColorProperty("effectColor", effectColor))
      ..add(DoubleProperty("effectExtent", effectExtent))
      ..add(DiagnosticsProperty<Duration>("effectDuration", effectDuration))
      ..add(DiagnosticsProperty<Curve>("effectCurve", effectCurve));
  }
}
