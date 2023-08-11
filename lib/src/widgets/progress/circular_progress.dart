import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_size_properties.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/circular_progress_indicator.dart';

enum MoonCircularProgressSize {
  x2s,
  xs,
  sm,
  md,
  lg,
}

class MoonCircularProgress extends StatelessWidget {
  /// Color of the circular progress widget.
  final Color? color;

  /// Background color of the circular progress widget.
  final Color? backgroundColor;

  /// Size value of the circular progress widget.
  final double? sizeValue;

  /// Stroke width of the circular progress widget.
  final double? strokeWidth;

  /// Value of the circular progress widget.
  final double value;

  /// Size of the circular progress widget.
  final MoonCircularProgressSize? circularProgressSize;

  /// The semantic label for the circular progress widget.
  final String? semanticLabel;

  /// Stroke cap of the circular progress widget.
  final StrokeCap? strokeCap;

  /// MDS circular progress widget.
  const MoonCircularProgress({
    super.key,
    this.color,
    this.backgroundColor,
    this.sizeValue,
    this.strokeWidth,
    required this.value,
    this.circularProgressSize,
    this.semanticLabel,
    this.strokeCap,
  });

  MoonCircularProgressSizeProperties _getMoonCircularProgressSize(
    BuildContext context,
    MoonCircularProgressSize? moonCircularProgressSize,
  ) {
    switch (moonCircularProgressSize) {
      case MoonCircularProgressSize.x2s:
        return context.moonTheme?.circularProgressTheme.sizes.x2s ??
            MoonCircularProgressSizes(tokens: MoonTokens.light).x2s;
      case MoonCircularProgressSize.xs:
        return context.moonTheme?.circularProgressTheme.sizes.xs ??
            MoonCircularProgressSizes(tokens: MoonTokens.light).xs;
      case MoonCircularProgressSize.sm:
        return context.moonTheme?.circularProgressTheme.sizes.sm ??
            MoonCircularProgressSizes(tokens: MoonTokens.light).sm;
      case MoonCircularProgressSize.md:
        return context.moonTheme?.circularProgressTheme.sizes.md ??
            MoonCircularProgressSizes(tokens: MoonTokens.light).md;
      case MoonCircularProgressSize.lg:
        return context.moonTheme?.circularProgressTheme.sizes.lg ??
            MoonCircularProgressSizes(tokens: MoonTokens.light).lg;
      default:
        return context.moonTheme?.circularProgressTheme.sizes.md ??
            MoonCircularProgressSizes(tokens: MoonTokens.light).md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor =
        color ?? context.moonTheme?.circularProgressTheme.colors.color ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.circularProgressTheme.colors.backgroundColor ?? MoonColors.light.beerus;

    final MoonCircularProgressSizeProperties effectiveMoonCircularProgressSize =
        _getMoonCircularProgressSize(context, circularProgressSize);

    final double effectiveSize = sizeValue ?? effectiveMoonCircularProgressSize.progressSizeValue;

    final double effectiveStrokeWidth = strokeWidth ?? effectiveMoonCircularProgressSize.progressStrokeWidth;

    final StrokeCap effectiveStrokeCap = strokeCap ?? StrokeCap.round;

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: SizedBox(
        height: effectiveSize,
        width: effectiveSize,
        child: MoonCircularProgressIndicator(
          color: effectiveColor,
          backgroundColor: effectiveBackgroundColor,
          strokeWidth: effectiveStrokeWidth,
          value: value,
          strokeCap: effectiveStrokeCap,
        ),
      ),
    );
  }
}
