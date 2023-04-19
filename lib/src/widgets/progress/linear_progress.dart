import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/linear_progress_indicator.dart';

enum MoonLinearProgressSize {
  x6s,
  x5s,
  x4s,
  x3s,
  x2s,
}

class MoonLinearProgress extends StatelessWidget {
  /// Size of the linear progress widget.
  final MoonLinearProgressSize? linearProgressSize;

  /// Value of the linear progress widget.
  final double value;

  /// Height of the linear progress widget.
  final double? height;

  /// Color of the linear progress widget.
  final Color? color;

  /// Background color of the linear progress widget.
  final Color? backgroundColor;

  /// Border radius value of the linear progress widget.
  final BorderRadius? borderRadius;

  /// The semantic label for the linear progress widget.
  final String? semanticLabel;

  /// MDS linear progress widget.
  const MoonLinearProgress({
    super.key,
    this.linearProgressSize,
    required this.value,
    this.height,
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.semanticLabel,
  });

  MoonLinearProgressSizeProperties _getMoonProgressSize(
    BuildContext context,
    MoonLinearProgressSize? moonProgressSize,
  ) {
    switch (moonProgressSize) {
      case MoonLinearProgressSize.x6s:
        return context.moonTheme?.linearProgressTheme.sizes.x6s ?? MoonLinearProgressSizeProperties.x6s;
      case MoonLinearProgressSize.x5s:
        return context.moonTheme?.linearProgressTheme.sizes.x5s ?? MoonLinearProgressSizeProperties.x5s;
      case MoonLinearProgressSize.x4s:
        return context.moonTheme?.linearProgressTheme.sizes.x4s ?? MoonLinearProgressSizeProperties.x4s;
      case MoonLinearProgressSize.x3s:
        return context.moonTheme?.linearProgressTheme.sizes.x3s ?? MoonLinearProgressSizeProperties.x3s;
      case MoonLinearProgressSize.x2s:
        return context.moonTheme?.linearProgressTheme.sizes.x2s ?? MoonLinearProgressSizeProperties.x2s;

      default:
        return context.moonTheme?.linearProgressTheme.sizes.x4s ?? MoonLinearProgressSizeProperties.x4s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor =
        color ?? context.moonTheme?.linearProgressTheme.colors.color ?? MoonColors.light.piccolo;
    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.linearProgressTheme.colors.backgroundColor ?? MoonColors.light.trunks;

    final MoonLinearProgressSizeProperties effectiveProgressSize = _getMoonProgressSize(context, linearProgressSize);
    final BorderRadius effectiveBorderRadius = borderRadius ?? effectiveProgressSize.borderRadius;
    final double effectiveHeight = height ?? effectiveProgressSize.progressHeight;

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: MoonLinearProgressIndicator(
        value: value,
        borderRadius: effectiveBorderRadius,
        minHeight: effectiveHeight,
        color: effectiveColor,
        backgroundColor: effectiveBackgroundColor,
      ),
    );
  }
}
