
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonToastProperties extends ThemeExtension<MoonToastProperties> with DiagnosticableTreeMixin {
  static final properties = MoonToastProperties(
    borderRadius: MoonBorders.borders.surfaceSm,
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x2s),
    gap: MoonSizes.sizes.x2s,
    displayDuration: const Duration(seconds: 5),
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Toast border radius.
  final BorderRadius borderRadius;

  /// Padding around toast content.
  final EdgeInsets contentPadding;

  /// Space between toast children.
  final double gap;

  /// Toast display duration.
  final Duration displayDuration;

  /// Toast transition duration.
  final Duration transitionDuration;

  /// Toast transition curve.
  final Curve transitionCurve;

  const MoonToastProperties({
    required this.borderRadius,
    required this.contentPadding,
    required this.gap,
    required this.displayDuration,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonToastProperties copyWith({
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
    double? gap,
    Duration? displayDuration,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonToastProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      gap: gap ?? this.gap,
      displayDuration: displayDuration ?? this.displayDuration,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonToastProperties lerp(ThemeExtension<MoonToastProperties>? other, double t) {
    if (other is! MoonToastProperties) return this;

    return MoonToastProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      displayDuration: lerpDuration(displayDuration, other.displayDuration, t),
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonToastProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<EdgeInsets>("contentPadding", contentPadding))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<Duration>("displayDuration", displayDuration))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
