import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonHoverEffects extends ThemeExtension<MoonHoverEffects> with DiagnosticableTreeMixin {
  static final lightHoverEffect = MoonHoverEffects(
    primaryHoverColor: MoonColors.light.heles,
    secondaryHoverColor: MoonColors.light.jiren,
    hoverDuration: const Duration(milliseconds: 150),
    hoverCurve: Curves.easeInOutCubic,
  );

  static final darkHoverEffect = MoonHoverEffects(
    primaryHoverColor: MoonColors.dark.heles,
    secondaryHoverColor: MoonColors.dark.jiren,
    hoverDuration: const Duration(milliseconds: 150),
    hoverCurve: Curves.easeInOutCubic,
  );

  /// Primary hover effect color.
  final Color primaryHoverColor;

  /// Secondary hover effect color.
  final Color secondaryHoverColor;

  /// Hover effect duration.
  final Duration hoverDuration;

  /// Hover effect curve.
  final Curve hoverCurve;

  const MoonHoverEffects({
    required this.primaryHoverColor,
    required this.secondaryHoverColor,
    required this.hoverDuration,
    required this.hoverCurve,
  });

  @override
  MoonHoverEffects copyWith({
    Color? primaryHoverColor,
    Color? secondaryHoverColor,
    Duration? hoverDuration,
    Curve? hoverCurve,
  }) {
    return MoonHoverEffects(
      primaryHoverColor: primaryHoverColor ?? this.primaryHoverColor,
      secondaryHoverColor: secondaryHoverColor ?? this.secondaryHoverColor,
      hoverDuration: hoverDuration ?? this.hoverDuration,
      hoverCurve: hoverCurve ?? this.hoverCurve,
    );
  }

  @override
  MoonHoverEffects lerp(ThemeExtension<MoonHoverEffects>? other, double t) {
    if (other is! MoonHoverEffects) return this;

    return MoonHoverEffects(
      primaryHoverColor: Color.lerp(primaryHoverColor, other.primaryHoverColor, t)!,
      secondaryHoverColor: Color.lerp(secondaryHoverColor, other.secondaryHoverColor, t)!,
      hoverDuration: lerpDuration(hoverDuration, other.hoverDuration, t),
      hoverCurve: other.hoverCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonHoverEffects"))
      ..add(ColorProperty("primaryHoverColor", primaryHoverColor))
      ..add(ColorProperty("secondaryHoverColor", secondaryHoverColor))
      ..add(DiagnosticsProperty<Duration>("hoverDuration", hoverDuration))
      ..add(DiagnosticsProperty<Curve>("hoverCurve", hoverCurve));
  }
}
