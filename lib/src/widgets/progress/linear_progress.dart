import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_size_properties.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/linear_progress_indicator.dart';
import 'package:moon_design/src/widgets/progress_pin/pin_style.dart';
import 'package:moon_design/src/widgets/progress_pin/progress_pin.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonLinearProgressSize {
  x6s,
  x5s,
  x4s,
  x3s,
  x2s,
}

class MoonLinearProgress extends StatelessWidget {
  /// Whether to show the thumb and the pin for the linear progress.
  final bool showPin;

  /// Whether to show the [minLabel] widget for the linear progress.
  final bool showMinLabel;

  /// Whether to show the [maxLabel] widget for the linear progress.
  final bool showMaxLabel;

  /// Whether the pin height is added to the linear progress height.
  /// Applies only when both this and [showPin] are true.
  /// Otherwise, the pin acts as an overlay without affecting the linear progress height.
  final bool pinAffectsHeight;

  /// The border radius of the linear progress.
  final BorderRadiusGeometry? borderRadius;

  /// The color of the linear progress.
  final Color? color;

  /// The background color of the linear progress.
  final Color? backgroundColor;

  /// The text color of the [minLabel] and [maxLabel] widgets.
  final Color? textColor;

  /// The height of the linear progress.
  final double? height;

  /// The vertical gap between the linear progress and the [minLabel] and [maxLabel] widgets.
  ///
  /// Has effect only if [showMinLabel] and [showMaxLabel] are true.
  final double? verticalGap;

  /// The progress value of the linear progress.
  final double value;

  /// The size of the linear progress.
  final MoonLinearProgressSize? linearProgressSize;

  /// The styling options for the linear progress pin.
  final PinStyle? pinStyle;

  /// The semantic label for the linear progress.
  final String? semanticLabel;

  /// The widget to display the minimum progress value of the linear progress.
  final Widget? minLabel;

  /// The widget to display the maximum progress value of the linear progress.
  final Widget? maxLabel;

  /// Creates a Moon Design linear progress.
  const MoonLinearProgress({
    super.key,
    this.showPin = false,
    this.showMinLabel = false,
    this.showMaxLabel = false,
    this.pinAffectsHeight = true,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.verticalGap,
    required this.value,
    this.linearProgressSize,
    this.pinStyle,
    this.semanticLabel,
    this.minLabel,
    this.maxLabel,
  });

  MoonLinearProgressSizeProperties _getMoonProgressSize(
    BuildContext context,
    MoonLinearProgressSize? moonProgressSize,
  ) {
    switch (moonProgressSize) {
      case MoonLinearProgressSize.x6s:
        return context.moonTheme?.linearProgressTheme.sizes.x6s ??
            MoonLinearProgressSizes(tokens: MoonTokens.light).x6s;
      case MoonLinearProgressSize.x5s:
        return context.moonTheme?.linearProgressTheme.sizes.x5s ??
            MoonLinearProgressSizes(tokens: MoonTokens.light).x5s;
      case MoonLinearProgressSize.x4s:
        return context.moonTheme?.linearProgressTheme.sizes.x4s ??
            MoonLinearProgressSizes(tokens: MoonTokens.light).x4s;
      case MoonLinearProgressSize.x3s:
        return context.moonTheme?.linearProgressTheme.sizes.x3s ??
            MoonLinearProgressSizes(tokens: MoonTokens.light).x3s;
      case MoonLinearProgressSize.x2s:
        return context.moonTheme?.linearProgressTheme.sizes.x2s ??
            MoonLinearProgressSizes(tokens: MoonTokens.light).x2s;
      default:
        return context.moonTheme?.linearProgressTheme.sizes.x4s ??
            MoonLinearProgressSizes(tokens: MoonTokens.light).x4s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonLinearProgressSizeProperties effectiveProgressSize = _getMoonProgressSize(context, linearProgressSize);

    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ?? effectiveProgressSize.borderRadius;

    // This is used to ensure that the corners of the progress bar properly touch the thumb with bigger bar variants.
    final BorderRadiusGeometry progressRadius = switch (effectiveBorderRadius) {
      BorderRadiusDirectional() when showPin == true => BorderRadiusDirectional.only(
          topStart: effectiveBorderRadius.topStart,
          bottomStart: effectiveBorderRadius.bottomStart,
        ),
      BorderRadius() when showPin == true => BorderRadiusDirectional.only(
          topStart: effectiveBorderRadius.topLeft,
          bottomStart: effectiveBorderRadius.bottomLeft,
        ),
      _ => effectiveBorderRadius,
    };

    final Color effectiveColor =
        color ?? context.moonTheme?.linearProgressTheme.colors.color ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.linearProgressTheme.colors.backgroundColor ?? MoonColors.light.beerus;

    final Color effectiveTextColor =
        textColor ?? context.moonTheme?.linearProgressTheme.colors.textColor ?? MoonColors.light.textPrimary;

    final double effectiveHeight = height ?? effectiveProgressSize.progressHeight;

    final double effectiveVerticalGap = verticalGap ?? effectiveProgressSize.verticalGap;

    final double effectiveThumbSizeValue =
        // ignore: deprecated_member_use_from_same_package
        (pinStyle?.thumbSizeValue ?? pinStyle?.thumbWidth) ?? effectiveProgressSize.thumbSizeValue;

    final double effectivePinWidth =
        pinStyle?.pinWidth ?? context.moonTheme?.progressPinTheme.properties.pinWidth ?? 36;

    final double effectivePinDistance =
        pinStyle?.pinDistance ?? context.moonTheme?.progressPinTheme.properties.pinDistance ?? MoonSizes.sizes.x5s;

    final double effectivePinArrowHeight =
        pinStyle?.arrowHeight ?? context.moonTheme?.progressPinTheme.properties.arrowHeight ?? 6;

    final TextStyle effectiveTextStyle = effectiveProgressSize.textStyle;

    final double resolvedPaddingValue =
        effectiveThumbSizeValue - effectiveHeight > 0 ? effectiveThumbSizeValue / 2 - effectiveHeight / 2 : 0;

    final double heightWithPin =
        effectivePinWidth + effectivePinArrowHeight + effectivePinDistance + effectiveThumbSizeValue;

    Widget child = MoonLinearProgressIndicator(
      value: value,
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
      containerRadius: effectiveBorderRadius,
      progressRadius: showPin ? progressRadius : effectiveBorderRadius,
      minHeight: effectiveHeight,
    );

    if (showPin) {
      child = MoonProgressPin(
        progressValue: value,
        pinText: '${(value * 100).round()}%',
        pinStyle: pinStyle?.copyWith(thumbSizeValue: effectiveThumbSizeValue),
        child: child,
      );
    }

    if (showMinLabel || showMaxLabel) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showMinLabel)
                Expanded(
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: minLabel ?? const Text("0%"),
                    ),
                  ),
                ),
              if (showMaxLabel)
                Expanded(
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: maxLabel ?? const Text("100%"),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: effectiveVerticalGap),
          child,
        ],
      );
    }

    if (showPin && pinAffectsHeight) {
      child = Container(
        height: heightWithPin,
        padding: EdgeInsets.only(bottom: resolvedPaddingValue),
        alignment: Alignment.bottomCenter,
        child: child,
      );
    }

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: child,
    );
  }
}
