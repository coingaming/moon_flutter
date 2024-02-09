import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTableProperties extends ThemeExtension<MoonTableProperties> with DiagnosticableTreeMixin {
  /// The duration of the MoonTable row label transition animation during horizontal scrolling.
  final Duration transitionDuration;

  /// The curve of the MoonTable row label transition animation during horizontal scrolling.
  final Curve transitionCurve;

  const MoonTableProperties({
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonTableProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonTableProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonTableProperties lerp(ThemeExtension<MoonTableProperties>? other, double t) {
    if (other is! MoonTableProperties) return this;

    return MoonTableProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTableProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
