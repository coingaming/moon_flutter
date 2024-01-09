import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonBreadcrumbProperties extends ThemeExtension<MoonBreadcrumbProperties> with DiagnosticableTreeMixin {
  /// The gap between divider and MoonBreadcrumb item.
  final double gap;

  /// Padding around MoonBreadcrumb.
  final EdgeInsetsGeometry padding;

  /// MoonBreadcrumb item text style.
  final TextStyle itemTextStyle;

  /// Current MoonBreadcrumb item text style.
  final TextStyle currentItemTextStyle;

  /// Icon to use as divider.
  final IconData dividerIcon;

  /// MoonBreadcrumb more items menu item text style.
  final TextStyle menuItemTextStyle;

  /// MoonBreadcrumb more items menu max height.
  final double menuMaxHeight;

  const MoonBreadcrumbProperties({
    required this.gap,
    required this.dividerIcon,
    required this.itemTextStyle,
    required this.currentItemTextStyle,
    required this.padding,
    required this.menuItemTextStyle,
    required this.menuMaxHeight,
  });

  @override
  MoonBreadcrumbProperties copyWith({
    double? gap,
    IconData? dividerIcon,
    TextStyle? itemTextStyle,
    TextStyle? currentItemTextStyle,
    EdgeInsetsGeometry? padding,
    TextStyle? menuItemTextStyle,
    double? menuMaxHeight,
  }) {
    return MoonBreadcrumbProperties(
      gap: gap ?? this.gap,
      dividerIcon: dividerIcon ?? this.dividerIcon,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      currentItemTextStyle: currentItemTextStyle ?? this.currentItemTextStyle,
      padding: padding ?? this.padding,
      menuItemTextStyle: menuItemTextStyle ?? this.menuItemTextStyle,
      menuMaxHeight: menuMaxHeight ?? this.menuMaxHeight,
    );
  }

  @override
  MoonBreadcrumbProperties lerp(ThemeExtension<MoonBreadcrumbProperties>? other, double t) {
    if (other is! MoonBreadcrumbProperties) return this;

    return MoonBreadcrumbProperties(
      gap: lerpDouble(gap, other.gap, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      dividerIcon: dividerIcon,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t)!,
      currentItemTextStyle: TextStyle.lerp(currentItemTextStyle, other.currentItemTextStyle, t)!,
      menuItemTextStyle: TextStyle.lerp(menuItemTextStyle, other.menuItemTextStyle, t)!,
      menuMaxHeight: lerpDouble(menuMaxHeight, other.menuMaxHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBreadcrumbProperties"))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("itemTextStyle", itemTextStyle))
      ..add(
        DiagnosticsProperty<TextStyle>(
          "currentItemTextStyle",
          currentItemTextStyle,
        ),
      )
      ..add(DiagnosticsProperty<IconData>("dividerIcon", dividerIcon))
      ..add(DiagnosticsProperty<TextStyle>("menuItemTextStyle", menuItemTextStyle))
      ..add(DoubleProperty("menuMaxHeight", menuMaxHeight));
  }
}
