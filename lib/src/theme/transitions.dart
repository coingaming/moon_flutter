import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonTransitions extends ThemeExtension<MoonTransitions> with DiagnosticableTreeMixin {
  static const arrival = MoonTransitions(
    transitionCurve: Curves.easeOut,
    transitionDuration: Duration(milliseconds: 300),
  );

  static const departure = MoonTransitions(
    transitionCurve: Curves.easeIn,
    transitionDuration: Duration(milliseconds: 200),
  );

  final Curve transitionCurve;
  final Duration transitionDuration;

  const MoonTransitions({
    required this.transitionCurve,
    required this.transitionDuration,
  });

  @override
  MoonTransitions copyWith({
    Curve? transitionCurve,
    Duration? transitionDuration,
  }) {
    return MoonTransitions(
      transitionCurve: transitionCurve ?? this.transitionCurve,
      transitionDuration: transitionDuration ?? this.transitionDuration,
    );
  }

  @override
  MoonTransitions lerp(ThemeExtension<MoonTransitions>? other, double t) {
    if (other is! MoonTransitions) return this;

    return MoonTransitions(
      transitionCurve: transitionCurve,
      transitionDuration: transitionDuration,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTransitions"))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration));
  }
}
