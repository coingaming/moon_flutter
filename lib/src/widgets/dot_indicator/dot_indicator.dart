import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';

import 'package:moon_tokens/moon_tokens.dart';

class MoonDotIndicator extends StatelessWidget {
  /// The color of the selected dot.
  final Color? selectedColor;

  /// The color of the unselected dots.
  final Color? unselectedColor;

  /// The gap between the dots.
  final double? gap;

  /// The size of each dot.
  final double? size;

  /// The duration of the dot indicator transition animation.
  final Duration? transitionDuration;

  /// The curve of the dot indicator transition animation.
  final Curve? transitionCurve;

  /// The index of the currently selected dot.
  final int selectedDot;

  /// The total number of dots to build for the indicator.
  final int dotCount;

  /// Creates a Moon Design dot indicator.
  const MoonDotIndicator({
    this.selectedColor,
    this.unselectedColor,
    this.gap,
    this.size,
    this.transitionDuration,
    this.transitionCurve,
    required this.selectedDot,
    required this.dotCount,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveSize = size ?? MoonSizes.sizes.x4s;

    final double effectiveGap = gap ?? MoonSizes.sizes.x4s;

    final Color effectiveSelectedColor =
        selectedColor ?? MoonColors.light.piccolo;

    final Color effectiveUnselectedColor =
        unselectedColor ?? MoonColors.light.beerus;

    final Duration effectiveTransitionDuration = transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve =
        transitionCurve ?? MoonTransitions.transitions.defaultTransitionCurve;

    final Style dotIndicatorStyle = Style(
      $flex.chain
        ..gap(effectiveGap)
        ..mainAxisAlignment.center(),
    );

    Style dotStyle(Color color) => Style(
          $box.chain
            ..width(effectiveSize)
            ..height(effectiveSize)
            ..color(color)
            ..shape.circle(),
        );

    return MoonRawDotIndicator(
      dotCount: dotCount,
      selectedDot: selectedDot,
      selectedColor: effectiveSelectedColor,
      unselectedColor: effectiveUnselectedColor,
      transitionDuration: effectiveTransitionDuration,
      transitionCurve: effectiveTransitionCurve,
      dotIndicatorStyle: dotIndicatorStyle,
      dotBuilder: (int _, Color color) => Box(style: dotStyle(color)),
    );
  }
}
