import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

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

  // Transition effect curve.
  final Curve transitionCurve;
  // Transition effect duration.
  final Duration transitionDuration;

  const MoonTransitionEffects({
    required this.transitionCurve,
    required this.transitionDuration,
  });

  @override
  MoonTransitionEffects copyWith({
    Curve? transitionCurve,
    Duration? transitionDuration,
  }) {
    return MoonTransitionEffects(
      transitionCurve: transitionCurve ?? this.transitionCurve,
      transitionDuration: transitionDuration ?? this.transitionDuration,
    );
  }

  @override
  MoonTransitionEffects lerp(ThemeExtension<MoonTransitionEffects>? other, double t) {
    if (other is! MoonTransitionEffects) return this;

    return MoonTransitionEffects(
      transitionCurve: other.transitionCurve,
      transitionDuration: other.transitionDuration,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTransitionEffects"))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration));
  }
}
