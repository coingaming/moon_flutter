import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';

class MoonTextArea extends StatelessWidget {
  final Color? backgroundColor;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorBorderColor;
  final Color? focusBorderColor;
  final Color? hintTextColor;
  final BorderRadius? borderRadius;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;

  const MoonTextArea({
    super.key,
    this.backgroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.focusBorderColor,
    this.hintTextColor,
    this.borderRadius,
    this.transitionDuration,
    this.transitionCurve,
    this.hintText,
    this.textStyle,
    this.errorTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.textAreaTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveActiveBorderColor =
        activeBorderColor ?? context.moonTheme?.textAreaTheme.colors.activeBorderColor ?? MoonColors.light.piccolo;

    final Color effectiveInactiveBorderColor =
        inactiveBorderColor ?? context.moonTheme?.textAreaTheme.colors.inactiveBorderColor ?? MoonColors.light.beerus;

    final Color effectiveErrorBorderColor =
        errorBorderColor ?? context.moonTheme?.textAreaTheme.colors.errorBorderColor ?? MoonColors.light.chiChi100;

    final Color effectiveFocusBorderColor =
        focusBorderColor ?? context.moonTheme?.textAreaTheme.colors.focusBorderColor ?? MoonColors.light.piccolo;

    final Color effectiveHintTextColor =
        hintTextColor ?? context.moonTheme?.textAreaTheme.colors.hintTextColor ?? MoonColors.light.trunks;

    final BorderRadius effectiveBorderRadius =
        borderRadius ?? context.moonTheme?.textAreaTheme.properties.borderRadius ?? BorderRadius.circular(8);

    final Duration effectiveTransitionDuration = transitionDuration ??
        context.moonTheme?.textAreaTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        transitionCurve ?? context.moonTheme?.textAreaTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final TextStyle effectiveTextStyle =
        textStyle ?? context.moonTheme?.textAreaTheme.properties.textStyle ?? const TextStyle(fontSize: 16);

    final TextStyle effectiveErrorTextStyle =
        errorTextStyle ?? context.moonTheme?.textAreaTheme.properties.errorTextStyle ?? const TextStyle(fontSize: 12);

    return SizedBox(
      height: 300,
      child: TextField(
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        enabled: false,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: SmoothBorderRadius.all(
                  SmoothRadius(cornerRadius: 8, cornerSmoothing: 1))), // Adds a border around the TextField
        ),
      ),
    );
  }
}
