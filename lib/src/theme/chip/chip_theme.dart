import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/chip/chip_sizes.dart';

@immutable
class MoonChipTheme extends ThemeExtension<MoonChipTheme> with DiagnosticableTreeMixin {
  static final sizes = MoonChipTheme(
    sm: MoonChipSizes.sm,
    md: MoonChipSizes.md,
  );

  /// Small chip properties.
  final MoonChipSizes sm;

  /// Medium chip properties.
  final MoonChipSizes md;

  const MoonChipTheme({
    required this.sm,
    required this.md,
  });

  @override
  MoonChipTheme copyWith({
    MoonChipSizes? xs,
    MoonChipSizes? sm,
    MoonChipSizes? md,
    MoonChipSizes? lg,
    MoonChipSizes? xl,
  }) {
    return MoonChipTheme(
      sm: sm ?? this.sm,
      md: md ?? this.md,
    );
  }

  @override
  MoonChipTheme lerp(ThemeExtension<MoonChipTheme>? other, double t) {
    if (other is! MoonChipTheme) return this;

    return MoonChipTheme(
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipTheme"))
      ..add(DiagnosticsProperty<MoonChipSizes>("sm", sm))
      ..add(DiagnosticsProperty<MoonChipSizes>("md", md));
  }
}
