import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTransitionEffects extends ThemeExtension<MoonTransitionEffects> with DiagnosticableTreeMixin {
  static const arrival = MoonTransitionEffects(
    transitionCurve: Curves.easeOut,
    transitionDuration: Duration(milliseconds: 300),
  );

  static const departure = MoonTransitionEffects(
    transitionCurve: Curves.easeIn,
    transitionDuration: Duration(milliseconds: 200),
  );

  static const controlScaleEffect = MoonTransitionEffects(
    transitionCurve: Curves.easeInOut,
    transitionDuration: Duration(milliseconds: 150),
    transitionLowerBound: 0.9,
  );

  static const controlFocusEffect = MoonTransitionEffects(
    transitionCurve: Curves.easeInOut,
    transitionDuration: Duration(milliseconds: 150),
    transitionLowerBound: 0.9,
  );

  static const buttonHoverEffect = MoonTransitionEffects(
    transitionCurve: Curves.easeInOut,
    transitionDuration: Duration(milliseconds: 150),
    transitionLowerBound: 0.9,
  );

  /// Transition effect curve.
  final Curve transitionCurve;

  /// Transition effect duration.
  final Duration transitionDuration;

  /// Transition effect AnimationController lower bound value.
  final double transitionLowerBound;

  const MoonTransitionEffects({
    required this.transitionCurve,
    required this.transitionDuration,
    this.transitionLowerBound = 0,
  });

  @override
  MoonTransitionEffects copyWith({
    Curve? transitionCurve,
    Duration? transitionDuration,
    double? transitionLowerBound,
  }) {
    return MoonTransitionEffects(
      transitionCurve: transitionCurve ?? this.transitionCurve,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionLowerBound: transitionLowerBound ?? this.transitionLowerBound,
    );
  }

  @override
  MoonTransitionEffects lerp(ThemeExtension<MoonTransitionEffects>? other, double t) {
    if (other is! MoonTransitionEffects) return this;

    return MoonTransitionEffects(
      transitionCurve: other.transitionCurve,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionLowerBound: lerpDouble(transitionLowerBound, other.transitionLowerBound, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTransitionEffects"))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DoubleProperty("transitionLowerBound", transitionLowerBound));
  }
}
