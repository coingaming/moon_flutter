import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/circular_progress_indicator.dart';

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
  final StrokeCap? strokeCap;

  const MoonCircularProgress({
    super.key,
    this.circularProgressSize,
    required this.value,
    this.sizeValue,
    this.strokeWidth,
    this.color,
    this.backgroundColor,
    this.strokeCap,
  });

  MoonCircularProgressSizeProperties _getMoonCircularProgressSize(
    BuildContext context,
    MoonCircularProgressSize? moonCircularProgressSize,
  ) {
    switch (moonCircularProgressSize) {
      case MoonCircularProgressSize.x2s:
        return context.moonTheme?.circularProgressTheme.sizes.x2s ?? MoonCircularProgressSizeProperties.x2s;
      case MoonCircularProgressSize.xs:
        return context.moonTheme?.circularProgressTheme.sizes.xs ?? MoonCircularProgressSizeProperties.xs;
      case MoonCircularProgressSize.sm:
        return context.moonTheme?.circularProgressTheme.sizes.sm ?? MoonCircularProgressSizeProperties.sm;
      case MoonCircularProgressSize.md:
        return context.moonTheme?.circularProgressTheme.sizes.md ?? MoonCircularProgressSizeProperties.md;
      case MoonCircularProgressSize.lg:
        return context.moonTheme?.circularProgressTheme.sizes.lg ?? MoonCircularProgressSizeProperties.lg;

      default:
        return context.moonTheme?.circularProgressTheme.sizes.md ?? MoonCircularProgressSizeProperties.md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor =
        color ?? context.moonTheme?.circularProgressTheme.colors.color ?? MoonColors.light.piccolo;
    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.circularProgressTheme.colors.backgroundColor ?? MoonColors.light.trunks;

    final StrokeCap effectiveStrokeCap = strokeCap ?? StrokeCap.round;

    final MoonCircularProgressSizeProperties effectiveMoonCircularProgressSize =
        _getMoonCircularProgressSize(context, circularProgressSize);
    final double effectiveSize = sizeValue ?? effectiveMoonCircularProgressSize.progressSizeValue;
    final double effectiveStrokeWidth = strokeWidth ?? effectiveMoonCircularProgressSize.progressStrokeWidth;

    return SizedBox(
      height: effectiveSize,
      width: effectiveSize,
      child: MoonCircularProgressIndicator(
        value: value,
        strokeWidth: effectiveStrokeWidth,
        color: effectiveColor,
        backgroundColor: effectiveBackgroundColor,
        strokeCap: effectiveStrokeCap,
      ),
    );
  }
}
