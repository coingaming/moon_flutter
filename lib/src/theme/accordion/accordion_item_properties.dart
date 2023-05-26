import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonAccordionItemProperties extends ThemeExtension<MoonAccordionItemProperties> with DiagnosticableTreeMixin {
  static const properties = MoonAccordionItemProperties(
    transitionDuration: Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Accordion item border radius.

  /// Accordion item transition duration.
  final Duration transitionDuration;

  /// Accordion item transition curve.
  final Curve transitionCurve;

  const MoonAccordionItemProperties({
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonAccordionItemProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonAccordionItemProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonAccordionItemProperties lerp(ThemeExtension<MoonAccordionItemProperties>? other, double t) {
    if (other is! MoonAccordionItemProperties) return this;

    return MoonAccordionItemProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionItemProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
