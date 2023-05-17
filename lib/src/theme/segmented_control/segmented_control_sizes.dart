import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/segmented_control/segmented_control_size_properties.dart';

@immutable
class MoonSegmentedControlSizes extends ThemeExtension<MoonSegmentedControlSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonSegmentedControlSizes(
    sm: MoonSegmentedControlSizeProperties.sm,
    md: MoonSegmentedControlSizeProperties.md,
  );

  /// Small segmentedControl item properties.
  final MoonSegmentedControlSizeProperties sm;

  /// Medium segmentedControl item properties.
  final MoonSegmentedControlSizeProperties md;

  const MoonSegmentedControlSizes({
    required this.sm,
    required this.md,
  });

  @override
  MoonSegmentedControlSizes copyWith({
    MoonSegmentedControlSizeProperties? sm,
    MoonSegmentedControlSizeProperties? md,
  }) {
    return MoonSegmentedControlSizes(
      sm: sm ?? this.sm,
      md: md ?? this.md,
    );
  }

  @override
  MoonSegmentedControlSizes lerp(ThemeExtension<MoonSegmentedControlSizes>? other, double t) {
    if (other is! MoonSegmentedControlSizes) return this;

    return MoonSegmentedControlSizes(
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSegmentedControlSizes"))
      ..add(DiagnosticsProperty<MoonSegmentedControlSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonSegmentedControlSizeProperties>("md", md));
  }
}
