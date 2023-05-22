import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/chips/chip.dart';

class MoonTextChip extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the chip should be focusable.
  final bool isFocusable;

  /// Whether this chip should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the chip is active/selected.
  final bool isActive;

  /// Whether the chip should show a border.
  final bool showBorder;

  /// Whether the chip should show a focus effect.
  final bool showFocusEffect;

  /// Whether the chip should show a tooltip.
  final bool showTooltip;

  /// The border radius of the chip.
  final BorderRadiusGeometry? borderRadius;

  /// The border and text color of the active/selected chip.
  final Color? activeColor;

  /// The border color of the  chip.
  final Color? borderColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the hover effect.
  final Color? hoverEffectColor;

  /// The text color of the chip.
  final Color? textColor;

  /// The border width of the chip.
  final double? borderWidth;

  /// The opacity value of the chip when it is disabled.
  final double? disabledOpacityValue;

  /// The extent of the focus effect.
  final double? focusEffectExtent;

  /// The gap between the leading or trailing and the label widgets.
  final double? gap;

  /// The height of the chip.
  final double? height;

  /// The width of the chip.
  final double? width;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// The duration of the focus effect.
  final Duration? focusEffectDuration;

  /// The duration of the hover effect.
  final Duration? hoverEffectDuration;

  /// The curve of the focus effect.
  final Curve? focusEffectCurve;

  /// The curve of the hover effect.
  final Curve? hoverEffectCurve;

  /// The padding of the chip.
  final EdgeInsetsGeometry? padding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The size of the chip.
  final MoonChipSize? chipSize;

  /// Custom decoration for the chip.
  final Decoration? decoration;

  /// The semantic label for the chip.
  final String? semanticLabel;

  /// The tooltip message for the button.
  final String tooltipMessage;

  /// The callback that is called when the chip is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the chip is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget in the leading slot of the chip.
  final Widget? leading;

  /// The widget in the label slot of the chip.
  final Widget? label;

  /// The widget in the trailing slot of the chip.
  final Widget? trailing;

  /// MDS text chip widget.
  const MoonTextChip({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isActive = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.showTooltip = false,
    this.borderRadius,
    this.activeColor,
    this.borderColor,
    this.focusEffectColor,
    this.hoverEffectColor,
    this.textColor,
    this.borderWidth,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.padding,
    this.focusNode,
    this.chipSize,
    this.decoration,
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
    final effectiveTextColor = textColor ?? context.moonTypography?.colors.bodyPrimary ?? MoonColors.light.bulma;

    return MoonChip(
      key: key,
      autofocus: autofocus,
      isFocusable: isFocusable,
      isActive: isActive,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      showBorder: showBorder,
      showFocusEffect: showFocusEffect,
      showTooltip: showTooltip,
      borderRadius: borderRadius,
      activeColor: activeColor,
      backgroundColor: Colors.transparent,
      borderColor: borderColor,
      focusEffectColor: focusEffectColor,
      hoverEffectColor: hoverEffectColor,
      textColor: effectiveTextColor,
      disabledOpacityValue: disabledOpacityValue,
      focusEffectExtent: focusEffectExtent,
      gap: gap,
      height: height,
      width: width,
      minTouchTargetSize: minTouchTargetSize,
      focusEffectDuration: focusEffectDuration,
      hoverEffectDuration: hoverEffectDuration,
      focusEffectCurve: focusEffectCurve,
      hoverEffectCurve: hoverEffectCurve,
      padding: padding,
      focusNode: focusNode,
      chipSize: chipSize,
      decoration: decoration,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      label: label,
      trailing: trailing,
    );
  }
}
