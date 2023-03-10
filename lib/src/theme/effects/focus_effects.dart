import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonFocusEffects extends ThemeExtension<MoonFocusEffects> with DiagnosticableTreeMixin {
  static const lightFocusEffect = MoonFocusEffects(
    effectColor: Colors.black26,
    effectExtent: 4,
    effectDuration: Duration(milliseconds: 150),
    effectCurve: Curves.easeInOutCubic,
  );

  static const darkFocusEffect = MoonFocusEffects(
    effectColor: Colors.white24,
    effectExtent: 4,
    effectDuration: Duration(milliseconds: 150),
    effectCurve: Curves.easeInOutCubic,
  );

  /// Focus effect color.
  final Color effectColor;

  /// Focus effect extent.
  final double effectExtent;

  /// Focus effect duration.
  final Duration effectDuration;

  /// Focus effect curve.
  final Curve effectCurve;

  const MoonFocusEffects({
    required this.effectColor,
    required this.effectExtent,
    required this.effectDuration,
    required this.effectCurve,
  });

  @override
  MoonFocusEffects copyWith({
    Color? effectColor,
    double? effectExtent,
    Duration? effectDuration,
    Curve? effectCurve,
  }) {
    return MoonFocusEffects(
      effectColor: effectColor ?? this.effectColor,
      effectExtent: effectExtent ?? this.effectExtent,
      effectDuration: effectDuration ?? this.effectDuration,
      effectCurve: effectCurve ?? this.effectCurve,
    );
  }

  @override
  MoonFocusEffects lerp(ThemeExtension<MoonFocusEffects>? other, double t) {
    if (other is! MoonFocusEffects) return this;

    return MoonFocusEffects(
      effectColor: Color.lerp(effectColor, other.effectColor, t)!,
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
