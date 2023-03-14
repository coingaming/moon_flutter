import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonSwitchSizeProperties extends ThemeExtension<MoonSwitchSizeProperties> with DiagnosticableTreeMixin {
  static final x2s = MoonSwitchSizeProperties(
    width: 2 * MoonSizes.sizes.x3s + 3 * MoonSizes.sizes.x6s,
    height: MoonSizes.sizes.x2s,
    thumbSizeValue: MoonSizes.sizes.x3s,
    padding: EdgeInsets.all(MoonSizes.sizes.x6s),
  );

  static final xs = MoonSwitchSizeProperties(
    width: 2 * MoonSizes.sizes.x2s + 3 * MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.xs,
    thumbSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.all(MoonSizes.sizes.x5s),
  );

  static final sm = MoonSwitchSizeProperties(
    width: 2 * MoonSizes.sizes.xs + 3 * MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.sm,
    thumbSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.all(MoonSizes.sizes.x5s),
  );

  /// Switch width.
  final double width;

  /// Switch height.
  final double height;

  /// Switch thumb size.
  final double thumbSizeValue;

  /// Switch track padding.
  final EdgeInsets padding;

  const MoonSwitchSizeProperties({
    required this.width,
    required this.height,
    required this.thumbSizeValue,
    required this.padding,
  });

  @override
  MoonSwitchSizeProperties copyWith({
    double? width,
    double? height,
    double? thumbSizeValue,
    EdgeInsets? padding,
  }) {
    return MoonSwitchSizeProperties(
      width: width ?? this.width,
      height: height ?? this.height,
      thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
      padding: padding ?? this.padding,
    );
  }

  @override
  MoonSwitchSizeProperties lerp(ThemeExtension<MoonSwitchSizeProperties>? other, double t) {
    if (other is! MoonSwitchSizeProperties) return this;

    return MoonSwitchSizeProperties(
      width: lerpDouble(width, other.width, t)!,
      height: lerpDouble(height, other.height, t)!,
      thumbSizeValue: lerpDouble(thumbSizeValue, other.thumbSizeValue, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchSizeProperties"))
      ..add(DoubleProperty("width", width))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("thumbSizeValue", thumbSizeValue))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding));
  }
}
