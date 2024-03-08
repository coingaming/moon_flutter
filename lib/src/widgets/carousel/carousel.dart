import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

import 'package:moon_design/src/theme/theme.dart';
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
  /// This makes the carousel behave like a [ListView] in terms of how the 'maxExtent' is calculated
  /// and makes the last carousel item(s) unreachable for the purposes of the [onIndexChanged] callback.
  final bool clampMaxExtent;

  /// Whether to enable infinite looping for the carousel items.
  final bool loop;

  /// Positions the selected carousel item within the viewport. Values range from 0 to 1.
  ///
  /// A value of 0.0 indicates that the selected item is aligned to the start of the viewport,
  /// and a value of 1.0 indicates that it is aligned to the end of the viewport.
  ///
  /// This property is ignored when [isCentered] is set to true.
  final double anchor;

  /// The gap between the carousel items.
  final double? gap;

  /// The maximum width for each carousel item in the viewport.
  final double itemExtent;

  /// The factor to adjust and multiply the velocity of carousel scrolling.
  final double velocityFactor;

  /// The delay between the items in the carousel's automatic scrolling sequence.
  final Duration? autoPlayDelay;

  /// The duration of the MoonCarousel [autoplay] transition animation.
  final Duration? transitionDuration;

  /// The curve of the MoonCarousel [autoplay] transition animation.
  final Curve? transitionCurve;

  /// The total number of items to build for the carousel.
  final int itemCount;

  /// The [ScrollController] used to control the carousel.
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
  /// When [loop] is false, 'itemIndex' corresponds to 'realIndex' (i.e., the index of the element).
  ///
  /// When [loop] is true, two indexes are exposed by the 'itemBuilder'.
  ///
  /// The first is 'itemIndex', which represents the modded item index,
  /// e.g., for a list of 10, 'position(11) = 1', and 'position(-1) = 9'.
  ///
  /// The second is 'realIndex', which represents the actual index, e.g., [..., -2, -1, 0, 1, 2, ...] in loop.
  /// The 'realIndex' is essential to support 'jumpToItem' by tapping on it.
  final Widget Function(BuildContext context, int itemIndex, int realIndex) itemBuilder;

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
        assert(velocityFactor > 0.0 && velocityFactor <= 1.0);

  @override
  State<MoonCarousel> createState() => _MoonCarouselState();
}

class _MoonCarouselState extends State<MoonCarousel> {
  late int _lastReportedItemIndex;
  late MoonCarouselScrollController _scrollController;

  final Key _forwardListKey = const ValueKey<String>("moon_carousel_key");

  double _effectiveGap = 0;

  // Calculates the anchor position for the viewport to center the selected item when 'isCentered' is true.
  double _getCenteredAnchor(BoxConstraints constraints) {
    if (!widget.isCentered) return widget.anchor;

    final maxExtent = widget.axisDirection == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;

    return ((maxExtent / 2) - (widget.itemExtent / 2)) / maxExtent;
  }

