import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button/button_size_properties.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/common/animated_icon_theme.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';

enum MoonButtonSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

class MoonButton extends StatelessWidget {
  /// The callback that is called when the button is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// The size of the button.
  final MoonButtonSize? buttonSize;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The semantic label for the button.
  final String? semanticLabel;

  /// The tooltip message for the button.
  final String tooltipMessage;

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

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the button should be focusable.
  final bool isFocusable;

  /// Whether the button should be full width.
  final bool isFullWidth;

  /// Whether this button should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the button should show a border.
  final bool showBorder;

  /// Whether the button should show a tooltip.
  final bool showTooltip;

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

  /// MDS base button.
  ///
  /// See also:
  ///
  ///   * [MoonFilledButton], MDS filled button.
  ///   * [MoonOutlinedButton], MDS outlined button.
  ///   * [MoonTextButton], MDS text button.
  const MoonButton({
    super.key,
    this.onTap,
    this.onLongPress,
    this.buttonSize,
    this.focusNode,
    this.semanticLabel,
    this.tooltipMessage = "",
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
    this.showTooltip = false,
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
    this.leftIcon,
    this.label,
    this.rightIcon,
  });

  /// Constructor for creating explicit icon button.
  factory MoonButton.icon({
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    MoonButtonSize? buttonSize,
    FocusNode? focusNode,
    String? semanticLabel,
    String tooltipMessage = "",
    double? width,
    double? height,
    double? disabledOpacityValue,
    double? borderWidth,
    double? gap,
    double? focusEffectExtent,
    double? pulseEffectExtent,
    double? scaleEffectScalar,
    double minTouchTargetSize = 40,
    bool autofocus = false,
    bool isFocusable = true,
    bool ensureMinimalTouchTargetSize = false,
    bool showBorder = false,
    bool showTooltip = false,
    bool showFocusEffect = true,
    bool showPulseEffect = false,
    bool showPulseEffectJiggle = true,
    bool showScaleAnimation = true,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    Color? focusEffectColor,
    Color? hoverEffectColor,
    Color? pulseEffectColor,
    Duration? focusEffectDuration,
    Duration? hoverEffectDuration,
    Duration? scaleEffectDuration,
    Duration? pulseEffectDuration,
    Curve? focusEffectCurve,
    Curve? hoverEffectCurve,
    Curve? scaleEffectCurve,
    Curve? pulseEffectCurve,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Widget? icon,
  }) {
    return MoonButton(
      onTap: onTap,
      onLongPress: onLongPress,
      buttonSize: buttonSize,
      focusNode: focusNode,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      width: width,
      height: height,
      disabledOpacityValue: disabledOpacityValue,
      borderWidth: borderWidth,
      gap: gap,
      focusEffectExtent: focusEffectExtent,
      pulseEffectExtent: pulseEffectExtent,
      scaleEffectScalar: scaleEffectScalar,
      minTouchTargetSize: minTouchTargetSize,
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      showBorder: showBorder,
      showTooltip: showTooltip,
      showFocusEffect: showFocusEffect,
      showPulseEffect: showPulseEffect,
      showPulseEffectJiggle: showPulseEffectJiggle,
      showScaleAnimation: showScaleAnimation,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      textColor: textColor,
      focusEffectColor: focusEffectColor,
      hoverEffectColor: hoverEffectColor,
      pulseEffectColor: pulseEffectColor,
      focusEffectDuration: focusEffectDuration,
      hoverEffectDuration: hoverEffectDuration,
      scaleEffectDuration: scaleEffectDuration,
      pulseEffectDuration: pulseEffectDuration,
      focusEffectCurve: focusEffectCurve,
      hoverEffectCurve: hoverEffectCurve,
      scaleEffectCurve: scaleEffectCurve,
      pulseEffectCurve: pulseEffectCurve,
      padding: padding,
      borderRadius: borderRadius,
      leftIcon: icon,
    );
  }

  bool get _isEnabled => onTap != null || onLongPress != null;

  MoonButtonSizeProperties _getMoonButtonSize(BuildContext context, MoonButtonSize? moonButtonSize) {
    switch (moonButtonSize) {
      case MoonButtonSize.xs:
        return context.moonTheme?.buttonTheme.sizes.xs ?? MoonButtonSizeProperties.xs;
      case MoonButtonSize.sm:
        return context.moonTheme?.buttonTheme.sizes.sm ?? MoonButtonSizeProperties.sm;
      case MoonButtonSize.md:
        return context.moonTheme?.buttonTheme.sizes.md ?? MoonButtonSizeProperties.md;
      case MoonButtonSize.lg:
        return context.moonTheme?.buttonTheme.sizes.lg ?? MoonButtonSizeProperties.lg;
      case MoonButtonSize.xl:
        return context.moonTheme?.buttonTheme.sizes.xl ?? MoonButtonSizeProperties.xl;
      default:
        return context.moonTheme?.buttonTheme.sizes.md ?? MoonButtonSizeProperties.md;
    }
  }

