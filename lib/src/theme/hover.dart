import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonHover extends ThemeExtension<MoonHover> with DiagnosticableTreeMixin {
  static final light = MoonHover(
    primaryHover: MoonColors.light.heles,
    secondaryHover: MoonColors.light.jiren,
  );

  static final dark = MoonHover(
    primaryHover: MoonColors.dark.heles,
    secondaryHover: MoonColors.dark.jiren,
  );

  /// Primary widget hover state color.
  final Color primaryHover;

  /// Secondary widget hover state color.
  final Color secondaryHover;

  const MoonHover({
    required this.primaryHover,
    required this.secondaryHover,
  });

  @override
  MoonHover copyWith({
    Color? primaryHover,
    Color? secondaryHover,
  }) {
    return MoonHover(
      primaryHover: primaryHover ?? this.primaryHover,
      secondaryHover: secondaryHover ?? this.secondaryHover,
    );
  }

  @override
  MoonHover lerp(ThemeExtension<MoonHover>? other, double t) {
    if (other is! MoonHover) return this;

    return MoonHover(
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      secondaryHover: Color.lerp(secondaryHover, other.secondaryHover, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonHover"))
      ..add(ColorProperty("primaryHover", primaryHover))
      ..add(ColorProperty("secondaryHover", secondaryHover));
  }
}
