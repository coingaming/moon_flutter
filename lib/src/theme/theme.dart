import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_theme.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button/button_theme.dart';
import 'package:moon_design/src/theme/chip/chip_theme.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/effects.dart';
import 'package:moon_design/src/theme/loader/loader_theme.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/tag/tag_theme.dart';
import 'package:moon_design/src/theme/tooltip/tooltip.dart';
import 'package:moon_design/src/theme/typography/typography.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
  static final light = MoonTheme(
    avatarTheme: MoonAvatarTheme.sizes,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.sizes,
    chipTheme: MoonChipTheme.sizes,
    colors: MoonColors.light,
    effects: MoonEffects.light,
    loaderTheme: MoonLoaderTheme.sizes,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    tagTheme: MoonTagTheme.sizes,
    tooltipTheme: MoonTooltipTheme.tooltip,
    typography: MoonTypography.textStyles,
  );

  static final dark = MoonTheme(
    avatarTheme: MoonAvatarTheme.sizes,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.sizes,
    chipTheme: MoonChipTheme.sizes,
    colors: MoonColors.dark,
    effects: MoonEffects.dark,
    loaderTheme: MoonLoaderTheme.sizes,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    tagTheme: MoonTagTheme.sizes,
    tooltipTheme: MoonTooltipTheme.tooltip,
    typography: MoonTypography.textStyles,
  );

  /// Moon Design System avatar theming.
  final MoonAvatarTheme avatarTheme;

  /// Moon Design System borders.
  final MoonBorders borders;

  /// Moon Design System buttons theming.
  final MoonButtonTheme buttonTheme;

  /// Moon Design System chip theming.
  final MoonChipTheme chipTheme;

  /// Moon Design System colors.
  final MoonColors colors;

  /// Moon Design System effects.
  final MoonEffects effects;

  /// Moon Design System loader theming.
  final MoonLoaderTheme loaderTheme;

  /// Moon Design System opacities.
  final MoonOpacity opacity;

  /// Moon Design System shadows.
  final MoonShadows shadows;

  /// Moon Design System sizes.
  final MoonSizes sizes;

  /// Moon Design System tag theming.
  final MoonTagTheme tagTheme;

  /// Moon Design System tooltip theming.
  final MoonTooltipTheme tooltipTheme;

  /// Moon Design System typography.
  final MoonTypography typography;

  const MoonTheme({
    required this.avatarTheme,
    required this.borders,
    required this.buttonTheme,
    required this.chipTheme,
    required this.colors,
    required this.effects,
    required this.loaderTheme,
    required this.opacity,
    required this.shadows,
    required this.sizes,
    required this.tagTheme,
    required this.tooltipTheme,
    required this.typography,
  });

  @override
  MoonTheme copyWith({
    MoonAvatarTheme? avatarTheme,
    MoonBorders? borders,
    MoonButtonTheme? buttonTheme,
    MoonChipTheme? chipTheme,
    MoonColors? colors,
    MoonEffects? effects,
    MoonLoaderTheme? loaderTheme,
    MoonOpacity? opacity,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonTagTheme? tagTheme,
    MoonTooltipTheme? tooltipTheme,
    MoonTypography? typography,
  }) {
    return MoonTheme(
      avatarTheme: avatarTheme ?? this.avatarTheme,
      borders: borders ?? this.borders,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      colors: colors ?? this.colors,
      effects: effects ?? this.effects,
      loaderTheme: loaderTheme ?? this.loaderTheme,
      opacity: opacity ?? this.opacity,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      tagTheme: tagTheme ?? this.tagTheme,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
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
      chipTheme: chipTheme.lerp(other.chipTheme, t),
      colors: colors.lerp(other.colors, t),
      effects: effects.lerp(other.effects, t),
      loaderTheme: loaderTheme.lerp(other.loaderTheme, t),
      opacity: opacity.lerp(other.opacity, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
      tagTheme: tagTheme.lerp(other.tagTheme, t),
      tooltipTheme: tooltipTheme.lerp(other.tooltipTheme, t),
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
      ..add(DiagnosticsProperty<MoonChipTheme>("MoonChipTheme", chipTheme))
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", colors))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonLoaderTheme>("MoonLoaderTheme", loaderTheme))
      ..add(DiagnosticsProperty<MoonOpacity>("MoonOpacity", opacity))
      ..add(DiagnosticsProperty<MoonShadows>("MoonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("MoonSizes", sizes))
      ..add(DiagnosticsProperty<MoonTagTheme>("MoonTagTheme", tagTheme))
      ..add(DiagnosticsProperty<MoonTooltipTheme>("MoonTooltipTheme", tooltipTheme))
      ..add(DiagnosticsProperty<MoonTypography>("MoonTypography", typography));
  }
}

extension MoonThemeX on BuildContext {
  MoonTheme? get moonTheme => Theme.of(this).extension<MoonTheme>();
  MoonAvatarTheme? get moonAvatarTheme => moonTheme?.avatarTheme;
  MoonBorders? get moonBorders => moonTheme?.borders;
  MoonButtonTheme? get moonButtonTheme => moonTheme?.buttonTheme;
  MoonChipTheme? get moonChipTheme => moonTheme?.chipTheme;
  MoonColors? get moonColors => moonTheme?.colors;
  MoonEffects? get moonEffects => moonTheme?.effects;
  MoonLoaderTheme? get moonLoaderTheme => moonTheme?.loaderTheme;
  MoonOpacity? get moonOpacity => moonTheme?.opacity;
  MoonShadows? get moonShadows => moonTheme?.shadows;
  MoonSizes? get moonSizes => moonTheme?.sizes;
  MoonTagTheme? get moonTagTheme => moonTheme?.tagTheme;
  MoonTooltipTheme? get moonTooltipTheme => moonTheme?.tooltipTheme;
  MoonTypography? get moonTypography => moonTheme?.typography;
}
