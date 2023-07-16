import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonSwitchProperties extends ThemeExtension<MoonSwitchProperties> with DiagnosticableTreeMixin {
  /// Switch transition duration.
  final Duration transitionDuration;

  /// Switch transition curve.
  final Curve transitionCurve;

  const MoonSwitchProperties({
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonSwitchProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonSwitchProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonSwitchProperties lerp(ThemeExtension<MoonSwitchProperties>? other, double t) {
    if (other is! MoonSwitchProperties) return this;

    return MoonSwitchProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
