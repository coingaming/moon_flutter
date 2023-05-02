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

  /// The semantic label for the linear progress widget.
  final String? semanticLabel;

  /// MDS linear progress widget.
  const MoonLinearProgress({
    super.key,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.height,
    required this.value,
    this.linearProgressSize,
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
    final MoonLinearProgressSizeProperties effectiveProgressSize = _getMoonProgressSize(context, linearProgressSize);

    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ?? effectiveProgressSize.borderRadius;

    final Color effectiveColor =
        color ?? context.moonTheme?.linearProgressTheme.colors.color ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.linearProgressTheme.colors.backgroundColor ?? MoonColors.light.trunks;

    final double effectiveHeight = height ?? effectiveProgressSize.progressHeight;

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: MoonLinearProgressIndicator(
        borderRadius: effectiveBorderRadius,
        value: value,
        color: effectiveColor,
        backgroundColor: effectiveBackgroundColor,
        minHeight: effectiveHeight,
      ),
    );
  }
}
