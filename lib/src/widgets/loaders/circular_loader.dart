import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_size_properties.dart';
import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/circular_progress_indicator.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonCircularLoaderSize {
  x2s,
  xs,
  sm,
  md,
  lg,
}

class MoonCircularLoader extends StatelessWidget {
  /// Color of the circular loader widget.
  final Color? color;

  /// Background color of the circular loader widget.
  final Color? backgroundColor;

  /// Size value of the circular loader widget.
  final double? sizeValue;

  /// Stroke width of the circular loader widget.
  final double? strokeWidth;

  /// Size of the circular loader widget.
  final MoonCircularLoaderSize? circularLoaderSize;

  /// Stroke cap of the circular loader widget.
  final StrokeCap? strokeCap;

  /// MDS circular loader widget.
  const MoonCircularLoader({
    super.key,
    this.color,
    this.backgroundColor,
    this.sizeValue,
    this.strokeWidth,
    this.circularLoaderSize,
    this.strokeCap,
  });

  MoonCircularLoaderSizeProperties _getMoonLoaderSize(BuildContext context, MoonCircularLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonCircularLoaderSize.x2s:
        return context.moonTheme?.circularLoaderTheme.sizes.x2s ??
            MoonCircularLoaderSizes(tokens: MoonTokens.light).x2s;
      case MoonCircularLoaderSize.xs:
        return context.moonTheme?.circularLoaderTheme.sizes.xs ?? MoonCircularLoaderSizes(tokens: MoonTokens.light).xs;
      case MoonCircularLoaderSize.sm:
        return context.moonTheme?.circularLoaderTheme.sizes.sm ?? MoonCircularLoaderSizes(tokens: MoonTokens.light).sm;
      case MoonCircularLoaderSize.md:
        return context.moonTheme?.circularLoaderTheme.sizes.md ?? MoonCircularLoaderSizes(tokens: MoonTokens.light).md;
      case MoonCircularLoaderSize.lg:
        return context.moonTheme?.circularLoaderTheme.sizes.lg ?? MoonCircularLoaderSizes(tokens: MoonTokens.light).lg;
      default:
        return context.moonTheme?.circularLoaderTheme.sizes.md ?? MoonCircularLoaderSizes(tokens: MoonTokens.light).md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonCircularLoaderSizeProperties effectiveLoaderSize = _getMoonLoaderSize(context, circularLoaderSize);

    final Color effectiveColor = color ?? context.moonTheme?.circularLoaderTheme.colors.color ?? MoonColors.light.hit;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.circularLoaderTheme.colors.backgroundColor ?? MoonColors.light.trunks;

    final double effectiveSize = sizeValue ?? effectiveLoaderSize.loaderSizeValue;

    final double effectiveStrokeWidth = strokeWidth ?? effectiveLoaderSize.loaderStrokeWidth;

    final StrokeCap effectiveStrokeCap = strokeCap ?? StrokeCap.round;

    return SizedBox(
      height: effectiveSize,
      width: effectiveSize,
      child: MoonCircularProgressIndicator(
        color: effectiveColor,
        backgroundColor: effectiveBackgroundColor,
        strokeWidth: effectiveStrokeWidth,
        strokeCap: effectiveStrokeCap,
      ),
    );
  }
}
