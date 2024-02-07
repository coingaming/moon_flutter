import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonAccordionProperties extends ThemeExtension<MoonAccordionProperties> with DiagnosticableTreeMixin {
  /// The duration of the MoonAccordion transition animation (expand and collapse).
  final Duration transitionDuration;

  /// The curve of the MoonAccordion transition animation (expand and collapse).
  final Curve transitionCurve;

  const MoonAccordionProperties({
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonAccordionProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonAccordionProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonAccordionProperties lerp(ThemeExtension<MoonAccordionProperties>? other, double t) {
    if (other is! MoonAccordionProperties) return this;

    return MoonAccordionProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
