import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/chip/chip_size_properties.dart';
import 'package:moon_design/src/theme/chip/chip_sizes.dart';
import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonChipSize {
  sm,
  md,
}

class MoonChip extends StatefulWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the chip is focusable.
  final bool isFocusable;

  /// Whether to ensure a minimum touch target size for the chip.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the chip is active (selected).
  final bool isActive;

  /// Whether to show a border around the chip.
  final bool showBorder;

  /// Whether to show a focus outline effect when the chip is focused.
  final bool showFocusEffect;

  /// The border radius of the chip.
  final BorderRadiusGeometry? borderRadius;

  /// The text and border color of the chip when [isActive] is true.
  final Color? activeColor;

  /// The background color of the chip.
  final Color? backgroundColor;

  /// The background color of the chip when [isActive] is true.
  final Color? activeBackgroundColor;

  /// The border color of the chip.
  final Color? borderColor;

  /// The color of the chip focus effect.
  final Color? focusEffectColor;

  /// The text color of the chip.
  final Color? textColor;

  /// The custom decoration of the chip.
  final Decoration? decoration;

  /// The border width of the chip.
  final double? borderWidth;

  /// The opacity value of the disabled chip.
  final double? disabledOpacityValue;

  /// The extent of the chip focus effect.
  final double? focusEffectExtent;

  /// The gap between the [leading], [label] and [trailing] widgets of the chip.
  final double? gap;

  /// The height of the chip.
  final double? height;

  /// The width of the chip.
  final double? width;

  /// The minimum size of the chip touch target.
  final double minTouchTargetSize;

  /// The duration of the chip active state effect.
  final Duration? activeEffectDuration;

  /// The duration of the chip focus effect.
  final Duration? focusEffectDuration;

  /// The curve of the chip active state effect.
  final Curve? activeEffectCurve;

  /// The curve of the chip focus effect.
  final Curve? focusEffectCurve;

  /// The padding of the chip.
  final EdgeInsetsGeometry? padding;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The size of the chip.
  final MoonChipSize? chipSize;

  /// The semantic label for the chip.
  final String? semanticLabel;

  /// The callback that is called when the chip is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the chip is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget to display before the [label] widget of the chip.
  final Widget? leading;

  /// The primary content of the chip widget.
  final Widget? label;

  /// The widget to display after the [label] widget of the chip.
  final Widget? trailing;

  /// Creates a Moon Design chip.
  ///
  /// See also:
  ///
  ///   * [MoonChip.text], Moon Design text chip.
  const MoonChip({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isActive = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.borderRadius,
    this.activeColor,
    this.backgroundColor,
    this.activeBackgroundColor,
    this.borderColor,
    this.focusEffectColor,
    this.textColor,
    this.decoration,
    this.borderWidth,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize = 40,
    this.activeEffectDuration,
    this.focusEffectDuration,
    this.activeEffectCurve,
    this.focusEffectCurve,
    this.padding,
    this.focusNode,
    this.chipSize,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  });

  /// Creates a Moon Design text chip.
  const MoonChip.text({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.isActive = false,
    this.showBorder = false,
    this.showFocusEffect = true,
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
    this.activeEffectDuration,
    this.focusEffectCurve,
    this.activeEffectCurve,
    this.padding,
    this.focusNode,
    this.chipSize,
    this.decoration,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  }) : backgroundColor = Colors.transparent;

  @override
  State<MoonChip> createState() => _MoonChipState();
}

