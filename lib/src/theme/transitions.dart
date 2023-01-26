import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:moon_design/src/theme/transition_effects.dart';

@immutable
class MoonTransitions extends ThemeExtension<MoonTransitions> with DiagnosticableTreeMixin {
  /// Arrival effect.
  final MoonTransitionEffects arrival;

  /// Departure effect.
  final MoonTransitionEffects departure;

  /// Button effect.
  final MoonTransitionEffects buttonEffect;

  const MoonTransitions({
    this.arrival = MoonTransitionEffects.arrival,
    this.departure = MoonTransitionEffects.departure,
    this.buttonEffect = MoonTransitionEffects.buttonEffect,
  });

  @override
  MoonTransitions copyWith({
    MoonTransitionEffects? arrival,
    MoonTransitionEffects? departure,
    MoonTransitionEffects? buttonEffect,
  }) {
    return MoonTransitions(
      arrival: arrival ?? this.arrival,
      departure: departure ?? this.departure,
      buttonEffect: buttonEffect ?? this.buttonEffect,
    );
  }

  @override
  MoonTransitions lerp(ThemeExtension<MoonTransitions>? other, double t) {
    if (other is! MoonTransitions) return this;

    return MoonTransitions(
      arrival: other.arrival,
      departure: other.departure,
      buttonEffect: other.buttonEffect,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTransitions"))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("arrival", arrival))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("departure", departure))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("buttonEffect", buttonEffect));
  }
}
