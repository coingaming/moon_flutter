import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonCircularLoaderSizeProperties
    extends ThemeExtension<MoonCircularLoaderSizeProperties>
    with DiagnosticableTreeMixin {
  /// The size value of the MoonCircularLoader.
  final double loaderSizeValue;

  /// The stroke width of the MoonCircularLoader.
  final double loaderStrokeWidth;

  const MoonCircularLoaderSizeProperties({
    required this.loaderSizeValue,
    required this.loaderStrokeWidth,
  });

  @override
  MoonCircularLoaderSizeProperties copyWith({
    double? loaderSizeValue,
    double? loaderStrokeWidth,
  }) {
    return MoonCircularLoaderSizeProperties(
      loaderSizeValue: loaderSizeValue ?? this.loaderSizeValue,
      loaderStrokeWidth: loaderStrokeWidth ?? this.loaderStrokeWidth,
    );
  }

  @override
  MoonCircularLoaderSizeProperties lerp(
    ThemeExtension<MoonCircularLoaderSizeProperties>? other,
    double t,
  ) {
    if (other is! MoonCircularLoaderSizeProperties) return this;

    return MoonCircularLoaderSizeProperties(
      loaderSizeValue: lerpDouble(loaderSizeValue, other.loaderSizeValue, t)!,
      loaderStrokeWidth:
          lerpDouble(loaderStrokeWidth, other.loaderStrokeWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderSizeProperties"))
      ..add(DoubleProperty("loaderSizeValue", loaderSizeValue))
      ..add(DoubleProperty("loaderStrokeWidth", loaderStrokeWidth));
  }
}
