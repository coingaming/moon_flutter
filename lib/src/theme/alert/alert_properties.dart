import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonAlertProperties extends ThemeExtension<MoonAlertProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAlertProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    padding: EdgeInsets.all(MoonSizes.sizes.x2s),
    gap: MoonSizes.sizes.x3s,
  );

  /// Alert border radius.
  final BorderRadius borderRadius;

  /// Alert gap.
  final double gap;

  /// Alert padding.
  final EdgeInsets padding;

  const MoonAlertProperties({
    required this.borderRadius,
    required this.gap,
    required this.padding,
  });

  @override
  MoonAlertProperties copyWith({
    BorderRadius? borderRadius,
    double? gap,
    EdgeInsets? padding,
  }) {
    return MoonAlertProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      padding: padding ?? this.padding,
    );
  }

  @override
  MoonAlertProperties lerp(ThemeExtension<MoonAlertProperties>? other, double t) {
    if (other is! MoonAlertProperties) return this;

    return MoonAlertProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<double>("gap", gap))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding));
  }
}
