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
  /// Size of the circular loader widget.
  final MoonCircularLoaderSize? circularLoaderSize;

  /// Size value of the circular loader widget.
  final double? sizeValue;

  /// Stroke width of the circular loader widget.
  final double? strokeWidth;

  /// Stroke cap of the circular loader widget.
  final StrokeCap? strokeCap;

  /// Color of the circular loader widget.
  final Color? color;

  /// Background color of the circular loader widget.
  final Color? backgroundColor;

  /// MDS circular loader widget.
  const MoonCircularLoader({
    super.key,
    this.circularLoaderSize,
    this.sizeValue,
    this.strokeWidth,
    this.strokeCap,
    this.color,
    this.backgroundColor,
  });

  MoonCircularLoaderSizeProperties _getMoonLoaderSize(BuildContext context, MoonCircularLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonCircularLoaderSize.x2s:
        return context.moonTheme?.circularLoaderTheme.sizes.x2s ?? MoonCircularLoaderSizeProperties.x2s;
      case MoonCircularLoaderSize.xs:
        return context.moonTheme?.circularLoaderTheme.sizes.xs ?? MoonCircularLoaderSizeProperties.xs;
      case MoonCircularLoaderSize.sm:
        return context.moonTheme?.circularLoaderTheme.sizes.sm ?? MoonCircularLoaderSizeProperties.sm;
      case MoonCircularLoaderSize.md:
        return context.moonTheme?.circularLoaderTheme.sizes.md ?? MoonCircularLoaderSizeProperties.md;
      case MoonCircularLoaderSize.lg:
        return context.moonTheme?.circularLoaderTheme.sizes.lg ?? MoonCircularLoaderSizeProperties.lg;

      default:
        return context.moonTheme?.circularLoaderTheme.sizes.md ?? MoonCircularLoaderSizeProperties.md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? context.moonTheme?.circularLoaderTheme.colors.color ?? MoonColors.light.hit;
    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.circularLoaderTheme.colors.backgroundColor ?? MoonColors.light.trunks;

    final StrokeCap effectiveStrokeCap = strokeCap ?? StrokeCap.round;

    final MoonCircularLoaderSizeProperties effectiveLoaderSize = _getMoonLoaderSize(context, circularLoaderSize);
    final double effectiveSize = sizeValue ?? effectiveLoaderSize.loaderSizeValue;
    final double effectiveStrokeWidth = strokeWidth ?? effectiveLoaderSize.loaderStrokeWidth;

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
