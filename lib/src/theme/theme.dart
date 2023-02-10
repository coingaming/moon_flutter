import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar_theme.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button_theme.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
  static final light = MoonTheme(
    avatarTheme: MoonAvatarTheme.sizes,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.sizes,
    colors: MoonColors.light,
    effects: MoonEffects.light,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    typography: MoonTypography.textStyles,
  );

  static final dark = MoonTheme(
    avatarTheme: MoonAvatarTheme.sizes,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.sizes,
    colors: MoonColors.dark,
    effects: MoonEffects.dark,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    typography: MoonTypography.textStyles,
  );

  /// Moon Design System avatar theming.
  final MoonAvatarTheme avatarTheme;

  /// Moon Design System borders.
  final MoonBorders borders;

  /// Moon Design System buttons theming.
  final MoonButtonTheme buttonTheme;

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

  const MoonTheme({
    required this.avatarTheme,
    required this.buttonTheme,
    required this.borders,
    required this.colors,
    required this.effects,
    required this.opacity,
    required this.shadows,
    required this.sizes,
    required this.typography,
  });

  @override
  MoonTheme copyWith({
    MoonAvatarTheme? avatarTheme,
    MoonBorders? borders,
    MoonButtonTheme? buttonTheme,
    MoonColors? colors,
    MoonEffects? effects,
    MoonOpacity? opacity,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonTypography? typography,
  }) {
    return MoonTheme(
      avatarTheme: avatarTheme ?? this.avatarTheme,
      borders: borders ?? this.borders,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      colors: colors ?? this.colors,
      effects: effects ?? this.effects,
      opacity: opacity ?? this.opacity,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      typography: typography ?? this.typography,
    );
  }

  @override
  MoonTheme lerp(ThemeExtension<MoonTheme>? other, double t) {
    if (other is! MoonTheme) return this;

    return MoonTheme(
      avatarTheme: avatarTheme.lerp(other.avatarTheme, t),
      borders: borders.lerp(other.borders, t),
      buttonTheme: buttonTheme.lerp(other.buttonTheme, t),
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
      ..add(DiagnosticsProperty("type", "MoonTheme"))
      ..add(DiagnosticsProperty<MoonAvatarTheme>("MoonAvatarTheme", avatarTheme))
      ..add(DiagnosticsProperty<MoonBorders>("MoonBorders", borders))
      ..add(DiagnosticsProperty<MoonButtonTheme>("MoonButtonTheme", buttonTheme))
      ..add(DiagnosticsProperty<MoonColors>("moonColors", colors))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonOpacity>("moonOpacity", opacity))
      ..add(DiagnosticsProperty<MoonShadows>("moonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("moonSizes", sizes))
      ..add(DiagnosticsProperty<MoonTypography>("moonTypography", typography));
  }
}

extension MoonThemeX on BuildContext {
  MoonTheme? get moonTheme => Theme.of(this).extension<MoonTheme>();
  MoonAvatarTheme? get moonAvatarTheme => moonTheme?.avatarTheme;
  MoonBorders? get moonBorders => moonTheme?.borders;
  MoonButtonTheme? get moonButtonTheme => moonTheme?.buttonTheme;
  MoonColors? get moonColors => moonTheme?.colors;
  MoonEffects? get moonEffects => moonTheme?.effects;
  MoonOpacity? get moonOpacity => moonTheme?.opacity;
  MoonShadows? get moonShadows => moonTheme?.shadows;
  MoonSizes? get moonSizes => moonTheme?.sizes;
  MoonTypography? get moonTypography => moonTheme?.typography;
}
