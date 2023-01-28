import 'package:flutter/material.dart';

import 'package:moon_design/src/control_wrapper.dart';
import 'package:moon_design/src/theme/button_size.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';

class MoonFilledButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final MoonButtonSize? buttonSize;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color? hoverOverlayColor;
  final Duration? hoverAnimationDuration;
  final Duration? scaleAnimationDuration;
  final Curve? hoverAnimationCurve;
  final Curve? scaleAnimationCurve;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Widget? label;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const MoonFilledButton({
    super.key,
    this.onTap,
    this.onLongPress,
    this.buttonSize,
    this.width,
    this.height,
    this.backgroundColor = Colors.blue,
    this.hoverOverlayColor,
    this.hoverAnimationDuration,
    this.hoverAnimationCurve,
    this.scaleAnimationDuration,
    this.scaleAnimationCurve,
    this.padding,
    this.borderRadius,
    this.label,
    this.leftIcon,
    this.rightIcon,
  });

  Color get textColor => backgroundColor.computeLuminance() > 0.5 ? MoonColors.light.bulma : MoonColors.dark.bulma;

  Color get effectiveHoverOverlayColor {
    if (hoverOverlayColor != null) return hoverOverlayColor!;

    return backgroundColor.computeLuminance() > 0.5 ? MoonColors.light.heles : MoonColors.dark.heles;
  }

  Color get hoverColor => Color.alphaBlend(effectiveHoverOverlayColor, backgroundColor);

  @override
  Widget build(BuildContext context) {
    final effectiveGap = buttonSize?.gap ?? 8;
    final effectiveHeight = height ?? buttonSize?.height;
    final effectivePadding = padding ?? buttonSize?.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    final effectiveBorderRadius =
        borderRadius ?? buttonSize?.borderRadius ?? const BorderRadius.all(Radius.circular(8));

    final effectiveHoverAnimationCurve =
        hoverAnimationCurve ?? context.moonTransitions?.buttonHoverEffect.transitionCurve ?? Curves.easeInOut;

    final effectiveHoverAnimationDuration = hoverAnimationDuration ??
        context.moonTransitions?.buttonHoverEffect.transitionDuration ??
        const Duration(milliseconds: 150);

    return MoonControlWrapper(
      onTap: onTap,
      onLongPress: onLongPress,
      semanticTypeIsButton: true,
      borderRadius: effectiveBorderRadius,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        return AnimatedContainer(
          padding: effectivePadding,
          width: width,
          height: effectiveHeight,
          duration: effectiveHoverAnimationDuration,
          curve: effectiveHoverAnimationCurve,
          decoration: BoxDecoration(
            color: isHovered ? hoverColor : backgroundColor,
            borderRadius: effectiveBorderRadius,
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: textColor),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leftIcon != null) ...[
                  Flexible(child: leftIcon!),
                  SizedBox(width: effectiveGap),
                ],
                if (label != null) Flexible(child: label!),
                if (rightIcon != null) ...[
                  SizedBox(width: effectiveGap),
                  Flexible(child: rightIcon!),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
