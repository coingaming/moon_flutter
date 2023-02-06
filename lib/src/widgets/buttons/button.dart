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
  /// The callback that is called when the control is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the control is long-pressed.
  final VoidCallback? onLongPress;

  /// The size of the button.
  final ButtonSize? buttonSize;

  /// The focus node for the button.
  final FocusNode? focusNode;

  /// The semantic label for the button.
  final String? semanticLabel;

  /// The width of the button.
  final double? width;

  /// The height of the button.
  final double? height;

  /// The opacity value of the button when it is disabled.
  final double? disabledOpacityValue;

  /// The border width of the button.
  final double? borderWidth;

  /// The gap between the icon and the label.
  final double? gap;

  /// The extent of the focus effect.
  final double? focusEffectExtent;

  /// The extent of the pulse effect.
  final double? pulseEffectExtent;

  /// The scalar controlling the scaling of the scale effect.
  final double? scaleEffectScalar;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// Whether the button should automatically be focused when it is mounted.
  final bool autofocus;

  /// Whether the button should be focusable.
  final bool isFocusable;

  /// Whether the button should be full width.
  final bool isFullWidth;

  /// Whether this button should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the button should show a border.
  final bool showBorder;

  /// Whether the button should show a focus effect.
  final bool showFocusEffect;

  /// Whether the button should show a pulse effect.
  final bool showPulseEffect;

  /// Whether the button should jiggle when the pulse effect is shown.
  final bool showPulseEffectJiggle;

  /// Whether the button should show a scale animation.
  final bool showScaleAnimation;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The border color of the button.
  final Color? borderColor;

  /// The text color of the button.
  final Color? textColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the hover effect.
  final Color? hoverEffectColor;

  /// The color of the pulse effect.
  final Color? pulseEffectColor;

  /// The duration of the focus effect.
  final Duration? focusEffectDuration;

  /// The duration of the hover effect.
  final Duration? hoverEffectDuration;

  /// The duration of the scale effect.
  final Duration? scaleEffectDuration;

  /// The duration of the pulse effect.
  final Duration? pulseEffectDuration;

  /// The curve of the focus effect.
  final Curve? focusEffectCurve;

  /// The curve of the hover effect.
  final Curve? hoverEffectCurve;

  /// The curve of the scale effect.
  final Curve? scaleEffectCurve;

  /// The curve of the pulse effect.
  final Curve? pulseEffectCurve;

  /// The padding of the button.
  final EdgeInsets? padding;

  /// The border radius of the button.
  final BorderRadius? borderRadius;

  /// The widget in the left icon slot of the button.
  final Widget? leftIcon;

  /// The widget in the label slot of the button.
  final Widget? label;

  /// The widget in the right icon slot of the button.
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
      height: effectiveHeight,
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
