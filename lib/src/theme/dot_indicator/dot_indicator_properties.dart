import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonDotIndicatorProperties
    extends ThemeExtension<MoonDotIndicatorProperties>
    with DiagnosticableTreeMixin {
  /// The gap between the MoonDotIndicator dots.
  final double gap;

  /// The size of each MoonDotIndicator dot.
  final double size;

  /// The duration of the MoonDotIndicator transition animation.
  final Duration transitionDuration;

  /// The curve of the MoonDotIndicator transition animation.
  final Curve transitionCurve;

  const MoonDotIndicatorProperties({
    required this.size,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.gap,
  });

  @override
  MoonDotIndicatorProperties copyWith({
    double? gap,
    double? size,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonDotIndicatorProperties(
      gap: gap ?? this.gap,
      size: size ?? this.size,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonDotIndicatorProperties lerp(
    ThemeExtension<MoonDotIndicatorProperties>? other,
    double t,
  ) {
    if (other is! MoonDotIndicatorProperties) return this;

    return MoonDotIndicatorProperties(
      gap: lerpDouble(gap, other.gap, t)!,
      size: lerpDouble(size, other.size, t)!,
      transitionDuration: lerpDuration(
        transitionDuration,
        other.transitionDuration,
        t,
      ),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonDotIndicatorProperties"),
      )
      ..add(
        DoubleProperty("gap", gap),
      )
      ..add(
        DoubleProperty("size", size),
      )
      ..add(
        DiagnosticsProperty<Duration>("transitionDuration", transitionDuration),
      )
      ..add(
        DiagnosticsProperty<Curve>("transitionCurve", transitionCurve),
      );
  }
}
