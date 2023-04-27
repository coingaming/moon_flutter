import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';

@immutable
class MoonEffects extends ThemeExtension<MoonEffects> with DiagnosticableTreeMixin {
  static final light = MoonEffects(
    controlFocusEffect: MoonFocusEffects.lightFocusEffect,
    controlHoverEffect: MoonHoverEffects.lightHoverEffect,
    controlPulseEffect: MoonControlsEffects.controlPulseEffect,
    controlScaleEffect: MoonControlsEffects.controlScaleEffect,
  );

  static final dark = MoonEffects(
    controlFocusEffect: MoonFocusEffects.darkFocusEffect,
    controlHoverEffect: MoonHoverEffects.darkHoverEffect,
    controlPulseEffect: MoonControlsEffects.controlPulseEffect,
    controlScaleEffect: MoonControlsEffects.controlScaleEffect,
  );

  /// Control widgets focus effect.
  final MoonFocusEffects controlFocusEffect;

  /// Control widgets hover effect.
  final MoonHoverEffects controlHoverEffect;

  /// Control widgets focus effect.
  final MoonControlsEffects controlPulseEffect;

  /// Control widgets scale effect.
  final MoonControlsEffects controlScaleEffect;

  const MoonEffects({
    required this.controlFocusEffect,
    required this.controlHoverEffect,
    required this.controlPulseEffect,
    required this.controlScaleEffect,
  });

  @override
  MoonEffects copyWith({
    MoonFocusEffects? controlFocusEffect,
    MoonHoverEffects? controlHoverEffect,
    MoonControlsEffects? controlPulseEffect,
    MoonControlsEffects? controlScaleEffect,
  }) {
    return MoonEffects(
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
      ..add(DiagnosticsProperty<MoonControlsEffects>("controlScaleEffect", controlScaleEffect))
      ..add(DiagnosticsProperty<MoonControlsEffects>("controlPulseEffect", controlPulseEffect))
      ..add(DiagnosticsProperty<MoonFocusEffects>("controlFocusEffect", controlFocusEffect))
      ..add(DiagnosticsProperty<MoonHoverEffects>("controlHoverEffect", controlHoverEffect));
  }
}
