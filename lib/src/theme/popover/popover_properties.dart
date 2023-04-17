import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonPopoverProperties extends ThemeExtension<MoonPopoverProperties> with DiagnosticableTreeMixin {
  static final properties = MoonPopoverProperties(
    distanceToTarget: MoonSizes.sizes.x4s,
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveMd,
    transitionDuration: const Duration(milliseconds: 150),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Popover distance to target child widget.
  final double distanceToTarget;

  /// Padding around popover content.
  final EdgeInsetsGeometry contentPadding;

  /// Popover border radius.
  final BorderRadius borderRadius;

  /// Popover transition duration (fade in or out animation).
  final Duration transitionDuration;

  /// Popover transition curve (fade in or out animation).
  final Curve transitionCurve;

  const MoonPopoverProperties({
    required this.distanceToTarget,
    required this.contentPadding,
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonPopoverProperties copyWith({
    double? distanceToTarget,
    EdgeInsetsGeometry? contentPadding,
    BorderRadius? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonPopoverProperties(
      distanceToTarget: distanceToTarget ?? this.distanceToTarget,
      contentPadding: contentPadding ?? this.contentPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonPopoverProperties lerp(ThemeExtension<MoonPopoverProperties>? other, double t) {
    if (other is! MoonPopoverProperties) return this;

    return MoonPopoverProperties(
      distanceToTarget: lerpDouble(distanceToTarget, other.distanceToTarget, t)!,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonPopoverProperties"))
      ..add(DoubleProperty("distanceToTarget", distanceToTarget))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("contentPadding", contentPadding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
