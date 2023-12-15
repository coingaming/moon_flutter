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
import 'package:moon_design/src/theme/dropdown/dropdown_theme.dart';
import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_theme.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_theme.dart';
import 'package:moon_design/src/theme/menu_item/menu_item_theme.dart';
import 'package:moon_design/src/theme/modal/modal_theme.dart';
import 'package:moon_design/src/theme/popover/popover_theme.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_theme.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_theme.dart';
import 'package:moon_design/src/theme/progress_pin/progress_pin_theme.dart';
import 'package:moon_design/src/theme/radio/radio_theme.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_theme.dart';
import 'package:moon_design/src/theme/switch/switch_theme.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_theme.dart';
import 'package:moon_design/src/theme/table/table_theme.dart';
import 'package:moon_design/src/theme/tag/tag_theme.dart';
import 'package:moon_design/src/theme/text_area/text_area_theme.dart';
import 'package:moon_design/src/theme/text_input/text_input_theme.dart';
import 'package:moon_design/src/theme/text_input_group/text_input_group_theme.dart';
import 'package:moon_design/src/theme/toast/toast_theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_theme.dart';
import 'package:moon_tokens/moon_tokens.dart';

@immutable
class MoonTheme extends ThemeExtension<MoonTheme> with DiagnosticableTreeMixin {
  ///Moon Design System tokens.
  final MoonTokens tokens;

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

  /// Moon Design System MoonDropdown widget theming.
  final MoonDropdownTheme dropdownTheme;

  /// Moon Design System effects.
  final MoonEffectsTheme effects;

  /// Moon Design System MoonLinearLoader widget theming.
  final MoonLinearLoaderTheme linearLoaderTheme;

  /// Moon Design System MoonLinearProgress widget theming.
  final MoonLinearProgressTheme linearProgressTheme;

  /// Moon Design System MoonMenuItem widget theming.
  final MoonMenuItemTheme menuItemTheme;

  /// Moon Design System MoonModal widget theming.
  final MoonModalTheme modalTheme;

  /// Moon Design System MoonPopover widget theming.
  final MoonPopoverTheme popoverTheme;

  /// Moon Design System MoonProgressPin widget theming.
  final MoonProgressPinTheme progressPinTheme;

  /// Moon Design System MoonRadio widget theming.
  final MoonRadioTheme radioTheme;

  /// Moon Design System MoonSegmentedControl widget theming.
  final MoonSegmentedControlTheme segmentedControlTheme;

  /// Moon Design System MoonSwitch widget theming.
  final MoonSwitchTheme switchTheme;

  /// Moon Design System MoonTabBar widget theming.
  final MoonTabBarTheme tabBarTheme;

  /// Moon Design System MoonTable widget theming.
  final MoonTableTheme tableTheme;

  /// Moon Design System MoonTag widget theming.
  final MoonTagTheme tagTheme;

  /// Moon Design System MoonTextArea widget theming.
  final MoonTextAreaTheme textAreaTheme;

  /// Moon Design System MoonTextInput widget theming.
  final MoonTextInputTheme textInputTheme;

  /// Moon Design System MoonTextInputGroup widget theming.
  final MoonTextInputGroupTheme textInputGroupTheme;

  /// Moon Design System MoonToast widget theming.
  final MoonToastTheme toastTheme;

