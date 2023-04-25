import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonSwitchSizeProperties extends ThemeExtension<MoonSwitchSizeProperties> with DiagnosticableTreeMixin {
  static final x2s = MoonSwitchSizeProperties(
    height: MoonSizes.sizes.x2s,
    width: 2 * MoonSizes.sizes.x3s + 3 * MoonSizes.sizes.x6s,
    thumbSizeValue: MoonSizes.sizes.x3s,
    padding: EdgeInsets.all(MoonSizes.sizes.x6s),
  );

  static final xs = MoonSwitchSizeProperties(
    height: MoonSizes.sizes.xs,
    width: 2 * MoonSizes.sizes.x2s + 3 * MoonSizes.sizes.x5s,
    thumbSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.all(MoonSizes.sizes.x5s),
  );

  static final sm = MoonSwitchSizeProperties(
    height: MoonSizes.sizes.sm,
    width: 2 * MoonSizes.sizes.xs + 3 * MoonSizes.sizes.x5s,
    thumbSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.all(MoonSizes.sizes.x5s),
  );

  /// Switch height.
  final double height;

  /// Switch width.
  final double width;

  /// Switch thumb size.
  final double thumbSizeValue;

  /// Switch track padding.
  final EdgeInsetsGeometry padding;

  const MoonSwitchSizeProperties({
    required this.height,
    required this.width,
    required this.thumbSizeValue,
    required this.padding,
  });

  @override
  MoonSwitchSizeProperties copyWith({
    double? height,
    double? width,
    double? thumbSizeValue,
    EdgeInsetsGeometry? padding,
  }) {
    return MoonSwitchSizeProperties(
      height: height ?? this.height,
      width: width ?? this.width,
      thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
      padding: padding ?? this.padding,
    );
  }

  @override
  MoonSwitchSizeProperties lerp(ThemeExtension<MoonSwitchSizeProperties>? other, double t) {
    if (other is! MoonSwitchSizeProperties) return this;

    return MoonSwitchSizeProperties(
      height: lerpDouble(height, other.height, t)!,
      width: lerpDouble(width, other.width, t)!,
      thumbSizeValue: lerpDouble(thumbSizeValue, other.thumbSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchSizeProperties"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("width", width))
      ..add(DoubleProperty("thumbSizeValue", thumbSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding));
  }
}
