import 'package:flutter/material.dart';

import 'package:moon_design/src/control_wrapper.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button_sizes.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/theme.dart';

enum ButtonSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

class MoonFilledButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ButtonSize? buttonSize;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final double? width;
  final double? height;
  final double? disabledOpacityValue;
  final double? borderWidth;
  final double? focusBorderWidth;
  final double? gap;
  final double? pulseEffectWidth;
  final double? scaleAnimationLowerBound;
  final double minTouchTargetSize;
  final bool autofocus;
  final bool isFocusable;
  final bool ensureMinimalTouchTargetSize;
  final bool showBorder;
  final bool showFocusAnimation;
  final bool showPulseAnimation;
  final bool showScaleAnimation;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? hoverOverlayColor;
  final Color? pulseEffectColor;
  final Duration? focusAnimationDuration;
  final Duration? hoverAnimationDuration;
  final Duration? scaleAnimationDuration;
  final Duration? pulseAnimationDuration;
  final Curve? focusAnimationCurve;
  final Curve? hoverAnimationCurve;
  final Curve? scaleAnimationCurve;
  final Curve? pulseAnimationCurve;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Widget? label;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const MoonFilledButton({
    super.key,
    this.onTap,
    this.onLongPress,
    this.buttonSize,
    this.focusNode,
    this.semanticLabel,
    this.width,
    this.height,
    this.disabledOpacityValue,
    this.borderWidth,
    this.focusBorderWidth,
    this.gap,
    this.pulseEffectWidth,
    this.scaleAnimationLowerBound,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.showBorder = false,
    this.showFocusAnimation = true,
    this.showPulseAnimation = false,
    this.showScaleAnimation = true,
    this.backgroundColor = Colors.blue,
    this.borderColor,
    this.focusBorderColor,
    this.hoverOverlayColor,
    this.pulseEffectColor,
    this.focusAnimationDuration,
    this.hoverAnimationDuration,
    this.scaleAnimationDuration,
    this.pulseAnimationDuration,
    this.focusAnimationCurve,
    this.hoverAnimationCurve,
    this.scaleAnimationCurve,
    this.pulseAnimationCurve,
    this.padding,
    this.borderRadius,
    this.label,
    this.leftIcon,
    this.rightIcon,
  });

  MoonButtonSizes getButtonSize(BuildContext context, ButtonSize? buttonSize) {
    switch (buttonSize) {
      case ButtonSize.xs:
        return context.moonTheme?.buttons.xs ?? MoonButtonSizes.xs;
      case ButtonSize.sm:
        return context.moonTheme?.buttons.sm ?? MoonButtonSizes.sm;
      case ButtonSize.md:
        return context.moonTheme?.buttons.md ?? MoonButtonSizes.md;
      case ButtonSize.lg:
        return context.moonTheme?.buttons.lg ?? MoonButtonSizes.lg;
      case ButtonSize.xl:
        return context.moonTheme?.buttons.xl ?? MoonButtonSizes.xl;
      default:
        return context.moonTheme?.buttons.md ?? MoonButtonSizes.xs;
    }
  }

  Color get textColor => backgroundColor.computeLuminance() > 0.5 ? MoonColors.light.bulma : MoonColors.dark.bulma;

  @override
  Widget build(BuildContext context) {
    final effectiveButtonSize = getButtonSize(context, buttonSize);

    final effectiveGap = gap ?? effectiveButtonSize.gap;
    final effectiveHeight = height ?? effectiveButtonSize.height;
    final effectivePadding = padding ?? effectiveButtonSize.padding;
    final effectiveBorderRadius = borderRadius ?? effectiveButtonSize.borderRadius;

    final correctedPadding = EdgeInsetsDirectional.fromSTEB(
      leftIcon == null && label != null ? effectivePadding.left : 0,
      effectivePadding.top,
      rightIcon == null && label != null ? effectivePadding.right : 0,
      effectivePadding.bottom,
    );

    final effectiveHoverOverlayColor = hoverOverlayColor ??
        context.moonEffects?.buttonHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightButtonHoverEffect.primaryHoverColor;

    final hoverColor = Color.alphaBlend(effectiveHoverOverlayColor, backgroundColor);

    final effectiveHoverAnimationCurve = hoverAnimationCurve ??
        context.moonEffects?.buttonHoverEffect.hoverCurve ??
        MoonHoverEffects.lightButtonHoverEffect.hoverCurve;

    final effectiveHoverAnimationDuration = hoverAnimationDuration ??
        context.moonEffects?.buttonHoverEffect.hoverDuration ??
        MoonHoverEffects.lightButtonHoverEffect.hoverDuration;

    final effectiveBorderColor = borderColor ?? context.moonColors?.trunks ?? MoonColors.light.trunks;

    final effectiveBorderWidth = borderWidth ?? context.moonBorders?.borderWidth ?? MoonBorders.borders.borderWidth;

    final effectiveFocusBorderColor = focusBorderColor ?? backgroundColor.withOpacity(0.2);

    return MoonControlWrapper(
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
      semanticTypeIsButton: true,
      borderRadius: effectiveBorderRadius,
      disabledOpacityValue: disabledOpacityValue,
      minTouchTargetSize: minTouchTargetSize,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      focusNode: focusNode,
      autofocus: autofocus,
      isFocusable: isFocusable,
      showFocusAnimation: showFocusAnimation,
      focusBorderColor: effectiveFocusBorderColor,
      focusBorderWidth: focusBorderWidth,
      focusAnimationDuration: focusAnimationDuration,
      focusAnimationCurve: focusAnimationCurve,
      showScaleAnimation: showScaleAnimation,
      scaleAnimationLowerBound: scaleAnimationLowerBound,
      scaleAnimationDuration: scaleAnimationDuration,
      scaleAnimationCurve: scaleAnimationCurve,
      showPulseAnimation: showPulseAnimation,
      pulseEffectColor: pulseEffectColor,
      pulseEffectWidth: pulseEffectWidth,
      pulseAnimationDuration: pulseAnimationDuration,
      pulseAnimationCurve: pulseAnimationCurve,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        return AnimatedContainer(
          padding: correctedPadding,
          width: width,
          height: effectiveHeight,
          duration: effectiveHoverAnimationDuration,
          curve: effectiveHoverAnimationCurve,
          decoration: BoxDecoration(
            color: isHovered ? hoverColor : backgroundColor,
            border: showBorder ? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth) : null,
            borderRadius: effectiveBorderRadius,
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: textColor, fontSize: effectiveButtonSize.textStyle.fontSize),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leftIcon != null)
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                      child: leftIcon,
                    ),
                  ),
                if (label != null) Flexible(child: label!),
                if (rightIcon != null)
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                      child: rightIcon,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
