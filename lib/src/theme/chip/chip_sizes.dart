import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonChipSizes extends ThemeExtension<MoonChipSizes> with DiagnosticableTreeMixin {
  static final sm = MoonChipSizes(
    height: MoonSizes.sizes.sm,
    gap: MoonSizes.sizes.x5s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final md = MoonChipSizes(
    height: MoonSizes.sizes.md,
    gap: MoonSizes.sizes.x4s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  /// Chip height.
  final double height;

  /// Space between chip children.
  final double gap;

  /// Padding around chip children.
  final EdgeInsets padding;

  /// Chip border radius.
  final BorderRadius borderRadius;

  /// Chip text style.
  final TextStyle textStyle;

  const MoonChipSizes({
    required this.height,
    required this.gap,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonChipSizes copyWith({
    double? height,
    double? gap,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonChipSizes(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonChipSizes lerp(ThemeExtension<MoonChipSizes>? other, double t) {
    if (other is! MoonChipSizes) return this;

    return MoonChipSizes(
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipSizes"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
