import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonHoverEffects extends ThemeExtension<MoonHoverEffects> with DiagnosticableTreeMixin {
  static final light = MoonHoverEffects(
    primaryHover: MoonColors.light.heles,
    secondaryHover: MoonColors.light.jiren,
  );

  static final dark = MoonHoverEffects(
    primaryHover: MoonColors.dark.heles,
    secondaryHover: MoonColors.dark.jiren,
  );

  /// Primary hover state color.
  final Color primaryHover;

  /// Secondary hover state color.
  final Color secondaryHover;

  const MoonHoverEffects({
    required this.primaryHover,
    required this.secondaryHover,
  });

  @override
  MoonHoverEffects copyWith({
    Color? primaryHover,
    Color? secondaryHover,
  }) {
    return MoonHoverEffects(
      primaryHover: primaryHover ?? this.primaryHover,
      secondaryHover: secondaryHover ?? this.secondaryHover,
    );
  }

  @override
  MoonHoverEffects lerp(ThemeExtension<MoonHoverEffects>? other, double t) {
    if (other is! MoonHoverEffects) return this;

    return MoonHoverEffects(
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      secondaryHover: Color.lerp(secondaryHover, other.secondaryHover, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonHoverEffects"))
      ..add(ColorProperty("primaryHover", primaryHover))
      ..add(ColorProperty("secondaryHover", secondaryHover));
  }
}
