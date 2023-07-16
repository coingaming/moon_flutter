import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_theme.dart';
import 'package:moon_design/src/theme/alert/alert_theme.dart';
import 'package:moon_design/src/theme/authcode/authcode_theme.dart';
import 'package:moon_design/src/theme/avatar/avatar_theme.dart';
import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_theme.dart';
import 'package:moon_design/src/theme/button/button_theme.dart';
import 'package:moon_design/src/theme/carousel/carousel_theme.dart';
import 'package:moon_design/src/theme/checkbox/checkbox_theme.dart';
import 'package:moon_design/src/theme/chip/chip_theme.dart';
import 'package:moon_design/src/theme/dot_indicator/dot_indicator_theme.dart';
import 'package:moon_design/src/theme/drawer/drawer_theme.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_theme.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_theme.dart';
import 'package:moon_design/src/theme/modal/modal_theme.dart';
import 'package:moon_design/src/theme/popover/popover_theme.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_theme.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_theme.dart';
import 'package:moon_design/src/theme/radio/radio_theme.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_theme.dart';
import 'package:moon_design/src/theme/switch/switch_theme.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_theme.dart';
import 'package:moon_design/src/theme/tag/tag_theme.dart';
import 'package:moon_design/src/theme/text_area/text_area_theme.dart';
import 'package:moon_design/src/theme/text_input/text_input_theme.dart';
import 'package:moon_design/src/theme/toast/toast_theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/effects/effects.dart';
import 'package:moon_design/src/theme/tokens/iconography/iconography.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_theme.dart';

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

  /// Moon Design System MoonDotIndicator widget theming.
  final MoonDotIndicatorTheme dotIndicatorTheme;

  /// Moon Design System MoonDrawer widget theming.
  final MoonDrawerTheme drawerTheme;

  /// Moon Design System MoonLinearLoader widget theming.
  final MoonLinearLoaderTheme linearLoaderTheme;

  /// Moon Design System MoonLinearProgress widget theming.
  final MoonLinearProgressTheme linearProgressTheme;

  /// Moon Design System MoonModal widget theming.
  final MoonModalTheme modalTheme;

  /// Moon Design System MoonPopover widget theming.
  final MoonPopoverTheme popoverTheme;

  /// Moon Design System MoonRadio widget theming.
  final MoonRadioTheme radioTheme;

  /// Moon Design System MoonSegmentedControl widget theming.
  final MoonSegmentedControlTheme segmentedControlTheme;

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

  final MoonTokens tokens;

  MoonTheme({
    required this.tokens,
    MoonAccordionTheme? accordionTheme,
    MoonAlertTheme? alertTheme,
    MoonAuthCodeTheme? authCodeTheme,
    MoonAvatarTheme? avatarTheme,
    MoonBottomSheetTheme? bottomSheetTheme,
    MoonButtonTheme? buttonTheme,
    MoonCarouselTheme? carouselTheme,
    MoonCheckboxTheme? checkboxTheme,
    MoonChipTheme? chipTheme,
    MoonCircularLoaderTheme? circularLoaderTheme,
    MoonCircularProgressTheme? circularProgressTheme,
    MoonDotIndicatorTheme? dotIndicatorTheme,
    MoonDrawerTheme? drawerTheme,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonModalTheme? modalTheme,
    MoonPopoverTheme? popoverTheme,
    MoonRadioTheme? radioTheme,
    MoonSegmentedControlTheme? segmentedControlTheme,
    MoonSwitchTheme? switchTheme,
    MoonTabBarTheme? tabBarTheme,
    MoonTagTheme? tagTheme,
    MoonTextAreaTheme? textAreaTheme,
    MoonTextInputTheme? textInputTheme,
    MoonToastTheme? toastTheme,
    MoonTooltipTheme? tooltipTheme,
  })  : accordionTheme = accordionTheme ?? MoonAccordionTheme(tokens: tokens),
        alertTheme = alertTheme ?? MoonAlertTheme(tokens: tokens),
        authCodeTheme = authCodeTheme ?? MoonAuthCodeTheme(tokens: tokens),
        avatarTheme = avatarTheme ?? MoonAvatarTheme(tokens: tokens),
        bottomSheetTheme = bottomSheetTheme ?? MoonBottomSheetTheme(tokens: tokens),
        buttonTheme = buttonTheme ?? MoonButtonTheme(tokens: tokens),
        carouselTheme = carouselTheme ?? MoonCarouselTheme(tokens: tokens),
        checkboxTheme = checkboxTheme ?? MoonCheckboxTheme(tokens: tokens),
        chipTheme = chipTheme ?? MoonChipTheme(tokens: tokens),
        circularLoaderTheme = circularLoaderTheme ?? MoonCircularLoaderTheme(tokens: tokens),
        circularProgressTheme = circularProgressTheme ?? MoonCircularProgressTheme(tokens: tokens),
        dotIndicatorTheme = dotIndicatorTheme ?? MoonDotIndicatorTheme(tokens: tokens),
        drawerTheme = drawerTheme ?? MoonDrawerTheme(tokens: tokens),
        linearLoaderTheme = linearLoaderTheme ?? MoonLinearLoaderTheme(tokens: tokens),
        linearProgressTheme = linearProgressTheme ?? MoonLinearProgressTheme(tokens: tokens),
        modalTheme = modalTheme ?? MoonModalTheme(tokens: tokens),
        popoverTheme = popoverTheme ?? MoonPopoverTheme(tokens: tokens),
        radioTheme = radioTheme ?? MoonRadioTheme(tokens: tokens),
        segmentedControlTheme = segmentedControlTheme ?? MoonSegmentedControlTheme(tokens: tokens),
        switchTheme = switchTheme ?? MoonSwitchTheme(tokens: tokens),
        tabBarTheme = tabBarTheme ?? MoonTabBarTheme(tokens: tokens),
        tagTheme = tagTheme ?? MoonTagTheme(tokens: tokens),
        textAreaTheme = textAreaTheme ?? MoonTextAreaTheme(tokens: tokens),
        textInputTheme = textInputTheme ?? MoonTextInputTheme(tokens: tokens),
        toastTheme = toastTheme ?? MoonToastTheme(tokens: tokens),
        tooltipTheme = tooltipTheme ?? MoonTooltipTheme(tokens: tokens);

  @override
  MoonTheme copyWith({
    MoonAccordionTheme? accordionTheme,
    MoonAlertTheme? alertTheme,
    MoonAuthCodeTheme? authCodeTheme,
    MoonAvatarTheme? avatarTheme,
    MoonBottomSheetTheme? bottomSheetTheme,
    MoonButtonTheme? buttonTheme,
    MoonCarouselTheme? carouselTheme,
    MoonCheckboxTheme? checkboxTheme,
    MoonChipTheme? chipTheme,
    MoonCircularLoaderTheme? circularLoaderTheme,
    MoonCircularProgressTheme? circularProgressTheme,
    MoonDotIndicatorTheme? dotIndicatorTheme,
    MoonDrawerTheme? drawerTheme,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonModalTheme? modalTheme,
    MoonPopoverTheme? popoverTheme,
    MoonRadioTheme? radioTheme,
    MoonSegmentedControlTheme? segmentedControlTheme,
    MoonSwitchTheme? switchTheme,
    MoonTabBarTheme? tabBarTheme,
    MoonTagTheme? tagTheme,
    MoonTextAreaTheme? textAreaTheme,
    MoonTextInputTheme? textInputTheme,
    MoonToastTheme? toastTheme,
    MoonTokens? tokens,
    MoonTooltipTheme? tooltipTheme,
  }) {
    return MoonTheme(
      accordionTheme: accordionTheme ?? this.accordionTheme,
      alertTheme: alertTheme ?? this.alertTheme,
      authCodeTheme: authCodeTheme ?? this.authCodeTheme,
      avatarTheme: avatarTheme ?? this.avatarTheme,
      bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      carouselTheme: carouselTheme ?? this.carouselTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      circularLoaderTheme: circularLoaderTheme ?? this.circularLoaderTheme,
      circularProgressTheme: circularProgressTheme ?? this.circularProgressTheme,
      dotIndicatorTheme: dotIndicatorTheme ?? this.dotIndicatorTheme,
      drawerTheme: drawerTheme ?? this.drawerTheme,
      linearLoaderTheme: linearLoaderTheme ?? this.linearLoaderTheme,
      linearProgressTheme: linearProgressTheme ?? this.linearProgressTheme,
      modalTheme: modalTheme ?? this.modalTheme,
      popoverTheme: popoverTheme ?? this.popoverTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      segmentedControlTheme: segmentedControlTheme ?? this.segmentedControlTheme,
      switchTheme: switchTheme ?? this.switchTheme,
      tabBarTheme: tabBarTheme ?? this.tabBarTheme,
      tagTheme: tagTheme ?? this.tagTheme,
      textAreaTheme: textAreaTheme ?? this.textAreaTheme,
      textInputTheme: textInputTheme ?? this.textInputTheme,
      toastTheme: toastTheme ?? this.toastTheme,
      tokens: tokens ?? this.tokens,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
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
      bottomSheetTheme: bottomSheetTheme.lerp(other.bottomSheetTheme, t),
      buttonTheme: buttonTheme.lerp(other.buttonTheme, t),
      carouselTheme: carouselTheme.lerp(other.carouselTheme, t),
      checkboxTheme: checkboxTheme.lerp(other.checkboxTheme, t),
      chipTheme: chipTheme.lerp(other.chipTheme, t),
      circularLoaderTheme: circularLoaderTheme.lerp(other.circularLoaderTheme, t),
      circularProgressTheme: circularProgressTheme.lerp(other.circularProgressTheme, t),
      dotIndicatorTheme: dotIndicatorTheme.lerp(other.dotIndicatorTheme, t),
      drawerTheme: drawerTheme.lerp(other.drawerTheme, t),
      linearLoaderTheme: linearLoaderTheme.lerp(other.linearLoaderTheme, t),
      linearProgressTheme: linearProgressTheme.lerp(other.linearProgressTheme, t),
      modalTheme: modalTheme.lerp(other.modalTheme, t),
      popoverTheme: popoverTheme.lerp(other.popoverTheme, t),
      radioTheme: radioTheme.lerp(other.radioTheme, t),
      segmentedControlTheme: segmentedControlTheme.lerp(other.segmentedControlTheme, t),
      switchTheme: switchTheme.lerp(other.switchTheme, t),
      tabBarTheme: tabBarTheme.lerp(other.tabBarTheme, t),
      tagTheme: tagTheme.lerp(other.tagTheme, t),
      textAreaTheme: textAreaTheme.lerp(other.textAreaTheme, t),
      textInputTheme: textInputTheme.lerp(other.textInputTheme, t),
      toastTheme: toastTheme.lerp(other.toastTheme, t),
      tokens: tokens.lerp(other.tokens, t),
      tooltipTheme: tooltipTheme.lerp(other.tooltipTheme, t),
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
      ..add(DiagnosticsProperty<MoonButtonTheme>("MoonButtonTheme", buttonTheme))
      ..add(DiagnosticsProperty<MoonCarouselTheme>("MoonCarouselTheme", carouselTheme))
      ..add(DiagnosticsProperty<MoonCheckboxTheme>("MoonCheckboxTheme", checkboxTheme))
      ..add(DiagnosticsProperty<MoonChipTheme>("MoonChipTheme", chipTheme))
      ..add(DiagnosticsProperty<MoonCircularLoaderTheme>("MoonCircularLoaderTheme", circularLoaderTheme))
      ..add(DiagnosticsProperty<MoonCircularProgressTheme>("MoonCircularProgressTheme", circularProgressTheme))
      ..add(DiagnosticsProperty<MoonDotIndicatorTheme>("MoonDotIndicatorTheme", dotIndicatorTheme))
      ..add(DiagnosticsProperty<MoonDrawerTheme>("MoonDrawerTheme", drawerTheme))
      ..add(DiagnosticsProperty<MoonLinearLoaderTheme>("MoonLinearLoaderTheme", linearLoaderTheme))
      ..add(DiagnosticsProperty<MoonLinearProgressTheme>("MoonLinearProgressTheme", linearProgressTheme))
      ..add(DiagnosticsProperty<MoonModalTheme>("MoonModalTheme", modalTheme))
      ..add(DiagnosticsProperty<MoonPopoverTheme>("MoonPopoverTheme", popoverTheme))
      ..add(DiagnosticsProperty<MoonRadioTheme>("MoonRadioTheme", radioTheme))
      ..add(DiagnosticsProperty<MoonSegmentedControlTheme>("MoonSegmentedControlTheme", segmentedControlTheme))
      ..add(DiagnosticsProperty<MoonSwitchTheme>("MoonSwitchTheme", switchTheme))
      ..add(DiagnosticsProperty<MoonTabBarTheme>("MoonTabBarTheme", tabBarTheme))
      ..add(DiagnosticsProperty<MoonTagTheme>("MoonTagTheme", tagTheme))
      ..add(DiagnosticsProperty<MoonTextAreaTheme>("MoonTextAreaTheme", textAreaTheme))
      ..add(DiagnosticsProperty<MoonTextInputTheme>("MoonTextInputTheme", textInputTheme))
      ..add(DiagnosticsProperty<MoonToastTheme>("MoonToastTheme", toastTheme))
      ..add(DiagnosticsProperty<MoonTokens>("MoonTokens", tokens))
      ..add(DiagnosticsProperty<MoonTooltipTheme>("MoonTooltipTheme", tooltipTheme));
  }
}

extension MoonThemeX on BuildContext {
  MoonTheme? get moonTheme => Theme.of(this).extension<MoonTheme>();
  MoonBorders? get moonBorders => moonTheme?.tokens.borders;
  MoonColors? get moonColors => moonTheme?.tokens.colors;
  MoonEffects? get moonEffects => moonTheme?.tokens.effects;
  MoonIconography? get moonIconography => moonTheme?.tokens.iconography;
  MoonOpacities? get moonOpacities => moonTheme?.tokens.opacities;
  MoonShadows? get moonShadows => moonTheme?.tokens.shadows;
  MoonSizes? get moonSizes => moonTheme?.tokens.sizes;
  MoonTransitions? get moonTransitions => moonTheme?.tokens.transitions;
  MoonTypography? get moonTypography => moonTheme?.tokens.typography;
}
