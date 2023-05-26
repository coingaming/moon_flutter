import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/chip/chip_size_properties.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';

enum MoonChipSize {
  sm,
  md,
}

class MoonChip extends StatefulWidget {
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

  /// The border and text color of the chip when active.
  final Color? activeColor;

  /// The background color of the chip.
  final Color? backgroundColor;

  /// The background color of the chip when active.
  final Color? activeBackgroundColor;

  /// The border color of the  chip.
  final Color? borderColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

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

  /// Custom decoration for the chip.
  final Decoration? decoration;

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
    this.activeBackgroundColor,
    this.borderColor,
    this.focusEffectColor,
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
    this.decoration,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  });

  /// MDS chip widget text variant
  const MoonChip.text({
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
    this.activeBackgroundColor,
    this.borderColor,
    this.focusEffectColor,
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
    this.decoration,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  }) : backgroundColor = Colors.transparent;

  @override
  State<MoonChip> createState() => _MoonChipState();
}

class _MoonChipState extends State<MoonChip> with SingleTickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _backgroundColorTween = ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _borderColorTween = ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _textColorTween = ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _backgroundColor;
  Animation<Color?>? _borderColor;
  Animation<Color?>? _textColor;

  AnimationController? _animationController;

  void _handleHoverEffect(bool shouldAnimate) {
    if (shouldAnimate) {
      _animationController?.forward();
    } else {
      _animationController?.reverse();
    }
  }

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

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoonChipSizeProperties effectiveMoonChipSize = _getMoonChipSize(context, widget.chipSize);

    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ?? effectiveMoonChipSize.borderRadius;

    final double effectiveBorderWidth =
        widget.borderWidth ?? context.moonBorders?.defaultBorderWidth ?? MoonBorders.borders.defaultBorderWidth;

    final double effectiveHeight = widget.height ?? effectiveMoonChipSize.height;

    final double effectiveGap = widget.gap ?? effectiveMoonChipSize.gap;

    final Color effectiveActiveColor =
        widget.activeColor ?? context.moonTheme?.chipTheme.colors.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.chipTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveActiveBackgroundColor = widget.activeBackgroundColor ??
        context.moonTheme?.chipTheme.colors.activeBackgroundColor ??
        MoonColors.light.jiren;

    final Color effectiveTextColor =
        widget.textColor ?? context.moonTheme?.chipTheme.colors.textColor ?? MoonTypography.light.colors.bodyPrimary;

    final Curve effectiveHoverEffectCurve = widget.hoverEffectCurve ??
        context.moonEffects?.controlHoverEffect.hoverCurve ??
        MoonHoverEffects.lightHoverEffect.hoverCurve;

    final Duration effectiveHoverEffectDuration = widget.hoverEffectDuration ??
        context.moonEffects?.controlHoverEffect.hoverDuration ??
        MoonHoverEffects.lightHoverEffect.hoverDuration;

    final EdgeInsetsGeometry effectivePadding = widget.padding ?? effectiveMoonChipSize.padding;

    final EdgeInsets resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedPadding = widget.padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.leading == null && widget.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            widget.trailing == null && widget.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    _animationController ??= AnimationController(duration: effectiveHoverEffectDuration, vsync: this);

    _backgroundColor ??=
        _animationController!.drive(_backgroundColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));

    _borderColor ??= _animationController!.drive(_borderColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));

    _textColor ??= _animationController!.drive(_textColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));

    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = effectiveActiveBackgroundColor;

    _borderColorTween
      ..begin = Colors.transparent
      ..end = widget.borderColor ?? effectiveActiveColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveActiveColor;

    return MoonBaseControl(
      autofocus: widget.autofocus,
      isFocusable: widget.isFocusable,
      ensureMinimalTouchTargetSize: widget.ensureMinimalTouchTargetSize,
      showFocusEffect: widget.showFocusEffect,
      showScaleAnimation: false,
      showTooltip: widget.showTooltip,
      borderRadius: effectiveBorderRadius,
      backgroundColor: widget.backgroundColor,
      focusEffectColor: widget.focusEffectColor,
      disabledOpacityValue: widget.disabledOpacityValue,
      minTouchTargetSize: widget.minTouchTargetSize,
      focusEffectExtent: widget.focusEffectExtent,
      focusEffectDuration: widget.focusEffectDuration,
      focusEffectCurve: widget.focusEffectCurve,
      focusNode: widget.focusNode,
      tooltipMessage: widget.tooltipMessage,
      semanticLabel: widget.semanticLabel,
      onTap: widget.onTap ?? () {},
      onLongPress: widget.onLongPress,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final bool canAnimate = widget.isActive || isHovered || isFocused;
        _handleHoverEffect(canAnimate);

        return AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) {
            return IconTheme(
              data: IconThemeData(
                color: _textColor!.value,
                size: effectiveMoonChipSize.iconSizeValue,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: _textColor!.value,
                  fontSize: effectiveMoonChipSize.textStyle.fontSize,
                ),
                child: Container(
                  width: widget.width,
                  height: effectiveHeight,
                  padding: correctedPadding,
                  constraints: BoxConstraints(minWidth: effectiveHeight),
                  decoration: widget.decoration ??
                      ShapeDecoration(
                        color: _backgroundColor!.value,
                        shape: MoonSquircleBorder(
                          borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                          side: BorderSide(
                            color: widget.showBorder ? _borderColor!.value! : Colors.transparent,
                            width: widget.showBorder ? effectiveBorderWidth : 0,
                            style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                          ),
                        ),
                      ),
                  child: child,
                ),
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.leading != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                  child: widget.leading,
                ),
              if (widget.label != null) widget.label!,
              if (widget.trailing != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                  child: widget.trailing,
                ),
            ],
          ),
        );
      },
    );
  }
}
