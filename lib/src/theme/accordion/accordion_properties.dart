import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonAccordionProperties extends ThemeExtension<MoonAccordionProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAccordionProperties(
    borderWidth: MoonBorders.borders.borderWidth,
    dividerWidth: 1,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Accordion border width.
  final double borderWidth;

  /// Accordion divider width.
  final double dividerWidth;

  /// Accordion transition duration.
  final Duration transitionDuration;

  /// Accordion transition curve.
  final Curve transitionCurve;

  const MoonAccordionProperties({
    required this.borderWidth,
    required this.dividerWidth,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonAccordionProperties copyWith({
    double? borderWidth,
    double? dividerWidth,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonAccordionProperties(
      borderWidth: borderWidth ?? this.borderWidth,
      dividerWidth: dividerWidth ?? this.dividerWidth,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonAccordionProperties lerp(ThemeExtension<MoonAccordionProperties>? other, double t) {
    if (other is! MoonAccordionProperties) return this;

    return MoonAccordionProperties(
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionProperties"))
      ..add(DiagnosticsProperty<double>("borderWidth", borderWidth))
      ..add(DiagnosticsProperty<double>("dividerWidth", dividerWidth))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
