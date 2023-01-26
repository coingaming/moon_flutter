import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/hover_effects.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/transitions.dart';
import 'package:moon_design/src/theme/typography.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
  static final light = MoonTheme(
    borders: const MoonBorders(),
    colors: MoonColors.light,
    hoverEffects: MoonHoverEffects.light,
    shadows: MoonShadows.light,
    sizes: const MoonSizes(),
    transitions: const MoonTransitions(),
    typography: const MoonTypography(),
  );

  static final dark = MoonTheme(
    borders: const MoonBorders(),
    colors: MoonColors.dark,
    hoverEffects: MoonHoverEffects.dark,
    shadows: MoonShadows.dark,
    sizes: const MoonSizes(),
    transitions: const MoonTransitions(),
    typography: const MoonTypography(),
  );

  /// MDS borders.
  final MoonBorders borders;

  /// MDS colors.
  final MoonColors colors;

  /// MDS hover effects.
  final MoonHoverEffects hoverEffects;

  /// MDS shadows.
  final MoonShadows shadows;

  /// MDS sizes.
  final MoonSizes sizes;

  /// MDS transitions.
  final MoonTransitions transitions;

  /// MDS typography.
  final MoonTypography typography;

  const MoonTheme({
    required this.borders,
    required this.colors,
    required this.hoverEffects,
    required this.shadows,
    required this.sizes,
    required this.transitions,
    required this.typography,
  });

  @override
  MoonTheme copyWith({
    MoonBorders? borders,
    MoonColors? colors,
    MoonHoverEffects? hoverEffects,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonTransitions? transitions,
    MoonTypography? typography,
  }) {
    return MoonTheme(
      borders: borders ?? this.borders,
      colors: colors ?? this.colors,
      hoverEffects: hoverEffects ?? this.hoverEffects,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      transitions: transitions ?? this.transitions,
      typography: typography ?? this.typography,
    );
  }

  @override
  MoonTheme lerp(ThemeExtension<MoonTheme>? other, double t) {
    if (other is! MoonTheme) return this;

    return MoonTheme(
      borders: borders.lerp(other.borders, t),
      colors: colors.lerp(other.colors, t),
      hoverEffects: hoverEffects.lerp(other.hoverEffects, t),
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
      ..add(DiagnosticsProperty("type", "MoonTheme"))
      ..add(DiagnosticsProperty<MoonBorders>("moonBorders", borders))
      ..add(DiagnosticsProperty<MoonColors>("moonColors", colors))
      ..add(DiagnosticsProperty<MoonHoverEffects>("moonHoverEffects", hoverEffects))
      ..add(DiagnosticsProperty<MoonShadows>("moonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("moonSizes", sizes))
      ..add(DiagnosticsProperty<MoonTransitions>("moonTransitions", transitions))
      ..add(DiagnosticsProperty<MoonTypography>("moonTypography", typography));
  }
}

extension MoonThemeX on BuildContext {
  MoonTheme get moonTheme => Theme.of(this).extension<MoonTheme>()!;
  MoonBorders get moonBorders => moonTheme.borders;
  MoonColors get moonColors => moonTheme.colors;
}
