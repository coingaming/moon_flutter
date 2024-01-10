import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonBreadcrumbProperties extends ThemeExtension<MoonBreadcrumbProperties> with DiagnosticableTreeMixin {
  /// The gap between divider and MoonBreadcrumb item.
  final double gap;

  /// The MoonBreadcrumb expanded menu max height.
  final double menuMaxHeight;

  /// The MoonBreadcrumb transition duration.
  final Duration transitionDuration;

  /// The MoonBreadcrumb transition curve.
  final Curve transitionCurve;

  /// The padding around MoonBreadcrumb.
  final EdgeInsetsGeometry padding;

  /// The MoonBreadcrumb item text style.
  final TextStyle itemTextStyle;

  /// The current MoonBreadcrumb item text style.
  final TextStyle currentItemTextStyle;

  /// The MoonBreadcrumb expanded menu item text style.
  final TextStyle menuItemTextStyle;

  const MoonBreadcrumbProperties({
    required this.gap,
    required this.menuMaxHeight,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.padding,
    required this.itemTextStyle,
    required this.currentItemTextStyle,
    required this.menuItemTextStyle,
  });

  @override
  MoonBreadcrumbProperties copyWith({
    double? gap,
    double? menuMaxHeight,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? padding,
    TextStyle? itemTextStyle,
    TextStyle? currentItemTextStyle,
    TextStyle? menuItemTextStyle,
  }) {
    return MoonBreadcrumbProperties(
      gap: gap ?? this.gap,
      menuMaxHeight: menuMaxHeight ?? this.menuMaxHeight,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      padding: padding ?? this.padding,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      currentItemTextStyle: currentItemTextStyle ?? this.currentItemTextStyle,
      menuItemTextStyle: menuItemTextStyle ?? this.menuItemTextStyle,
    );
  }

  @override
  MoonBreadcrumbProperties lerp(ThemeExtension<MoonBreadcrumbProperties>? other, double t) {
    if (other is! MoonBreadcrumbProperties) return this;

    return MoonBreadcrumbProperties(
      gap: lerpDouble(gap, other.gap, t)!,
      menuMaxHeight: lerpDouble(menuMaxHeight, other.menuMaxHeight, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t)!,
      currentItemTextStyle: TextStyle.lerp(currentItemTextStyle, other.currentItemTextStyle, t)!,
      menuItemTextStyle: TextStyle.lerp(menuItemTextStyle, other.menuItemTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBreadcrumbProperties"))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("menuMaxHeight", menuMaxHeight))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("itemTextStyle", itemTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("currentItemTextStyle", currentItemTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("menuItemTextStyle", menuItemTextStyle));
  }
}
