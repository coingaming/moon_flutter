import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_theme.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button/button_theme.dart';
import 'package:moon_design/src/theme/chip/chip_theme.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/effects.dart';
import 'package:moon_design/src/theme/loaders/circular_loader_theme.dart';
import 'package:moon_design/src/theme/loaders/linear_loader_theme.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/progress/circular_progress_theme.dart';
import 'package:moon_design/src/theme/progress/linear_progress_theme.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/tag/tag_theme.dart';
import 'package:moon_design/src/theme/tooltip/tooltip.dart';
import 'package:moon_design/src/theme/typography/typography.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
  static final light = MoonTheme(
    avatar: MoonAvatarTheme.light,
    borders: MoonBorders.borders,
    button: MoonButtonTheme.light,
    chip: MoonChipTheme.light,
    circularLoaderTheme: MoonCircularLoaderTheme.sizes,
    circularProgressTheme: MoonCircularProgressTheme.sizes,
    colors: MoonColors.light,
    effects: MoonEffects.light,
    linearLoaderTheme: MoonLinearLoaderTheme.sizes,
    linearProgressTheme: MoonLinearProgressTheme.sizes,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    tagTheme: MoonTagTheme.sizes,
    tooltipTheme: MoonTooltipTheme.tooltip,
    typography: MoonTypography.light,
  );

  static final dark = MoonTheme(
    avatar: MoonAvatarTheme.dark,
    borders: MoonBorders.borders,
    button: MoonButtonTheme.dark,
    chip: MoonChipTheme.dark,
    circularLoaderTheme: MoonCircularLoaderTheme.sizes,
    circularProgressTheme: MoonCircularProgressTheme.sizes,
    colors: MoonColors.dark,
    effects: MoonEffects.dark,
    linearLoaderTheme: MoonLinearLoaderTheme.sizes,
    linearProgressTheme: MoonLinearProgressTheme.sizes,
    opacity: MoonOpacity.opacities,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    tagTheme: MoonTagTheme.sizes,
    tooltipTheme: MoonTooltipTheme.tooltip,
    typography: MoonTypography.dark,
  );

  /// Moon Design System avatar theming.
  final MoonAvatarTheme avatar;

  /// Moon Design System borders.
  final MoonBorders borders;

  /// Moon Design System buttons theming.
  final MoonButtonTheme button;

  /// Moon Design System chip theming.
  final MoonChipTheme chip;

  /// Moon Design System circular loader theming.
  final MoonCircularLoaderTheme circularLoaderTheme;

  /// Moon Design System circular progress theming.
  final MoonCircularProgressTheme circularProgressTheme;

  /// Moon Design System colors.
  final MoonColors colors;

  /// Moon Design System effects.
  final MoonEffects effects;

  /// Moon Design System linear loader theming.
  final MoonLinearLoaderTheme linearLoaderTheme;

  /// Moon Design System linear progress theming.
  final MoonLinearProgressTheme linearProgressTheme;

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
    required this.avatar,
    required this.borders,
    required this.button,
    required this.chip,
    required this.circularLoaderTheme,
    required this.circularProgressTheme,
    required this.colors,
    required this.effects,
    required this.linearLoaderTheme,
    required this.linearProgressTheme,
    required this.opacity,
    required this.shadows,
    required this.sizes,
    required this.tagTheme,
    required this.tooltipTheme,
    required this.typography,
  });

  @override
  MoonTheme copyWith({
    MoonAvatarTheme? avatar,
    MoonBorders? borders,
    MoonButtonTheme? button,
    MoonChipTheme? chip,
    MoonCircularLoaderTheme? circularLoaderTheme,
    MoonCircularProgressTheme? circularProgressTheme,
    MoonColors? colors,
    MoonEffects? effects,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonOpacity? opacity,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonTagTheme? tagTheme,
    MoonTooltipTheme? tooltipTheme,
    MoonTypography? typography,
  }) {
    return MoonTheme(
      avatar: avatar ?? this.avatar,
      borders: borders ?? this.borders,
      button: button ?? this.button,
      chip: chip ?? this.chip,
      circularLoaderTheme: circularLoaderTheme ?? this.circularLoaderTheme,
      circularProgressTheme: circularProgressTheme ?? this.circularProgressTheme,
      colors: colors ?? this.colors,
      effects: effects ?? this.effects,
      linearLoaderTheme: linearLoaderTheme ?? this.linearLoaderTheme,
      linearProgressTheme: linearProgressTheme ?? this.linearProgressTheme,
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
      avatar: avatar.lerp(other.avatar, t),
      borders: borders.lerp(other.borders, t),
      button: button.lerp(other.button, t),
      chip: chip.lerp(other.chip, t),
      circularLoaderTheme: circularLoaderTheme.lerp(other.circularLoaderTheme, t),
      circularProgressTheme: circularProgressTheme.lerp(other.circularProgressTheme, t),
      colors: colors.lerp(other.colors, t),
      effects: effects.lerp(other.effects, t),
      linearLoaderTheme: linearLoaderTheme.lerp(other.linearLoaderTheme, t),
      linearProgressTheme: linearProgressTheme.lerp(other.linearProgressTheme, t),
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
      ..add(DiagnosticsProperty<MoonAvatarTheme>("MoonAvatarTheme", avatar))
      ..add(DiagnosticsProperty<MoonBorders>("MoonBorders", borders))
      ..add(DiagnosticsProperty<MoonButtonTheme>("MoonButtonTheme", button))
      ..add(DiagnosticsProperty<MoonChipTheme>("MoonChipTheme", chip))
      ..add(DiagnosticsProperty<MoonCircularLoaderTheme>("MoonCircularLoaderTheme", circularLoaderTheme))
      ..add(DiagnosticsProperty<MoonCircularProgressTheme>("MoonCircularProgressTheme", circularProgressTheme))
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", colors))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonLinearLoaderTheme>("MoonLinearLoaderTheme", linearLoaderTheme))
      ..add(DiagnosticsProperty<MoonLinearProgressTheme>("MoonLinearProgressTheme", linearProgressTheme))
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
  MoonBorders? get moonBorders => moonTheme?.borders;
  MoonColors? get moonColors => moonTheme?.colors;
  MoonEffects? get moonEffects => moonTheme?.effects;
  MoonOpacity? get moonOpacity => moonTheme?.opacity;
  MoonShadows? get moonShadows => moonTheme?.shadows;
  MoonSizes? get moonSizes => moonTheme?.sizes;
  MoonTypography? get moonTypography => moonTheme?.typography;
}
