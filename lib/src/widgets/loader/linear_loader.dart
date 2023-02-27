import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/loaders/linear_loader_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/linear_progress_indicator.dart';

enum MoonLinearLoaderSize {
  x6s,
  x5s,
  x4s,
  x3s,
  x2s,
}

class MoonLinearLoader extends StatelessWidget {
  final MoonLinearLoaderSize? loaderSize;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final double? borderRadiusValue;

  const MoonLinearLoader({
    super.key,
    this.loaderSize,
    this.height,
    this.color,
    this.backgroundColor,
    this.borderRadiusValue,
  });

  MoonLinearLoaderSizes _getMoonLoaderSize(BuildContext context, MoonLinearLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonLinearLoaderSize.x6s:
        return context.moonTheme?.linearLoaderTheme.x6s ?? MoonLinearLoaderSizes.x6s;
      case MoonLinearLoaderSize.x5s:
        return context.moonTheme?.linearLoaderTheme.x5s ?? MoonLinearLoaderSizes.x5s;
      case MoonLinearLoaderSize.x4s:
        return context.moonTheme?.linearLoaderTheme.x4s ?? MoonLinearLoaderSizes.x4s;
      case MoonLinearLoaderSize.x3s:
        return context.moonTheme?.linearLoaderTheme.x3s ?? MoonLinearLoaderSizes.x3s;
      case MoonLinearLoaderSize.x2s:
        return context.moonTheme?.linearLoaderTheme.x2s ?? MoonLinearLoaderSizes.x2s;

      default:
        return context.moonTheme?.linearLoaderTheme.x4s ?? MoonLinearLoaderSizes.x4s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonLinearLoaderSizes effectiveLoaderSize = _getMoonLoaderSize(context, loaderSize);
    final double effectiveBorderRadiusValue = borderRadiusValue ?? effectiveLoaderSize.borderRadiusValue;
    final double effectiveHeight = height ?? effectiveLoaderSize.loaderHeight;
    final Color effectiveColor = color ?? context.moonColors?.hit ?? MoonColors.light.hit;
    final Color effectiveBackgroundColor = backgroundColor ?? context.moonColors?.trunks ?? MoonColors.light.trunks;

    return MoonLinearProgressIndicator(
      borderRadiusValue: effectiveBorderRadiusValue,
      minHeight: effectiveHeight,
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
    );
  }
}
