import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tag/tag_size_properties.dart';

@immutable
class MoonTagSizes extends ThemeExtension<MoonTagSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonTagSizes(
    x2s: MoonTagSizeProperties.x2s,
    xs: MoonTagSizeProperties.xs,
  );

  /// (2x) Extra small tag properties.
  final MoonTagSizeProperties x2s;

  /// Extra small tag properties.
  final MoonTagSizeProperties xs;

  const MoonTagSizes({
    required this.x2s,
    required this.xs,
  });

  @override
  MoonTagSizes copyWith({
    MoonTagSizeProperties? x2s,
    MoonTagSizeProperties? xs,
  }) {
    return MoonTagSizes(
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
    );
  }

  @override
  MoonTagSizes lerp(ThemeExtension<MoonTagSizes>? other, double t) {
    if (other is! MoonTagSizes) return this;

    return MoonTagSizes(
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagSizes"))
      ..add(DiagnosticsProperty<MoonTagSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonTagSizeProperties>("xs", xs));
  }
}
