import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonAccordionSizeProperties extends ThemeExtension<MoonAccordionSizeProperties> with DiagnosticableTreeMixin {
  static final sm = MoonAccordionSizeProperties(
    headerHeight: MoonSizes.sizes.sm,
    iconSizeValue: MoonSizes.sizes.x2s,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    textStyle: MoonTextStyles.heading.text12,
  );

  static final md = MoonAccordionSizeProperties(
    headerHeight: MoonSizes.sizes.md,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonAccordionSizeProperties(
    headerHeight: MoonSizes.sizes.lg,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final xl = MoonAccordionSizeProperties(
    headerHeight: MoonSizes.sizes.xl,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    textStyle: MoonTextStyles.heading.text16,
  );

  /// Accordion header height.
  final double headerHeight;

  /// Accordion icon size value.
  final double iconSizeValue;

  /// Padding around accordion title and icon.
  final EdgeInsets headerPadding;

  /// Accordion text style.
  final TextStyle textStyle;

  const MoonAccordionSizeProperties({
    required this.headerHeight,
    required this.iconSizeValue,
    required this.headerPadding,
    required this.textStyle,
  });

  @override
  MoonAccordionSizeProperties copyWith({
    double? headerHeight,
    double? iconSizeValue,
    EdgeInsets? headerPadding,
    TextStyle? textStyle,
  }) {
    return MoonAccordionSizeProperties(
      headerHeight: headerHeight ?? this.headerHeight,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      headerPadding: headerPadding ?? this.headerPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonAccordionSizeProperties lerp(ThemeExtension<MoonAccordionSizeProperties>? other, double t) {
    if (other is! MoonAccordionSizeProperties) return this;

    return MoonAccordionSizeProperties(
      headerHeight: lerpDouble(headerHeight, other.headerHeight, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      headerPadding: EdgeInsets.lerp(headerPadding, other.headerPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionSizeProperties"))
      ..add(DoubleProperty("headerHeight", headerHeight))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsets>("headerPadding", headerPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
