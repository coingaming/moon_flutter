import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_size_properties.dart';
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

  MoonLinearLoaderSizeProperties _getMoonLoaderSize(BuildContext context, MoonLinearLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonLinearLoaderSize.x6s:
        return context.moonTheme?.linearLoaderTheme.sizes.x6s ?? MoonLinearLoaderSizeProperties.x6s;
      case MoonLinearLoaderSize.x5s:
        return context.moonTheme?.linearLoaderTheme.sizes.x5s ?? MoonLinearLoaderSizeProperties.x5s;
      case MoonLinearLoaderSize.x4s:
        return context.moonTheme?.linearLoaderTheme.sizes.x4s ?? MoonLinearLoaderSizeProperties.x4s;
      case MoonLinearLoaderSize.x3s:
        return context.moonTheme?.linearLoaderTheme.sizes.x3s ?? MoonLinearLoaderSizeProperties.x3s;
      case MoonLinearLoaderSize.x2s:
        return context.moonTheme?.linearLoaderTheme.sizes.x2s ?? MoonLinearLoaderSizeProperties.x2s;

      default:
        return context.moonTheme?.linearLoaderTheme.sizes.x4s ?? MoonLinearLoaderSizeProperties.x4s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? context.moonTheme?.linearLoaderTheme.colors.color ?? MoonColors.light.hit;
    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.linearLoaderTheme.colors.backgroundColor ?? MoonColors.light.trunks;

    final MoonLinearLoaderSizeProperties effectiveLoaderSize = _getMoonLoaderSize(context, loaderSize);
    final double effectiveBorderRadiusValue = borderRadiusValue ?? effectiveLoaderSize.borderRadiusValue;
    final double effectiveHeight = height ?? effectiveLoaderSize.loaderHeight;

    return MoonLinearProgressIndicator(
      borderRadiusValue: effectiveBorderRadiusValue,
      minHeight: effectiveHeight,
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
    );
  }
}
