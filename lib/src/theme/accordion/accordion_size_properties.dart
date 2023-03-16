import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonAccordionSizeProperties extends ThemeExtension<MoonAccordionSizeProperties> with DiagnosticableTreeMixin {
  static final sm = MoonAccordionSizeProperties(
    height: MoonSizes.sizes.sm,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text12,
  );

  static final md = MoonAccordionSizeProperties(
    height: MoonSizes.sizes.md,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonAccordionSizeProperties(
    height: MoonSizes.sizes.lg,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final xl = MoonAccordionSizeProperties(
    height: MoonSizes.sizes.xl,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text16,
  );

  /// Accordion height.
  final double height;

  /// Space between button children.

  /// Accordion icon size value.
  final double iconSizeValue;

  /// Padding around accordion title and icon.
  final EdgeInsets padding;

  /// Accordion border radius.
  final BorderRadius borderRadius;

  /// Accordion text style.
  final TextStyle textStyle;

  const MoonAccordionSizeProperties({
    required this.height,
    required this.iconSizeValue,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonAccordionSizeProperties copyWith({
    double? height,
    double? iconSizeValue,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonAccordionSizeProperties(
      height: height ?? this.height,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonAccordionSizeProperties lerp(ThemeExtension<MoonAccordionSizeProperties>? other, double t) {
    if (other is! MoonAccordionSizeProperties) return this;

    return MoonAccordionSizeProperties(
      height: lerpDouble(height, other.height, t)!,
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
      ..add(DiagnosticsProperty("type", "MoonAccordionSizeProperties"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
