import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/button_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/base_control.dart';

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
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? focusEffectColor;
  final Color? hoverEffectColor;
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
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.focusEffectColor,
    this.hoverEffectColor,
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

  @override
  Widget build(BuildContext context) {
    final MoonButtonSizes effectiveButtonSize = getButtonSize(context, buttonSize);
    final BorderRadius effectiveBorderRadius = borderRadius ?? effectiveButtonSize.borderRadius;

    final double effectiveGap = gap ?? effectiveButtonSize.gap;
    final double effectiveHeight = height ?? effectiveButtonSize.height;
    final EdgeInsets effectivePadding = padding ?? effectiveButtonSize.padding;

    final EdgeInsetsDirectional correctedPadding = EdgeInsetsDirectional.fromSTEB(
      leftIcon == null && label != null ? effectivePadding.left : 0,
      effectivePadding.top,
      rightIcon == null && label != null ? effectivePadding.right : 0,
      effectivePadding.bottom,
    );

    return MoonBaseControl(
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
      showBorder: showBorder,
      showFocusEffect: showFocusEffect,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textColor: textColor,
      focusEffectColor: focusEffectColor,
      focusEffectExtent: focusEffectExtent,
      focusEffectDuration: focusEffectDuration,
      focusEffectCurve: focusEffectCurve,
      hoverEffectColor: hoverEffectColor,
      hoverEffectDuration: hoverEffectDuration,
      hoverEffectCurve: hoverEffectCurve,
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
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: width,
          height: effectiveHeight,
          padding: correctedPadding,
          constraints: BoxConstraints(minWidth: effectiveHeight),
          child: DefaultTextStyle.merge(
            style: TextStyle(fontSize: effectiveButtonSize.textStyle.fontSize),
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
