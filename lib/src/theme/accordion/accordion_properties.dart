import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonAccordionProperties extends ThemeExtension<MoonAccordionProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAccordionProperties(
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    borderRadius: SmoothBorderRadius.all(
      SmoothRadius(
        cornerRadius: MoonBorders.borders.interactiveSm.topLeft.x,
        cornerSmoothing: 1,
      ),
    ),
  );

  /// Accordion transition duration.
  final Duration transitionDuration;

  /// Accordion transition curve.
  final Curve transitionCurve;

  /// Accordion border radius.
  final SmoothBorderRadius borderRadius;

  const MoonAccordionProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonAccordionProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    SmoothBorderRadius? borderRadius,
  }) {
    return MoonAccordionProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  MoonAccordionProperties lerp(ThemeExtension<MoonAccordionProperties>? other, double t) {
    if (other is! MoonAccordionProperties) return this;

    return MoonAccordionProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      borderRadius: SmoothBorderRadius.lerp(borderRadius, other.borderRadius, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius));
  }
}
