import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/buttons/button.dart';
import 'package:moon_tokens/moon_tokens.dart';

class MoonFilledButton extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the button is focusable.
  final bool isFocusable;

  /// Whether to ensure a minimum touch target size for the button.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the button takes up the full width of its parent container.
  final bool isFullWidth;

  /// Whether to show a continuous pulsating effect.
  final bool showPulseEffect;

  /// The border radius of the button.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The custom decoration of the button.
  final Decoration? decoration;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// The minimum size of the button touch target.
  final double minTouchTargetSize;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The size of the button.
  final MoonButtonSize? buttonSize;

  /// The semantic label for the button.
  final String? semanticLabel;

  /// The callback that is called when the button is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget to display before the [label] widget of the button.
  final Widget? leading;

  /// The primary content of the button widget.
  final Widget? label;

  /// The widget to display after the [label] widget of the button.
  final Widget? trailing;

  /// Creates a Moon Design filled button.
  ///
  /// See also:
  ///
  ///   * [MoonOutlinedButton], Moon Design outlined button.
  ///   * [MoonTextButton], Moon Design text button.
  ///   * [MoonButton.icon], Moon Design icon button.
  const MoonFilledButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusNode,
    this.buttonSize,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor = backgroundColor ??
        context.moonTheme?.buttonTheme.colors.filledVariantBackgroundColor ??
        MoonColors.light.piccolo;

    final Color effectiveTextColor =
        context.moonTheme?.buttonTheme.colors.filledVariantTextColor ?? MoonColors.light.goten;

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