  // Determines whether the carousel's anchored content surpasses the viewport's width.
  // If not, clamping is not applicable.
  bool _clampMaxExtent(double viewportWidth) {
    final double itemsWidth = widget.itemCount * widget.itemExtent;
    final double gapWidth = (widget.itemCount - 1) * _effectiveGap;
    final double anchor = viewportWidth * widget.anchor * 2;
    final double totalWidth = itemsWidth + gapWidth + anchor;

    return totalWidth >= viewportWidth && widget.clampMaxExtent;
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.axisDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));

        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection = textDirectionToAxisDirection(textDirection);

        return axisDirection;

      case Axis.vertical:
        return AxisDirection.down;
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController = (widget.controller as MoonCarouselScrollController?) ?? MoonCarouselScrollController();

    _lastReportedItemIndex = _scrollController.initialItem;

    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        final Duration effectiveAutoPlayDelay = widget.autoPlayDelay ??
            context.moonTheme?.carouselTheme.properties.autoPlayDelay ??
            const Duration(seconds: 3);

        final Duration effectiveTransitionDuration = widget.transitionDuration ??
            context.moonTheme?.carouselTheme.properties.transitionDuration ??
            const Duration(milliseconds: 800);

        final Curve effectiveTransitionCurve = widget.transitionCurve ??
            context.moonTheme?.carouselTheme.properties.transitionCurve ??
            Curves.fastOutSlowIn;

        _scrollController.startAutoPlay(
          delay: effectiveAutoPlayDelay,
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
        );
      });
    }
  }

  @override
  void didUpdateWidget(MoonCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.autoPlay != oldWidget.autoPlay) {
      if (widget.autoPlay) {
        final Duration effectiveAutoPlayDelay = widget.autoPlayDelay ??
            context.moonTheme?.carouselTheme.properties.autoPlayDelay ??
            const Duration(seconds: 3);

        final Duration effectiveTransitionDuration = widget.transitionDuration ??
            context.moonTheme?.carouselTheme.properties.transitionDuration ??
            const Duration(milliseconds: 800);

        final Curve effectiveTransitionCurve = widget.transitionCurve ??
            context.moonTheme?.carouselTheme.properties.transitionCurve ??
            Curves.fastOutSlowIn;

        _scrollController.startAutoPlay(
          delay: effectiveAutoPlayDelay,
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
        );
      } else {
        _scrollController.stopAutoplay();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  List<Widget> _buildSlivers(BuildContext context, {required AxisDirection axisDirection}) {
    final EdgeInsetsDirectional resolvedPadding = widget.axisDirection == Axis.horizontal
        ? EdgeInsetsDirectional.only(end: _effectiveGap)
        : EdgeInsetsDirectional.only(bottom: _effectiveGap);

    /// Delegate responsible for building items lazily in the forward direction as the viewport scrolls.
    final SliverChildDelegate childDelegate = SliverChildBuilderDelegate(
      (context, index) => Padding(
        padding: resolvedPadding,
        child: widget.itemBuilder(context, index.abs() % widget.itemCount, index),
      ),
      childCount: widget.loop ? null : widget.itemCount,
    );

    /// Delegate responsible for building items lazily in the reverse direction as the viewport scrolls.
    final SliverChildDelegate? reversedChildDelegate = widget.loop
        ? SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: resolvedPadding,
              child: widget.itemBuilder(context, widget.itemCount - (index.abs() % widget.itemCount) - 1, -(index + 1)),
            ),
          )
        : null;

    final Widget forward = SliverFixedExtentList(
      key: _forwardListKey,
      delegate: childDelegate,
      itemExtent: widget.itemExtent + _effectiveGap,
    );

    if (!widget.loop) return [forward];

    final Widget reversed = SliverFixedExtentList(
      delegate: reversedChildDelegate!,
      itemExtent: widget.itemExtent + _effectiveGap,
    );

    return [reversed, forward];
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = context.moonTheme?.carouselTheme.colors.textColor ?? MoonColors.light.textPrimary;

    final Color effectiveIconColor = context.moonTheme?.carouselTheme.colors.iconColor ?? MoonColors.light.iconPrimary;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.carouselTheme.properties.textStyle ?? MoonTypography.typography.body.textDefault;

    final AxisDirection axisDirection = _getDirection(context);

    final ScrollBehavior effectiveScrollBehavior = widget.scrollBehavior ??
        ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        );

    _effectiveGap = widget.gap ?? context.moonTheme?.carouselTheme.properties.gap ?? MoonSizes.sizes.x2s;

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (ScrollUpdateNotification notification) {
        final MoonCarouselExtentMetrics metrics = notification.metrics as MoonCarouselExtentMetrics;

        final int currentItem = metrics.itemIndex;

        if (currentItem != _lastReportedItemIndex) {
          _lastReportedItemIndex = currentItem;

          final int trueIndex = _getTrueIndex(_lastReportedItemIndex, widget.itemCount);

          if (widget.onIndexChanged != null) {
            // ignore: prefer_null_aware_method_calls
            widget.onIndexChanged!(trueIndex);
          }
        }

        return false;
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double centeredAnchor = _getCenteredAnchor(constraints);
          final bool clampMaxExtent = _clampMaxExtent(constraints.maxWidth);

          return IconTheme(
            data: IconThemeData(
              color: effectiveIconColor,
            ),
            child: DefaultTextStyle(
              style: effectiveTextStyle.copyWith(color: effectiveTextColor),
              child: _MoonCarouselScrollable(
                anchor: centeredAnchor,
                axisDirection: axisDirection,
                controller: _scrollController,
                clampMaxExtent: clampMaxExtent,
                gap: _effectiveGap,
                itemCount: widget.itemCount,
                itemExtent: widget.itemExtent + _effectiveGap,
                loop: widget.loop,
                physics: widget.physics ?? const MoonCarouselScrollPhysics(),
                scrollBehavior: effectiveScrollBehavior,
                velocityFactor: widget.velocityFactor,
                viewportBuilder: (BuildContext context, ViewportOffset position) {
                  return Viewport(
                    anchor: centeredAnchor,
                    axisDirection: axisDirection,
                    center: _forwardListKey,
                    offset: position,
                    slivers: _buildSlivers(context, axisDirection: axisDirection),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Extends Scrollable by including the viewport's itemExtent, itemCount, loop, and other values.
/// This allows ScrollPosition and Physics to access these values directly from the scroll context.
class _MoonCarouselScrollable extends Scrollable {
  final bool clampMaxExtent;
  final bool loop;
  final double anchor;
  final double gap;
  final double itemExtent;
  final double velocityFactor;
  final int itemCount;

  const _MoonCarouselScrollable({
    super.axisDirection = AxisDirection.right,
    super.controller,
    super.physics,
    super.scrollBehavior,
    required super.viewportBuilder,
    required this.clampMaxExtent,
    required this.loop,
    required this.anchor,
    required this.gap,
    required this.itemExtent,
    required this.velocityFactor,
    required this.itemCount,
  });

  @override
  _MoonCarouselScrollableState createState() => _MoonCarouselScrollableState();
}

class _MoonCarouselScrollableState extends ScrollableState {
  bool get clampMaxExtent => (widget as _MoonCarouselScrollable).clampMaxExtent;

  bool get loop => (widget as _MoonCarouselScrollable).loop;

  double get anchor => (widget as _MoonCarouselScrollable).anchor;

  double get gap => (widget as _MoonCarouselScrollable).gap;

  double get itemExtent => (widget as _MoonCarouselScrollable).itemExtent;

  double get velocityFactor => (widget as _MoonCarouselScrollable).velocityFactor;

  int get itemCount => (widget as _MoonCarouselScrollable).itemCount;
}

/// Scroll controller for [MoonCarousel].
class MoonCarouselScrollController extends ScrollController {
  /// The initial carousel item index for [MoonCarouselScrollController].
  ///
  /// Defaults to '0'.
  final int initialItem;

  /// Scroll controller for [MoonCarousel].
  MoonCarouselScrollController({this.initialItem = 0});

  // Timer for autoplay.
  Timer? _autoplayTimer;

  void startAutoPlay({Duration delay = const Duration(seconds: 3), Duration? duration, Curve? curve}) {
    _autoplayTimer?.cancel();

    _autoplayTimer = Timer.periodic(delay, (timer) {
      // When the carousel reaches the end, animate it back to the beginning.
      if (offset >= position.maxScrollExtent && !position.outOfRange) {
        animateToItem(0, duration: duration, curve: curve);
      } else {
        nextItem(duration: duration, curve: curve);
      }
    });
  }

  void stopAutoplay() {
    _autoplayTimer?.cancel();
  }

  @override
  void dispose() {
    stopAutoplay();

    super.dispose();
  }

  /// Returns the index of the currently selected item. If [MoonCarousel.loop] is true it provides the modded index value.
  int get selectedItem => _getTrueIndex(
        (position as _MoonCarouselScrollPosition).itemIndex,
        (position as _MoonCarouselScrollPosition).itemCount,
      );

  /// Animate to the specified item index.
  Future<void> animateToItem(int itemIndex, {Duration? duration, Curve? curve}) async {
    if (!hasClients) return;

    await Future.wait<void>([
      for (final position in positions.cast<_MoonCarouselScrollPosition>())
        position.animateTo(
          itemIndex * position.itemExtent,
          duration: duration ?? const Duration(milliseconds: 800),
          curve: curve ?? Curves.fastOutSlowIn,
        ),
    ]);
  }

  /// Jump to the specified item index.
  void jumpToItem(int itemIndex) {
    for (final position in positions.cast<_MoonCarouselScrollPosition>()) {
      position.jumpTo(itemIndex * position.itemExtent);
    }
  }

  /// Animate to the next item in the viewport.
  Future<void> nextItem({Duration? duration, Curve? curve}) async {
    if (!hasClients) return;

    await Future.wait<void>([
      for (final position in positions.cast<_MoonCarouselScrollPosition>())
        position.animateTo(
          offset + position.itemExtent,
          duration: duration ?? const Duration(milliseconds: 800),
          curve: curve ?? Curves.fastOutSlowIn,
        ),
    ]);
  }

  /// Animate to the previous item in the viewport.
  Future<void> previousItem({Duration? duration, Curve? curve}) async {
    if (!hasClients) return;

    await Future.wait<void>([
      for (final position in positions.cast<_MoonCarouselScrollPosition>())
        position.animateTo(
          offset - position.itemExtent,
          duration: duration ?? const Duration(milliseconds: 800),
          curve: curve ?? Curves.fastOutSlowIn,
        ),
    ]);
  }

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics, ScrollContext context, ScrollPosition? oldPosition) {
    return _MoonCarouselScrollPosition(
      context: context,
      initialItem: initialItem,
      oldPosition: oldPosition,
      physics: physics,
    );
  }
}

/// The metrics for the [MoonCarouselScrollController].
class MoonCarouselExtentMetrics extends FixedScrollMetrics {
  /// The index of the currently selected item within the scroll view.
  final int itemIndex;

  /// Provides an immutable snapshot of the current scroll positions within the carousel.
  /// This snapshot can be directly accessed by [ScrollNotification] to retrieve the currently selected
  /// real item index at any given moment.
  MoonCarouselExtentMetrics({
    required super.minScrollExtent,
    required super.maxScrollExtent,
    required super.pixels,
    required super.viewportDimension,
    required super.axisDirection,
    required super.devicePixelRatio,
    required this.itemIndex,
  });

  @override
  MoonCarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    int? itemIndex,
  }) {
    return MoonCarouselExtentMetrics(
      axisDirection: axisDirection ?? this.axisDirection,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : 0.0),
      maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
      pixels: pixels ?? this.pixels,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }
}

int _getItemFromOffset({
  required double itemExtent,
  required double minScrollExtent,
  required double maxScrollExtent,
  required double offset,
}) {
  return (_clipOffsetToScrollableRange(offset, minScrollExtent, maxScrollExtent) / itemExtent).round();
}

double _clipOffsetToScrollableRange(double offset, double minScrollExtent, double maxScrollExtent) {
  return math.min(math.max(offset, minScrollExtent), maxScrollExtent);
}

// Returns the modded item index from the real index.
int _getTrueIndex(int currentIndex, int totalCount) {
  if (currentIndex >= 0) return currentIndex % totalCount;

  return (totalCount + (currentIndex % totalCount)) % totalCount;
}

class _MoonCarouselScrollPosition extends ScrollPositionWithSingleContext implements MoonCarouselExtentMetrics {
  _MoonCarouselScrollPosition({
    required super.physics,
    required super.context,
    required int initialItem,
    super.oldPosition,
  })  : assert(context is _MoonCarouselScrollableState),
        super(initialPixels: _getItemExtentFromScrollContext(context) * initialItem);

  double get anchor => _getAnchorFromScrollContext(context);

  static double _getAnchorFromScrollContext(ScrollContext context) => (context as _MoonCarouselScrollableState).anchor;

  double get itemExtent => _getItemExtentFromScrollContext(context);

  static double _getItemExtentFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).itemExtent;

  double get gap => _getGapFromScrollContext(context);

  static double _getGapFromScrollContext(ScrollContext context) => (context as _MoonCarouselScrollableState).gap;

  int get itemCount => _getItemCountFromScrollContext(context);

  static int _getItemCountFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).itemCount;

  bool get clampMaxExtent => _getDeferMaxExtentFromScrollContext(context);

  static bool _getDeferMaxExtentFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).clampMaxExtent;

  bool get loop => _getLoopFromScrollContext(context);

  static bool _getLoopFromScrollContext(ScrollContext context) => (context as _MoonCarouselScrollableState).loop;

  double get velocityFactor => _getVelocityFactorFromScrollContext(context);

  static double _getVelocityFactorFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).velocityFactor;

  @override
  int get itemIndex {
    return _getItemFromOffset(
      itemExtent: itemExtent,
      minScrollExtent: hasContentDimensions ? minScrollExtent : 0.0,
      maxScrollExtent: maxScrollExtent,
      offset: pixels,
    );
  }

  @override
  double get maxScrollExtent {
    if (loop) {
      return super.hasContentDimensions ? super.maxScrollExtent : 0.0;
    } else if (clampMaxExtent) {
      final itemsToSubtract = viewportDimension ~/ itemExtent;
      final remainderOfViewport = viewportDimension % itemExtent;
      final anchorWhitespaceFactor = viewportDimension * anchor * 2;

      return itemExtent * (itemCount - itemsToSubtract) - remainderOfViewport + anchorWhitespaceFactor - gap;
    } else {
      return itemExtent * (itemCount - 1);
    }
  }

  @override
  MoonCarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    int? itemIndex,
  }) {
    return MoonCarouselExtentMetrics(
      axisDirection: axisDirection ?? this.axisDirection,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : 0.0),
      maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
      pixels: pixels ?? this.pixels,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }
}

