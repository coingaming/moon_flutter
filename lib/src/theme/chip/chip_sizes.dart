import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/chip/chip_size_properties.dart';

@immutable
class MoonChipSizes extends ThemeExtension<MoonChipSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonChipSizes(
    sm: MoonChipSizeProperties.sm,
    md: MoonChipSizeProperties.md,
  );

  /// Small chip properties.
  final MoonChipSizeProperties sm;

  /// Medium chip properties.
  final MoonChipSizeProperties md;

  const MoonChipSizes({
    required this.sm,
    required this.md,
  });

  @override
  MoonChipSizes copyWith({
    MoonChipSizeProperties? sm,
    MoonChipSizeProperties? md,
  }) {
    return MoonChipSizes(
      sm: sm ?? this.sm,
      md: md ?? this.md,
    );
  }

  @override
  MoonChipSizes lerp(ThemeExtension<MoonChipSizes>? other, double t) {
    if (other is! MoonChipSizes) return this;

    return MoonChipSizes(
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipSizes"))
      ..add(DiagnosticsProperty<MoonChipSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonChipSizeProperties>("md", md));
  }
}
