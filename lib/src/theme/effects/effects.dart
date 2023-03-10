import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';

@immutable
class MoonEffects extends ThemeExtension<MoonEffects> with DiagnosticableTreeMixin {
  static final light = MoonEffects(
    controlScaleEffect: MoonControlsEffects.controlScaleEffect,
    controlPulseEffect: MoonControlsEffects.controlPulseEffect,
    controlFocusEffect: MoonFocusEffects.lightFocusEffect,
    controlHoverEffect: MoonHoverEffects.lightHoverEffect,
  );

  static final dark = MoonEffects(
    controlScaleEffect: MoonControlsEffects.controlScaleEffect,
    controlPulseEffect: MoonControlsEffects.controlPulseEffect,
    controlFocusEffect: MoonFocusEffects.darkFocusEffect,
    controlHoverEffect: MoonHoverEffects.darkHoverEffect,
  );

  /// Control widgets scale effect.
  final MoonControlsEffects controlScaleEffect;

  /// Control widgets focus effect.
  final MoonControlsEffects controlPulseEffect;

  /// Control widgets focus effect.
  final MoonFocusEffects controlFocusEffect;

  /// Control widgets hover effect.
  final MoonHoverEffects controlHoverEffect;

  const MoonEffects({
    required this.controlScaleEffect,
    required this.controlPulseEffect,
    required this.controlFocusEffect,
    required this.controlHoverEffect,
  });

  @override
  MoonEffects copyWith({
    MoonControlsEffects? controlScaleEffect,
    MoonControlsEffects? controlPulseEffect,
    MoonFocusEffects? controlFocusEffect,
    MoonHoverEffects? controlHoverEffect,
  }) {
    return MoonEffects(
      controlScaleEffect: controlScaleEffect ?? this.controlScaleEffect,
      controlPulseEffect: controlPulseEffect ?? this.controlPulseEffect,
      controlFocusEffect: controlFocusEffect ?? this.controlFocusEffect,
      controlHoverEffect: controlHoverEffect ?? this.controlHoverEffect,
    );
  }

  @override
  MoonEffects lerp(ThemeExtension<MoonEffects>? other, double t) {
    if (other is! MoonEffects) return this;

    return MoonEffects(
      controlScaleEffect: controlScaleEffect.lerp(other.controlScaleEffect, t),
      controlPulseEffect: controlPulseEffect.lerp(other.controlPulseEffect, t),
      controlFocusEffect: controlFocusEffect.lerp(other.controlFocusEffect, t),
      controlHoverEffect: controlHoverEffect.lerp(other.controlHoverEffect, t),
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