  Color _getTextColor(
    BuildContext context, {
    required bool isDarkMode,
    required bool isHovered,
    required bool isFocused,
  }) {
    if (textColor != null && (!isHovered && !isFocused)) return textColor!;
    if (backgroundColor == null && context.moonTypography != null) return context.moonTypography!.colors.bodyPrimary;

    final backgroundLuminance = backgroundColor!.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonButtonSizeProperties effectiveMoonButtonSize = _getMoonButtonSize(context, buttonSize);

    final double effectiveHeight = height ?? effectiveMoonButtonSize.height;
    final double effectiveGap = gap ?? effectiveMoonButtonSize.gap;
    final EdgeInsets effectivePadding = padding ?? effectiveMoonButtonSize.padding;

    final EdgeInsetsDirectional correctedPadding = EdgeInsetsDirectional.fromSTEB(
      leftIcon == null && label != null ? effectivePadding.left : 0,
      effectivePadding.top,
      rightIcon == null && label != null ? effectivePadding.right : 0,
      effectivePadding.bottom,
    );

    final Color effectiveBorderColor =
        borderColor ?? context.moonTheme?.buttonTheme.colors.borderColor ?? MoonColors.light.trunks;
    final BorderRadius effectiveBorderRadius = borderRadius ?? effectiveMoonButtonSize.borderRadius;

    final double effectiveBorderWidth =
        borderWidth ?? context.moonBorders?.borderWidth ?? MoonBorders.borders.borderWidth;

    final Color effectiveHoverEffectColor = hoverEffectColor ??
        context.moonEffects?.controlHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightHoverEffect.primaryHoverColor;

    final Color hoverColor = Color.alphaBlend(effectiveHoverEffectColor, backgroundColor ?? Colors.transparent);

    final Curve effectiveHoverEffectCurve = hoverEffectCurve ??
        context.moonEffects?.controlHoverEffect.hoverCurve ??
        MoonHoverEffects.lightHoverEffect.hoverCurve;

    final Duration effectiveHoverEffectDuration = hoverEffectDuration ??
        context.moonEffects?.controlHoverEffect.hoverDuration ??
        MoonHoverEffects.lightHoverEffect.hoverDuration;

    return MoonBaseControl(
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      semanticTypeIsButton: true,
      borderRadius: effectiveBorderRadius,
      disabledOpacityValue: disabledOpacityValue,
      minTouchTargetSize: minTouchTargetSize,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      focusNode: focusNode,
      autofocus: autofocus,
      isFocusable: isFocusable,
      backgroundColor: backgroundColor,
      showTooltip: showTooltip,
      showFocusEffect: showFocusEffect,
      focusEffectColor: focusEffectColor,
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
        final Color effectiveTextColor =
            _getTextColor(context, isDarkMode: context.isDarkMode, isHovered: isHovered, isFocused: isFocused);

        final bool canAnimateHover = _isEnabled && (isHovered || isFocused || isPressed);

        return AnimatedContainer(
          duration: effectiveHoverEffectDuration,
          curve: effectiveHoverEffectCurve,
          width: width,
          height: effectiveHeight,
          constraints: BoxConstraints(minWidth: effectiveHeight),
          decoration: ShapeDecoration(
            color: canAnimateHover ? hoverColor : backgroundColor,
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
          child: Padding(
            padding: isFullWidth ? EdgeInsets.zero : correctedPadding,
            child: AnimatedIconTheme(
              duration: effectiveHoverEffectDuration,
              color: effectiveTextColor,
              size: effectiveMoonButtonSize.iconSizeValue,
              child: AnimatedDefaultTextStyle(
                style: TextStyle(color: effectiveTextColor, fontSize: effectiveMoonButtonSize.textStyle.fontSize),
                duration: effectiveHoverEffectDuration,
                child: isFullWidth
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          if (leftIcon != null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: effectiveGap),
                              alignment: Directionality.of(context) == TextDirection.ltr
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: leftIcon,
                            ),
                          if (label != null)
                            Align(
                              child: label,
                            ),
                          if (rightIcon != null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: effectiveGap),
                              alignment: Directionality.of(context) == TextDirection.ltr
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: rightIcon,
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
            ),
          ),
        );
      },
    );
  }
}
