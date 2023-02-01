import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonFocusEffects extends ThemeExtension<MoonFocusEffects> with DiagnosticableTreeMixin {
  static const lightFocusEffect = MoonFocusEffects(
    effectColor: Colors.black26,
    effectExtent: 4,
    effectCurve: Curves.easeInOut,
    effectDuration: Duration(milliseconds: 150),
  );

  static const darkFocusEffect = MoonFocusEffects(
    effectColor: Colors.white24,
    effectExtent: 4,
    effectCurve: Curves.easeInOut,
    effectDuration: Duration(milliseconds: 150),
  );

  /// Focus effect color.
  final Color effectColor;

  /// Focus effect extent.
  final double effectExtent;

  /// Focus effect curve.
  final Curve effectCurve;

  /// Focus effect duration.
  final Duration effectDuration;

  const MoonFocusEffects({
    required this.effectColor,
    required this.effectExtent,
    required this.effectCurve,
    required this.effectDuration,
  });

  @override
  MoonFocusEffects copyWith({
    Color? effectColor,
    double? effectExtent,
    Curve? effectCurve,
    Duration? effectDuration,
  }) {
    return MoonFocusEffects(
      effectColor: effectColor ?? this.effectColor,
      effectExtent: effectExtent ?? this.effectExtent,
      effectCurve: effectCurve ?? this.effectCurve,
      effectDuration: effectDuration ?? this.effectDuration,
    );
  }

  @override
  MoonFocusEffects lerp(ThemeExtension<MoonFocusEffects>? other, double t) {
    if (other is! MoonFocusEffects) return this;

    return MoonFocusEffects(
      effectColor: Color.lerp(effectColor, other.effectColor, t)!,
      effectExtent: lerpDouble(effectExtent, other.effectExtent, t)!,
      effectCurve: other.effectCurve,
      effectDuration: lerpDuration(effectDuration, other.effectDuration, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonFocusEffects"))
      ..add(ColorProperty("effectColor", effectColor))
      ..add(DoubleProperty("effectExtent", effectExtent))
      ..add(DiagnosticsProperty<Curve>("effectCurve", effectCurve))
      ..add(DiagnosticsProperty<Duration>("effectDuration", effectDuration));
  }
}
