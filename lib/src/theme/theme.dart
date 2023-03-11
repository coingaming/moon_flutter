import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_theme.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button/button_theme.dart';
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
    avatar: MoonAvatarTheme.light,
    borders: MoonBorders.borders,
    button: MoonButtonTheme.light,
    chip: MoonChipTheme.light,
    circularLoader: MoonCircularLoaderTheme.light,
    circularProgress: MoonCircularProgressTheme.light,
    colors: MoonColors.light,
    effects: MoonEffects.light,
    linearLoader: MoonLinearLoaderTheme.light,
    linearProgress: MoonLinearProgressTheme.light,
    opacity: MoonOpacity.opacities,
    popover: MoonPopoverTheme.light,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    switchTheme: MoonSwitchTheme.light,
    tag: MoonTagTheme.light,
    tooltip: MoonTooltipTheme.light,
    typography: MoonTypography.light,
  );

  static final dark = MoonTheme(
    avatar: MoonAvatarTheme.dark,
    borders: MoonBorders.borders,
    button: MoonButtonTheme.dark,
    chip: MoonChipTheme.dark,
    circularLoader: MoonCircularLoaderTheme.dark,
    circularProgress: MoonCircularProgressTheme.dark,
    colors: MoonColors.dark,
    effects: MoonEffects.dark,
    linearLoader: MoonLinearLoaderTheme.dark,
    linearProgress: MoonLinearProgressTheme.dark,
    opacity: MoonOpacity.opacities,
    popover: MoonPopoverTheme.dark,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    switchTheme: MoonSwitchTheme.dark,
    tag: MoonTagTheme.dark,
    tooltip: MoonTooltipTheme.dark,
    typography: MoonTypography.dark,
  );

  /// Moon Design System MoonAvatar widget theming.
  final MoonAvatarTheme avatar;

  /// Moon Design System borders.
  final MoonBorders borders;

  /// Moon Design System MoonButton widgets theming.
  final MoonButtonTheme button;

  /// Moon Design System MoonChip widgets theming.
  final MoonChipTheme chip;

  /// Moon Design System MoonCircularLoader widget theming.
  final MoonCircularLoaderTheme circularLoader;

  /// Moon Design System MoonCircularProgress widget theming.
  final MoonCircularProgressTheme circularProgress;

  /// Moon Design System colors.
  final MoonColors colors;

  /// Moon Design System effects.
  final MoonEffects effects;

  /// Moon Design System MoonLinearLoader widget theming.
  final MoonLinearLoaderTheme linearLoader;

  /// Moon Design System MoonLinearProgress widget theming.
  final MoonLinearProgressTheme linearProgress;

  /// Moon Design System opacities.
  final MoonOpacity opacity;

  /// Moon Design System MoonPopover widget theming.
  final MoonPopoverTheme popover;

  /// Moon Design System shadows.
  final MoonShadows shadows;

  /// Moon Design System sizes.
  final MoonSizes sizes;

  /// Moon Design System MoonSwitch widget theming.
  final MoonSwitchTheme switchTheme;

  /// Moon Design System MoonTag widget theming.
  final MoonTagTheme tag;

  /// Moon Design System MoonTooltip widget theming.
  final MoonTooltipTheme tooltip;

  /// Moon Design System typography.
  final MoonTypography typography;

  const MoonTheme({
    required this.avatar,
    required this.borders,
    required this.button,
    required this.chip,
    required this.circularLoader,
    required this.circularProgress,
    required this.colors,
    required this.effects,
    required this.linearLoader,
    required this.linearProgress,
    required this.opacity,
    required this.popover,
    required this.shadows,
    required this.sizes,
    required this.switchTheme,
    required this.tag,
    required this.tooltip,
    required this.typography,
  });

  @override
  MoonTheme copyWith({
    MoonAvatarTheme? avatar,
    MoonBorders? borders,
    MoonButtonTheme? button,
    MoonChipTheme? chip,
    MoonCircularLoaderTheme? circularLoader,
    MoonCircularProgressTheme? circularProgress,
    MoonColors? colors,
    MoonEffects? effects,
    MoonLinearLoaderTheme? linearLoader,
    MoonLinearProgressTheme? linearProgress,
    MoonOpacity? opacity,
    MoonPopoverTheme? popover,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonSwitchTheme? switchTheme,
    MoonTagTheme? tag,
    MoonTooltipTheme? tooltip,
    MoonTypography? typography,
  }) {
    return MoonTheme(
      avatar: avatar ?? this.avatar,
      borders: borders ?? this.borders,
      button: button ?? this.button,
      chip: chip ?? this.chip,
      circularLoader: circularLoader ?? this.circularLoader,
      circularProgress: circularProgress ?? this.circularProgress,
      colors: colors ?? this.colors,
      effects: effects ?? this.effects,
      linearLoader: linearLoader ?? this.linearLoader,
      linearProgress: linearProgress ?? this.linearProgress,
      opacity: opacity ?? this.opacity,
      popover: popover ?? this.popover,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      switchTheme: switchTheme ?? this.switchTheme,
      tag: tag ?? this.tag,
      tooltip: tooltip ?? this.tooltip,
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
      circularLoader: circularLoader.lerp(other.circularLoader, t),
      circularProgress: circularProgress.lerp(other.circularProgress, t),
      colors: colors.lerp(other.colors, t),
      effects: effects.lerp(other.effects, t),
      linearLoader: linearLoader.lerp(other.linearLoader, t),
      linearProgress: linearProgress.lerp(other.linearProgress, t),
      opacity: opacity.lerp(other.opacity, t),
      popover: popover.lerp(other.popover, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
      switchTheme: switchTheme.lerp(other.switchTheme, t),
      tag: tag.lerp(other.tag, t),
      tooltip: tooltip.lerp(other.tooltip, t),
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
      ..add(DiagnosticsProperty<MoonCircularLoaderTheme>("MoonCircularLoaderTheme", circularLoader))
      ..add(DiagnosticsProperty<MoonCircularProgressTheme>("MoonCircularProgressTheme", circularProgress))
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", colors))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonLinearLoaderTheme>("MoonLinearLoaderTheme", linearLoader))
      ..add(DiagnosticsProperty<MoonLinearProgressTheme>("MoonLinearProgressTheme", linearProgress))
      ..add(DiagnosticsProperty<MoonOpacity>("MoonOpacity", opacity))
      ..add(DiagnosticsProperty<MoonPopoverTheme>("MoonPopoverTheme", popover))
      ..add(DiagnosticsProperty<MoonShadows>("MoonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("MoonSizes", sizes))
      ..add(DiagnosticsProperty<MoonSwitchTheme>("MoonSwitchTheme", switchTheme))
      ..add(DiagnosticsProperty<MoonTagTheme>("MoonTagTheme", tag))
      ..add(DiagnosticsProperty<MoonTooltipTheme>("MoonTooltipTheme", tooltip))
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
