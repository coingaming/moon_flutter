import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/progress/linear_progress_sizes.dart';
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
  final MoonLinearProgressSize? loaderSize;
  final double value;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final double? borderRadiusValue;

  const MoonLinearProgress({
    super.key,
    this.loaderSize,
    required this.value,
    this.height,
    this.color,
    this.backgroundColor,
    this.borderRadiusValue,
  });

  MoonLinearProgressSizes _getMoonLoaderSize(BuildContext context, MoonLinearProgressSize? moonProgressSize) {
    switch (moonProgressSize) {
      case MoonLinearProgressSize.x6s:
        return context.moonTheme?.linearProgressTheme.x6s ?? MoonLinearProgressSizes.x6s;
      case MoonLinearProgressSize.x5s:
        return context.moonTheme?.linearProgressTheme.x5s ?? MoonLinearProgressSizes.x5s;
      case MoonLinearProgressSize.x4s:
        return context.moonTheme?.linearProgressTheme.x4s ?? MoonLinearProgressSizes.x4s;
      case MoonLinearProgressSize.x3s:
        return context.moonTheme?.linearProgressTheme.x3s ?? MoonLinearProgressSizes.x3s;
      case MoonLinearProgressSize.x2s:
        return context.moonTheme?.linearProgressTheme.x2s ?? MoonLinearProgressSizes.x2s;

      default:
        return context.moonTheme?.linearProgressTheme.x4s ?? MoonLinearProgressSizes.x4s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonLinearProgressSizes effectiveProgressSize = _getMoonLoaderSize(context, loaderSize);
    final double effectiveBorderRadiusValue = borderRadiusValue ?? effectiveProgressSize.borderRadiusValue;
    final double effectiveHeight = height ?? effectiveProgressSize.progressHeight;
    final Color effectiveColor = color ?? context.moonColors?.hit ?? MoonColors.light.hit;
    final Color effectiveBackgroundColor = backgroundColor ?? context.moonColors?.trunks ?? MoonColors.light.trunks;

    return MoonLinearProgressIndicator(
      value: value,
      borderRadiusValue: effectiveBorderRadiusValue,
      minHeight: effectiveHeight,
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
    );
  }
}
