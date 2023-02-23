import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loader/loader_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';

enum MoonLoaderSize {
  x2s,
  xs,
  sm,
  md,
  lg,
}

class MoonLoader extends StatelessWidget {
  final MoonLoaderSize? loaderSize;
  final double? sizeValue;
  final double? strokeWidth;
  final Color? color;
  final Color? backgroundColor;

  const MoonLoader({
    super.key,
    this.loaderSize,
    this.sizeValue,
    this.strokeWidth,
    this.color,
    this.backgroundColor,
  });

  MoonLoaderSizes _getMoonLoaderSize(BuildContext context, MoonLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonLoaderSize.x2s:
        return context.moonTheme?.loaderTheme.x2s ?? MoonLoaderSizes.x2s;
      case MoonLoaderSize.xs:
        return context.moonTheme?.loaderTheme.xs ?? MoonLoaderSizes.xs;
      case MoonLoaderSize.sm:
        return context.moonTheme?.loaderTheme.sm ?? MoonLoaderSizes.sm;
      case MoonLoaderSize.md:
        return context.moonTheme?.loaderTheme.md ?? MoonLoaderSizes.md;
      case MoonLoaderSize.lg:
        return context.moonTheme?.loaderTheme.lg ?? MoonLoaderSizes.lg;

      default:
        return context.moonTheme?.loaderTheme.md ?? MoonLoaderSizes.md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonLoaderSizes effectiveMoonLoaderSize = _getMoonLoaderSize(context, loaderSize);
    final double effectiveSize = sizeValue ?? effectiveMoonLoaderSize.loaderSizeValue;
    final double effectiveStrokeWidth = strokeWidth ?? effectiveMoonLoaderSize.loaderStrokeWidth;

    return SizedBox(
      height: effectiveSize,
      width: effectiveSize,
      child: CircularProgressIndicator(
        strokeWidth: effectiveStrokeWidth,
        color: color,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
