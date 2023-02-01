import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button_sizes.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/control_wrapper.dart';

enum ButtonSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

class MoonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ButtonSize? buttonSize;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final double? width;
  final double? height;
  final double? disabledOpacityValue;
  final double? borderWidth;
  final double? gap;
  final double? focusEffectExtent;
  final double? pulseEffectExtent;
  final double? scaleAnimationLowerBound;
  final double minTouchTargetSize;
  final bool autofocus;
  final bool isFocusable;
  final bool isFullWidth;
  final bool ensureMinimalTouchTargetSize;
  final bool showBorder;
  final bool showFocusAnimation;
  final bool showPulseAnimation;
  final bool showScaleAnimation;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? focusEffectColor;
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

  const MoonButton({
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
    this.gap,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleAnimationLowerBound,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.ensureMinimalTouchTargetSize = false,
    this.showBorder = false,
    this.showFocusAnimation = true,
    this.showPulseAnimation = false,
    this.showScaleAnimation = true,
    this.backgroundColor = Colors.blue,
    this.borderColor,
    this.focusEffectColor,
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

  const MoonButton.outlined({
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
    this.gap,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleAnimationLowerBound,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.ensureMinimalTouchTargetSize = false,
    this.showFocusAnimation = true,
    this.showPulseAnimation = false,
    this.showScaleAnimation = true,
    this.borderColor,
    this.focusEffectColor,
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
  })  : showBorder = true,
        backgroundColor = Colors.transparent;

  const MoonButton.text({
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
    this.gap,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleAnimationLowerBound,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.ensureMinimalTouchTargetSize = false,
    this.showFocusAnimation = true,
    this.showPulseAnimation = false,
    this.showScaleAnimation = true,
    this.focusEffectColor,
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
  })  : showBorder = false,
        borderColor = null,
        backgroundColor = Colors.transparent;

  MoonButtonSizes getButtonSize(BuildContext context, ButtonSize? buttonSize) {
    switch (buttonSize) {
      case ButtonSize.xs:
        return context.moonTheme?.buttonTheme.xs ?? MoonButtonSizes.xs;
      case ButtonSize.sm:
        return context.moonTheme?.buttonTheme.sm ?? MoonButtonSizes.sm;
      case ButtonSize.md:
        return context.moonTheme?.buttonTheme.md ?? MoonButtonSizes.md;
      case ButtonSize.lg:
        return context.moonTheme?.buttonTheme.lg ?? MoonButtonSizes.lg;
      case ButtonSize.xl:
        return context.moonTheme?.buttonTheme.xl ?? MoonButtonSizes.xl;
      default:
        return context.moonTheme?.buttonTheme.md ?? MoonButtonSizes.xs;
    }
  }

  Color getTextColor({required bool isDarkMode, required double backgroundLuminance}) {
    if (backgroundColor == Colors.transparent && isDarkMode) return MoonColors.dark.bulma;
    if (backgroundColor == Colors.transparent && !isDarkMode) return MoonColors.light.bulma;
    if (backgroundLuminance > 0.5) return MoonColors.light.bulma;
    return MoonColors.dark.bulma;
  }

  Color? getFocusColor({required bool isDarkMode}) {
    if (backgroundColor != Colors.transparent) {
      return isDarkMode ? backgroundColor.withOpacity(0.8) : backgroundColor.withOpacity(0.2);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundLuminance = backgroundColor.computeLuminance();

    final effectiveTextColor = getTextColor(isDarkMode: context.isDarkMode, backgroundLuminance: backgroundLuminance);
    final effectiveFocusColor = getFocusColor(isDarkMode: context.isDarkMode);
    final effectiveButtonSize = getButtonSize(context, buttonSize);

    final effectiveGap = gap ?? effectiveButtonSize.gap;
    final effectiveHeight = height ?? effectiveButtonSize.height;
    final effectivePadding = padding ?? effectiveButtonSize.padding;

    final effectiveBorderColor = borderColor ?? context.moonColors?.trunks ?? MoonColors.light.trunks;
    final effectiveBorderWidth = borderWidth ?? context.moonBorders?.borderWidth ?? MoonBorders.borders.borderWidth;
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
      focusEffectColor: effectiveFocusColor,
      focusEffectExtent: focusEffectExtent,
      focusAnimationDuration: focusAnimationDuration,
      focusAnimationCurve: focusAnimationCurve,
      showScaleAnimation: showScaleAnimation,
      scaleAnimationLowerBound: scaleAnimationLowerBound,
      scaleAnimationDuration: scaleAnimationDuration,
      scaleAnimationCurve: scaleAnimationCurve,
      showPulseAnimation: showPulseAnimation,
      pulseEffectColor: pulseEffectColor,
      pulseEffectExtent: pulseEffectExtent,
      pulseAnimationDuration: pulseAnimationDuration,
      pulseAnimationCurve: pulseAnimationCurve,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        return AnimatedContainer(
          width: width,
          height: effectiveHeight,
          padding: correctedPadding,
          duration: effectiveHoverAnimationDuration,
          curve: effectiveHoverAnimationCurve,
          decoration: BoxDecoration(
            color: isHovered || isFocused || isPressed ? hoverColor : backgroundColor,
            border: showBorder ? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth) : null,
            borderRadius: effectiveBorderRadius,
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: effectiveTextColor, fontSize: effectiveButtonSize.textStyle.fontSize),
            child: isFullWidth
                ? Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      if (leftIcon != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                            child: leftIcon,
                          ),
                        ),
                      if (label != null) Align(child: label),
                      if (rightIcon != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                            child: rightIcon,
                          ),
                        ),
                    ],
                  )
                : Row(
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
