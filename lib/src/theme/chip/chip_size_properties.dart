import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonChipSizeProperties extends ThemeExtension<MoonChipSizeProperties> with DiagnosticableTreeMixin {
  static final sm = MoonChipSizeProperties(
    height: MoonSizes.sizes.sm,
    gap: MoonSizes.sizes.x5s,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final md = MoonChipSizeProperties(
    height: MoonSizes.sizes.md,
    gap: MoonSizes.sizes.x4s,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  /// Chip height.
  final double height;

  /// Space between chip children.
  final double gap;

  /// Chip icon size value.
  final double iconSizeValue;

  /// Padding around chip children.
  final EdgeInsets padding;

  /// Chip border radius.
  final BorderRadius borderRadius;

  /// Chip text style.
  final TextStyle textStyle;

  const MoonChipSizeProperties({
    required this.height,
    required this.gap,
    required this.iconSizeValue,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonChipSizeProperties copyWith({
    double? height,
    double? gap,
    double? iconSizeValue,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonChipSizeProperties(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonChipSizeProperties lerp(ThemeExtension<MoonChipSizeProperties>? other, double t) {
    if (other is! MoonChipSizeProperties) return this;

    return MoonChipSizeProperties(
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipSizeProperties"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
