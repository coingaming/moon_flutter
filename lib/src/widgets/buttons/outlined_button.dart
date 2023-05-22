import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/buttons/button.dart';

class MoonOutlinedButton extends StatelessWidget {
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

  /// Whether the button should show a tooltip.
  final bool showTooltip;

  /// The border radius of the button.
  final BorderRadiusGeometry? borderRadius;

  /// The border color of the button.
  final Color? borderColor;

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

  /// Custom shape decoration for the button.
  final ShapeDecoration? shapeDecoration;

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

  /// MDS outlined button variant.
  ///
  /// See also:
  ///
  ///   * [MoonFilledButton], MDS filled button.
  ///   * [MoonTextButton], MDS text button.
  const MoonOutlinedButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.showTooltip = false,
    this.borderRadius,
    this.borderColor,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusNode,
    this.buttonSize,
    this.shapeDecoration,
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
    return MoonButton(
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      isFullWidth: isFullWidth,
      showPulseEffect: showPulseEffect,
      showTooltip: showTooltip,
      showBorder: true,
      borderRadius: borderRadius,
      borderColor: borderColor,
      height: height,
      width: width,
      minTouchTargetSize: minTouchTargetSize,
      focusNode: focusNode,
      buttonSize: buttonSize,
      shapeDecoration: shapeDecoration,
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