  /// Moon Design System MoonTooltip widget theming.
  final MoonTooltipTheme tooltipTheme;

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
    MoonDropdownTheme? dropdownTheme,
    MoonEffectsTheme? effects,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonMenuItemTheme? menuItemTheme,
    MoonModalTheme? modalTheme,
    MoonPopoverTheme? popoverTheme,
    MoonProgressPinTheme? progressPinTheme,
    MoonRadioTheme? radioTheme,
    MoonSegmentedControlTheme? segmentedControlTheme,
    MoonSwitchTheme? switchTheme,
    MoonTabBarTheme? tabBarTheme,
    MoonTableTheme? tableTheme,
    MoonTagTheme? tagTheme,
    MoonTextAreaTheme? textAreaTheme,
    MoonTextInputTheme? textInputTheme,
    MoonTextInputGroupTheme? textInputGroupTheme,
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
        dropdownTheme = dropdownTheme ?? MoonDropdownTheme(tokens: tokens),
        effects = effects ?? MoonEffectsTheme(tokens: tokens),
        linearLoaderTheme = linearLoaderTheme ?? MoonLinearLoaderTheme(tokens: tokens),
        linearProgressTheme = linearProgressTheme ?? MoonLinearProgressTheme(tokens: tokens),
        menuItemTheme = menuItemTheme ?? MoonMenuItemTheme(tokens: tokens),
        modalTheme = modalTheme ?? MoonModalTheme(tokens: tokens),
        popoverTheme = popoverTheme ?? MoonPopoverTheme(tokens: tokens),
        progressPinTheme = progressPinTheme ?? MoonProgressPinTheme(tokens: tokens),
        radioTheme = radioTheme ?? MoonRadioTheme(tokens: tokens),
        segmentedControlTheme = segmentedControlTheme ?? MoonSegmentedControlTheme(tokens: tokens),
        switchTheme = switchTheme ?? MoonSwitchTheme(tokens: tokens),
        tabBarTheme = tabBarTheme ?? MoonTabBarTheme(tokens: tokens),
        tableTheme = tableTheme ?? MoonTableTheme(tokens: tokens),
        tagTheme = tagTheme ?? MoonTagTheme(tokens: tokens),
        textAreaTheme = textAreaTheme ?? MoonTextAreaTheme(tokens: tokens),
        textInputTheme = textInputTheme ?? MoonTextInputTheme(tokens: tokens),
        textInputGroupTheme = textInputGroupTheme ?? MoonTextInputGroupTheme(tokens: tokens),
        toastTheme = toastTheme ?? MoonToastTheme(tokens: tokens),
        tooltipTheme = tooltipTheme ?? MoonTooltipTheme(tokens: tokens);

  @override
  MoonTheme copyWith({
    MoonTokens? tokens,
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
    MoonDropdownTheme? dropdownTheme,
    MoonEffectsTheme? effects,
    MoonLinearLoaderTheme? linearLoaderTheme,
    MoonLinearProgressTheme? linearProgressTheme,
    MoonMenuItemTheme? menuItemTheme,
    MoonModalTheme? modalTheme,
    MoonPopoverTheme? popoverTheme,
    MoonProgressPinTheme? progressPinTheme,
    MoonRadioTheme? radioTheme,
    MoonSegmentedControlTheme? segmentedControlTheme,
    MoonSwitchTheme? switchTheme,
    MoonTabBarTheme? tabBarTheme,
    MoonTableTheme? tableTheme,
    MoonTagTheme? tagTheme,
    MoonTextAreaTheme? textAreaTheme,
    MoonTextInputTheme? textInputTheme,
    MoonTextInputGroupTheme? textInputGroupTheme,
    MoonToastTheme? toastTheme,
    MoonTooltipTheme? tooltipTheme,
  }) {
    return MoonTheme(
      tokens: tokens ?? this.tokens,
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
      dropdownTheme: dropdownTheme ?? this.dropdownTheme,
      effects: effects ?? this.effects,
      linearLoaderTheme: linearLoaderTheme ?? this.linearLoaderTheme,
      linearProgressTheme: linearProgressTheme ?? this.linearProgressTheme,
      menuItemTheme: menuItemTheme ?? this.menuItemTheme,
      modalTheme: modalTheme ?? this.modalTheme,
      popoverTheme: popoverTheme ?? this.popoverTheme,
      progressPinTheme: progressPinTheme ?? this.progressPinTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      segmentedControlTheme: segmentedControlTheme ?? this.segmentedControlTheme,
      switchTheme: switchTheme ?? this.switchTheme,
      tabBarTheme: tabBarTheme ?? this.tabBarTheme,
      tableTheme: tableTheme ?? this.tableTheme,
      tagTheme: tagTheme ?? this.tagTheme,
      textAreaTheme: textAreaTheme ?? this.textAreaTheme,
      textInputTheme: textInputTheme ?? this.textInputTheme,
      textInputGroupTheme: textInputGroupTheme ?? this.textInputGroupTheme,
      toastTheme: toastTheme ?? this.toastTheme,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
    );
  }

