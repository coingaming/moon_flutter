import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonToastProperties extends ThemeExtension<MoonToastProperties> with DiagnosticableTreeMixin {
  static final properties = MoonToastProperties(
    borderRadius: MoonBorders.borders.surfaceSm,
    gap: MoonSizes.sizes.x2s,
    displayDuration: const Duration(seconds: 5),
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x2s),
  );

  /// Toast border radius.
  final BorderRadiusGeometry borderRadius;

  /// Space between toast children.
  final double gap;

  /// Toast display duration.
  final Duration displayDuration;

  /// Toast transition duration.
  final Duration transitionDuration;

  /// Toast transition curve.
  final Curve transitionCurve;

  /// Padding around toast content.
  final EdgeInsetsGeometry contentPadding;

  const MoonToastProperties({
    required this.borderRadius,
    required this.gap,
    required this.displayDuration,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.contentPadding,
  });

  @override
  MoonToastProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    Duration? displayDuration,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return MoonToastProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      displayDuration: displayDuration ?? this.displayDuration,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }

  @override
  MoonToastProperties lerp(ThemeExtension<MoonToastProperties>? other, double t) {
    if (other is! MoonToastProperties) return this;

    return MoonToastProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      displayDuration: lerpDuration(displayDuration, other.displayDuration, t),
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonToastProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<Duration>("displayDuration", displayDuration))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("contentPadding", contentPadding));
  }
}
