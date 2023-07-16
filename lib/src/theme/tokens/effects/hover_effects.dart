import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonHoverEffects extends ThemeExtension<MoonHoverEffects> with DiagnosticableTreeMixin {
  static final lightHoverEffect = MoonHoverEffects(
    primaryHoverColor: MoonColors.light.heles,
    secondaryHoverColor: MoonColors.light.jiren,
    hoverDuration: MoonTransitions.transitions.defaultTransitionDuration,
    hoverCurve: MoonTransitions.transitions.defaultTransitionCurve,
  );

  static final darkHoverEffect = MoonHoverEffects(
    primaryHoverColor: MoonColors.dark.heles,
    secondaryHoverColor: MoonColors.dark.jiren,
    hoverDuration: MoonTransitions.transitions.defaultTransitionDuration,
    hoverCurve: MoonTransitions.transitions.defaultTransitionCurve,
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
      primaryHoverColor: colorPremulLerp(primaryHoverColor, other.primaryHoverColor, t)!,
      secondaryHoverColor: colorPremulLerp(secondaryHoverColor, other.secondaryHoverColor, t)!,
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
