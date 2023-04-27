import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonAccordionItemProperties extends ThemeExtension<MoonAccordionItemProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAccordionItemProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Accordion item border radius.
  final BorderRadius borderRadius;

  /// Accordion item transition duration.
  final Duration transitionDuration;

  /// Accordion item transition curve.
  final Curve transitionCurve;

  const MoonAccordionItemProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonAccordionItemProperties copyWith({
    BorderRadius? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonAccordionItemProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonAccordionItemProperties lerp(ThemeExtension<MoonAccordionItemProperties>? other, double t) {
    if (other is! MoonAccordionItemProperties) return this;

    return MoonAccordionItemProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionItemProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
