import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:moon_design/src/theme/transition_effects.dart';

@immutable
class MoonTransitions extends ThemeExtension<MoonTransitions> with DiagnosticableTreeMixin {
  /// Arrival effect.
  final MoonTransitionEffects arrival;

  /// Departure effect.
  final MoonTransitionEffects departure;

  const MoonTransitions({
    this.arrival = MoonTransitionEffects.arrival,
    this.departure = MoonTransitionEffects.departure,
  });

  @override
  MoonTransitions copyWith({
    MoonTransitionEffects? arrival,
    MoonTransitionEffects? departure,
  }) {
    return MoonTransitions(
      arrival: arrival ?? this.arrival,
      departure: departure ?? this.departure,
    );
  }

  @override
  MoonTransitions lerp(ThemeExtension<MoonTransitions>? other, double t) {
    if (other is! MoonTransitions) return this;

    return MoonTransitions(
      arrival: other.arrival,
      departure: other.departure,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTransitions"))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("arrival", arrival))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("departure", departure));
  }
}
