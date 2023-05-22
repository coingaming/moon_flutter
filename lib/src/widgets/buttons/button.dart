import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/button/button_size_properties.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
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
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the button should be focusable.
  final bool isFocusable;

  /// Whether this button should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the button should be full width.
  final bool isFullWidth;

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

  /// Whether the button should show a tooltip.
  final bool showTooltip;

  /// The border radius of the button.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The border color of the button.
  final Color? borderColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the hover effect.
  final Color? hoverEffectColor;

  /// The color of the pulse effect.
  final Color? pulseEffectColor;

  /// The text color of the button.
  final Color? textColor;

  /// The border width of the button.
  final double? borderWidth;

  /// The opacity value of the button when it is disabled.
  final double? disabledOpacityValue;

  /// The gap between the leading or trailing and the label widgets.
  final double? gap;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// The extent of the focus effect.
  final double? focusEffectExtent;

  /// The extent of the pulse effect.
  final double? pulseEffectExtent;

  /// The scalar controlling the scaling of the scale effect.
  final double? scaleEffectScalar;

  /// The duration of the focus effect.
  final Duration? focusEffectDuration;

  /// The duration of the hover effect.
  final Duration? hoverEffectDuration;

  /// The duration of the pulse effect.
  final Duration? pulseEffectDuration;

  /// The duration of the scale effect.
  final Duration? scaleEffectDuration;

  /// The curve of the focus effect.
  final Curve? focusEffectCurve;

  /// The curve of the hover effect.
  final Curve? hoverEffectCurve;

  /// The curve of the pulse effect.
  final Curve? pulseEffectCurve;

  /// The curve of the scale effect.
  final Curve? scaleEffectCurve;

  /// The padding of the button.
  final EdgeInsetsGeometry? padding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The size of the button.
  final MoonButtonSize? buttonSize;

  /// Custom decoration for the button.
  final Decoration? decoration;

  /// The semantic label for the button.
  final String? semanticLabel;

  /// The tooltip message for the button.
  final String tooltipMessage;

  /// The callback that is called when the button is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget in the leading slot of the button.
  final Widget? leading;

  /// The widget in the label slot of the button.
  final Widget? label;

  /// The widget in the trailing slot of the button.
  final Widget? trailing;

  /// MDS base button.
  ///
  /// See also:
  ///
  ///   * [MoonFilledButton], MDS filled button.
  ///   * [MoonOutlinedButton], MDS outlined button.
  ///   * [MoonTextButton], MDS text button.
  const MoonButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isFullWidth = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.showTooltip = false,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusEffectColor,
    this.hoverEffectColor,
    this.pulseEffectColor,
    this.textColor,
    this.borderWidth,
    this.disabledOpacityValue,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectScalar,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.pulseEffectCurve,
    this.scaleEffectCurve,
    this.padding,
    this.focusNode,
    this.buttonSize,
    this.decoration,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  /// Constructor for creating explicit icon button.
  factory MoonButton.icon({
    bool autofocus = false,
    bool isFocusable = true,
    bool ensureMinimalTouchTargetSize = false,
    bool showBorder = false,
    bool showFocusEffect = true,
    bool showPulseEffect = false,
    bool showPulseEffectJiggle = true,
    bool showScaleAnimation = true,
    bool showTooltip = false,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    Color? borderColor,
    Color? focusEffectColor,
    Color? hoverEffectColor,
    Color? pulseEffectColor,
    double? borderWidth,
    double? disabledOpacityValue,
    double? gap,
    double? height,
    double? width,
    double minTouchTargetSize = 40,
    double? focusEffectExtent,
    double? pulseEffectExtent,
    double? scaleEffectScalar,
    Duration? focusEffectDuration,
    Duration? hoverEffectDuration,
    Duration? pulseEffectDuration,
    Duration? scaleEffectDuration,
    Curve? focusEffectCurve,
    Curve? hoverEffectCurve,
    Curve? pulseEffectCurve,
    Curve? scaleEffectCurve,
    FocusNode? focusNode,
    EdgeInsetsGeometry? padding,
    MoonButtonSize? buttonSize,
    Decoration? decoration,
    String? semanticLabel,
    String tooltipMessage = "",
    VoidCallback? onLongPress,
    VoidCallback? onTap,
    Widget? icon,
  }) {
    return MoonButton(
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      showBorder: showBorder,
      showFocusEffect: showFocusEffect,
      showPulseEffect: showPulseEffect,
      showPulseEffectJiggle: showPulseEffectJiggle,
      showScaleAnimation: showScaleAnimation,
      showTooltip: showTooltip,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      focusEffectColor: focusEffectColor,
      hoverEffectColor: hoverEffectColor,
      pulseEffectColor: pulseEffectColor,
      borderWidth: borderWidth,
      disabledOpacityValue: disabledOpacityValue,
      gap: gap,
      height: height,
      width: width,
      minTouchTargetSize: minTouchTargetSize,
      focusEffectExtent: focusEffectExtent,
      pulseEffectExtent: pulseEffectExtent,
      scaleEffectScalar: scaleEffectScalar,
      focusEffectDuration: focusEffectDuration,
      hoverEffectDuration: hoverEffectDuration,
      pulseEffectDuration: pulseEffectDuration,
      scaleEffectDuration: scaleEffectDuration,
      focusEffectCurve: focusEffectCurve,
      hoverEffectCurve: hoverEffectCurve,
      pulseEffectCurve: pulseEffectCurve,
      scaleEffectCurve: scaleEffectCurve,
      focusNode: focusNode,
      padding: padding,
      buttonSize: buttonSize,
      decoration: decoration,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      onLongPress: onLongPress,
      onTap: onTap,
      leading: icon,
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

    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ?? effectiveMoonButtonSize.borderRadius;

    final Color effectiveBorderColor =
        borderColor ?? context.moonTheme?.buttonTheme.colors.borderColor ?? MoonColors.light.trunks;

    final double effectiveBorderWidth =
        borderWidth ?? context.moonBorders?.defaultBorderWidth ?? MoonBorders.borders.defaultBorderWidth;

    final Color effectiveHoverEffectColor = hoverEffectColor ??
        context.moonEffects?.controlHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightHoverEffect.primaryHoverColor;

    final Color hoverColor = Color.alphaBlend(effectiveHoverEffectColor, backgroundColor ?? Colors.transparent);

    final double effectiveHeight = height ?? effectiveMoonButtonSize.height;

    final double effectiveGap = gap ?? effectiveMoonButtonSize.gap;

    final EdgeInsetsGeometry effectivePadding = padding ?? effectiveMoonButtonSize.padding;

    final EdgeInsets resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedPadding = padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            leading == null && label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            trailing == null && label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    final Duration effectiveHoverEffectDuration = hoverEffectDuration ??
        context.moonEffects?.controlHoverEffect.hoverDuration ??
        MoonHoverEffects.lightHoverEffect.hoverDuration;

    final Curve effectiveHoverEffectCurve = hoverEffectCurve ??
        context.moonEffects?.controlHoverEffect.hoverCurve ??
        MoonHoverEffects.lightHoverEffect.hoverCurve;

    return MoonBaseControl(
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      semanticTypeIsButton: true,
      showFocusEffect: showFocusEffect,
      showPulseEffect: showPulseEffect,
      showPulseEffectJiggle: showPulseEffectJiggle,
      showScaleAnimation: showScaleAnimation,
      showTooltip: showTooltip,
      borderRadius: effectiveBorderRadius,
      backgroundColor: backgroundColor,
      focusEffectColor: focusEffectColor,
      pulseEffectColor: pulseEffectColor,
      disabledOpacityValue: disabledOpacityValue,
      minTouchTargetSize: minTouchTargetSize,
      focusEffectExtent: focusEffectExtent,
      pulseEffectExtent: pulseEffectExtent,
      scaleEffectScalar: scaleEffectScalar,
      focusEffectDuration: focusEffectDuration,
      pulseEffectDuration: pulseEffectDuration,
      scaleEffectDuration: scaleEffectDuration,
      focusEffectCurve: focusEffectCurve,
      pulseEffectCurve: pulseEffectCurve,
      scaleEffectCurve: scaleEffectCurve,
      focusNode: focusNode,
      semanticLabel: semanticLabel,
      tooltipMessage: tooltipMessage,
      onTap: onTap,
      onLongPress: onLongPress,
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
          decoration: decoration ??
              ShapeDecorationWithPremultipliedAlpha(
                color: canAnimateHover ? hoverColor : backgroundColor,
                shape: MoonSquircleBorder(
                  side: BorderSide(
                    color: effectiveBorderColor,
                    width: showBorder ? effectiveBorderWidth : 0,
                    style: showBorder ? BorderStyle.solid : BorderStyle.none,
                  ),
                  borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
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
                          if (leading != null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: effectiveGap),
                              alignment: Directionality.of(context) == TextDirection.ltr
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: leading,
                            ),
                          if (label != null)
                            Align(
                              child: label,
                            ),
                          if (trailing != null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: effectiveGap),
                              alignment: Directionality.of(context) == TextDirection.ltr
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: trailing,
                            ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (leading != null)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                              child: leading,
                            ),
                          if (label != null) label!,
                          if (trailing != null)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                              child: trailing,
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
