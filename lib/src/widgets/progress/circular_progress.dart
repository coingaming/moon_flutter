import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_size_properties.dart';
import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/circular_progress_indicator.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonCircularProgressSize {
  x2s,
  xs,
  sm,
  md,
  lg,
}

class MoonCircularProgress extends StatelessWidget {
  /// The color of the circular progress.
  final Color? color;

  /// The background color of the circular progress.
  final Color? backgroundColor;

  /// The custom size value of the circular progress. For predefined sizes, use
  /// [circularProgressSize].
  final double? sizeValue;

  /// The width of the stroke for the circular progress.
  final double? strokeWidth;

  /// The progress value of the circular progress.
  final double value;

  /// The size of the circular progress.
  final MoonCircularProgressSize? circularProgressSize;

  /// The semantic label for the circular progress.
  final String? semanticLabel;

  /// The shape of the end of the stroke (stroke-cap) for the circular progress.
  final StrokeCap? strokeCap;

  /// Creates a Moon Design circular progress.
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
    final Color effectiveColor = color ??
        context.moonTheme?.circularProgressTheme.colors.color ??
        MoonColors.light.piccolo;

    final Color effectiveBackgroundColor = backgroundColor ??
        context.moonTheme?.circularProgressTheme.colors.backgroundColor ??
        MoonColors.light.beerus;

    final MoonCircularProgressSizeProperties effectiveMoonCircularProgressSize =
        _getMoonCircularProgressSize(context, circularProgressSize);

    final double effectiveSize =
        sizeValue ?? effectiveMoonCircularProgressSize.progressSizeValue;

    final double effectiveStrokeWidth =
        strokeWidth ?? effectiveMoonCircularProgressSize.progressStrokeWidth;

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
