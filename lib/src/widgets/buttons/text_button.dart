import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/buttons/button.dart';

class MoonTextButton extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether this button should be focusable.
  final bool isFocusable;

  /// Whether this button should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether this button should be full width.
  final bool isFullWidth;

  /// Whether this button should show a pulse effect.
  final bool showPulseEffect;

  /// Whether this button should show a tooltip.
  final bool showTooltip;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The size of the button.
  final MoonButtonSize? buttonSize;

  /// The semantic label for the button.
  final String? semanticLabel;

  /// The tooltip message for the button.
  final String tooltipMessage;

  /// The callback that is called when the button is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget in the leading slot of the button.
  final Widget? leading;

  /// The widget in the label slot of the button.
  final Widget? label;

  /// The widget in the trailing slot of the button.
  final Widget? trailing;

  /// MDS text button variant.
  ///
  /// See also:
  ///
  ///   * [MoonFilledButton], MDS filled button.
  ///   * [MoonOutlinedButton], MDS outlined button.
  const MoonTextButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.showTooltip = false,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusNode,
    this.buttonSize,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = context.moonTheme?.buttonTheme.colors.textVariantTextColor ?? MoonColors.light.trunks;

    final effectiveHoverColor = context.moonTheme?.buttonTheme.colors.textVariantHoverColor ?? MoonColors.light.jiren;

    final effectiveFocusColor =
        context.moonTheme?.buttonTheme.colors.textVariantFocusColor.withOpacity(context.isDarkMode ? 0.8 : 0.2) ??
            MoonColors.light.piccolo.withOpacity(context.isDarkMode ? 0.8 : 0.2);

    return MoonButton(
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      isFullWidth: isFullWidth,
      showPulseEffect: showPulseEffect,
      showTooltip: showTooltip,
      textColor: effectiveTextColor,
      hoverEffectColor: effectiveHoverColor,
      focusEffectColor: effectiveFocusColor,
      height: height,
      width: width,
      minTouchTargetSize: minTouchTargetSize,
      focusNode: focusNode,
      buttonSize: buttonSize,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      onTap: onTap,
      onLongPress: onLongPress,
      label: label,
      leading: leading,
      trailing: trailing,
    );
  }
}
