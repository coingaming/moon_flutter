import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import 'package:moon_design/src/theme/transition_effects.dart';

@immutable
class MoonTransitions extends ThemeExtension<MoonTransitions> with DiagnosticableTreeMixin {
  /// Arrival effect.
  final MoonTransitionEffects arrival;

  /// Departure effect.
  final MoonTransitionEffects departure;

  /// Controls scale effect.
  final MoonTransitionEffects controlScaleEffect;

  /// Controls focus effect.
  final MoonTransitionEffects controlFocusEffect;

  /// Button hover effect.
  final MoonTransitionEffects buttonHoverEffect;

  const MoonTransitions({
    this.arrival = MoonTransitionEffects.arrival,
    this.departure = MoonTransitionEffects.departure,
    this.controlScaleEffect = MoonTransitionEffects.controlScaleEffect,
    this.controlFocusEffect = MoonTransitionEffects.controlFocusEffect,
    this.buttonHoverEffect = MoonTransitionEffects.buttonHoverEffect,
  });

  @override
  MoonTransitions copyWith({
    MoonTransitionEffects? arrival,
    MoonTransitionEffects? departure,
    MoonTransitionEffects? controlScaleEffect,
    MoonTransitionEffects? controlFocusEffect,
    MoonTransitionEffects? buttonHoverEffect,
  }) {
    return MoonTransitions(
      arrival: arrival ?? this.arrival,
      departure: departure ?? this.departure,
      controlScaleEffect: controlScaleEffect ?? this.controlScaleEffect,
      controlFocusEffect: controlFocusEffect ?? this.controlFocusEffect,
      buttonHoverEffect: buttonHoverEffect ?? this.buttonHoverEffect,
    );
  }

  @override
  MoonTransitions lerp(ThemeExtension<MoonTransitions>? other, double t) {
    if (other is! MoonTransitions) return this;

    return MoonTransitions(
      arrival: arrival.lerp(other.arrival, t),
      departure: departure.lerp(other.departure, t),
      controlScaleEffect: controlScaleEffect.lerp(other.controlScaleEffect, t),
      controlFocusEffect: controlFocusEffect.lerp(other.controlFocusEffect, t),
      buttonHoverEffect: buttonHoverEffect.lerp(other.buttonHoverEffect, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTransitions"))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("arrival", arrival))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("departure", departure))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("controlScaleEffect", controlScaleEffect))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("controlFocusEffect", controlFocusEffect))
      ..add(DiagnosticsProperty<MoonTransitionEffects>("buttonHoverEffect", buttonHoverEffect));
  }
}
