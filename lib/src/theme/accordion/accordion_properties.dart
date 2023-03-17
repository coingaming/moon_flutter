import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonAccordionProperties extends ThemeExtension<MoonAccordionProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAccordionProperties(
    dividerWidth: 1,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    shapeBorder: SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.all(
        SmoothRadius(
          cornerRadius: MoonBorders.borders.interactiveSm.topLeft.x,
          cornerSmoothing: 1,
        ),
      ),
    ),
  );

  /// Accordion divider width.
  final double dividerWidth;

  /// Accordion transition duration.
  final Duration transitionDuration;

  /// Accordion transition curve.
  final Curve transitionCurve;

  /// Accordion shape border.
  final ShapeBorder shapeBorder;

  const MoonAccordionProperties({
    required this.dividerWidth,
    required this.shapeBorder,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonAccordionProperties copyWith({
    double? dividerWidth,
    Duration? transitionDuration,
    Curve? transitionCurve,
    ShapeBorder? shapeBorder,
  }) {
    return MoonAccordionProperties(
      dividerWidth: dividerWidth ?? this.dividerWidth,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      shapeBorder: shapeBorder ?? this.shapeBorder,
    );
  }

  @override
  MoonAccordionProperties lerp(ThemeExtension<MoonAccordionProperties>? other, double t) {
    if (other is! MoonAccordionProperties) return this;

    return MoonAccordionProperties(
      dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      shapeBorder: ShapeBorder.lerp(shapeBorder, other.shapeBorder, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionProperties"))
      ..add(DiagnosticsProperty<double>("dividerWidth", dividerWidth))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<ShapeBorder>("shapeBorder", shapeBorder));
  }
}
