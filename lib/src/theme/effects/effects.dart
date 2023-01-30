import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';

@immutable
class MoonEffects extends ThemeExtension<MoonEffects> with DiagnosticableTreeMixin {
  static final light = MoonEffects(
    controlScaleEffect: MoonControlsEffects.controlScaleEffect,
    controlFocusEffect: MoonControlsEffects.controlFocusEffect,
    controlPulseEffect: MoonControlsEffects.controlPulseEffect,
    buttonHoverEffect: MoonHoverEffects.lightButtonHoverEffect,
  );

  static final dark = MoonEffects(
    controlScaleEffect: MoonControlsEffects.controlScaleEffect,
    controlFocusEffect: MoonControlsEffects.controlFocusEffect,
    controlPulseEffect: MoonControlsEffects.controlPulseEffect,
    buttonHoverEffect: MoonHoverEffects.darkButtonHoverEffect,
  );

  /// Control widgets scale effect.
  final MoonControlsEffects controlScaleEffect;

  /// Control widgets focus effect.
  final MoonControlsEffects controlFocusEffect;

  /// Control widgets focus effect.
  final MoonControlsEffects controlPulseEffect;

  /// Button hover effect.
  final MoonHoverEffects buttonHoverEffect;

  const MoonEffects({
    required this.controlScaleEffect,
    required this.controlFocusEffect,
    required this.controlPulseEffect,
    required this.buttonHoverEffect,
  });

  @override
  MoonEffects copyWith({
    MoonControlsEffects? controlScaleEffect,
    MoonControlsEffects? controlFocusEffect,
    MoonControlsEffects? controlPulseEffect,
    MoonHoverEffects? buttonHoverEffect,
  }) {
    return MoonEffects(
      controlScaleEffect: controlScaleEffect ?? this.controlScaleEffect,
      controlFocusEffect: controlFocusEffect ?? this.controlFocusEffect,
      controlPulseEffect: controlPulseEffect ?? this.controlPulseEffect,
      buttonHoverEffect: buttonHoverEffect ?? this.buttonHoverEffect,
    );
  }

  @override
  MoonEffects lerp(ThemeExtension<MoonEffects>? other, double t) {
    if (other is! MoonEffects) return this;

    return MoonEffects(
      controlScaleEffect: controlScaleEffect.lerp(other.controlScaleEffect, t),
      controlFocusEffect: controlFocusEffect.lerp(other.controlFocusEffect, t),
      controlPulseEffect: controlPulseEffect.lerp(other.controlPulseEffect, t),
      buttonHoverEffect: buttonHoverEffect.lerp(other.buttonHoverEffect, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonEffects"))
      ..add(DiagnosticsProperty<MoonControlsEffects>("controlScaleEffect", controlScaleEffect))
      ..add(DiagnosticsProperty<MoonControlsEffects>("controlFocusEffect", controlFocusEffect))
      ..add(DiagnosticsProperty<MoonControlsEffects>("controlPulseEffect", controlPulseEffect))
      ..add(DiagnosticsProperty<MoonHoverEffects>("buttonHoverEffect", buttonHoverEffect));
  }
}
