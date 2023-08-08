import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/widgets/buttons/button.dart';

class MoonFilledButton extends StatelessWidget {
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

  /// The border radius of the button.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the button.
  final Color? backgroundColor;

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

  /// Custom decoration for the button.
  final Decoration? decoration;

  /// The semantic label for the button.
  final String? semanticLabel;

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

  /// MDS filled button variant.
  ///
  /// See also:
  ///
  ///   * [MoonOutlinedButton], MDS outlined button.
  ///   * [MoonTextButton], MDS text button.
  const MoonFilledButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.borderRadius,
    this.backgroundColor,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusNode,
    this.buttonSize,
    this.decoration,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ??
        context.moonTheme?.buttonTheme.colors.filledVariantBackgroundColor ??
        MoonColors.light.piccolo;

    final effectiveTextColor = context.moonTheme?.buttonTheme.colors.filledVariantTextColor ?? MoonColors.light.goten;

    return MoonButton(
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      isFullWidth: isFullWidth,
      showPulseEffect: showPulseEffect,
      textColor: effectiveTextColor,
      borderRadius: borderRadius,
      backgroundColor: effectiveBackgroundColor,
      height: height,
      width: width,
      minTouchTargetSize: minTouchTargetSize,
      focusNode: focusNode,
      buttonSize: buttonSize,
      decoration: decoration,
      semanticLabel: semanticLabel,
      onTap: onTap,
      onLongPress: onLongPress,
      label: label,
      leading: leading,
      trailing: trailing,
    );
  }
}
