import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/input/input_size_properties.dart';

@immutable
class MoonInputSizes extends ThemeExtension<MoonInputSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonInputSizes(
    sm: MoonInputSizeProperties.sm,
    md: MoonInputSizeProperties.md,
    lg: MoonInputSizeProperties.lg,
  );

  /// Small input properties.
  final MoonInputSizeProperties sm;

  /// Medium input properties.
  final MoonInputSizeProperties md;

  /// Large input properties.
  final MoonInputSizeProperties lg;

  const MoonInputSizes({
    required this.sm,
    required this.md,
    required this.lg,
  });

  @override
  MoonInputSizes copyWith({
    MoonInputSizeProperties? sm,
    MoonInputSizeProperties? md,
    MoonInputSizeProperties? lg,
  }) {
    return MoonInputSizes(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonInputSizes lerp(ThemeExtension<MoonInputSizes>? other, double t) {
    if (other is! MoonInputSizes) return this;

    return MoonInputSizes(
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonInputSizes"))
      ..add(DiagnosticsProperty<MoonInputSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonInputSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonInputSizeProperties>("lg", lg));
  }
}
