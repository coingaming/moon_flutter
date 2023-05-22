import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/chip/chip_size_properties.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/animated_icon_theme.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';

enum MoonChipSize {
  sm,
  md,
}

class MoonChip extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the chip should be focusable.
  final bool isFocusable;

  /// Whether this chip should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the chip is active/selected.
  final bool isActive;

  /// Whether the chip should show a border.
  final bool showBorder;

  /// Whether the chip should show a focus effect.
  final bool showFocusEffect;

  /// Whether the chip should show a tooltip.
  final bool showTooltip;

  /// The border radius of the chip.
  final BorderRadiusGeometry? borderRadius;

  /// The border and text color of the active/selected chip.
  final Color? activeColor;

  /// The background color of the chip.
  final Color? backgroundColor;

  /// The border color of the  chip.
  final Color? borderColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the hover effect.
  final Color? hoverEffectColor;

  /// The text color of the chip.
  final Color? textColor;

  /// The border width of the chip.
  final double? borderWidth;

  /// The opacity value of the chip when it is disabled.
  final double? disabledOpacityValue;

  /// The extent of the focus effect.
  final double? focusEffectExtent;

  /// The gap between the leading or trailing and the label widgets.
  final double? gap;

  /// The height of the chip.
  final double? height;

  /// The width of the chip.
  final double? width;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// The duration of the focus effect.
  final Duration? focusEffectDuration;

  /// The duration of the hover effect.
  final Duration? hoverEffectDuration;

  /// The curve of the focus effect.
  final Curve? focusEffectCurve;

  /// The curve of the hover effect.
  final Curve? hoverEffectCurve;

  /// The padding of the chip.
  final EdgeInsetsGeometry? padding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The size of the chip.
  final MoonChipSize? chipSize;

  /// Custom shape decoration for the chip.
  final Decoration? shapeDecoration;

  /// The semantic label for the chip.
  final String? semanticLabel;

  /// The tooltip message for the chip.
  final String tooltipMessage;

  /// The callback that is called when the chip is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the chip is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget in the leading slot of the chip.
  final Widget? leading;

  /// The widget in the label slot of the chip.
  final Widget? label;

  /// The widget in the trailing slot of the chip.
  final Widget? trailing;

  /// MDS chip widget
  const MoonChip({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isActive = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.showTooltip = false,
    this.borderRadius,
    this.activeColor,
    this.backgroundColor,
    this.borderColor,
    this.focusEffectColor,
    this.hoverEffectColor,
    this.textColor,
    this.borderWidth,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.padding,
    this.focusNode,
    this.chipSize,
    this.shapeDecoration,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  });

  MoonChipSizeProperties _getMoonChipSize(BuildContext context, MoonChipSize? moonChipSize) {
    switch (moonChipSize) {
      case MoonChipSize.sm:
        return context.moonTheme?.chipTheme.sizes.sm ?? MoonChipSizeProperties.sm;
      case MoonChipSize.md:
        return context.moonTheme?.chipTheme.sizes.md ?? MoonChipSizeProperties.md;

      default:
        return context.moonTheme?.chipTheme.sizes.md ?? MoonChipSizeProperties.sm;
    }
  }

  Color _getTextColor({
    required bool isActive,
    required Color activeColor,
    required Color backgroundColor,
    required Color? textColor,
  }) {
    if (isActive) return activeColor;
    if (textColor != null) return textColor;

    final backgroundLuminance = backgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  Color _getBorderColor({required bool isActive, required Color activeColor}) =>
      isActive ? activeColor : borderColor ?? Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final MoonChipSizeProperties effectiveMoonChipSize = _getMoonChipSize(context, chipSize);

    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ?? effectiveMoonChipSize.borderRadius;

    final double effectiveBorderWidth =
        borderWidth ?? context.moonBorders?.defaultBorderWidth ?? MoonBorders.borders.defaultBorderWidth;

    final double effectiveHeight = height ?? effectiveMoonChipSize.height;

    final double effectiveGap = gap ?? effectiveMoonChipSize.gap;

    final Color effectiveActiveColor =
        activeColor ?? context.moonTheme?.chipTheme.colors.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.chipTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveHoverEffectColor = hoverEffectColor ??
        context.moonEffects?.controlHoverEffect.secondaryHoverColor ??
        MoonHoverEffects.lightHoverEffect.secondaryHoverColor;

    final Curve effectiveHoverEffectCurve = hoverEffectCurve ??
        context.moonEffects?.controlHoverEffect.hoverCurve ??
        MoonHoverEffects.lightHoverEffect.hoverCurve;

    final Duration effectiveHoverEffectDuration = hoverEffectDuration ??
        context.moonEffects?.controlHoverEffect.hoverDuration ??
        MoonHoverEffects.lightHoverEffect.hoverDuration;

    final EdgeInsetsGeometry effectivePadding = padding ?? effectiveMoonChipSize.padding;

    final EdgeInsets resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedPadding = padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            leading == null && label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            trailing == null && label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;
    return MoonBaseControl(
      autofocus: autofocus,
      isFocusable: isFocusable,
      ensureMinimalTouchTargetSize: ensureMinimalTouchTargetSize,
      showFocusEffect: showFocusEffect,
      showScaleAnimation: false,
      showTooltip: showTooltip,
      borderRadius: effectiveBorderRadius,
      backgroundColor: backgroundColor,
      focusEffectColor: focusEffectColor,
      disabledOpacityValue: disabledOpacityValue,
      minTouchTargetSize: minTouchTargetSize,
      focusEffectExtent: focusEffectExtent,
      focusEffectDuration: focusEffectDuration,
      focusEffectCurve: focusEffectCurve,
      focusNode: focusNode,
      tooltipMessage: tooltipMessage,
      semanticLabel: semanticLabel,
      onTap: onTap ?? () {},
      onLongPress: onLongPress,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final bool canAnimate = isActive || isHovered || isFocused;

        final Color effectiveBorderColor =
            borderColor ?? _getBorderColor(isActive: canAnimate, activeColor: effectiveActiveColor);

        final Color effectiveTextColor = _getTextColor(
          isActive: canAnimate,
          activeColor: effectiveActiveColor,
          backgroundColor: effectiveBackgroundColor,
          textColor: textColor,
        );

        return AnimatedContainer(
          width: width,
          height: effectiveHeight,
          padding: correctedPadding,
          duration: effectiveHoverEffectDuration,
          curve: effectiveHoverEffectCurve,
          constraints: BoxConstraints(minWidth: effectiveHeight),
          decoration: shapeDecoration ??
              ShapeDecorationWithPremultipliedAlpha(
                color: canAnimate ? effectiveHoverEffectColor : effectiveBackgroundColor,
                shape: MoonSquircleBorder(
                  side: BorderSide(
                    color: effectiveBorderColor,
                    width: showBorder ? effectiveBorderWidth : 0,
                    style: showBorder ? BorderStyle.solid : BorderStyle.none,
                  ),
                  borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                ),
              ),
          child: AnimatedIconTheme(
            duration: effectiveHoverEffectDuration,
            color: effectiveTextColor,
            size: effectiveMoonChipSize.iconSizeValue,
            child: AnimatedDefaultTextStyle(
              duration: effectiveHoverEffectDuration,
              style: TextStyle(fontSize: effectiveMoonChipSize.textStyle.fontSize, color: effectiveTextColor),
              child: Row(
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
        );
      },
    );
  }
}
