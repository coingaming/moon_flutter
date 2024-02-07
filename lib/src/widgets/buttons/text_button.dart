import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/buttons/button.dart';
import 'package:moon_tokens/moon_tokens.dart';

class MoonTextButton extends StatelessWidget {
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

  /// Creates a Moon Design text button.
  ///
  /// See also:
  ///
  ///   * [MoonFilledButton], Moon Design filled button.
  ///   * [MoonOutlinedButton], Moon Design outlined button.
  ///   * [MoonButton.icon], Moon Design icon button.
  const MoonTextButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.decoration,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusNode,
    this.buttonSize,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor =
        context.moonTheme?.buttonTheme.colors.textVariantTextColor ?? MoonColors.light.textSecondary;

    final Color effectiveHoverTextColor =
        context.moonTheme?.buttonTheme.colors.textColor ?? MoonColors.light.textPrimary;

    final Color effectiveHoverColor =
        context.moonTheme?.buttonTheme.colors.textVariantHoverColor ?? MoonColors.light.jiren;

    final Color effectiveFocusColor =
        context.moonTheme?.buttonTheme.colors.textVariantFocusColor.withOpacity(context.isDarkMode ? 0.8 : 0.2) ??
            MoonColors.light.piccolo.withOpacity(context.isDarkMode ? 0.8 : 0.2);

    return MoonButton(
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      isFullWidth: isFullWidth,
      showPulseEffect: showPulseEffect,
      textColor: effectiveTextColor,
      hoverTextColor: effectiveHoverTextColor,
      hoverEffectColor: effectiveHoverColor,
      focusEffectColor: effectiveFocusColor,
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
