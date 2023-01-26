import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:moon_design/moon_design.dart';

@immutable
class MoonOpacity extends ThemeExtension<MoonOpacity> with DiagnosticableTreeMixin {
  /// Disabled opacity effect.
  final MoonOpacityEffects disabled;

  const MoonOpacity({
    this.disabled = MoonOpacityEffects.disabled,
  });

  @override
  MoonOpacity copyWith({
    MoonOpacityEffects? disabled,
  }) {
    return MoonOpacity(
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  MoonOpacity lerp(ThemeExtension<MoonOpacity>? other, double t) {
    if (other is! MoonOpacity) return this;

    return MoonOpacity(
      disabled: other.disabled,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonOpacity"))
      ..add(DiagnosticsProperty<MoonOpacityEffects>("disabled", disabled));
  }
}
