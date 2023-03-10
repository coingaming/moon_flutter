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
  final MoonLinearProgressSize? progressSize;
  final double value;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final double? borderRadiusValue;

  const MoonLinearProgress({
    super.key,
    this.progressSize,
    required this.value,
    this.height,
    this.color,
    this.backgroundColor,
    this.borderRadiusValue,
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

    final MoonLinearProgressSizeProperties effectiveProgressSize = _getMoonProgressSize(context, progressSize);
    final double effectiveBorderRadiusValue = borderRadiusValue ?? effectiveProgressSize.borderRadiusValue;
    final double effectiveHeight = height ?? effectiveProgressSize.progressHeight;

    return MoonLinearProgressIndicator(
      value: value,
      borderRadiusValue: effectiveBorderRadiusValue,
      minHeight: effectiveHeight,
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
    );
  }
}
