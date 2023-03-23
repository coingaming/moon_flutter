import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/chips/chip.dart';

class MoonTextChip extends StatelessWidget {
  /// The callback that is called when the chip is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the chip is long-pressed.
  final VoidCallback? onLongPress;

  /// The size of the chip.
  final MoonChipSize? chipSize;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The semantic label for the chip.
  final String? semanticLabel;

  /// The tooltip message for the button.
  final String tooltipMessage;

  /// The width of the chip.
  final double? width;

  /// The height of the chip.
  final double? height;

  /// The opacity value of the chip when it is disabled.
  final double? disabledOpacityValue;

  /// The border width of the chip.
  final double? borderWidth;

  /// The gap between the icon and the label.
  final double? gap;

  /// The extent of the focus effect.
  final double? focusEffectExtent;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the chip is active/selected.
  final bool isActive;

  /// Whether the chip should be focusable.
  final bool isFocusable;

  /// Whether this chip should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the chip should show a border.
  final bool showBorder;

  /// Whether the chip should show a tooltip.
  final bool showTooltip;

  /// Whether the chip should show a focus effect.
  final bool showFocusEffect;

  /// The border and text color of the active/selected chip.
  final Color? activeColor;

  /// The border color of the  chip.
  final Color? borderColor;

  /// The text color of the chip.
  final Color? textColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the hover effect.
  final Color? hoverEffectColor;

  /// The duration of the focus effect.
  final Duration? focusEffectDuration;

  /// The duration of the hover effect.
  final Duration? hoverEffectDuration;

  /// The curve of the focus effect.
  final Curve? focusEffectCurve;

  /// The curve of the hover effect.
  final Curve? hoverEffectCurve;

  /// The padding of the chip.
  final EdgeInsets? padding;

  /// The border radius of the chip.
  final BorderRadius? borderRadius;

  /// The widget in the left icon slot of the chip.
  final Widget? leftIcon;

  /// The widget in the label slot of the chip.
  final Widget? label;

  /// The widget in the right icon slot of the chip.
  final Widget? rightIcon;

  /// MDS text chip widget.
  const MoonTextChip({
    super.key,
    this.onTap,
    this.onLongPress,
    this.chipSize,
    this.focusNode,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.width,
    this.height,
    this.disabledOpacityValue,
    this.borderWidth,
    this.gap,
    this.focusEffectExtent,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isActive = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.showBorder = false,
    this.showTooltip = false,
    this.showFocusEffect = true,
    this.activeColor,
    this.borderColor,
    this.textColor,
    this.focusEffectColor,
    this.hoverEffectColor,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.padding,
    this.borderRadius,
    this.label,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? context.moonTypography?.colors.bodyPrimary ?? MoonColors.light.bulma;

    return MoonChip(
      key: key,
      onTap: onTap,
      onLongPress: onLongPress,
      width: width,
      height: height,
      gap: gap,
      padding: padding,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      isActive: isActive,
      activeColor: activeColor,
      backgroundColor: Colors.transparent,
      borderColor: borderColor,
      textColor: effectiveTextColor,
      chipSize: chipSize,
      showBorder: showBorder,
      showTooltip: showTooltip,
      borderRadius: borderRadius,
      disabledOpacityValue: disabledOpacityValue,
      showFocusEffect: showFocusEffect,
      autofocus: autofocus,
      focusNode: focusNode,
      isFocusable: isFocusable,
      focusEffectColor: focusEffectColor,
      focusEffectCurve: focusEffectCurve,
      focusEffectDuration: focusEffectDuration,
      focusEffectExtent: focusEffectExtent,
      hoverEffectColor: hoverEffectColor,
      hoverEffectCurve: hoverEffectCurve,
      hoverEffectDuration: hoverEffectDuration,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      minTouchTargetSize: minTouchTargetSize,
      leftIcon: leftIcon,
      label: label,
      rightIcon: rightIcon,
    );
  }
}
