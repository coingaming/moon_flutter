import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/sizes.dart';

@immutable
class MoonCircularProgressSizeProperties extends ThemeExtension<MoonCircularProgressSizeProperties>
    with DiagnosticableTreeMixin {
  static final x2s = MoonCircularProgressSizeProperties(
    progressSizeValue: MoonSizes.sizes.x2s,
    progressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final xs = MoonCircularProgressSizeProperties(
    progressSizeValue: MoonSizes.sizes.xs,
    progressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final sm = MoonCircularProgressSizeProperties(
    progressSizeValue: MoonSizes.sizes.sm,
    progressStrokeWidth: MoonSizes.sizes.x6s,
  );

  static final md = MoonCircularProgressSizeProperties(
    progressSizeValue: MoonSizes.sizes.md,
    progressStrokeWidth: MoonSizes.sizes.x5s,
  );

  static final lg = MoonCircularProgressSizeProperties(
    progressSizeValue: MoonSizes.sizes.lg,
    progressStrokeWidth: MoonSizes.sizes.x5s,
  );

  /// Circular progress size value.
  final double progressSizeValue;

  /// Circular progress stroke width.
  final double progressStrokeWidth;

  const MoonCircularProgressSizeProperties({
    required this.progressSizeValue,
    required this.progressStrokeWidth,
  });

  @override
  MoonCircularProgressSizeProperties copyWith({
    double? progressSizeValue,
    double? progressStrokeWidth,
  }) {
    return MoonCircularProgressSizeProperties(
      progressSizeValue: progressSizeValue ?? this.progressSizeValue,
      progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
    );
  }

  @override
  MoonCircularProgressSizeProperties lerp(ThemeExtension<MoonCircularProgressSizeProperties>? other, double t) {
    if (other is! MoonCircularProgressSizeProperties) return this;

    return MoonCircularProgressSizeProperties(
      progressSizeValue: lerpDouble(progressSizeValue, other.progressSizeValue, t)!,
      progressStrokeWidth: lerpDouble(progressStrokeWidth, other.progressStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularProgressSizeProperties"))
      ..add(DoubleProperty("progressSizeValue", progressSizeValue))
      ..add(DoubleProperty("progressStrokeWidth", progressStrokeWidth));
  }
}
