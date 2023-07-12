import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/typography.dart';

@immutable
class MoonTokens extends ThemeExtension<MoonTokens> with DiagnosticableTreeMixin {
  static final light = MoonTokens(
    borders: MoonBorders.borders,
    colors: MoonColors.light,
    effects: MoonEffects.light,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    typography: MoonTypography.light,
  );

  static final dark = MoonTokens(
    borders: MoonBorders.borders,
    colors: MoonColors.dark,
    effects: MoonEffects.dark,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    typography: MoonTypography.dark,
  );

  /// Moon Design System borders.
  final MoonBorders borders;

  /// Moon Design System colors.
  final MoonColors colors;

  /// Moon Design System effects.
  final MoonEffects effects;

  /// Moon Design System opacities.
  final MoonOpacity opacity;

  /// Moon Design System shadows.
  final MoonShadows shadows;

  /// Moon Design System sizes.
  final MoonSizes sizes;

  /// Moon Design System typography.
  final MoonTypography typography;

  const MoonTokens({
    required this.borders,
    required this.colors,
    required this.effects,
    required this.opacity,
    required this.shadows,
    required this.sizes,
    required this.typography,
  });

  @override
  MoonTokens copyWith({
    MoonBorders? borders,
    MoonColors? colors,
    MoonEffects? effects,
    MoonOpacity? opacity,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonTypography? typography,
  }) {
    return MoonTokens(
      borders: borders ?? this.borders,
      colors: colors ?? this.colors,
      effects: effects ?? this.effects,
      opacity: opacity ?? this.opacity,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      typography: typography ?? this.typography,
    );
  }

  @override
  MoonTokens lerp(ThemeExtension<MoonTokens>? other, double t) {
    if (other is! MoonTokens) return this;

    return MoonTokens(
      borders: borders.lerp(other.borders, t),
      colors: colors.lerp(other.colors, t),
      effects: effects.lerp(other.effects, t),
      opacity: opacity.lerp(other.opacity, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
      typography: typography.lerp(other.typography, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTokens"))
      ..add(DiagnosticsProperty<MoonBorders>("MoonBorders", borders))
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", colors))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonOpacity>("MoonOpacity", opacity))
      ..add(DiagnosticsProperty<MoonShadows>("MoonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("MoonSizes", sizes))
      ..add(DiagnosticsProperty<MoonTypography>("MoonTypography", typography));
  }
}