  @override
  MoonTheme lerp(ThemeExtension<MoonTheme>? other, double t) {
    if (other is! MoonTheme) return this;

    return MoonTheme(
      tokens: tokens.lerp(other.tokens, t),
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
      dropdownTheme: dropdownTheme.lerp(other.dropdownTheme, t),
      effects: effects.lerp(other.effects, t),
      linearLoaderTheme: linearLoaderTheme.lerp(other.linearLoaderTheme, t),
      linearProgressTheme: linearProgressTheme.lerp(other.linearProgressTheme, t),
      menuItemTheme: menuItemTheme.lerp(other.menuItemTheme, t),
      modalTheme: modalTheme.lerp(other.modalTheme, t),
      popoverTheme: popoverTheme.lerp(other.popoverTheme, t),
      progressPinTheme: progressPinTheme.lerp(other.progressPinTheme, t),
      radioTheme: radioTheme.lerp(other.radioTheme, t),
      segmentedControlTheme: segmentedControlTheme.lerp(other.segmentedControlTheme, t),
      switchTheme: switchTheme.lerp(other.switchTheme, t),
      tabBarTheme: tabBarTheme.lerp(other.tabBarTheme, t),
      tableTheme: tableTheme.lerp(other.tableTheme, t),
      tagTheme: tagTheme.lerp(other.tagTheme, t),
      textAreaTheme: textAreaTheme.lerp(other.textAreaTheme, t),
      textInputTheme: textInputTheme.lerp(other.textInputTheme, t),
      textInputGroupTheme: textInputGroupTheme.lerp(other.textInputGroupTheme, t),
      toastTheme: toastTheme.lerp(other.toastTheme, t),
      tooltipTheme: tooltipTheme.lerp(other.tooltipTheme, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("MoonTokens", tokens))
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
      ..add(DiagnosticsProperty<MoonDropdownTheme>("MoonDropdownTheme", dropdownTheme))
      ..add(DiagnosticsProperty<MoonEffectsTheme>("MoonEffectsTheme", effects))
      ..add(DiagnosticsProperty<MoonLinearLoaderTheme>("MoonLinearLoaderTheme", linearLoaderTheme))
      ..add(DiagnosticsProperty<MoonLinearProgressTheme>("MoonLinearProgressTheme", linearProgressTheme))
      ..add(DiagnosticsProperty<MoonMenuItemTheme>("MoonMenuItemTheme", menuItemTheme))
      ..add(DiagnosticsProperty<MoonModalTheme>("MoonModalTheme", modalTheme))
      ..add(DiagnosticsProperty<MoonPopoverTheme>("MoonPopoverTheme", popoverTheme))
      ..add(DiagnosticsProperty<MoonProgressPinTheme>("MoonProgressPinTheme", progressPinTheme))
      ..add(DiagnosticsProperty<MoonRadioTheme>("MoonRadioTheme", radioTheme))
      ..add(DiagnosticsProperty<MoonSegmentedControlTheme>("MoonSegmentedControlTheme", segmentedControlTheme))
      ..add(DiagnosticsProperty<MoonSwitchTheme>("MoonSwitchTheme", switchTheme))
      ..add(DiagnosticsProperty<MoonTabBarTheme>("MoonTabBarTheme", tabBarTheme))
      ..add(DiagnosticsProperty<MoonTableTheme>("MoonTableTheme", tableTheme))
      ..add(DiagnosticsProperty<MoonTagTheme>("MoonTagTheme", tagTheme))
      ..add(DiagnosticsProperty<MoonTextAreaTheme>("MoonTextAreaTheme", textAreaTheme))
      ..add(DiagnosticsProperty<MoonTextInputTheme>("MoonTextInputTheme", textInputTheme))
      ..add(DiagnosticsProperty<MoonTextInputGroupTheme>("MoonTextInputGroupTheme", textInputGroupTheme))
      ..add(DiagnosticsProperty<MoonToastTheme>("MoonToastTheme", toastTheme))
      ..add(DiagnosticsProperty<MoonTooltipTheme>("MoonTooltipTheme", tooltipTheme));
  }
}

extension MoonThemeX on BuildContext {
  MoonTheme? get moonTheme => Theme.of(this).extension<MoonTheme>();

  MoonBorders? get moonBorders => moonTheme?.tokens.borders;

  MoonColors? get moonColors => moonTheme?.tokens.colors;

  MoonEffectsTheme? get moonEffects => moonTheme?.effects;

  MoonOpacities? get moonOpacities => moonTheme?.tokens.opacities;

  MoonShadows? get moonShadows => moonTheme?.tokens.shadows;

  MoonSizes? get moonSizes => moonTheme?.tokens.sizes;

  MoonTransitions? get moonTransitions => moonTheme?.tokens.transitions;

  MoonTypography? get moonTypography => moonTheme?.tokens.typography;
}
