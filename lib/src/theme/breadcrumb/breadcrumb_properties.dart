import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonBreadcrumbProperties extends ThemeExtension<MoonBreadcrumbProperties> with DiagnosticableTreeMixin {
  /// The gap between the divider and the MoonBreadcrumb's item.
  final double gap;

  /// The gap between the MoonBreadcrumb item's leading, label and trailing widgets.
  final double itemGap;

  /// The duration of the MoonBreadcrumb's transition animation.
  final Duration transitionDuration;

  /// The curve of the MoonBreadcrumb's transition animation.
  final Curve transitionCurve;

  /// The text style of the MoonBreadcrumb's item.
  final TextStyle itemTextStyle;

  /// The text style of the current MoonBreadcrumb's item.
  final TextStyle currentItemTextStyle;

  /// The text style of the MoonBreadcrumb's show more item.
  final TextStyle showMoreItemTextStyle;

  const MoonBreadcrumbProperties({
    required this.gap,
    required this.itemGap,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.itemTextStyle,
    required this.currentItemTextStyle,
    required this.showMoreItemTextStyle,
  });

  @override
  MoonBreadcrumbProperties copyWith({
    double? gap,
    double? itemGap,
    Duration? transitionDuration,
    Curve? transitionCurve,
    TextStyle? itemTextStyle,
    TextStyle? currentItemTextStyle,
    TextStyle? showMoreItemTextStyle,
  }) {
    return MoonBreadcrumbProperties(
      gap: gap ?? this.gap,
      itemGap: itemGap ?? this.itemGap,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      currentItemTextStyle: currentItemTextStyle ?? this.currentItemTextStyle,
      showMoreItemTextStyle: showMoreItemTextStyle ?? this.showMoreItemTextStyle,
    );
  }

  @override
  MoonBreadcrumbProperties lerp(ThemeExtension<MoonBreadcrumbProperties>? other, double t) {
    if (other is! MoonBreadcrumbProperties) return this;

    return MoonBreadcrumbProperties(
      gap: lerpDouble(gap, other.gap, t)!,
      itemGap: lerpDouble(itemGap, other.itemGap, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t)!,
      currentItemTextStyle: TextStyle.lerp(currentItemTextStyle, other.currentItemTextStyle, t)!,
      showMoreItemTextStyle: TextStyle.lerp(showMoreItemTextStyle, other.showMoreItemTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBreadcrumbProperties"))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("itemGap", itemGap))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<TextStyle>("itemTextStyle", itemTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("currentItemTextStyle", currentItemTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("showMoreItemTextStyle", showMoreItemTextStyle));
  }
}
