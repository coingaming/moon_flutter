import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_size_properties.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
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
  /// Show linear progress with thumb and pin.
  final bool showPin;

  /// Border radius value of the linear progress widget.
  final BorderRadiusGeometry? borderRadius;

  /// Color of the linear progress widget.
  final Color? color;

  /// Background color of the linear progress widget.
  final Color? backgroundColor;

  /// Height of the linear progress widget.
  final double? height;

  /// Value of the linear progress widget.
  final double value;

  /// Size of the linear progress widget.
  final MoonLinearProgressSize? linearProgressSize;

  /// Style for the linear progress pin.
  final PinStyle? pinStyle;

  /// The semantic label for the linear progress widget.
  final String? semanticLabel;

  /// MDS linear progress widget.
  const MoonLinearProgress({
    super.key,
    this.showPin = false,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.height,
    required this.value,
    this.linearProgressSize,
    this.pinStyle,
    this.semanticLabel,
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

    final Color effectiveColor =
        color ?? context.moonTheme?.linearProgressTheme.colors.color ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.linearProgressTheme.colors.backgroundColor ?? MoonColors.light.beerus;

    final double effectiveHeight = height ?? effectiveProgressSize.progressHeight;

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: showPin
          ? MoonProgressPin(
              progressValue: value,
              progressLabel: '${(value * 100).round()}%',
              pinStyle: pinStyle,
              child: MoonLinearProgressIndicator(
                value: value,
                color: effectiveColor,
                backgroundColor: effectiveBackgroundColor,
                borderRadius: effectiveBorderRadius,
                minHeight: effectiveHeight,
              ),
            )
          : MoonLinearProgressIndicator(
              value: value,
              color: effectiveColor,
              backgroundColor: effectiveBackgroundColor,
              borderRadius: effectiveBorderRadius,
              minHeight: effectiveHeight,
            ),
    );
  }
}
