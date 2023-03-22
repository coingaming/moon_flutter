import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonModalProperties extends ThemeExtension<MoonModalProperties> with DiagnosticableTreeMixin {
  static final properties = MoonModalProperties(
    borderRadius: MoonBorders.borders.surfaceSm,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Modal border radius.
  final BorderRadius borderRadius;

  /// Modal transition duration.
  final Duration transitionDuration;

  /// Modal transition curve.
  final Curve transitionCurve;

  const MoonModalProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonModalProperties copyWith({
    BorderRadius? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonModalProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonModalProperties lerp(ThemeExtension<MoonModalProperties>? other, double t) {
    if (other is! MoonModalProperties) return this;

    return MoonModalProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonModalProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
