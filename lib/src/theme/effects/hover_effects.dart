import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonHoverEffects extends ThemeExtension<MoonHoverEffects> with DiagnosticableTreeMixin {
  static final lightHoverEffect = MoonHoverEffects(
    primaryHoverColor: MoonColors.light.heles,
    secondaryHoverColor: MoonColors.light.jiren,
    hoverCurve: Curves.easeInOut,
    hoverDuration: const Duration(milliseconds: 150),
  );

  static final darkHoverEffect = MoonHoverEffects(
    primaryHoverColor: MoonColors.dark.heles,
    secondaryHoverColor: MoonColors.dark.jiren,
    hoverCurve: Curves.easeInOut,
    hoverDuration: const Duration(milliseconds: 150),
  );

  /// Primary hover effect color.
  final Color primaryHoverColor;

  /// Secondary hover effect color.
  final Color secondaryHoverColor;

  /// Hover effect curve.
  final Curve hoverCurve;

  /// Hover effect duration.
  final Duration hoverDuration;

  const MoonHoverEffects({
    required this.primaryHoverColor,
    required this.secondaryHoverColor,
    required this.hoverCurve,
    required this.hoverDuration,
  });

  @override
  MoonHoverEffects copyWith({
    Color? primaryHoverColor,
    Color? secondaryHoverColor,
    Curve? hoverCurve,
    Duration? hoverDuration,
  }) {
    return MoonHoverEffects(
      primaryHoverColor: primaryHoverColor ?? this.primaryHoverColor,
      secondaryHoverColor: secondaryHoverColor ?? this.secondaryHoverColor,
      hoverCurve: hoverCurve ?? this.hoverCurve,
      hoverDuration: hoverDuration ?? this.hoverDuration,
    );
  }

  @override
  MoonHoverEffects lerp(ThemeExtension<MoonHoverEffects>? other, double t) {
    if (other is! MoonHoverEffects) return this;

    return MoonHoverEffects(
      primaryHoverColor: Color.lerp(primaryHoverColor, other.primaryHoverColor, t)!,
      secondaryHoverColor: Color.lerp(secondaryHoverColor, other.secondaryHoverColor, t)!,
      hoverCurve: other.hoverCurve,
      hoverDuration: lerpDuration(hoverDuration, other.hoverDuration, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonHoverEffects"))
      ..add(ColorProperty("primaryHoverColor", primaryHoverColor))
      ..add(ColorProperty("secondaryHoverColor", secondaryHoverColor))
      ..add(DiagnosticsProperty<Curve>("hoverCurve", hoverCurve))
      ..add(DiagnosticsProperty<Duration>("hoverDuration", hoverDuration));
  }
}
