import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonAccordionItemProperties extends ThemeExtension<MoonAccordionItemProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAccordionItemProperties(
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    borderRadius: MoonBorders.borders.interactiveSm,
  );

  /// Accordion item transition duration.
  final Duration transitionDuration;

  /// Accordion item transition curve.
  final Curve transitionCurve;

  /// Accordion item border radius.
  final BorderRadius borderRadius;

  const MoonAccordionItemProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonAccordionItemProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    BorderRadius? borderRadius,
  }) {
    return MoonAccordionItemProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  MoonAccordionItemProperties lerp(ThemeExtension<MoonAccordionItemProperties>? other, double t) {
    if (other is! MoonAccordionItemProperties) return this;

    return MoonAccordionItemProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionItemProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius));
  }
}
