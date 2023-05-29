import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonAccordionItemSizeProperties extends ThemeExtension<MoonAccordionItemSizeProperties>
    with DiagnosticableTreeMixin {
  static final sm = MoonAccordionItemSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    headerHeight: MoonSizes.sizes.sm,
    iconSizeValue: MoonSizes.sizes.x2s,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    headerTextStyle: MoonTextStyles.heading.text12,
    contentTextStyle: MoonTextStyles.body.text12,
  );

  static final md = MoonAccordionItemSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    headerHeight: MoonSizes.sizes.md,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    headerTextStyle: MoonTextStyles.heading.text14,
    contentTextStyle: MoonTextStyles.body.text14,
  );

  static final lg = MoonAccordionItemSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    headerHeight: MoonSizes.sizes.lg,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    headerTextStyle: MoonTextStyles.heading.text14,
    contentTextStyle: MoonTextStyles.body.text14,
  );

  static final xl = MoonAccordionItemSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    headerHeight: MoonSizes.sizes.xl,
    iconSizeValue: MoonSizes.sizes.xs,
    headerPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x2s),
    headerTextStyle: MoonTextStyles.heading.text16,
    contentTextStyle: MoonTextStyles.body.text14,
  );

  /// Accordion item border radius.
  final BorderRadiusGeometry borderRadius;

  /// Accordion header height.
  final double headerHeight;

  /// Accordion icon size value.
  final double iconSizeValue;

  /// Padding around accordion title and icon.
  final EdgeInsetsGeometry headerPadding;

  /// Accordion header text style.
  final TextStyle headerTextStyle;

  /// Accordion content text style.
  final TextStyle contentTextStyle;

  const MoonAccordionItemSizeProperties({
    required this.borderRadius,
    required this.headerHeight,
    required this.iconSizeValue,
    required this.headerPadding,
    required this.headerTextStyle,
    required this.contentTextStyle,
  });

  @override
  MoonAccordionItemSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? headerHeight,
    double? iconSizeValue,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? headerTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return MoonAccordionItemSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      headerHeight: headerHeight ?? this.headerHeight,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      headerPadding: headerPadding ?? this.headerPadding,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    );
  }

  @override
  MoonAccordionItemSizeProperties lerp(ThemeExtension<MoonAccordionItemSizeProperties>? other, double t) {
    if (other is! MoonAccordionItemSizeProperties) return this;

    return MoonAccordionItemSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      headerHeight: lerpDouble(headerHeight, other.headerHeight, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      headerPadding: EdgeInsetsGeometry.lerp(headerPadding, other.headerPadding, t)!,
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t)!,
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionItemSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("headerHeight", headerHeight))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("headerPadding", headerPadding))
      ..add(DiagnosticsProperty<TextStyle>("headerTextStyle", headerTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("contentTextStyle", contentTextStyle));
  }
}
