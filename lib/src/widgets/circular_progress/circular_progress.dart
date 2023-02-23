import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/circular_progress/circular_progress_sizes.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';

enum MoonCircularProgressSize {
  x2s,
  xs,
  sm,
  md,
  lg,
}

class MoonCircularProgress extends StatelessWidget {
  final MoonCircularProgressSize? circularProgressSize;
  final double value;
  final double? sizeValue;
  final double? strokeWidth;
  final Color? color;
  final Color? backgroundColor;

  const MoonCircularProgress({
    super.key,
    this.circularProgressSize,
    required this.value,
    this.sizeValue,
    this.strokeWidth,
    this.color,
    this.backgroundColor,
  });

  MoonCircularProgressSizes _getMoonCircularProgressSize(
    BuildContext context,
    MoonCircularProgressSize? moonCircularProgressSize,
  ) {
    switch (moonCircularProgressSize) {
      case MoonCircularProgressSize.x2s:
        return context.moonTheme?.circularProgressTheme.x2s ?? MoonCircularProgressSizes.x2s;
      case MoonCircularProgressSize.xs:
        return context.moonTheme?.circularProgressTheme.xs ?? MoonCircularProgressSizes.xs;
      case MoonCircularProgressSize.sm:
        return context.moonTheme?.circularProgressTheme.sm ?? MoonCircularProgressSizes.sm;
      case MoonCircularProgressSize.md:
        return context.moonTheme?.circularProgressTheme.md ?? MoonCircularProgressSizes.md;
      case MoonCircularProgressSize.lg:
        return context.moonTheme?.circularProgressTheme.lg ?? MoonCircularProgressSizes.lg;

      default:
        return context.moonTheme?.circularProgressTheme.md ?? MoonCircularProgressSizes.md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonCircularProgressSizes effectiveMoonCircularProgressSize =
        _getMoonCircularProgressSize(context, circularProgressSize);
    final double effectiveSize = sizeValue ?? effectiveMoonCircularProgressSize.circularProgressSizeValue;
    final double effectiveStrokeWidth = strokeWidth ?? effectiveMoonCircularProgressSize.circularProgressStrokeWidth;
    final Color effectiveBackgroundColor = backgroundColor ?? context.moonColors?.trunks ?? MoonColors.light.trunks;

    return SizedBox(
      height: effectiveSize,
      width: effectiveSize,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: effectiveStrokeWidth,
        color: color,
        backgroundColor: effectiveBackgroundColor,
      ),
    );
  }
}
