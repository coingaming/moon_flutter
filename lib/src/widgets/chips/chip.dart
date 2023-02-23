import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/chip/chip_sizes.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/animated_icon_theme.dart';
import 'package:moon_design/src/widgets/base_control.dart';

enum MoonChipSize {
  sm,
  md,
}

class MoonChip extends StatelessWidget {
  /// The callback that is called when the chip is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the chip is long-pressed.
  final VoidCallback? onLongPress;

  /// The size of the chip.
  final MoonChipSize? chipSize;

  /// The focus node for the chip.
  final FocusNode? focusNode;

  /// The semantic label for the chip.
  final String? semanticLabel;

  /// The tooltip message for the chip.
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

  /// Whether the chip should automatically be focused when it is mounted.
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

  /// The background color of the chip.
  final Color? backgroundColor;

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

  const MoonChip({
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
    this.backgroundColor,
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

  MoonChipSizes _getMoonChipSize(BuildContext context, MoonChipSize? moonChipSize) {
    switch (moonChipSize) {
      case MoonChipSize.sm:
        return context.moonTheme?.chipTheme.sm ?? MoonChipSizes.sm;
      case MoonChipSize.md:
        return context.moonTheme?.chipTheme.md ?? MoonChipSizes.md;

      default:
        return context.moonTheme?.chipTheme.md ?? MoonChipSizes.sm;
    }
  }

  Color _getTextColor({
    required Color backgroundColor,
    required Color activeColor,
    required Color? textColor,
    required bool isActive,
  }) {
    if (isActive) return activeColor;
    if (textColor != null) return textColor;

    final backgroundLuminance = backgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  Color _getBorderColor({required bool isActive, required Color activeColor}) =>
      isActive ? activeColor : borderColor ?? Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final MoonChipSizes effectiveMoonChipSize = _getMoonChipSize(context, chipSize);

    final double effectiveHeight = height ?? effectiveMoonChipSize.height;
    final double effectiveGap = gap ?? effectiveMoonChipSize.gap;

    final EdgeInsets effectivePadding = padding ?? effectiveMoonChipSize.padding;

    final EdgeInsetsDirectional correctedPadding = EdgeInsetsDirectional.fromSTEB(
      leftIcon == null && label != null ? effectivePadding.left : 0,
      effectivePadding.top,
      rightIcon == null && label != null ? effectivePadding.right : 0,
      effectivePadding.bottom,
    );

    final BorderRadius effectiveBorderRadius = borderRadius ?? effectiveMoonChipSize.borderRadius;
    final double effectiveBorderWidth =
        borderWidth ?? context.moonBorders?.borderWidth ?? MoonBorders.borders.borderWidth;

    final Color effectiveActiveColor = activeColor ?? context.moonColors?.piccolo ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor = backgroundColor ?? context.moonColors?.gohan ?? MoonColors.light.gohan;

    final Color effectiveHoverEffectColor = hoverEffectColor ??
        context.moonEffects?.controlHoverEffect.secondaryHoverColor ??
        MoonHoverEffects.lightHoverEffect.secondaryHoverColor;

    final Curve effectiveHoverEffectCurve = hoverEffectCurve ??
        context.moonEffects?.controlHoverEffect.hoverCurve ??
        MoonHoverEffects.lightHoverEffect.hoverCurve;

    final Duration effectiveHoverEffectDuration = hoverEffectDuration ??
        context.moonEffects?.controlHoverEffect.hoverDuration ??
        MoonHoverEffects.lightHoverEffect.hoverDuration;

    return MoonBaseControl(
      onTap: onTap ?? () {},
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      borderRadius: effectiveBorderRadius,
      disabledOpacityValue: disabledOpacityValue,
      minTouchTargetSize: minTouchTargetSize,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      focusNode: focusNode,
      autofocus: autofocus,
      isFocusable: isFocusable,
      showTooltip: showTooltip,
      showFocusEffect: showFocusEffect,
      backgroundColor: backgroundColor,
      focusEffectColor: focusEffectColor,
      focusEffectExtent: focusEffectExtent,
      focusEffectDuration: focusEffectDuration,
      focusEffectCurve: focusEffectCurve,
      showScaleAnimation: false,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final bool canAnimate = isActive || isHovered || isFocused;

        final Color effectiveBorderColor =
            borderColor ?? _getBorderColor(isActive: canAnimate, activeColor: effectiveActiveColor);

        final Color effectiveTextColor = _getTextColor(
          isActive: canAnimate,
          activeColor: effectiveActiveColor,
          backgroundColor: effectiveBackgroundColor,
          textColor: textColor,
        );

        return AnimatedContainer(
          duration: effectiveHoverEffectDuration,
          curve: effectiveHoverEffectCurve,
          width: width,
          height: effectiveHeight,
          padding: correctedPadding,
          constraints: BoxConstraints(minWidth: effectiveHeight),
          decoration: ShapeDecoration(
            color: canAnimate ? effectiveHoverEffectColor : effectiveBackgroundColor,
            shape: SmoothRectangleBorder(
              side: BorderSide(
                color: effectiveBorderColor,
                width: showBorder ? effectiveBorderWidth : 0,
                style: showBorder ? BorderStyle.solid : BorderStyle.none,
              ),
              borderRadius: SmoothBorderRadius.only(
                topLeft: SmoothRadius(
                  cornerRadius: effectiveBorderRadius.topLeft.x,
                  cornerSmoothing: 1,
                ),
                topRight: SmoothRadius(
                  cornerRadius: effectiveBorderRadius.topRight.x,
                  cornerSmoothing: 1,
                ),
                bottomLeft: SmoothRadius(
                  cornerRadius: effectiveBorderRadius.bottomLeft.x,
                  cornerSmoothing: 1,
                ),
                bottomRight: SmoothRadius(
                  cornerRadius: effectiveBorderRadius.bottomRight.x,
                  cornerSmoothing: 1,
                ),
              ),
            ),
          ),
          child: AnimatedIconTheme(
            duration: effectiveHoverEffectDuration,
            curve: effectiveHoverEffectCurve,
            color: effectiveTextColor,
            size: effectiveMoonChipSize.iconSizeValue,
            child: AnimatedDefaultTextStyle(
              duration: effectiveHoverEffectDuration,
              curve: effectiveHoverEffectCurve,
              style: TextStyle(fontSize: effectiveMoonChipSize.textStyle.fontSize, color: effectiveTextColor),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leftIcon != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                      child: leftIcon,
                    ),
                  if (label != null) label!,
                  if (rightIcon != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                      child: rightIcon,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
