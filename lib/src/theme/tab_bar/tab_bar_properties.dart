import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTabBarProperties extends ThemeExtension<MoonTabBarProperties>
    with DiagnosticableTreeMixin {
  /// The gap between the MoonTabBar tabs.
  final double gap;

  /// The duration of the MoonTabBar transition animation.
  final Duration transitionDuration;

  /// The curve of the MoonTabBar transition animation.
  final Curve transitionCurve;

  const MoonTabBarProperties({
    required this.gap,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonTabBarProperties copyWith({
    double? gap,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonTabBarProperties(
      gap: gap ?? this.gap,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonTabBarProperties lerp(
    ThemeExtension<MoonTabBarProperties>? other,
    double t,
  ) {
    if (other is! MoonTabBarProperties) return this;

    return MoonTabBarProperties(
      gap: lerpDouble(gap, other.gap, t)!,
      transitionDuration:
          lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonTabBarProperties"),
      )
      ..add(
        DoubleProperty("gap", gap),
      )
      ..add(
        DiagnosticsProperty<Duration>("transitionDuration", transitionDuration),
      )
      ..add(
        DiagnosticsProperty<Curve>("transitionCurve", transitionCurve),
      );
  }
}
