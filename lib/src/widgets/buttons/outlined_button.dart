import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/buttons/button.dart';

class MoonOutlinedButton extends StatelessWidget {
  /// The callback that is called when the button is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// The size of the button.
  final MoonButtonSize? buttonSize;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The semantic label for the button.
  final String? semanticLabel;

  /// The tooltip message for the button.
  final String tooltipMessage;

  /// The width of the button.
  final double? width;

  /// The height of the button.
  final double? height;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// Whether this button should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether this button should be focusable.
  final bool isFocusable;

  /// Whether this button should be full width.
  final bool isFullWidth;

  /// Whether the button should show a tooltip.
  final bool showTooltip;

  /// Whether this button should show a pulse effect.
  final bool showPulseEffect;

  /// The widget in the left icon slot of the button.
  final Widget? leftIcon;

  /// The widget in the label slot of the button.
  final Widget? label;

  /// The widget in the right icon slot of the button.
  final Widget? rightIcon;

  /// MDS secondary button variant.
  ///
  /// See also:
  ///
  ///   * [MoonFilledButton], MDS primary button.
  ///   * [MoonTertiaryButton], MDS tertiary button.
  ///   * [MoonTextButton], MDS ghost button.
  const MoonOutlinedButton({
    super.key,
    this.onTap,
    this.onLongPress,
    this.buttonSize,
    this.focusNode,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.width,
    this.height,
    this.minTouchTargetSize = 40,
    this.ensureMinimalTouchTargetSize = false,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.showTooltip = false,
    this.showPulseEffect = false,
    this.label,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MoonButton(
      onTap: onTap,
      onLongPress: onLongPress,
      buttonSize: buttonSize,
      focusNode: focusNode,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      width: width,
      height: height,
      minTouchTargetSize: minTouchTargetSize,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      autofocus: autofocus,
      isFocusable: isFocusable,
      isFullWidth: isFullWidth,
      showTooltip: showTooltip,
      showPulseEffect: showPulseEffect,
      showBorder: true,
      label: label,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
    );
  }
}
