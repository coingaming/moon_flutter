import 'dart:ui';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonOpacityEffects extends ThemeExtension<MoonOpacityEffects> with DiagnosticableTreeMixin {
  static const disabled = MoonOpacityEffects(opacity: 0.68);

  /// Opacity value.
  final double opacity;

  const MoonOpacityEffects({
    required this.opacity,
  });

  @override
  MoonOpacityEffects copyWith({
    double? opacity,
  }) {
    return MoonOpacityEffects(
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  MoonOpacityEffects lerp(ThemeExtension<MoonOpacityEffects>? other, double t) {
    if (other is! MoonOpacityEffects) return this;

    return MoonOpacityEffects(
      opacity: lerpDouble(opacity, other.opacity, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonOpacityEffects"))
      ..add(DoubleProperty("opacity", opacity));
  }
}
