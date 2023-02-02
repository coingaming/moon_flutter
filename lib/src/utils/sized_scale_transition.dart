import 'dart:math';

import 'package:flutter/material.dart';

class SizedScaleTransition extends AnimatedWidget {
  /// Creates a scale transition that scales on X and Y axis by fixed unit value.
  ///
  /// The [scale], [child], [childWidth], [childHeight] and [targetScale] arguments must not be null. The [alignment]
  /// argument defaults to [Alignment.center].
  const SizedScaleTransition({
    super.key,
    required Animation<double> scale,
    this.alignment = Alignment.center,
    this.filterQuality,
    required this.childWidth,
    required this.childHeight,
    required this.targetScale,
    required this.child,
  }) : super(listenable: scale);

  /// The animation that controls the scale of the child.
  ///
  /// If the current value of the scale animation is v, the child will be
  /// painted v times its normal size.
  Animation<double> get scale => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system in which the scale
  /// takes place, relative to the size of the box.
  ///
  /// For example, to set the origin of the scale to bottom middle, you can use
  /// an alignment of (0.0, 1.0).
  final Alignment alignment;

  /// The filter quality with which to apply the transform as a bitmap operation.
  ///
  /// When the animation is stopped (either in [AnimationStatus.dismissed] or
  /// [AnimationStatus.completed]), the filter quality argument will be ignored.
  ///
  /// {@macro flutter.widgets.Transform.optional.FilterQuality}
  final FilterQuality? filterQuality;

  /// The width of the widget below this widget in the tree.
  final double childWidth;

  /// The height of the widget below this widget in the tree.
  final double childHeight;

  /// The target scale value for the child.
  final double targetScale;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The ImageFilter layer created by setting filterQuality will introduce
    // a saveLayer call. This is usually worthwhile when animating the layer,
    // but leaving it in the layer tree before the animation has started or after
    // it has finished significantly hurts performance.
    final bool useFilterQuality;

    switch (scale.status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.completed:
        useFilterQuality = false;
        break;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        useFilterQuality = true;
        break;
    }

    final smallestDimension = min(childWidth, childHeight);
    final largestDimension = max(childWidth, childHeight);
    final scaledSmallestDimensionValue = smallestDimension * targetScale;
    final smallestDimensionDifference = smallestDimension - scaledSmallestDimensionValue;
    final largestDimensionDifference = largestDimension - smallestDimensionDifference;
    final largestDimensionScalar = largestDimensionDifference / largestDimension;

    final scaleXTween =
        Tween(begin: 1.0, end: childWidth > childHeight ? largestDimensionScalar : targetScale).animate(scale);
    final scaleYTween =
        Tween(begin: 1.0, end: childHeight > childWidth ? largestDimensionScalar : targetScale).animate(scale);

    return Transform.scale(
      scaleX: scaleXTween.value,
      scaleY: scaleYTween.value,
      alignment: alignment,
      filterQuality: useFilterQuality ? filterQuality : null,
      child: child,
    );
  }
}
