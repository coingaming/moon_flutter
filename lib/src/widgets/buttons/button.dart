import 'package:figma_squircle/figma_squircle.dart';
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
  final double? scaleEffectScalar;
  final double minTouchTargetSize;
  final bool autofocus;
  final bool isFocusable;
  final bool isFullWidth;
  final bool ensureMinimalTouchTargetSize;
  final bool showBorder;
  final bool showFocusEffect;
  final bool showPulseEffect;
  final bool showPulseEffectJiggle;
  final bool showScaleAnimation;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? focusEffectColor;
  final Color? hoverOverlayColor;
  final Color? pulseEffectColor;
  final Duration? focusEffectDuration;
  final Duration? hoverEffectDuration;
  final Duration? scaleEffectDuration;
  final Duration? pulseEffectDuration;
  final Curve? focusEffectCurve;
  final Curve? hoverEffectCurve;
  final Curve? scaleEffectCurve;
  final Curve? pulseEffectCurve;
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
    this.scaleEffectScalar,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.ensureMinimalTouchTargetSize = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.backgroundColor = Colors.blue,
    this.borderColor,
    this.focusEffectColor,
    this.hoverOverlayColor,
    this.pulseEffectColor,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.scaleEffectDuration,
    this.pulseEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.scaleEffectCurve,
    this.pulseEffectCurve,
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
    this.scaleEffectScalar,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.ensureMinimalTouchTargetSize = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.borderColor,
    this.focusEffectColor,
    this.hoverOverlayColor,
    this.pulseEffectColor,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.scaleEffectDuration,
    this.pulseEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.scaleEffectCurve,
    this.pulseEffectCurve,
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
    this.scaleEffectScalar,
    this.minTouchTargetSize = 40,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.ensureMinimalTouchTargetSize = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.focusEffectColor,
    this.hoverOverlayColor,
    this.pulseEffectColor,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.scaleEffectDuration,
    this.pulseEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.scaleEffectCurve,
    this.pulseEffectCurve,
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

    final effectiveHoverOverlayColor = hoverOverlayColor ??
        context.moonEffects?.buttonHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightButtonHoverEffect.primaryHoverColor;

    final effectiveHoverEffectCurve = hoverEffectCurve ??
        context.moonEffects?.buttonHoverEffect.hoverCurve ??
        MoonHoverEffects.lightButtonHoverEffect.hoverCurve;

    final effectiveHoverEffectDuration = hoverEffectDuration ??
        context.moonEffects?.buttonHoverEffect.hoverDuration ??
        MoonHoverEffects.lightButtonHoverEffect.hoverDuration;

    final hoverColor = Color.alphaBlend(effectiveHoverOverlayColor, backgroundColor);

    final correctedPadding = EdgeInsetsDirectional.fromSTEB(
      leftIcon == null && label != null ? effectivePadding.left : 0,
      effectivePadding.top,
      rightIcon == null && label != null ? effectivePadding.right : 0,
      effectivePadding.bottom,
    );

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
      showFocusEffect: showFocusEffect,
      focusEffectColor: effectiveFocusColor,
      focusEffectExtent: focusEffectExtent,
      focusEffectDuration: focusEffectDuration,
      focusEffectCurve: focusEffectCurve,
      showScaleAnimation: showScaleAnimation,
      scaleEffectScalar: scaleEffectScalar,
      scaleEffectDuration: scaleEffectDuration,
      scaleEffectCurve: scaleEffectCurve,
      showPulseEffect: showPulseEffect,
      showPulseEffectJiggle: showPulseEffectJiggle,
      pulseEffectColor: pulseEffectColor,
      pulseEffectExtent: pulseEffectExtent,
      pulseEffectDuration: pulseEffectDuration,
      pulseEffectCurve: pulseEffectCurve,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        return AnimatedContainer(
          width: width,
          height: effectiveHeight,
          padding: correctedPadding,
          duration: effectiveHoverEffectDuration,
          curve: effectiveHoverEffectCurve,
          constraints: BoxConstraints(
            minWidth: effectiveHeight,
          ),
          decoration: ShapeDecoration(
            color: isHovered || isFocused || isPressed ? hoverColor : backgroundColor,
            shape: SmoothRectangleBorder(
              side: BorderSide(
                color: effectiveBorderColor,
                width: effectiveBorderWidth,
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
                      if (label != null)
                        Align(
                          child: label,
                        ),
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
        );
      },
    );
  }
}
