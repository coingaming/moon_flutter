import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/iconography/iconography.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

@immutable
class MoonTokens extends ThemeExtension<MoonTokens> with DiagnosticableTreeMixin {
  static final light = MoonTokens(
    borders: MoonBorders.borders,
    colors: MoonColors.light,
    complementaryColors: MoonColors.dark,
    iconography: MoonIconography.light,
    opacities: MoonOpacities.opacities,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    transitions: MoonTransitions.transitions,
    typography: MoonTypography.light,
  );

  static final dark = MoonTokens(
    borders: MoonBorders.borders,
    colors: MoonColors.dark,
    complementaryColors: MoonColors.light,
    iconography: MoonIconography.dark,
    opacities: MoonOpacities.opacities,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    transitions: MoonTransitions.transitions,
    typography: MoonTypography.dark,
  );

  /// Moon Design System borders.
  final MoonBorders borders;

  /// Moon Design System colors.
  final MoonColors colors;

  /// Moon Design System colors that are from complementary theme (light -> dark, dark -> light).
  final MoonColors complementaryColors;

  /// Moon Design System iconography.
  final MoonIconography iconography;

  /// Moon Design System opacities.
  final MoonOpacities opacities;

  /// Moon Design System shadows.
  final MoonShadows shadows;

  /// Moon Design System sizes.
  final MoonSizes sizes;

  final MoonTransitions transitions;

  /// Moon Design System typography.
  final MoonTypography typography;

  const MoonTokens({
    required this.borders,
    required this.colors,
    required this.complementaryColors,
    required this.iconography,
    required this.opacities,
    required this.shadows,
    required this.sizes,
    required this.transitions,
    required this.typography,
  });

  @override
  MoonTokens copyWith({
    MoonBorders? borders,
    MoonColors? colors,
    MoonColors? complementaryColors,
    MoonIconography? iconography,
    MoonOpacities? opacities,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonTransitions? transitions,
    MoonTypography? typography,
  }) {
    return MoonTokens(
      borders: borders ?? this.borders,
      colors: colors ?? this.colors,
      complementaryColors: complementaryColors ?? this.complementaryColors,
      iconography: iconography ?? this.iconography,
      opacities: opacities ?? this.opacities,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      transitions: transitions ?? this.transitions,
      typography: typography ?? this.typography,
    );
  }

  @override
  MoonTokens lerp(ThemeExtension<MoonTokens>? other, double t) {
    if (other is! MoonTokens) return this;

    return MoonTokens(
      borders: borders.lerp(other.borders, t),
      colors: colors.lerp(other.colors, t),
      complementaryColors: complementaryColors.lerp(other.complementaryColors, t),
      iconography: iconography.lerp(other.iconography, t),
      opacities: opacities.lerp(other.opacities, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
      transitions: transitions.lerp(other.transitions, t),
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
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", complementaryColors))
      ..add(DiagnosticsProperty<MoonIconography>("MoonIconography", iconography))
      ..add(DiagnosticsProperty<MoonOpacities>("MoonOpacities", opacities))
      ..add(DiagnosticsProperty<MoonShadows>("MoonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("MoonSizes", sizes))
      ..add(DiagnosticsProperty<MoonTransitions>("MoonTransitions", transitions))
      ..add(DiagnosticsProperty<MoonTypography>("MoonTypography", typography));
  }
}
