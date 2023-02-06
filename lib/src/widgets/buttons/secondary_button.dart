import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class MoonSecondaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ButtonSize? buttonSize;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final double? width;
  final double? height;
  final double minTouchTargetSize;
  final bool ensureMinimalTouchTargetSize;
  final bool autofocus;
  final bool isFocusable;
  final bool isFullWidth;
  final bool showPulseEffect;
  final Widget? label;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const MoonSecondaryButton({
    super.key,
    this.onTap,
    this.onLongPress,
    this.buttonSize,
    this.focusNode,
    this.semanticLabel,
    this.width,
    this.height,
    this.minTouchTargetSize = 40,
    this.ensureMinimalTouchTargetSize = false,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.label,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MoonButton(
      onTap: onTap,
      onLongPress: onLongPress,
      buttonSize: buttonSize,
      focusNode: focusNode,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
      minTouchTargetSize: minTouchTargetSize,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      autofocus: autofocus,
      isFocusable: isFocusable,
      isFullWidth: isFullWidth,
      showPulseEffect: showPulseEffect,
      showBorder: true,
      label: label,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
    );
  }
}
