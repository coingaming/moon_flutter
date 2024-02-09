import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonLinearLoaderSizeProperties extends ThemeExtension<MoonLinearLoaderSizeProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonLinearLoader.
  final BorderRadiusGeometry borderRadius;

  /// The height of the MoonLinearLoader.
  final double loaderHeight;

  const MoonLinearLoaderSizeProperties({
    required this.borderRadius,
    required this.loaderHeight,
  });

  @override
  MoonLinearLoaderSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? loaderHeight,
  }) {
    return MoonLinearLoaderSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      loaderHeight: loaderHeight ?? this.loaderHeight,
    );
  }

  @override
  MoonLinearLoaderSizeProperties lerp(ThemeExtension<MoonLinearLoaderSizeProperties>? other, double t) {
    if (other is! MoonLinearLoaderSizeProperties) return this;

    return MoonLinearLoaderSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      loaderHeight: lerpDouble(loaderHeight, other.loaderHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("loaderHeight", loaderHeight));
  }
}
