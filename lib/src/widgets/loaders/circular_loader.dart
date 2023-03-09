import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/circular_progress_indicator.dart';

enum MoonCircularLoaderSize {
  x2s,
  xs,
  sm,
  md,
  lg,
}

class MoonCircularLoader extends StatelessWidget {
  final MoonCircularLoaderSize? loaderSize;
  final double? sizeValue;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final Color? color;
  final Color? backgroundColor;

  const MoonCircularLoader({
    super.key,
    this.loaderSize,
    this.sizeValue,
    this.strokeWidth,
    this.strokeCap,
    this.color,
    this.backgroundColor,
  });

  MoonCircularLoaderSizeProperties _getMoonLoaderSize(BuildContext context, MoonCircularLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonCircularLoaderSize.x2s:
        return context.moonTheme?.circularLoader.sizes.x2s ?? MoonCircularLoaderSizeProperties.x2s;
      case MoonCircularLoaderSize.xs:
        return context.moonTheme?.circularLoader.sizes.xs ?? MoonCircularLoaderSizeProperties.xs;
      case MoonCircularLoaderSize.sm:
        return context.moonTheme?.circularLoader.sizes.sm ?? MoonCircularLoaderSizeProperties.sm;
      case MoonCircularLoaderSize.md:
        return context.moonTheme?.circularLoader.sizes.md ?? MoonCircularLoaderSizeProperties.md;
      case MoonCircularLoaderSize.lg:
        return context.moonTheme?.circularLoader.sizes.lg ?? MoonCircularLoaderSizeProperties.lg;

      default:
        return context.moonTheme?.circularLoader.sizes.md ?? MoonCircularLoaderSizeProperties.md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonCircularLoaderSizeProperties effectiveLoaderSize = _getMoonLoaderSize(context, loaderSize);
    final double effectiveSize = sizeValue ?? effectiveLoaderSize.loaderSizeValue;
    final double effectiveStrokeWidth = strokeWidth ?? effectiveLoaderSize.loaderStrokeWidth;
    final Color effectiveColor = color ?? context.moonTheme?.circularLoader.colors.color ?? MoonColors.light.hit;
    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.circularLoader.colors.backgroundColor ?? MoonColors.light.trunks;
    final StrokeCap effectiveStrokeCap = strokeCap ?? StrokeCap.round;

    return SizedBox(
      height: effectiveSize,
      width: effectiveSize,
      child: MoonCircularProgressIndicator(
        strokeWidth: effectiveStrokeWidth,
        strokeCap: effectiveStrokeCap,
        color: effectiveColor,
        backgroundColor: effectiveBackgroundColor,
      ),
    );
  }
}
