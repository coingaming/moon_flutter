import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/control_effect.dart';
import 'package:moon_design/src/theme/effects/focus_effect.dart';
import 'package:moon_design/src/theme/effects/hover_effect.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonEffectsTheme extends ThemeExtension<MoonEffectsTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The focus effect properties of the control widgets.
  final MoonFocusEffect controlFocusEffect;

  /// The hover effect properties of the control widgets.
  final MoonHoverEffect controlHoverEffect;

  /// The pulse effect properties of the control widgets.
  final MoonControlEffect controlPulseEffect;

  /// The scale effect properties of the control widgets.
  final MoonControlEffect controlScaleEffect;

  MoonEffectsTheme({
    required this.tokens,
    MoonFocusEffect? controlFocusEffect,
    MoonHoverEffect? controlHoverEffect,
    MoonControlEffect? controlPulseEffect,
    MoonControlEffect? controlScaleEffect,
  })  : controlFocusEffect = controlFocusEffect ??
            MoonFocusEffect(
              effectColor: tokens.colors.bulma.withOpacity(0.25),
              effectExtent: 4,
              effectDuration: tokens.transitions.defaultTransitionDuration,
              effectCurve: tokens.transitions.defaultTransitionCurve,
            ),
        controlHoverEffect = controlHoverEffect ??
            MoonHoverEffect(
              primaryHoverColor: tokens.colors.heles,
              secondaryHoverColor: tokens.colors.jiren,
              hoverDuration: tokens.transitions.defaultTransitionDuration,
              hoverCurve: tokens.transitions.defaultTransitionCurve,
            ),
        controlPulseEffect = controlPulseEffect ??
            MoonControlEffect(
              effectColor: tokens.colors.piccolo,
              effectDuration: const Duration(milliseconds: 1400),
              effectCurve: tokens.transitions.defaultTransitionCurve,
              effectExtent: 24,
            ),
        controlScaleEffect = controlScaleEffect ??
            MoonControlEffect(
              effectDuration: tokens.transitions.defaultTransitionDuration,
              effectCurve: tokens.transitions.defaultTransitionCurve,
              effectScalar: 0.95,
            );

  @override
  MoonEffectsTheme copyWith({
    MoonTokens? tokens,
    MoonFocusEffect? controlFocusEffect,
    MoonHoverEffect? controlHoverEffect,
    MoonControlEffect? controlPulseEffect,
    MoonControlEffect? controlScaleEffect,
  }) {
    return MoonEffectsTheme(
      tokens: tokens ?? this.tokens,
      controlFocusEffect: controlFocusEffect ?? this.controlFocusEffect,
      controlHoverEffect: controlHoverEffect ?? this.controlHoverEffect,
      controlPulseEffect: controlPulseEffect ?? this.controlPulseEffect,
      controlScaleEffect: controlScaleEffect ?? this.controlScaleEffect,
    );
  }

  @override
  MoonEffectsTheme lerp(ThemeExtension<MoonEffectsTheme>? other, double t) {
    if (other is! MoonEffectsTheme) return this;

    return MoonEffectsTheme(
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
      ..add(DiagnosticsProperty("type", "MoonEffectsTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(
        DiagnosticsProperty<MoonControlEffect>(
          "controlScaleEffect",
          controlScaleEffect,
        ),
      )
      ..add(
        DiagnosticsProperty<MoonControlEffect>(
          "controlPulseEffect",
          controlPulseEffect,
        ),
      )
      ..add(
        DiagnosticsProperty<MoonFocusEffect>(
          "controlFocusEffect",
          controlFocusEffect,
        ),
      )
      ..add(
        DiagnosticsProperty<MoonHoverEffect>(
          "controlHoverEffect",
          controlHoverEffect,
        ),
      );
  }
}