class _MoonChipState extends State<MoonChip>
    with SingleTickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _backgroundColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _borderColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _textColorTween =
      ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _backgroundColor;
  Animation<Color?>? _borderColor;
  Animation<Color?>? _textColor;

  AnimationController? _animationController;

  void _handleActiveEffect(bool shouldAnimate) {
    shouldAnimate
        ? _animationController?.forward()
        : _animationController?.reverse();
  }

  MoonChipSizeProperties _getMoonChipSize(
    BuildContext context,
    MoonChipSize? moonChipSize,
  ) {
    switch (moonChipSize) {
      case MoonChipSize.sm:
        return context.moonTheme?.chipTheme.sizes.sm ??
            MoonChipSizes(tokens: MoonTokens.light).sm;
      case MoonChipSize.md:
        return context.moonTheme?.chipTheme.sizes.md ??
            MoonChipSizes(tokens: MoonTokens.light).md;
      default:
        return context.moonTheme?.chipTheme.sizes.md ??
            MoonChipSizes(tokens: MoonTokens.light).md;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoonChipSizeProperties effectiveMoonChipSize =
        _getMoonChipSize(context, widget.chipSize);

    final BorderRadiusGeometry effectiveBorderRadius =
        widget.borderRadius ?? effectiveMoonChipSize.borderRadius;

    final double effectiveBorderWidth = widget.borderWidth ??
        context.moonBorders?.defaultBorderWidth ??
        MoonBorders.borders.defaultBorderWidth;

    final double effectiveHeight =
        widget.height ?? effectiveMoonChipSize.height;

    final double effectiveGap = widget.gap ?? effectiveMoonChipSize.gap;

    final Color effectiveActiveColor = widget.activeColor ??
        context.moonTheme?.chipTheme.colors.activeColor ??
        MoonColors.light.piccolo;

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.chipTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveActiveBackgroundColor = widget.activeBackgroundColor ??
        context.moonTheme?.chipTheme.colors.activeBackgroundColor ??
        MoonColors.light.jiren;

    final Color effectiveTextColor = widget.textColor ??
        context.moonTheme?.chipTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    final Duration effectiveActiveEffectDuration =
        widget.activeEffectDuration ??
            context.moonEffects?.controlHoverEffect.hoverDuration ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlHoverEffect
                .hoverDuration;

    final Curve effectiveActiveEffectCurve = widget.activeEffectCurve ??
        context.moonEffects?.controlHoverEffect.hoverCurve ??
        MoonEffectsTheme(tokens: MoonTokens.light)
            .controlHoverEffect
            .hoverCurve;

    final EdgeInsetsGeometry effectivePadding =
        widget.padding ?? effectiveMoonChipSize.padding;

    final EdgeInsets resolvedDirectionalPadding =
        effectivePadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedPadding = widget.padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.leading == null && widget.label != null
                ? resolvedDirectionalPadding.left
                : 0,
            resolvedDirectionalPadding.top,
            widget.trailing == null && widget.label != null
                ? resolvedDirectionalPadding.right
                : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    _animationController ??= AnimationController(
      duration: effectiveActiveEffectDuration,
      vsync: this,
    );

    _backgroundColor ??= _animationController!.drive(
      _backgroundColorTween
          .chain(CurveTween(curve: effectiveActiveEffectCurve)),
    );

    _borderColor ??= _animationController!.drive(
      _borderColorTween.chain(CurveTween(curve: effectiveActiveEffectCurve)),
    );

    _textColor ??= _animationController!.drive(
      _textColorTween.chain(CurveTween(curve: effectiveActiveEffectCurve)),
    );

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
      borderRadius: effectiveBorderRadius,
      backgroundColor: widget.backgroundColor,
      focusEffectColor: widget.focusEffectColor,
      disabledOpacityValue: widget.disabledOpacityValue,
      minTouchTargetSize: widget.minTouchTargetSize,
      focusEffectExtent: widget.focusEffectExtent,
      focusEffectDuration: widget.focusEffectDuration,
      focusEffectCurve: widget.focusEffectCurve,
      focusNode: widget.focusNode,
      semanticLabel: widget.semanticLabel,
      onTap: widget.onTap ?? () {},
      onLongPress: widget.onLongPress,
      builder: (
        BuildContext context,
        bool isEnabled,
        bool isHovered,
        bool isFocused,
        bool isPressed,
      ) {
        final bool canAnimate = widget.isActive || isHovered || isFocused;

        _handleActiveEffect(canAnimate);

        return AnimatedBuilder(
          animation: _animationController!,
          builder: (BuildContext context, Widget? child) {
            return IconTheme(
              data: IconThemeData(
                color: _textColor!.value,
                size: effectiveMoonChipSize.iconSizeValue,
              ),
              child: DefaultTextStyle(
                style: effectiveMoonChipSize.textStyle
                    .copyWith(color: _textColor!.value),
                child: Container(
                  width: widget.width,
                  height: effectiveHeight,
                  padding: correctedPadding,
                  constraints: BoxConstraints(minWidth: effectiveHeight),
                  decoration: widget.decoration ??
                      ShapeDecoration(
                        color: _backgroundColor!.value,
                        shape: MoonSquircleBorder(
                          borderRadius: effectiveBorderRadius
                              .squircleBorderRadius(context),
                          side: BorderSide(
                            color: widget.showBorder
                                ? _borderColor!.value!
                                : Colors.transparent,
                            width: widget.showBorder ? effectiveBorderWidth : 0,
                            style: widget.showBorder
                                ? BorderStyle.solid
                                : BorderStyle.none,
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
