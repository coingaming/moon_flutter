import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonAccordionItemSizeProperties extends ThemeExtension<MoonAccordionItemSizeProperties>
    with DiagnosticableTreeMixin {
  static final sm = MoonAccordionItemSizeProperties(
    headerHeight: MoonSizes.sizes.sm,
    iconSizeValue: MoonSizes.sizes.x2s,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    textStyle: MoonTextStyles.heading.text12,
  );

  static final md = MoonAccordionItemSizeProperties(
    headerHeight: MoonSizes.sizes.md,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonAccordionItemSizeProperties(
    headerHeight: MoonSizes.sizes.lg,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final xl = MoonAccordionItemSizeProperties(
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

  const MoonAccordionItemSizeProperties({
    required this.headerHeight,
    required this.iconSizeValue,
    required this.headerPadding,
    required this.textStyle,
  });

  @override
  MoonAccordionItemSizeProperties copyWith({
    double? headerHeight,
    double? iconSizeValue,
    EdgeInsets? headerPadding,
    TextStyle? textStyle,
  }) {
    return MoonAccordionItemSizeProperties(
      headerHeight: headerHeight ?? this.headerHeight,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      headerPadding: headerPadding ?? this.headerPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonAccordionItemSizeProperties lerp(ThemeExtension<MoonAccordionItemSizeProperties>? other, double t) {
    if (other is! MoonAccordionItemSizeProperties) return this;

    return MoonAccordionItemSizeProperties(
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
      ..add(DiagnosticsProperty("type", "MoonAccordionItemSizeProperties"))
      ..add(DoubleProperty("headerHeight", headerHeight))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsets>("headerPadding", headerPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
