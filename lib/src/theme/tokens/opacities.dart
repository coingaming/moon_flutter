import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonOpacities extends ThemeExtension<MoonOpacities> with DiagnosticableTreeMixin {
  static const opacities = MoonOpacities(disabled: 0.6);

  /// Disabled opacity value.
  final double disabled;

  const MoonOpacities({
    required this.disabled,
  });

  @override
  MoonOpacities copyWith({
    double? disabled,
  }) {
    return MoonOpacities(
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  MoonOpacities lerp(ThemeExtension<MoonOpacities>? other, double t) {
    if (other is! MoonOpacities) return this;

    return MoonOpacities(
      disabled: lerpDouble(disabled, other.disabled, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonOpacities"))
      ..add(DoubleProperty("disabled", disabled));
  }
}
