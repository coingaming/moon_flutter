import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

import 'package:moon_tokens/moon_tokens.dart';

class MoonCarousel extends StatefulWidget {
  /// The axis direction in which the carousel scrolls.
  final Axis axisDirection;

  /// Whether to enable the automatic scrolling for the carousel.
  final bool autoPlay;

  /// Whether to align the selected carousel item to the center of the viewport.
  /// When set to true, the [anchor] property is ignored.
  final bool isCentered;

  /// Whether to limit the 'maxExtent' proportionally based on the [anchor].
  ///
  /// This makes the carousel behave like a [ListView] in terms of how the
  /// 'maxExtent' is calculated and makes the last carousel item(s) unreachable
  /// for the purposes of the [onIndexChanged] callback.
  final bool clampMaxExtent;

  /// Whether to enable infinite looping for the carousel items.
  final bool loop;

  /// Positions the selected carousel item within the viewport.
  /// Values range from 0 to 1.
  ///
  /// A value of 0.0 indicates that the selected item is aligned to the start
  /// of the viewport, and a value of 1.0 indicates that it is aligned to the
  /// end of the viewport.
  ///
  /// This property is ignored when [isCentered] is set to true.
  final double anchor;

  /// The gap between the carousel items.
  final double? gap;

  /// The maximum width for each carousel item in the viewport.
  final double itemExtent;

  /// The factor to adjust and multiply the velocity of carousel scrolling.
  final double velocityFactor;

  /// The delay between the items in the carousel's automatic scrolling
  /// sequence.
  final Duration? autoPlayDelay;

  /// The duration of the carousel [autoplay] transition animation.
  final Duration? transitionDuration;

  /// The curve of the carousel [autoplay] transition animation.
  final Curve? transitionCurve;

  /// The total number of items to build for the carousel.
  final int itemCount;

  /// The [ScrollController] used to control the carousel.
  /// Defaults to [MoonCarouselScrollController], if not provided.
  final ScrollController? controller;

  /// The scroll physics of the carousel.
  ///
  /// Defaults to [MoonCarouselScrollPhysics], which ensures that the carousel
  /// always lands on a specific item after scrolling.
  final ScrollPhysics? physics;

  /// The custom scroll behavior for the carousel.
  final ScrollBehavior? scrollBehavior;

  /// The callback that is called when the carousel item index has changed.
  final void Function(int index)? onIndexChanged;

  /// Builds carousel items lazily within the viewport.
  ///
  /// When [loop] is false, 'itemIndex' corresponds to 'realIndex'
  /// (i.e., the index of the element).
  ///
  /// When [loop] is true, two indexes are exposed by the 'itemBuilder'.
  ///
  /// The first is 'itemIndex', which represents the modded item index,
  /// e.g., for a list of 10, 'position(11) = 1', and 'position(-1) = 9'.
  ///
  /// The second is 'realIndex', which represents the actual index,
  /// e.g., [..., -2, -1, 0, 1, 2, ...] in loop.
  /// The 'realIndex' is essential to support 'jumpToItem' by tapping on it.
  final Widget Function(BuildContext context, int itemIndex, int realIndex)
      itemBuilder;

  /// Creates a Moon Design carousel.
  const MoonCarousel({
    super.key,
    this.axisDirection = Axis.horizontal,
    this.autoPlay = false,
    this.isCentered = true,
    this.clampMaxExtent = false,
    this.loop = false,
    this.anchor = 0.0,
    this.gap,
    required this.itemExtent,
    this.velocityFactor = 0.5,
    this.autoPlayDelay,
    this.transitionDuration,
    this.transitionCurve,
    required this.itemCount,
    this.controller,
    this.physics,
    this.scrollBehavior,
    this.onIndexChanged,
    required this.itemBuilder,
  })  : assert(itemExtent > 0),
        assert(itemCount > 0),
        assert(gap == null || gap >= 0),
        assert(velocityFactor > 0.0 && velocityFactor <= 1.0);

  @override
  State<MoonCarousel> createState() => _MoonCarouselState();
}

class _MoonCarouselState extends State<MoonCarousel> {
  @override
  Widget build(BuildContext context) {
    final double effectiveGap = widget.gap ?? MoonSizes.sizes.x2s;

    final Duration effectiveAutoPlayDelay =
        widget.autoPlayDelay ?? const Duration(seconds: 3);

    final Duration effectiveTransitionDuration =
        widget.transitionDuration ?? const Duration(milliseconds: 800);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? Curves.fastOutSlowIn;

    final Color effectiveIconColor = MoonColors.light.iconPrimary;

    final Color effectiveTextColor = MoonColors.light.textPrimary;

    final TextStyle effectiveTextStyle =
        MoonTypography.typography.body.textDefault;

    final TextStyle resolvedTextStyle =
        effectiveTextStyle.copyWith(color: effectiveTextColor);

    final ScrollBehavior effectiveScrollBehavior = widget.scrollBehavior ??
        ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        );

    final Style defaultStyle = Style(
      $with.defaultTextStyle.style.as(resolvedTextStyle),
      $with.iconTheme.data.color(effectiveIconColor),
    );

    return SpecBuilder(
      style: defaultStyle,
      builder: (BuildContext context) => MoonRawCarousel(
        itemExtent: widget.itemExtent,
        itemCount: widget.itemCount,
        gap: effectiveGap,
        loop: widget.loop,
        controller: widget.controller ?? MoonCarouselScrollController(),
        scrollBehavior: effectiveScrollBehavior,
        physics: widget.physics,
        isCentered: widget.isCentered,
        anchor: widget.anchor,
        autoPlay: widget.autoPlay,
        clampMaxExtent: widget.clampMaxExtent,
        autoPlayDelay: effectiveAutoPlayDelay,
        onIndexChanged: widget.onIndexChanged,
        axisDirection: widget.axisDirection,
        transitionDuration: effectiveTransitionDuration,
        transitionCurve: effectiveTransitionCurve,
        velocityFactor: widget.velocityFactor,
        itemBuilder: (BuildContext context, int itemIndex, int realIndex) =>
            widget.itemBuilder(context, itemIndex, realIndex),
      ),
    );
  }
}
