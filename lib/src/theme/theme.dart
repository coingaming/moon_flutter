import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_theme.dart';
import 'package:moon_design/src/theme/alert/alert_theme.dart';
import 'package:moon_design/src/theme/authcode/authcode_theme.dart';
import 'package:moon_design/src/theme/avatar/avatar_theme.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button/button_theme.dart';
import 'package:moon_design/src/theme/checkbox/checkbox_theme.dart';
import 'package:moon_design/src/theme/chip/chip_theme.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/effects.dart';
import 'package:moon_design/src/theme/input/input_theme.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_theme.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_theme.dart';
import 'package:moon_design/src/theme/modal/modal_theme.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/popover/popover_theme.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_theme.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_theme.dart';
import 'package:moon_design/src/theme/radio/radio_theme.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/switch/switch_theme.dart';
import 'package:moon_design/src/theme/tag/tag_theme.dart';
import 'package:moon_design/src/theme/textarea/textarea_theme.dart';
import 'package:moon_design/src/theme/toast/toast_theme.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
  static final light = MoonTheme(
    accordionTheme: MoonAccordionTheme.light,
    alertTheme: MoonAlertTheme.light,
    authCodeTheme: MoonAuthCodeTheme.light,
    avatarTheme: MoonAvatarTheme.light,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.light,
    checkboxTheme: MoonCheckboxTheme.light,
    chipTheme: MoonChipTheme.light,
    circularLoaderTheme: MoonCircularLoaderTheme.light,
    circularProgressTheme: MoonCircularProgressTheme.light,
    colors: MoonColors.light,
    effects: MoonEffects.light,
    inputTheme: MoonInputTheme.light,
    linearLoaderTheme: MoonLinearLoaderTheme.light,
    linearProgressTheme: MoonLinearProgressTheme.light,
    modalTheme: MoonModalTheme.light,
    opacity: MoonOpacity.opacities,
    popoverTheme: MoonPopoverTheme.light,
    radioTheme: MoonRadioTheme.light,
    shadows: MoonShadows.light,
    sizes: MoonSizes.sizes,
    switchTheme: MoonSwitchTheme.light,
    tagTheme: MoonTagTheme.light,
    textAreaTheme: MoonTextAreaTheme.light,
    toastTheme: MoonToastTheme.light,
    tooltipTheme: MoonTooltipTheme.light,
    typography: MoonTypography.light,
  );

  static final dark = MoonTheme(
    accordionTheme: MoonAccordionTheme.dark,
    alertTheme: MoonAlertTheme.dark,
    authCodeTheme: MoonAuthCodeTheme.dark,
    avatarTheme: MoonAvatarTheme.dark,
    borders: MoonBorders.borders,
    buttonTheme: MoonButtonTheme.dark,
    checkboxTheme: MoonCheckboxTheme.dark,
    chipTheme: MoonChipTheme.dark,
    circularLoaderTheme: MoonCircularLoaderTheme.dark,
    circularProgressTheme: MoonCircularProgressTheme.dark,
    colors: MoonColors.dark,
    effects: MoonEffects.dark,
    inputTheme: MoonInputTheme.dark,
    linearLoaderTheme: MoonLinearLoaderTheme.dark,
    linearProgressTheme: MoonLinearProgressTheme.dark,
    modalTheme: MoonModalTheme.dark,
    opacity: MoonOpacity.opacities,
    popoverTheme: MoonPopoverTheme.dark,
    radioTheme: MoonRadioTheme.dark,
    shadows: MoonShadows.dark,
    sizes: MoonSizes.sizes,
    switchTheme: MoonSwitchTheme.dark,
    tagTheme: MoonTagTheme.dark,
    textAreaTheme: MoonTextAreaTheme.dark,
    toastTheme: MoonToastTheme.dark,
    tooltipTheme: MoonTooltipTheme.dark,
    typography: MoonTypography.dark,
  );

  /// Moon Design System MoonAccordion widget theming.
  final MoonAccordionTheme accordionTheme;

  /// Moon Design System MoonAlert widget theming.
  final MoonAlertTheme alertTheme;

  /// Moon Design System MoonAuthCode widget theming.
  final MoonAuthCodeTheme authCodeTheme;

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

  /// Moon Design System MoonInput widget theming.
  final MoonInputTheme inputTheme;

  /// Moon Design System MoonLinearLoader widget theming.
  final MoonLinearLoaderTheme linearLoaderTheme;

  /// Moon Design System MoonLinearProgress widget theming.
  final MoonLinearProgressTheme linearProgressTheme;

  /// Moon Design System MoonModal widget theming.
  final MoonModalTheme modalTheme;

  /// Moon Design System opacities.
  final MoonOpacity opacity;

  /// Moon Design System MoonPopover widget theming.
  final MoonPopoverTheme popoverTheme;

  /// Moon Design System MoonRadio widget theming.
  final MoonRadioTheme radioTheme;

  /// Moon Design System shadows.
  final MoonShadows shadows;

  /// Moon Design System sizes.
  final MoonSizes sizes;

  /// Moon Design System MoonSwitch widget theming.
  final MoonSwitchTheme switchTheme;

  /// Moon Design System MoonTag widget theming.
  final MoonTagTheme tagTheme;

  /// Moon Design System MoonTextArea widget theming.
  final MoonTextAreaTheme textAreaTheme;

  /// Moon Design System MoonToast widget theming.
  final MoonToastTheme toastTheme;

  /// Moon Design System MoonTooltip widget theming.
  final MoonTooltipTheme tooltipTheme;

  /// Moon Design System typography.
  final MoonTypography typography;

  const MoonTheme({
    required this.accordionTheme,
    required this.alertTheme,
    required this.authCodeTheme,
    required this.avatarTheme,
    required this.borders,
    required this.buttonTheme,
    required this.checkboxTheme,
    required this.chipTheme,
    required this.circularLoaderTheme,
    required this.circularProgressTheme,
    required this.colors,
    required this.effects,
    required this.inputTheme,
    required this.linearLoaderTheme,
    required this.linearProgressTheme,
    required this.modalTheme,
    required this.opacity,
    required this.popoverTheme,
    required this.radioTheme,
    required this.shadows,
    required this.sizes,
    required this.switchTheme,
    required this.tagTheme,
    required this.textAreaTheme,
    required this.toastTheme,
    required this.tooltipTheme,
    required this.typography,
  });

  @override
  MoonTheme copyWith({
    MoonAccordionTheme? accordionTheme,
    MoonAlertTheme? alertTheme,
    MoonAuthCodeTheme? authCodeTheme,
    MoonAvatarTheme? avatarTheme,
    MoonBorders? borders,
    MoonButtonTheme? buttonTheme,
    MoonCheckboxTheme? checkboxTheme,
    MoonChipTheme? chipTheme,
    MoonCircularLoaderTheme? circularLoaderTheme,
    MoonCircularProgressTheme? circularProgressTheme,
    MoonColors? colors,
    MoonEffects? effects,
    MoonInputTheme? inputTheme,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonModalTheme? modalTheme,
    MoonOpacity? opacity,
    MoonPopoverTheme? popoverTheme,
    MoonRadioTheme? radioTheme,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonSwitchTheme? switchTheme,
    MoonTagTheme? tagTheme,
    MoonTextAreaTheme? textAreaTheme,
    MoonToastTheme? toastTheme,
    MoonTooltipTheme? tooltipTheme,
    MoonTypography? typography,
  }) {
    return MoonTheme(
      accordionTheme: accordionTheme ?? this.accordionTheme,
      alertTheme: alertTheme ?? this.alertTheme,
      authCodeTheme: authCodeTheme ?? this.authCodeTheme,
      avatarTheme: avatarTheme ?? this.avatarTheme,
      borders: borders ?? this.borders,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      circularLoaderTheme: circularLoaderTheme ?? this.circularLoaderTheme,
      circularProgressTheme: circularProgressTheme ?? this.circularProgressTheme,
      colors: colors ?? this.colors,
      effects: effects ?? this.effects,
      inputTheme: inputTheme ?? this.inputTheme,
      linearLoaderTheme: linearLoaderTheme ?? this.linearLoaderTheme,
      linearProgressTheme: linearProgressTheme ?? this.linearProgressTheme,
      modalTheme: modalTheme ?? this.modalTheme,
      opacity: opacity ?? this.opacity,
      popoverTheme: popoverTheme ?? this.popoverTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      switchTheme: switchTheme ?? this.switchTheme,
      tagTheme: tagTheme ?? this.tagTheme,
      textAreaTheme: textAreaTheme ?? this.textAreaTheme,
      toastTheme: toastTheme ?? this.toastTheme,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
      typography: typography ?? this.typography,
    );
  }

  @override
  MoonTheme lerp(ThemeExtension<MoonTheme>? other, double t) {
    if (other is! MoonTheme) return this;

    return MoonTheme(
      accordionTheme: accordionTheme.lerp(other.accordionTheme, t),
      alertTheme: alertTheme.lerp(other.alertTheme, t),
      authCodeTheme: authCodeTheme.lerp(other.authCodeTheme, t),
      avatarTheme: avatarTheme.lerp(other.avatarTheme, t),
      borders: borders.lerp(other.borders, t),
      buttonTheme: buttonTheme.lerp(other.buttonTheme, t),
      checkboxTheme: checkboxTheme.lerp(other.checkboxTheme, t),
      chipTheme: chipTheme.lerp(other.chipTheme, t),
      circularLoaderTheme: circularLoaderTheme.lerp(other.circularLoaderTheme, t),
      circularProgressTheme: circularProgressTheme.lerp(other.circularProgressTheme, t),
      colors: colors.lerp(other.colors, t),
      effects: effects.lerp(other.effects, t),
      inputTheme: inputTheme.lerp(other.inputTheme, t),
      linearLoaderTheme: linearLoaderTheme.lerp(other.linearLoaderTheme, t),
      linearProgressTheme: linearProgressTheme.lerp(other.linearProgressTheme, t),
      modalTheme: modalTheme.lerp(other.modalTheme, t),
      opacity: opacity.lerp(other.opacity, t),
      popoverTheme: popoverTheme.lerp(other.popoverTheme, t),
      radioTheme: radioTheme.lerp(other.radioTheme, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
      switchTheme: switchTheme.lerp(other.switchTheme, t),
      tagTheme: tagTheme.lerp(other.tagTheme, t),
      textAreaTheme: textAreaTheme.lerp(other.textAreaTheme, t),
      toastTheme: toastTheme.lerp(other.toastTheme, t),
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
      ..add(DiagnosticsProperty<MoonAlertTheme>("MoonAlertTheme", alertTheme))
      ..add(DiagnosticsProperty<MoonAuthCodeTheme>("MoonAuthCodeTheme", authCodeTheme))
      ..add(DiagnosticsProperty<MoonAvatarTheme>("MoonAvatarTheme", avatarTheme))
      ..add(DiagnosticsProperty<MoonBorders>("MoonBorders", borders))
      ..add(DiagnosticsProperty<MoonButtonTheme>("MoonButtonTheme", buttonTheme))
      ..add(DiagnosticsProperty<MoonCheckboxTheme>("MoonCheckboxTheme", checkboxTheme))
      ..add(DiagnosticsProperty<MoonChipTheme>("MoonChipTheme", chipTheme))
      ..add(DiagnosticsProperty<MoonCircularLoaderTheme>("MoonCircularLoaderTheme", circularLoaderTheme))
      ..add(DiagnosticsProperty<MoonCircularProgressTheme>("MoonCircularProgressTheme", circularProgressTheme))
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", colors))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonInputTheme>("MoonInputTheme", inputTheme))
      ..add(DiagnosticsProperty<MoonLinearLoaderTheme>("MoonLinearLoaderTheme", linearLoaderTheme))
      ..add(DiagnosticsProperty<MoonLinearProgressTheme>("MoonLinearProgressTheme", linearProgressTheme))
      ..add(DiagnosticsProperty<MoonModalTheme>("MoonModalTheme", modalTheme))
      ..add(DiagnosticsProperty<MoonOpacity>("MoonOpacity", opacity))
      ..add(DiagnosticsProperty<MoonPopoverTheme>("MoonPopoverTheme", popoverTheme))
      ..add(DiagnosticsProperty<MoonRadioTheme>("MoonRadioTheme", radioTheme))
      ..add(DiagnosticsProperty<MoonShadows>("MoonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("MoonSizes", sizes))
      ..add(DiagnosticsProperty<MoonSwitchTheme>("MoonSwitchTheme", switchTheme))
      ..add(DiagnosticsProperty<MoonTagTheme>("MoonTagTheme", tagTheme))
      ..add(DiagnosticsProperty<MoonTextAreaTheme>("MoonTextAreaTheme", textAreaTheme))
      ..add(DiagnosticsProperty<MoonToastTheme>("MoonToastTheme", toastTheme))
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
