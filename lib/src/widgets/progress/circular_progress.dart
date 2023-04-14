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
  /// Size of the circular progress widget.
  final MoonCircularProgressSize? circularProgressSize;

  /// Value of the circular progress widget.
  final double value;

  /// Size value of the circular progress widget.
  final double? sizeValue;

  /// Stroke width of the circular progress widget.
  final double? strokeWidth;

  /// Color of the circular progress widget.
  final Color? color;

  /// Background color of the circular progress widget.
  final Color? backgroundColor;

  /// Stroke cap of the circular progress widget.
  final StrokeCap? strokeCap;

  /// The semantic label for the circular progress widget.
  final String? semanticLabel;

  /// MDS circular progress widget.
  const MoonCircularProgress({
    super.key,
    this.circularProgressSize,
    required this.value,
    this.sizeValue,
    this.strokeWidth,
    this.color,
    this.backgroundColor,
    this.strokeCap,
    this.semanticLabel,
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

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: SizedBox(
        height: effectiveSize,
        width: effectiveSize,
        child: MoonCircularProgressIndicator(
          value: value,
          strokeWidth: effectiveStrokeWidth,
          color: effectiveColor,
          backgroundColor: effectiveBackgroundColor,
          strokeCap: effectiveStrokeCap,
        ),
      ),
    );
  }
}
