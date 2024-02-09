import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTableSizeProperties extends ThemeExtension<MoonTableSizeProperties> with DiagnosticableTreeMixin {
  /// The border radius of the MoonTable row.
  final BorderRadiusGeometry rowBorderRadius;

  /// The vertical gap between the MoonTable rows.
  final double rowGap;

  /// The height of the MoonTable row.
  final double rowHeight;

  /// The horizontal gap between the MoonTable column label and sort icon.
  final double sortIconGap;

  /// The size value of the MoonTable column sort icon.
  final double sortIconSizeValue;

  /// The padding of the MoonTable cell.
  final EdgeInsetsGeometry cellPadding;

  /// The padding of the MoonTable row label.
  final EdgeInsetsGeometry rowLabelPadding;

  /// The text style of the MoonTable column.
  final TextStyle columnTextStyle;

  /// The text style of the MoonTable row.
  final TextStyle rowTextStyle;

  /// The text style of the MoonTable row label.
  final TextStyle rowLabelTextStyle;

  /// The text style of the MoonTable row pinned and animated label.
  final TextStyle rowPinnedAnimatedLabelTextStyle;

  const MoonTableSizeProperties({
    required this.rowBorderRadius,
    required this.rowGap,
    required this.rowHeight,
    required this.sortIconGap,
    required this.sortIconSizeValue,
    required this.cellPadding,
    required this.rowLabelPadding,
    required this.columnTextStyle,
    required this.rowTextStyle,
    required this.rowLabelTextStyle,
    required this.rowPinnedAnimatedLabelTextStyle,
  });

  @override
  MoonTableSizeProperties copyWith({
    BorderRadiusGeometry? rowBorderRadius,
    double? rowGap,
    double? rowHeight,
    double? sortIconGap,
    double? sortIconSizeValue,
    EdgeInsetsGeometry? cellPadding,
    EdgeInsetsGeometry? rowLabelPadding,
    TextStyle? columnTextStyle,
    TextStyle? rowTextStyle,
    TextStyle? rowLabelTextStyle,
    TextStyle? rowPinnedAnimatedLabelTextStyle,
  }) {
    return MoonTableSizeProperties(
      rowBorderRadius: rowBorderRadius ?? this.rowBorderRadius,
      rowGap: rowGap ?? this.rowGap,
      rowHeight: rowHeight ?? this.rowHeight,
      sortIconGap: sortIconGap ?? this.sortIconGap,
      sortIconSizeValue: sortIconSizeValue ?? this.sortIconSizeValue,
      cellPadding: cellPadding ?? this.cellPadding,
      rowLabelPadding: rowLabelPadding ?? this.rowLabelPadding,
      columnTextStyle: columnTextStyle ?? this.columnTextStyle,
      rowTextStyle: rowTextStyle ?? this.rowTextStyle,
      rowLabelTextStyle: rowLabelTextStyle ?? this.rowLabelTextStyle,
      rowPinnedAnimatedLabelTextStyle: rowPinnedAnimatedLabelTextStyle ?? this.rowPinnedAnimatedLabelTextStyle,
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
      rowLabelPadding: EdgeInsetsGeometry.lerp(rowLabelPadding, other.rowLabelPadding, t)!,
      columnTextStyle: TextStyle.lerp(columnTextStyle, other.columnTextStyle, t)!,
      rowTextStyle: TextStyle.lerp(rowTextStyle, other.rowTextStyle, t)!,
      rowLabelTextStyle: TextStyle.lerp(rowLabelTextStyle, other.rowLabelTextStyle, t)!,
      rowPinnedAnimatedLabelTextStyle: TextStyle.lerp(rowPinnedAnimatedLabelTextStyle, other.rowPinnedAnimatedLabelTextStyle, t)!,
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
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("rowLabelPadding", rowLabelPadding))
      ..add(DiagnosticsProperty<TextStyle>("columnTextStyle", columnTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("rowTextStyle", rowTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("rowLabelTextStyle", rowLabelTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("rowPinnedAnimatedLabelTextStyle", rowPinnedAnimatedLabelTextStyle));
  }
}
