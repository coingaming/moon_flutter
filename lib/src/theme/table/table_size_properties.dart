import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTableSizeProperties extends ThemeExtension<MoonTableSizeProperties> with DiagnosticableTreeMixin {
  /// Table row border radius.
  final BorderRadiusGeometry rowBorderRadius;

  /// Space between table rows.
  final double rowGap;

  /// Table row height.
  final double rowHeight;

  /// Horizontal gap between column label and sort icon.
  final double sortIconGap;

  /// Table sort icon size value.
  final double sortIconSizeValue;

  /// Table row cell padding.
  final EdgeInsetsGeometry cellPadding;

  /// Table row cell padding.
  final EdgeInsetsGeometry rowTitlePadding;

  /// Table column text style.
  final TextStyle columnTextStyle;

  /// Table row text style.
  final TextStyle rowTextStyle;

  /// Table row title text style.
  final TextStyle rowTitleTextStyle;

  /// Table row animated title text style.
  final TextStyle rowAnimatedTitleTextStyle;

  const MoonTableSizeProperties({
    required this.rowBorderRadius,
    required this.rowGap,
    required this.rowHeight,
    required this.sortIconGap,
    required this.sortIconSizeValue,
    required this.cellPadding,
    required this.rowTitlePadding,
    required this.columnTextStyle,
    required this.rowTextStyle,
    required this.rowTitleTextStyle,
    required this.rowAnimatedTitleTextStyle,
  });

  @override
  MoonTableSizeProperties copyWith({
    BorderRadiusGeometry? rowBorderRadius,
    double? rowGap,
    double? rowHeight,
    double? sortIconGap,
    double? sortIconSizeValue,
    EdgeInsetsGeometry? cellPadding,
    EdgeInsetsGeometry? rowTitlePadding,
    TextStyle? columnTextStyle,
    TextStyle? rowTextStyle,
    TextStyle? rowTitleTextStyle,
    TextStyle? rowAnimatedTitleTextStyle,
  }) {
    return MoonTableSizeProperties(
      rowBorderRadius: rowBorderRadius ?? this.rowBorderRadius,
      rowGap: rowGap ?? this.rowGap,
      rowHeight: rowHeight ?? this.rowHeight,
      sortIconGap: sortIconGap ?? this.sortIconGap,
      sortIconSizeValue: sortIconSizeValue ?? this.sortIconSizeValue,
      cellPadding: cellPadding ?? this.cellPadding,
      rowTitlePadding: rowTitlePadding ?? this.rowTitlePadding,
      columnTextStyle: columnTextStyle ?? this.columnTextStyle,
      rowTextStyle: rowTextStyle ?? this.rowTextStyle,
      rowTitleTextStyle: rowTitleTextStyle ?? this.rowTitleTextStyle,
      rowAnimatedTitleTextStyle: rowAnimatedTitleTextStyle ?? this.rowAnimatedTitleTextStyle,
    );
  }

  @override
  MoonTableSizeProperties lerp(ThemeExtension<MoonTableSizeProperties>? other, double t) {
    if (other is! MoonTableSizeProperties) return this;

    return MoonTableSizeProperties(
      rowBorderRadius: BorderRadiusGeometry.lerp(rowBorderRadius, other.rowBorderRadius, t)!,
      rowGap: lerpDouble(rowGap, other.rowGap, t)!,
      rowHeight: lerpDouble(rowHeight, other.rowHeight, t)!,
      sortIconGap: lerpDouble(sortIconGap, other.sortIconGap, t)!,
      sortIconSizeValue: lerpDouble(sortIconSizeValue, other.sortIconSizeValue, t)!,
      cellPadding: EdgeInsetsGeometry.lerp(cellPadding, other.cellPadding, t)!,
      rowTitlePadding: EdgeInsetsGeometry.lerp(rowTitlePadding, other.rowTitlePadding, t)!,
      columnTextStyle: TextStyle.lerp(columnTextStyle, other.columnTextStyle, t)!,
      rowTextStyle: TextStyle.lerp(rowTextStyle, other.rowTextStyle, t)!,
      rowTitleTextStyle: TextStyle.lerp(rowTitleTextStyle, other.rowTitleTextStyle, t)!,
      rowAnimatedTitleTextStyle: TextStyle.lerp(rowAnimatedTitleTextStyle, other.rowAnimatedTitleTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTableSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("rowBorderRadius", rowBorderRadius))
      ..add(DoubleProperty("rowGap", rowGap))
      ..add(DoubleProperty("rowHeight", rowHeight))
      ..add(DoubleProperty("sortIconGap", sortIconGap))
      ..add(DoubleProperty("sortIconSizeValue", sortIconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("cellPadding", cellPadding))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("rowTitlePadding", rowTitlePadding))
      ..add(DiagnosticsProperty<TextStyle>("columnTextStyle", columnTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("rowTextStyle", rowTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("rowTitleTextStyle", rowTitleTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("rowAnimatedTitleTextStyle", rowAnimatedTitleTextStyle));
  }
}
