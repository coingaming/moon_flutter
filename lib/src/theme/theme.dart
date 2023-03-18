import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/accordion/accordion_theme.dart';

import 'package:moon_design/src/theme/avatar/avatar_theme.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button/button_theme.dart';
import 'package:moon_design/src/theme/checkbox/checkbox_theme.dart';
import 'package:moon_design/src/theme/chip/chip_theme.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/effects.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_theme.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_theme.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/popover/popover_theme.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_theme.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_theme.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/switch/switch_theme.dart';
import 'package:moon_design/src/theme/tag/tag_theme.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
  static final light = MoonTheme(
    accordionTheme: MoonAccordionTheme.light,
    avatarTheme: MoonAvatarTheme.light,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.light,
    checkboxTheme: MoonCheckboxTheme.light,
    chipTheme: MoonChipTheme.light,
    circularLoaderTheme: MoonCircularLoaderTheme.light,
    circularProgressTheme: MoonCircularProgressTheme.light,
    colors: MoonColors.light,
    effects: MoonEffects.light,
    linearLoaderTheme: MoonLinearLoaderTheme.light,
    linearProgressTheme: MoonLinearProgressTheme.light,
    opacity: MoonOpacity.opacities,
    popoverTheme: MoonPopoverTheme.light,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    switchTheme: MoonSwitchTheme.light,
    tagTheme: MoonTagTheme.light,
    tooltipTheme: MoonTooltipTheme.light,
    typography: MoonTypography.light,
  );

  static final dark = MoonTheme(
    accordionTheme: MoonAccordionTheme.dark,
    avatarTheme: MoonAvatarTheme.dark,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.dark,
    checkboxTheme: MoonCheckboxTheme.dark,
    chipTheme: MoonChipTheme.dark,
    circularLoaderTheme: MoonCircularLoaderTheme.dark,
    circularProgressTheme: MoonCircularProgressTheme.dark,
    colors: MoonColors.dark,
    effects: MoonEffects.dark,
    linearLoaderTheme: MoonLinearLoaderTheme.dark,
    linearProgressTheme: MoonLinearProgressTheme.dark,
    opacity: MoonOpacity.opacities,
    popoverTheme: MoonPopoverTheme.dark,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    switchTheme: MoonSwitchTheme.dark,
    tagTheme: MoonTagTheme.dark,
    tooltipTheme: MoonTooltipTheme.dark,
    typography: MoonTypography.dark,
  );

  /// Moon Design System MoonAccordion widget theming.
  final MoonAccordionTheme accordionTheme;

  /// Moon Design System MoonAvatar widget theming.
  final MoonAvatarTheme avatarTheme;

  /// Moon Design System borders.
  final MoonBorders borders;

  /// Moon Design System MoonButton widgets theming.
  final MoonButtonTheme buttonTheme;

  /// Moon Design System MoonCheckbox widget theming.
  final MoonCheckboxTheme checkboxTheme;

  /// Moon Design System MoonChip widgets theming.
  final MoonChipTheme chipTheme;

  /// Moon Design System MoonCircularLoader widget theming.
  final MoonCircularLoaderTheme circularLoaderTheme;

  /// Moon Design System MoonCircularProgress widget theming.
  final MoonCircularProgressTheme circularProgressTheme;

  /// Moon Design System colors.
  final MoonColors colors;

  /// Moon Design System effects.
  final MoonEffects effects;

  /// Moon Design System MoonLinearLoader widget theming.
  final MoonLinearLoaderTheme linearLoaderTheme;

  /// Moon Design System MoonLinearProgress widget theming.
  final MoonLinearProgressTheme linearProgressTheme;

  /// Moon Design System opacities.
  final MoonOpacity opacity;

  /// Moon Design System MoonPopover widget theming.
  final MoonPopoverTheme popoverTheme;

  /// Moon Design System shadows.
  final MoonShadows shadows;

  /// Moon Design System sizes.
  final MoonSizes sizes;

  /// Moon Design System MoonSwitch widget theming.
  final MoonSwitchTheme switchTheme;

  /// Moon Design System MoonTag widget theming.
  final MoonTagTheme tagTheme;

  /// Moon Design System MoonTooltip widget theming.
  final MoonTooltipTheme tooltipTheme;

  /// Moon Design System typography.
  final MoonTypography typography;

  const MoonTheme({
    required this.accordionTheme,
    required this.avatarTheme,
    required this.borders,
    required this.buttonTheme,
    required this.checkboxTheme,
    required this.chipTheme,
    required this.circularLoaderTheme,
    required this.circularProgressTheme,
    required this.colors,
    required this.effects,
    required this.linearLoaderTheme,
    required this.linearProgressTheme,
    required this.opacity,
    required this.popoverTheme,
    required this.shadows,
    required this.sizes,
    required this.switchTheme,
    required this.tagTheme,
    required this.tooltipTheme,
    required this.typography,
  });

  @override
  MoonTheme copyWith({
    MoonAccordionTheme? accordionTheme,
    MoonAvatarTheme? avatarTheme,
    MoonBorders? borders,
    MoonButtonTheme? buttonTheme,
    MoonCheckboxTheme? checkboxTheme,
    MoonChipTheme? chipTheme,
    MoonCircularLoaderTheme? circularLoaderTheme,
    MoonCircularProgressTheme? circularProgressTheme,
    MoonColors? colors,
    MoonEffects? effects,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonOpacity? opacity,
    MoonPopoverTheme? popoverTheme,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonSwitchTheme? switchTheme,
    MoonTagTheme? tagTheme,
    MoonTooltipTheme? tooltipTheme,
    MoonTypography? typography,
  }) {
    return MoonTheme(
      accordionTheme: accordionTheme ?? this.accordionTheme,
      avatarTheme: avatarTheme ?? this.avatarTheme,
      borders: borders ?? this.borders,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      circularLoaderTheme: circularLoaderTheme ?? this.circularLoaderTheme,
      circularProgressTheme: circularProgressTheme ?? this.circularProgressTheme,
      colors: colors ?? this.colors,
      effects: effects ?? this.effects,
      linearLoaderTheme: linearLoaderTheme ?? this.linearLoaderTheme,
      linearProgressTheme: linearProgressTheme ?? this.linearProgressTheme,
      opacity: opacity ?? this.opacity,
      popoverTheme: popoverTheme ?? this.popoverTheme,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      switchTheme: switchTheme ?? this.switchTheme,
      tagTheme: tagTheme ?? this.tagTheme,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
      typography: typography ?? this.typography,
    );
  }

  @override
  MoonTheme lerp(ThemeExtension<MoonTheme>? other, double t) {
    if (other is! MoonTheme) return this;

    return MoonTheme(
      accordionTheme: accordionTheme.lerp(other.accordionTheme, t),
      avatarTheme: avatarTheme.lerp(other.avatarTheme, t),
      borders: borders.lerp(other.borders, t),
      buttonTheme: buttonTheme.lerp(other.buttonTheme, t),
      checkboxTheme: checkboxTheme.lerp(other.checkboxTheme, t),
      chipTheme: chipTheme.lerp(other.chipTheme, t),
      circularLoaderTheme: circularLoaderTheme.lerp(other.circularLoaderTheme, t),
      circularProgressTheme: circularProgressTheme.lerp(other.circularProgressTheme, t),
      colors: colors.lerp(other.colors, t),
      effects: effects.lerp(other.effects, t),
      linearLoaderTheme: linearLoaderTheme.lerp(other.linearLoaderTheme, t),
      linearProgressTheme: linearProgressTheme.lerp(other.linearProgressTheme, t),
      opacity: opacity.lerp(other.opacity, t),
      popoverTheme: popoverTheme.lerp(other.popoverTheme, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
      switchTheme: switchTheme.lerp(other.switchTheme, t),
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
      ..add(DiagnosticsProperty<MoonAccordionTheme>("MoonAccordionTheme", accordionTheme))
      ..add(DiagnosticsProperty<MoonAvatarTheme>("MoonAvatarTheme", avatarTheme))
      ..add(DiagnosticsProperty<MoonBorders>("MoonBorders", borders))
      ..add(DiagnosticsProperty<MoonButtonTheme>("MoonButtonTheme", buttonTheme))
      ..add(DiagnosticsProperty<MoonCheckboxTheme>("MoonCheckboxTheme", checkboxTheme))
      ..add(DiagnosticsProperty<MoonChipTheme>("MoonChipTheme", chipTheme))
      ..add(DiagnosticsProperty<MoonCircularLoaderTheme>("MoonCircularLoaderTheme", circularLoaderTheme))
      ..add(DiagnosticsProperty<MoonCircularProgressTheme>("MoonCircularProgressTheme", circularProgressTheme))
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", colors))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonLinearLoaderTheme>("MoonLinearLoaderTheme", linearLoaderTheme))
      ..add(DiagnosticsProperty<MoonLinearProgressTheme>("MoonLinearProgressTheme", linearProgressTheme))
      ..add(DiagnosticsProperty<MoonOpacity>("MoonOpacity", opacity))
      ..add(DiagnosticsProperty<MoonPopoverTheme>("MoonPopoverTheme", popoverTheme))
      ..add(DiagnosticsProperty<MoonShadows>("MoonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("MoonSizes", sizes))
      ..add(DiagnosticsProperty<MoonSwitchTheme>("MoonSwitchTheme", switchTheme))
      ..add(DiagnosticsProperty<MoonTagTheme>("MoonTagTheme", tagTheme))
      ..add(DiagnosticsProperty<MoonTooltipTheme>("MoonTooltipTheme", tooltipTheme))
      ..add(DiagnosticsProperty<MoonTypography>("MoonTypography", typography));
  }
}

extension MoonThemeX on BuildContext {
  MoonTheme? get moonTheme => Theme.of(this).extension<MoonTheme>();
  MoonAccordionTheme? get moonAccordionTheme => moonTheme?.accordionTheme;
  MoonBorders? get moonBorders => moonTheme?.borders;
  MoonColors? get moonColors => moonTheme?.colors;
  MoonEffects? get moonEffects => moonTheme?.effects;
  MoonOpacity? get moonOpacity => moonTheme?.opacity;
  MoonShadows? get moonShadows => moonTheme?.shadows;
  MoonSizes? get moonSizes => moonTheme?.sizes;
  MoonTypography? get moonTypography => moonTheme?.typography;
}
