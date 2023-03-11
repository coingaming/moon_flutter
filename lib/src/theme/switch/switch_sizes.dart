import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/switch/switch_size_properties.dart';

@immutable
class MoonSwitchSizes extends ThemeExtension<MoonSwitchSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonSwitchSizes(
    x2s: MoonSwitchSizeProperties.x2s,
    xs: MoonSwitchSizeProperties.xs,
    sm: MoonSwitchSizeProperties.sm,
  );

  /// (2x) Extra small switch properties.
  final MoonSwitchSizeProperties x2s;

  /// Extra small switch properties.
  final MoonSwitchSizeProperties xs;

  /// Small switch properties.
  final MoonSwitchSizeProperties sm;

  const MoonSwitchSizes({
    required this.x2s,
    required this.xs,
    required this.sm,
  });

  @override
  MoonSwitchSizes copyWith({
    MoonSwitchSizeProperties? x2s,
    MoonSwitchSizeProperties? xs,
    MoonSwitchSizeProperties? sm,
  }) {
    return MoonSwitchSizes(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
    );
  }

  @override
  MoonSwitchSizes lerp(ThemeExtension<MoonSwitchSizes>? other, double t) {
    if (other is! MoonSwitchSizes) return this;

    return MoonSwitchSizes(
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchSizes"))
      ..add(DiagnosticsProperty<MoonSwitchSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonSwitchSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonSwitchSizeProperties>("sm", sm));
  }
}
