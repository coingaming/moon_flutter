import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonCircularProgressSizes extends ThemeExtension<MoonCircularProgressSizes> with DiagnosticableTreeMixin {
  static final x2s = MoonCircularProgressSizes(
    progressSizeValue: MoonSizes.sizes.x2s,
    progressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final xs = MoonCircularProgressSizes(
    progressSizeValue: MoonSizes.sizes.xs,
    progressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final sm = MoonCircularProgressSizes(
    progressSizeValue: MoonSizes.sizes.sm,
    progressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final md = MoonCircularProgressSizes(
    progressSizeValue: MoonSizes.sizes.md,
    progressStrokeWidth: MoonSizes.sizes.x5s,
  );

  static final lg = MoonCircularProgressSizes(
    progressSizeValue: MoonSizes.sizes.lg,
    progressStrokeWidth: MoonSizes.sizes.x5s,
  );

  /// Circular progress size value.
  final double progressSizeValue;

  /// Circular progress stroke width.
  final double progressStrokeWidth;

  const MoonCircularProgressSizes({
    required this.progressSizeValue,
    required this.progressStrokeWidth,
  });

  @override
  MoonCircularProgressSizes copyWith({
    double? progressSizeValue,
    double? progressStrokeWidth,
  }) {
    return MoonCircularProgressSizes(
      progressSizeValue: progressSizeValue ?? this.progressSizeValue,
      progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
    );
  }

  @override
  MoonCircularProgressSizes lerp(ThemeExtension<MoonCircularProgressSizes>? other, double t) {
    if (other is! MoonCircularProgressSizes) return this;

    return MoonCircularProgressSizes(
      progressSizeValue: lerpDouble(progressSizeValue, other.progressSizeValue, t)!,
      progressStrokeWidth: lerpDouble(progressStrokeWidth, other.progressStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressSizes"))
      ..add(DoubleProperty("progressSizeValue", progressSizeValue))
      ..add(DoubleProperty("progressStrokeWidth", progressStrokeWidth));
  }
}
