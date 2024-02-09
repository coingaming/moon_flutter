import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonBreadcrumbColors extends ThemeExtension<MoonBreadcrumbColors> with DiagnosticableTreeMixin {
  /// The icon and text color of the MoonBreadcrumb item.
  final Color itemColor;

  /// The icon and text color of the current MoonBreadcrumb item.
  final Color? currentItemColor;

  /// The icon and text color of the MoonBreadcrumb item on hover.
  final Color? hoverEffectColor;

  const MoonBreadcrumbColors({
    required this.itemColor,
    required this.currentItemColor,
    required this.hoverEffectColor,
  });

  @override
  MoonBreadcrumbColors copyWith({
    Color? itemColor,
    Color? currentItemColor,
    Color? hoverEffectColor,
  }) {
    return MoonBreadcrumbColors(
      itemColor: itemColor ?? this.itemColor,
      currentItemColor: currentItemColor ?? this.currentItemColor,
      hoverEffectColor: hoverEffectColor ?? this.hoverEffectColor,
    );
  }

  @override
  MoonBreadcrumbColors lerp(
    ThemeExtension<MoonBreadcrumbColors>? other,
    double t,
  ) {
    if (other is! MoonBreadcrumbColors) return this;

    return MoonBreadcrumbColors(
      itemColor: colorPremulLerp(itemColor, other.itemColor, t)!,
      currentItemColor: colorPremulLerp(currentItemColor, other.currentItemColor, t),
      hoverEffectColor: colorPremulLerp(hoverEffectColor, other.hoverEffectColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBreadcrumbColors"))
      ..add(ColorProperty("itemColor", itemColor))
      ..add(ColorProperty("currentItemColor", currentItemColor))
      ..add(ColorProperty("hoverEffectColor", hoverEffectColor));
  }
}
