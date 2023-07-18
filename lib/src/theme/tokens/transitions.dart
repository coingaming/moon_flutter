import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTransitions extends ThemeExtension<MoonTransitions> with DiagnosticableTreeMixin {
  static const transitions = MoonTransitions(
    defaultTransitionDuration: Duration(milliseconds: 200),
    defaultTransitionCurve: Curves.easeInOutCubic,
  );

  /// Default transition duration.
  final Duration defaultTransitionDuration;

  /// Default transition curve.
  final Curve defaultTransitionCurve;

  const MoonTransitions({
    required this.defaultTransitionDuration,
    required this.defaultTransitionCurve,
  });

  @override
  MoonTransitions copyWith({
    Duration? defaultTransitionDuration,
    Curve? defaultTransitionCurve,
  }) {
    return MoonTransitions(
      defaultTransitionDuration: defaultTransitionDuration ?? this.defaultTransitionDuration,
      defaultTransitionCurve: defaultTransitionCurve ?? this.defaultTransitionCurve,
    );
  }

  @override
  MoonTransitions lerp(ThemeExtension<MoonTransitions>? other, double t) {
    if (other is! MoonTransitions) return this;

    return MoonTransitions(
      defaultTransitionDuration: lerpDuration(defaultTransitionDuration, other.defaultTransitionDuration, t),
      defaultTransitionCurve: other.defaultTransitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTransitions"))
      ..add(DiagnosticsProperty<Duration>("defaultTransitionDuration", defaultTransitionDuration))
      ..add(DiagnosticsProperty<Curve>("defaultTransitionCurve", defaultTransitionCurve));
  }
}