/// The physics for the [MoonCarousel].
class MoonCarouselScrollPhysics extends ScrollPhysics {
  /// Extends Flutter's [FixedExtentScrollPhysics] to implement carousel-specific behavior.
  /// When [MoonCarousel.loop] is false, friction is applied when the user tries to scroll beyond the viewport.
  /// The friction factor is calculated the same way as in [BouncingScrollPhysics].
  const MoonCarouselScrollPhysics({super.parent});

  @override
  MoonCarouselScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MoonCarouselScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('$runtimeType.applyBoundaryConditions() was called redundantly.'),
          ErrorDescription(
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.',
          ),
          DiagnosticsProperty<ScrollPhysics>(
            'The physics object in question was',
            this,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
          DiagnosticsProperty<ScrollMetrics>(
            'The position object in question was',
            position,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
        ]);
      }

      return true;
    }());
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      // Underscroll.
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      // Overscroll.
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      // Hit top edge.
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      // Hit bottom edge.
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final _MoonCarouselScrollPosition metrics = position as _MoonCarouselScrollPosition;

    // Scenario 1:
    // If the carousel is out of range and not returning to range, we defer to the parent ballistics to bring
    // the carousel back into range at the scrollable boundary.
    if ((velocity <= 0.0 && metrics.pixels <= metrics.minScrollExtent) ||
        (velocity >= 0.0 && metrics.pixels >= metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // Perform a test simulation to determine the carousel's ballistic trajectory without
    // interference from carousel items, simulating a natural fall.
    final Simulation? testFrictionSimulation = super.createBallisticSimulation(
      metrics,
      velocity * math.min(metrics.velocityFactor + 0.15, 1.0),
    );

    // Scenario 2:
    // If the simulated trajectory would have taken the carousel beyond the scroll extent,
    // defer back to the parent physics' ballistics to prevent it from overshooting the scrollable boundary.
    if (testFrictionSimulation != null &&
        (testFrictionSimulation.x(double.infinity) == metrics.minScrollExtent ||
            testFrictionSimulation.x(double.infinity) == metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // From the simulated final position, identify the nearest item the carousel should have settled
    // onto based on its natural trajectory.
    final int settlingItemIndex = _getItemFromOffset(
      itemExtent: metrics.itemExtent,
      minScrollExtent: metrics.minScrollExtent,
      maxScrollExtent: metrics.maxScrollExtent,
      offset: testFrictionSimulation?.x(double.infinity) ?? metrics.pixels,
    );

    final double settlingPixels = settlingItemIndex * metrics.itemExtent;

    // Scenario 3:
    // If the carousel has zero velocity and is already at the position it should settle onto,
    // there's no need for further action.
    final Tolerance tolerance = toleranceFor(metrics);

    if (velocity.abs() < tolerance.velocity && (settlingPixels - metrics.pixels).abs() < tolerance.distance) {
      return null;
    }

    // Scenario 4:
    // If the simulated trajectory indicates the carousel is likely to return to its initial position due to
    // a lack of sufficient initial velocity, use a spring simulation.
    if (settlingItemIndex == metrics.itemIndex) {
      return SpringSimulation(
        spring,
        metrics.pixels,
        settlingPixels,
        velocity * metrics.velocityFactor,
        tolerance: tolerance,
      );
    }

    // Scenario 5:
    // Create a new friction simulation, adjusting the drag force to ensure the carousel transitions
    // to the nearest item, aligning with its natural stopping point.
    return FrictionSimulation.through(
      metrics.pixels,
      settlingPixels,
      velocity * metrics.velocityFactor,
      tolerance.velocity * metrics.velocityFactor * velocity.sign,
    );
  }
}
