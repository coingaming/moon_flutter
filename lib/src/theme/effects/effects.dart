import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';

@immutable
class MoonEffects extends ThemeExtension<MoonEffects> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Control widgets focus effect.
  final MoonFocusEffects controlFocusEffect;

  /// Control widgets hover effect.
  final MoonHoverEffects controlHoverEffect;

  /// Control widgets focus effect.
  final MoonControlsEffects controlPulseEffect;

  /// Control widgets scale effect.
  final MoonControlsEffects controlScaleEffect;

  MoonEffects({
    required this.tokens,
    MoonFocusEffects? controlFocusEffect,
    MoonHoverEffects? controlHoverEffect,
    MoonControlsEffects? controlPulseEffect,
    MoonControlsEffects? controlScaleEffect,
  })  : controlFocusEffect = controlFocusEffect ??
            MoonFocusEffects(
              effectColor: tokens.colors.bulma.withOpacity(0.25),
              effectExtent: 4,
              effectDuration: tokens.transitions.defaultTransitionDuration,
              effectCurve: tokens.transitions.defaultTransitionCurve,
            ),
        controlHoverEffect = controlHoverEffect ??
            MoonHoverEffects(
              primaryHoverColor: tokens.colors.heles,
              secondaryHoverColor: tokens.colors.jiren,
              hoverDuration: tokens.transitions.defaultTransitionDuration,
              hoverCurve: tokens.transitions.defaultTransitionCurve,
            ),
        controlPulseEffect = controlPulseEffect ??
            MoonControlsEffects(
              effectColor: tokens.colors.piccolo,
              effectDuration: const Duration(milliseconds: 1400),
              effectCurve: tokens.transitions.defaultTransitionCurve,
              effectExtent: 24,
            ),
        controlScaleEffect = controlScaleEffect ??
            MoonControlsEffects(
              effectDuration: tokens.transitions.defaultTransitionDuration,
              effectCurve: tokens.transitions.defaultTransitionCurve,
              effectScalar: 0.95,
            );

  @override
  MoonEffects copyWith({
    MoonTokens? tokens,
    MoonFocusEffects? controlFocusEffect,
    MoonHoverEffects? controlHoverEffect,
    MoonControlsEffects? controlPulseEffect,
    MoonControlsEffects? controlScaleEffect,
  }) {
    return MoonEffects(
      tokens: tokens ?? this.tokens,
      controlFocusEffect: controlFocusEffect ?? this.controlFocusEffect,
      controlHoverEffect: controlHoverEffect ?? this.controlHoverEffect,
      controlPulseEffect: controlPulseEffect ?? this.controlPulseEffect,
      controlScaleEffect: controlScaleEffect ?? this.controlScaleEffect,
    );
  }

  @override
  MoonEffects lerp(ThemeExtension<MoonEffects>? other, double t) {
    if (other is! MoonEffects) return this;

    return MoonEffects(
      tokens: tokens.lerp(other.tokens, t),
      controlFocusEffect: controlFocusEffect.lerp(other.controlFocusEffect, t),
      controlHoverEffect: controlHoverEffect.lerp(other.controlHoverEffect, t),
      controlScaleEffect: controlScaleEffect.lerp(other.controlScaleEffect, t),
      controlPulseEffect: controlPulseEffect.lerp(other.controlPulseEffect, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonEffects"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonControlsEffects>("controlScaleEffect", controlScaleEffect))
      ..add(DiagnosticsProperty<MoonControlsEffects>("controlPulseEffect", controlPulseEffect))
      ..add(DiagnosticsProperty<MoonFocusEffects>("controlFocusEffect", controlFocusEffect))
      ..add(DiagnosticsProperty<MoonHoverEffects>("controlHoverEffect", controlHoverEffect));
  }
}
