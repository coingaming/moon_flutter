import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';

class MoonDotIndicator extends StatefulWidget {
  /// The gap between each dot.
  final double? gap;

  /// The size of each dot.
  final double? size;

  /// The color of the selected item.
  final Color? selectedColor;

  /// The color of the unselected item.
  final Color? unselectedColor;

  /// The index of the currently selected item.
  final int selectedItem;

  /// The total number of items.
  final int itemCount;

  /// Indicator transition duration.
  final Duration? transitionDuration;

  /// Indicator transition curve.
  final Curve? transitionCurve;

  /// MDS DotIndicator widget
  const MoonDotIndicator({
    this.gap,
    this.size,
    this.selectedColor,
    this.unselectedColor,
    required this.selectedItem,
    required this.itemCount,
    this.transitionDuration,
    this.transitionCurve,
  });

  @override
  _CarouselIndicatorState createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<MoonDotIndicator> with TickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _dotColorTween = ColorTweenWithPremultipliedAlpha();

  List<AnimationController>? _animationControllers;
  List<Animation<Color?>>? _animations;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationControllers![widget.selectedItem].forward();
    });
  }

  @override
  void didUpdateWidget(MoonDotIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedItem != oldWidget.selectedItem) {
      _animationControllers![oldWidget.selectedItem].reverse();
      _animationControllers![widget.selectedItem].forward();
    }
  }

  @override
  void dispose() {
    for (final controller in _animationControllers!) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double effectiveSize =
        widget.size ?? context.moonTheme?.dotIndicatorTheme.properties.size ?? MoonSizes.sizes.x4s;

    final double effectiveGap =
        widget.gap ?? context.moonTheme?.dotIndicatorTheme.properties.gap ?? MoonSizes.sizes.x4s;

    final Color effectiveSelectedColor =
        widget.selectedColor ?? context.moonTheme?.dotIndicatorTheme.colors.selectedColor ?? MoonColors.light.piccolo;

    final Color effectiveUnselectedColor = widget.unselectedColor ??
        context.moonTheme?.dotIndicatorTheme.colors.unselectedColor ??
        MoonColors.light.beerus;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.dotIndicatorTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.dotIndicatorTheme.properties.transitionCurve ??
        Curves.easeInOutCubic;

    _animationControllers ??= List.generate(
      widget.itemCount,
      (index) => AnimationController(
        duration: effectiveTransitionDuration,
        vsync: this,
      ),
    );

    _animations ??= List.generate(
      widget.itemCount,
      (index) => _animationControllers![index].drive(_dotColorTween.chain(CurveTween(curve: effectiveTransitionCurve))),
    );

    _dotColorTween
      ..begin = effectiveUnselectedColor
      ..end = effectiveSelectedColor;

    return RepaintBoundary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          widget.itemCount,
          (int index) => AnimatedBuilder(
            animation: _animations![index],
            builder: (BuildContext context, _) {
              return Container(
                width: effectiveSize,
                height: effectiveSize,
                margin: EdgeInsets.symmetric(horizontal: effectiveGap / 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _animations![index].value,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
