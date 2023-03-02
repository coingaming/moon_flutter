import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/loaders/circular_loader_sizes.dart';
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

  MoonCircularLoaderSizes _getMoonLoaderSize(BuildContext context, MoonCircularLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonCircularLoaderSize.x2s:
        return context.moonTheme?.circularLoaderTheme.x2s ?? MoonCircularLoaderSizes.x2s;
      case MoonCircularLoaderSize.xs:
        return context.moonTheme?.circularLoaderTheme.xs ?? MoonCircularLoaderSizes.xs;
      case MoonCircularLoaderSize.sm:
        return context.moonTheme?.circularLoaderTheme.sm ?? MoonCircularLoaderSizes.sm;
      case MoonCircularLoaderSize.md:
        return context.moonTheme?.circularLoaderTheme.md ?? MoonCircularLoaderSizes.md;
      case MoonCircularLoaderSize.lg:
        return context.moonTheme?.circularLoaderTheme.lg ?? MoonCircularLoaderSizes.lg;

      default:
        return context.moonTheme?.circularLoaderTheme.md ?? MoonCircularLoaderSizes.md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonCircularLoaderSizes effectiveLoaderSize = _getMoonLoaderSize(context, loaderSize);
    final double effectiveSize = sizeValue ?? effectiveLoaderSize.loaderSizeValue;
    final double effectiveStrokeWidth = strokeWidth ?? effectiveLoaderSize.loaderStrokeWidth;
    final Color effectiveColor = color ?? context.moonColors?.hit ?? MoonColors.light.hit;
    final Color effectiveBackgroundColor = backgroundColor ?? context.moonColors?.trunks ?? MoonColors.light.trunks;
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
