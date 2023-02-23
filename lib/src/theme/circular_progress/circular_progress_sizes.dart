import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonCircularProgressSizes extends ThemeExtension<MoonCircularProgressSizes> with DiagnosticableTreeMixin {
  static final x2s = MoonCircularProgressSizes(
    circularProgressSizeValue: MoonSizes.sizes.x2s,
    circularProgressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final xs = MoonCircularProgressSizes(
    circularProgressSizeValue: MoonSizes.sizes.xs,
    circularProgressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final sm = MoonCircularProgressSizes(
    circularProgressSizeValue: MoonSizes.sizes.sm,
    circularProgressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final md = MoonCircularProgressSizes(
    circularProgressSizeValue: MoonSizes.sizes.md,
    circularProgressStrokeWidth: MoonSizes.sizes.x5s,
  );

  static final lg = MoonCircularProgressSizes(
    circularProgressSizeValue: MoonSizes.sizes.lg,
    circularProgressStrokeWidth: MoonSizes.sizes.x5s,
  );

  /// Circular progress size value.
  final double circularProgressSizeValue;

  /// Circular progress stroke width.
  final double circularProgressStrokeWidth;

  const MoonCircularProgressSizes({
    required this.circularProgressSizeValue,
    required this.circularProgressStrokeWidth,
  });

  @override
  MoonCircularProgressSizes copyWith({
    double? circularProgressSizeValue,
    double? circularProgressStrokeWidth,
  }) {
    return MoonCircularProgressSizes(
      circularProgressSizeValue: circularProgressSizeValue ?? this.circularProgressSizeValue,
      circularProgressStrokeWidth: circularProgressStrokeWidth ?? this.circularProgressStrokeWidth,
    );
  }

  @override
  MoonCircularProgressSizes lerp(ThemeExtension<MoonCircularProgressSizes>? other, double t) {
    if (other is! MoonCircularProgressSizes) return this;

    return MoonCircularProgressSizes(
      circularProgressSizeValue: lerpDouble(circularProgressSizeValue, other.circularProgressSizeValue, t)!,
      circularProgressStrokeWidth: lerpDouble(circularProgressStrokeWidth, other.circularProgressStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressSizes"))
      ..add(DoubleProperty("circularProgressSizeValue", circularProgressSizeValue))
      ..add(DoubleProperty("circularProgressStrokeWidth", circularProgressStrokeWidth));
  }
}
