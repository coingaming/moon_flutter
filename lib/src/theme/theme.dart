import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_theme.dart';
import 'package:moon_design/src/theme/alert/alert_theme.dart';
import 'package:moon_design/src/theme/authcode/authcode_theme.dart';
import 'package:moon_design/src/theme/avatar/avatar_theme.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_theme.dart';
import 'package:moon_design/src/theme/button/button_theme.dart';
import 'package:moon_design/src/theme/carousel/carousel_theme.dart';
import 'package:moon_design/src/theme/checkbox/checkbox_theme.dart';
import 'package:moon_design/src/theme/chip/chip_theme.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/dot_indicator/dot_indicator_theme.dart';
import 'package:moon_design/src/theme/drawer/drawer_theme.dart';
import 'package:moon_design/src/theme/effects/effects.dart';
import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_theme.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_theme.dart';
import 'package:moon_design/src/theme/modal/modal_theme.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/popover/popover_theme.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_theme.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_theme.dart';
import 'package:moon_design/src/theme/radio/radio_theme.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_theme.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/switch/switch_theme.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_theme.dart';
import 'package:moon_design/src/theme/tag/tag_theme.dart';
import 'package:moon_design/src/theme/text_area/text_area_theme.dart';
import 'package:moon_design/src/theme/text_input/text_input_theme.dart';
import 'package:moon_design/src/theme/toast/toast_theme.dart';
import 'package:moon_design/src/theme/tokens.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
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
  final MoonBottomSheetTheme bottomSheetTheme;

  /// Moon Design System MoonButton widgets theming.
  final MoonButtonTheme buttonTheme;

  /// Moon Design System MoonCarousel widget theming.
  final MoonCarouselTheme carouselTheme;

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

  /// Moon Design System MoonDotIndicator widget theming.
  final MoonDotIndicatorTheme dotIndicatorTheme;

  /// Moon Design System MoonDrawer widget theming.
  final MoonDrawerTheme drawerTheme;

  /// Moon Design System effects.
  final MoonEffects effects;

  /// Moon Design System icons theming.
  final MoonIconTheme iconTheme;

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

  /// Moon Design System MoonSegmentedControl widget theming.
  final MoonSegmentedControlTheme segmentedControlTheme;

  /// Moon Design System shadows.
  final MoonShadows shadows;

  /// Moon Design System sizes.
  final MoonSizes sizes;

  /// Moon Design System MoonSwitch widget theming.
  final MoonSwitchTheme switchTheme;

  /// Moon Design System MoonTabBar widget theming.
  final MoonTabBarTheme tabBarTheme;

  /// Moon Design System MoonTag widget theming.
  final MoonTagTheme tagTheme;

  /// Moon Design System MoonTextArea widget theming.
  final MoonTextAreaTheme textAreaTheme;

  /// Moon Design System MoonTextInput widget theming.
  final MoonTextInputTheme textInputTheme;

  /// Moon Design System MoonToast widget theming.
  final MoonToastTheme toastTheme;

  /// Moon Design System MoonTooltip widget theming.
  final MoonTooltipTheme tooltipTheme;

  /// Moon Design System typography.
  final MoonTypography typography;

  final MoonTokens tokens;

  MoonTheme({
    required this.tokens,
    MoonAccordionTheme? accordionTheme,
    MoonAlertTheme? alertTheme,
    MoonAuthCodeTheme? authCodeTheme,
    MoonAvatarTheme? avatarTheme,
    MoonBorders? borders,
    MoonBottomSheetTheme? bottomSheetTheme,
    MoonButtonTheme? buttonTheme,
    MoonCarouselTheme? carouselTheme,
    MoonCheckboxTheme? checkboxTheme,
    MoonChipTheme? chipTheme,
    MoonCircularLoaderTheme? circularLoaderTheme,
    MoonCircularProgressTheme? circularProgressTheme,
    MoonColors? colors,
    MoonDotIndicatorTheme? dotIndicatorTheme,
    MoonDrawerTheme? drawerTheme,
    MoonEffects? effects,
    MoonIconTheme? iconTheme,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonModalTheme? modalTheme,
    MoonOpacity? opacity,
    MoonPopoverTheme? popoverTheme,
    MoonRadioTheme? radioTheme,
    MoonSegmentedControlTheme? segmentedControlTheme,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonSwitchTheme? switchTheme,
    MoonTabBarTheme? tabBarTheme,
    MoonTagTheme? tagTheme,
    MoonTextAreaTheme? textAreaTheme,
    MoonTextInputTheme? textInputTheme,
    MoonToastTheme? toastTheme,
    MoonTooltipTheme? tooltipTheme,
    MoonTypography? typography,
  })  : accordionTheme = accordionTheme ?? MoonAccordionTheme.light,
        alertTheme = alertTheme ?? MoonAlertTheme.light,
        authCodeTheme = authCodeTheme ?? MoonAuthCodeTheme.light,
        avatarTheme = avatarTheme ?? MoonAvatarTheme.light,
        borders = borders ?? MoonBorders.borders,
        bottomSheetTheme = bottomSheetTheme ?? MoonBottomSheetTheme.light,
        buttonTheme = buttonTheme ?? MoonButtonTheme.light,
        carouselTheme = carouselTheme ?? MoonCarouselTheme.light,
        checkboxTheme = checkboxTheme ?? MoonCheckboxTheme.light,
        chipTheme = chipTheme ?? MoonChipTheme.light,
        circularLoaderTheme = circularLoaderTheme ?? MoonCircularLoaderTheme.light,
        circularProgressTheme = circularProgressTheme ?? MoonCircularProgressTheme.light,
        colors = colors ?? MoonColors.light,
        dotIndicatorTheme = dotIndicatorTheme ?? MoonDotIndicatorTheme(tokens: tokens),
        drawerTheme = drawerTheme ?? MoonDrawerTheme.light,
        effects = effects ?? MoonEffects.light,
        iconTheme = iconTheme ?? MoonIconTheme.light,
        linearLoaderTheme = linearLoaderTheme ?? MoonLinearLoaderTheme.light,
        linearProgressTheme = linearProgressTheme ?? MoonLinearProgressTheme.light,
        modalTheme = modalTheme ?? MoonModalTheme.light,
        opacity = opacity ?? MoonOpacity.opacities,
        popoverTheme = popoverTheme ?? MoonPopoverTheme.light,
        radioTheme = radioTheme ?? MoonRadioTheme.light,
        segmentedControlTheme = segmentedControlTheme ?? MoonSegmentedControlTheme.light,
        shadows = shadows ?? MoonShadows.light,
        sizes = sizes ?? MoonSizes.sizes,
        switchTheme = switchTheme ?? MoonSwitchTheme.light,
        tabBarTheme = tabBarTheme ?? MoonTabBarTheme.light,
        tagTheme = tagTheme ?? MoonTagTheme.light,
        textAreaTheme = textAreaTheme ?? MoonTextAreaTheme.light,
        textInputTheme = textInputTheme ?? MoonTextInputTheme.light,
        toastTheme = toastTheme ?? MoonToastTheme.light,
        tooltipTheme = tooltipTheme ?? MoonTooltipTheme.light,
        typography = typography ?? MoonTypography.light;

  @override
  MoonTheme copyWith({
    MoonAccordionTheme? accordionTheme,
    MoonAlertTheme? alertTheme,
    MoonAuthCodeTheme? authCodeTheme,
    MoonAvatarTheme? avatarTheme,
    MoonBorders? borders,
    MoonBottomSheetTheme? bottomSheetTheme,
    MoonButtonTheme? buttonTheme,
    MoonCarouselTheme? carouselTheme,
    MoonCheckboxTheme? checkboxTheme,
    MoonChipTheme? chipTheme,
    MoonCircularLoaderTheme? circularLoaderTheme,
    MoonCircularProgressTheme? circularProgressTheme,
    MoonColors? colors,
    MoonDotIndicatorTheme? dotIndicatorTheme,
    MoonDrawerTheme? drawerTheme,
    MoonEffects? effects,
    MoonIconTheme? iconTheme,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonModalTheme? modalTheme,
    MoonOpacity? opacity,
    MoonPopoverTheme? popoverTheme,
    MoonRadioTheme? radioTheme,
    MoonSegmentedControlTheme? segmentedControlTheme,
    MoonShadows? shadows,
    MoonSizes? sizes,
    MoonSwitchTheme? switchTheme,
    MoonTabBarTheme? tabBarTheme,
    MoonTagTheme? tagTheme,
    MoonTextAreaTheme? textAreaTheme,
    MoonTextInputTheme? textInputTheme,
    MoonToastTheme? toastTheme,
    MoonTooltipTheme? tooltipTheme,
    MoonTypography? typography,
    MoonTokens? tokens,
  }) {
    return MoonTheme(
      accordionTheme: accordionTheme ?? this.accordionTheme,
      alertTheme: alertTheme ?? this.alertTheme,
      authCodeTheme: authCodeTheme ?? this.authCodeTheme,
      avatarTheme: avatarTheme ?? this.avatarTheme,
      borders: borders ?? this.borders,
      bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      carouselTheme: carouselTheme ?? this.carouselTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      circularLoaderTheme: circularLoaderTheme ?? this.circularLoaderTheme,
      circularProgressTheme: circularProgressTheme ?? this.circularProgressTheme,
      colors: colors ?? this.colors,
      dotIndicatorTheme: dotIndicatorTheme ?? this.dotIndicatorTheme,
      drawerTheme: drawerTheme ?? this.drawerTheme,
      effects: effects ?? this.effects,
      iconTheme: iconTheme ?? this.iconTheme,
      linearLoaderTheme: linearLoaderTheme ?? this.linearLoaderTheme,
      linearProgressTheme: linearProgressTheme ?? this.linearProgressTheme,
      modalTheme: modalTheme ?? this.modalTheme,
      opacity: opacity ?? this.opacity,
      popoverTheme: popoverTheme ?? this.popoverTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      segmentedControlTheme: segmentedControlTheme ?? this.segmentedControlTheme,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
      switchTheme: switchTheme ?? this.switchTheme,
      tabBarTheme: tabBarTheme ?? this.tabBarTheme,
      tagTheme: tagTheme ?? this.tagTheme,
      textAreaTheme: textAreaTheme ?? this.textAreaTheme,
      textInputTheme: textInputTheme ?? this.textInputTheme,
      toastTheme: toastTheme ?? this.toastTheme,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
      typography: typography ?? this.typography,
      tokens: tokens ?? this.tokens,
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
      bottomSheetTheme: bottomSheetTheme.lerp(other.bottomSheetTheme, t),
      buttonTheme: buttonTheme.lerp(other.buttonTheme, t),
      carouselTheme: carouselTheme.lerp(other.carouselTheme, t),
      checkboxTheme: checkboxTheme.lerp(other.checkboxTheme, t),
      chipTheme: chipTheme.lerp(other.chipTheme, t),
      circularLoaderTheme: circularLoaderTheme.lerp(other.circularLoaderTheme, t),
      circularProgressTheme: circularProgressTheme.lerp(other.circularProgressTheme, t),
      colors: colors.lerp(other.colors, t),
      dotIndicatorTheme: dotIndicatorTheme.lerp(other.dotIndicatorTheme, t),
      drawerTheme: drawerTheme.lerp(other.drawerTheme, t),
      effects: effects.lerp(other.effects, t),
      iconTheme: iconTheme.lerp(other.iconTheme, t),
      linearLoaderTheme: linearLoaderTheme.lerp(other.linearLoaderTheme, t),
      linearProgressTheme: linearProgressTheme.lerp(other.linearProgressTheme, t),
      modalTheme: modalTheme.lerp(other.modalTheme, t),
      opacity: opacity.lerp(other.opacity, t),
      popoverTheme: popoverTheme.lerp(other.popoverTheme, t),
      radioTheme: radioTheme.lerp(other.radioTheme, t),
      segmentedControlTheme: segmentedControlTheme.lerp(other.segmentedControlTheme, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
      switchTheme: switchTheme.lerp(other.switchTheme, t),
      tabBarTheme: tabBarTheme.lerp(other.tabBarTheme, t),
      tagTheme: tagTheme.lerp(other.tagTheme, t),
      textAreaTheme: textAreaTheme.lerp(other.textAreaTheme, t),
      textInputTheme: textInputTheme.lerp(other.textInputTheme, t),
      toastTheme: toastTheme.lerp(other.toastTheme, t),
      tooltipTheme: tooltipTheme.lerp(other.tooltipTheme, t),
      typography: typography.lerp(other.typography, t),
      tokens: tokens.lerp(other.tokens, t),
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
      ..add(DiagnosticsProperty<MoonCarouselTheme>("MoonCarouselTheme", carouselTheme))
      ..add(DiagnosticsProperty<MoonCheckboxTheme>("MoonCheckboxTheme", checkboxTheme))
      ..add(DiagnosticsProperty<MoonChipTheme>("MoonChipTheme", chipTheme))
      ..add(DiagnosticsProperty<MoonCircularLoaderTheme>("MoonCircularLoaderTheme", circularLoaderTheme))
      ..add(DiagnosticsProperty<MoonCircularProgressTheme>("MoonCircularProgressTheme", circularProgressTheme))
      ..add(DiagnosticsProperty<MoonColors>("MoonColors", colors))
      ..add(DiagnosticsProperty<MoonDotIndicatorTheme>("MoonDotIndicatorTheme", dotIndicatorTheme))
      ..add(DiagnosticsProperty<MoonDrawerTheme>("MoonDrawerTheme", drawerTheme))
      ..add(DiagnosticsProperty<MoonEffects>("MoonEffects", effects))
      ..add(DiagnosticsProperty<MoonIconTheme>("MoonIconTheme", iconTheme))
      ..add(DiagnosticsProperty<MoonLinearLoaderTheme>("MoonLinearLoaderTheme", linearLoaderTheme))
      ..add(DiagnosticsProperty<MoonLinearProgressTheme>("MoonLinearProgressTheme", linearProgressTheme))
      ..add(DiagnosticsProperty<MoonModalTheme>("MoonModalTheme", modalTheme))
      ..add(DiagnosticsProperty<MoonOpacity>("MoonOpacity", opacity))
      ..add(DiagnosticsProperty<MoonPopoverTheme>("MoonPopoverTheme", popoverTheme))
      ..add(DiagnosticsProperty<MoonRadioTheme>("MoonRadioTheme", radioTheme))
      ..add(DiagnosticsProperty<MoonSegmentedControlTheme>("MoonSegmentedControlTheme", segmentedControlTheme))
      ..add(DiagnosticsProperty<MoonShadows>("MoonShadows", shadows))
      ..add(DiagnosticsProperty<MoonSizes>("MoonSizes", sizes))
      ..add(DiagnosticsProperty<MoonSwitchTheme>("MoonSwitchTheme", switchTheme))
      ..add(DiagnosticsProperty<MoonTabBarTheme>("MoonTabBarTheme", tabBarTheme))
      ..add(DiagnosticsProperty<MoonTagTheme>("MoonTagTheme", tagTheme))
      ..add(DiagnosticsProperty<MoonTextAreaTheme>("MoonTextAreaTheme", textAreaTheme))
      ..add(DiagnosticsProperty<MoonTextInputTheme>("MoonTextInputTheme", textInputTheme))
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

  MoonIconTheme? get moonIconTheme => moonTheme?.iconTheme;

  MoonOpacity? get moonOpacity => moonTheme?.opacity;

  MoonShadows? get moonShadows => moonTheme?.shadows;

  MoonSizes? get moonSizes => moonTheme?.sizes;

  MoonTypography? get moonTypography => moonTheme?.typography;
}
