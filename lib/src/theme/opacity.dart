import 'dart:ui';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonOpacity extends ThemeExtension<MoonOpacity> with DiagnosticableTreeMixin {
  /// Dsiabled opacity value.
  final double disabled;

  const MoonOpacity({
    this.disabled = 0.68,
  });

  @override
  MoonOpacity copyWith({
    double? disabled,
  }) {
    return MoonOpacity(
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  MoonOpacity lerp(ThemeExtension<MoonOpacity>? other, double t) {
    if (other is! MoonOpacity) return this;

    return MoonOpacity(
      disabled: lerpDouble(disabled, other.disabled, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonOpacity"))
      ..add(DoubleProperty("disabled", disabled));
  }
}
