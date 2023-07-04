import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/theme/typography/typography.dart';

class MoonCarousel extends StatefulWidget {
  /// Axis direction of the carousel. Defaults to `Axis.horizontal`.
  final Axis axisDirection;

  /// Whether to automatically scroll the carousel. Defaults to `false`.
  final bool autoPlay;

  /// Whether to always align the selected item to center of the viewport (including the first and the last position).
  /// Defaults to `false`.
  final bool isItemAlwaysCentered;

  /// Whether to create an infinite looping list. Defaults to `true`.
  final bool loop;

  /// Gap between items in the viewport.
  final double? gap;

  /// Maximum width for single item in the viewport.
  final double itemExtent;

  /// Multiply velocity of carousel scrolling by this factor. Defaults to `0.5`.
  final double velocityFactor;

  /// Carousel auto play delay between items.
  final Duration? autoPlayDelay;

  /// Carousel transition duration (auto play duration).
  final Duration? transitionDuration;

  /// Accordion transition curve (auto play curve).
  final Curve? transitionCurve;

  /// Total items to build for the carousel.
  final int itemCount;

  /// Scroll controller for [MoonCarousel].
  final ScrollController? controller;

  /// Physics for [MoonCarousel]. Defaults to [MoonCarouselScrollPhysics], which makes sure we always land on a
  /// particular item after scrolling.
  final ScrollPhysics? physics;

  /// Scroll behavior for [MoonCarousel].
  final ScrollBehavior? scrollBehavior;

  /// Callback which is fired when item index has changed.
  final void Function(int)? onIndexChanged;

  /// For lazily building items in the viewport.
  ///
  /// When `loop: false`, `itemIndex` is equal to `realIndex` (i.e, index of element).
  ///
  /// When `loop: true`, two indexes are exposed by the `itemBuilder`.
  ///
  /// First one is the  `itemIndex`, that is the modded item index, i.e. for list of 10, position(11) = 1, and
  /// position(-1) = 9.
  ///
  /// Second one is the `realIndex`, that is the actual index, i.e. [..., -2, -1, 0, 1, 2, ...] in loop.
  /// `realIndex` is necessary to support `jumpToItem` by tapping on it.
  final Widget Function(BuildContext context, int itemIndex, int realIndex) itemBuilder;

  /// MDS Carousel widget.
  const MoonCarousel({
    super.key,
    this.axisDirection = Axis.horizontal,
    this.autoPlay = false,
    this.isItemAlwaysCentered = false,
    this.loop = false,
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
  final Key _forwardListKey = const ValueKey<String>("moon_carousel_key");

  late int _lastReportedItemIndex;
  late MoonCarouselScrollController _scrollController;

  // Get the anchor for the viewport to place the item at the center.
  double _getCenteredAnchor(BoxConstraints constraints) {
    if (!widget.isItemAlwaysCentered) return 0;

    final maxExtent = widget.axisDirection == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;

    return ((maxExtent / 2) - (widget.itemExtent / 2)) / maxExtent;
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

    _scrollController = (widget.controller as MoonCarouselScrollController?) ??
        MoonCarouselScrollController(isItemAlwaysCentered: widget.isItemAlwaysCentered);

    _lastReportedItemIndex = _scrollController.initialItem;

    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> _buildSlivers(BuildContext context) {
    final double effectiveGap = context.moonTheme?.carouselTheme.properties.gap ?? MoonSizes.sizes.x2s;

    /// Delegate for lazily building items in the forward direction.
    final SliverChildDelegate childDelegate = SliverChildBuilderDelegate(
      (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: effectiveGap / 2),
        child: widget.itemBuilder(context, index.abs() % widget.itemCount, index),
      ),
      childCount: widget.loop ? null : widget.itemCount,
    );

    /// Delegate for lazily building items in the reverse direction.
    final SliverChildDelegate? reversedChildDelegate = widget.loop
        ? SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: effectiveGap / 2),
              child: widget.itemBuilder(context, widget.itemCount - (index.abs() % widget.itemCount) - 1, -(index + 1)),
            ),
          )
        : null;

    final Widget forward =
        SliverFixedExtentList(key: _forwardListKey, delegate: childDelegate, itemExtent: widget.itemExtent);

    if (!widget.loop) return [forward];

    final Widget reversed = SliverFixedExtentList(delegate: reversedChildDelegate!, itemExtent: widget.itemExtent);

    return [reversed, forward];
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor =
        context.moonTheme?.carouselTheme.colors.textColor ?? MoonTypography.light.colors.bodyPrimary;

    final Color effectiveIconColor =
        context.moonTheme?.carouselTheme.colors.iconColor ?? MoonIconTheme.light.colors.primaryColor;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.carouselTheme.properties.textStyle ?? MoonTextStyles.body.textDefault;

    final AxisDirection axisDirection = _getDirection(context);

    final ScrollBehavior effectiveScrollBehavior = widget.scrollBehavior ??
        (kIsWeb
            ? ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              )
            : ScrollConfiguration.of(context).copyWith(scrollbars: false));

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
          final centeredAnchor = _getCenteredAnchor(constraints);

          return IconTheme(
            data: IconThemeData(
              color: effectiveIconColor,
            ),
            child: DefaultTextStyle(
              style: effectiveTextStyle.copyWith(color: effectiveTextColor),
              child: _MoonCarouselScrollable(
                axisDirection: axisDirection,
                controller: _scrollController,
                itemCount: widget.itemCount,
                itemExtent: widget.itemExtent,
                loop: widget.loop,
                physics: widget.physics ??
                    MoonCarouselScrollPhysics(
                      lastItemIndex: widget.itemCount - 1,
                      isItemAlwaysCentered: widget.isItemAlwaysCentered,
                    ),
                scrollBehavior: effectiveScrollBehavior,
                velocityFactor: widget.velocityFactor,
                viewportBuilder: (BuildContext context, ViewportOffset position) {
                  return Viewport(
                    anchor: centeredAnchor,
                    axisDirection: axisDirection,
                    center: _forwardListKey,
                    offset: position,
                    slivers: _buildSlivers(context),
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

/// Extends Scrollable to also include viewport children's itemExtent, itemCount, loop and other values.
/// This is done so that the ScrollPosition and Physics can also access these values via scroll context.
class _MoonCarouselScrollable extends Scrollable {
  final bool loop;
  final double itemExtent;
  final double velocityFactor;
  final int itemCount;

  const _MoonCarouselScrollable({
    super.axisDirection = AxisDirection.right,
    super.controller,
    super.physics,
    super.scrollBehavior,
    required super.viewportBuilder,
    required this.loop,
    required this.itemExtent,
    required this.velocityFactor,
    required this.itemCount,
  });

  @override
  _MoonCarouselScrollableState createState() => _MoonCarouselScrollableState();
}

class _MoonCarouselScrollableState extends ScrollableState {
  bool get loop => (widget as _MoonCarouselScrollable).loop;
  double get itemExtent => (widget as _MoonCarouselScrollable).itemExtent;
  double get velocityFactor => (widget as _MoonCarouselScrollable).velocityFactor;
  int get itemCount => (widget as _MoonCarouselScrollable).itemCount;
}

/// Scroll controller for [MoonCarousel].
class MoonCarouselScrollController extends ScrollController {
  /// Initial item index for [MoonCarouselScrollController]. Defaults to `0`.
  final int initialItem;

  /// Whether or not the carousel item is centered in the viewport at all times (including first and last item).
  final bool isItemAlwaysCentered;

  /// Scroll controller for [MoonCarousel].
  MoonCarouselScrollController({this.initialItem = 0, this.isItemAlwaysCentered = false});

  // Timer for autoplay.
  Timer? _autoplayTimer;

  void startAutoPlay({
    Duration delay = const Duration(seconds: 3),
    Duration? duration,
    Curve? curve,
  }) {
    _autoplayTimer?.cancel();

    _autoplayTimer = Timer.periodic(delay, (timer) {
      // If at end of carousel, animate back to the beginning.
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

  /// Returns the selected item's index. If `loop: true`, then it returns the modded index value.
  int get selectedItem => _getTrueIndex(
        (position as _MoonCarouselScrollPosition).itemIndex,
        (position as _MoonCarouselScrollPosition).itemCount,
      );

  /// Animate to specific item index.
  Future<void> animateToItem(
    int itemIndex, {
    Duration? duration,
    Curve? curve,
  }) async {
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

  /// Jump to specific item index.
  void jumpToItem(int itemIndex) {
    for (final position in positions.cast<_MoonCarouselScrollPosition>()) {
      position.jumpTo(itemIndex * position.itemExtent);
    }
  }

  /// Animate to the next item in the viewport.
  Future<void> nextItem({
    Duration? duration,
    Curve? curve,
  }) async {
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
  Future<void> previousItem({required BuildContext context, Duration? duration, Curve? curve}) async {
    if (!hasClients) return;

    final Duration effectiveTransitionDuration =
        duration ?? context.moonTheme?.carouselTheme.properties.transitionDuration ?? const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        curve ?? context.moonTheme?.carouselTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    await Future.wait<void>([
      for (final position in positions.cast<_MoonCarouselScrollPosition>())
        position.animateTo(
          offset - position.itemExtent,
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
        ),
    ]);
  }

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics, ScrollContext context, ScrollPosition? oldPosition) {
    return _MoonCarouselScrollPosition(
      context: context,
      initialItem: initialItem,
      isItemAlwaysCentered: isItemAlwaysCentered,
      oldPosition: oldPosition,
      physics: physics,
    );
  }
}

/// Metrics for the [MoonCarouselScrollController].
class MoonCarouselExtentMetrics extends FixedScrollMetrics {
  /// The scroll view's currently selected item index.
  final int itemIndex;

  /// This is an immutable snapshot of the current values of scroll positions. This can directly be accessed by
  /// [ScrollNotification] to get currently selected real item index at any time.
  MoonCarouselExtentMetrics({
    required super.axisDirection,
    required super.maxScrollExtent,
    required super.minScrollExtent,
    required super.pixels,
    required super.viewportDimension,
    //TODO: uncomment when 3.10: required double devicePixelRatio,
    required this.itemIndex,
  });

  @override
  MoonCarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    //TODO: uncomment when 3.10: double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    int? itemIndex,
  }) {
    return MoonCarouselExtentMetrics(
      axisDirection: axisDirection ?? this.axisDirection,
      //TODO: uncomment when 3.10: devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
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

/// Get the modded item index from the real index.
int _getTrueIndex(int currentIndex, int totalCount) {
  if (currentIndex >= 0) {
    return currentIndex % totalCount;
  }

  return (totalCount + (currentIndex % totalCount)) % totalCount;
}

class _MoonCarouselScrollPosition extends ScrollPositionWithSingleContext implements MoonCarouselExtentMetrics {
  final bool isItemAlwaysCentered;

  _MoonCarouselScrollPosition({
    required super.physics,
    required super.context,
    required int initialItem,
    required this.isItemAlwaysCentered,
    super.oldPosition,
  })  : assert(context is _MoonCarouselScrollableState),
        super(initialPixels: _getItemExtentFromScrollContext(context) * initialItem);

  double get itemExtent => _getItemExtentFromScrollContext(context);
  static double _getItemExtentFromScrollContext(ScrollContext context) {
    return (context as _MoonCarouselScrollableState).itemExtent;
  }

  int get itemCount => _getItemCountFromScrollContext(context);
  static int _getItemCountFromScrollContext(ScrollContext context) {
    return (context as _MoonCarouselScrollableState).itemCount;
  }

  bool get loop => _getLoopFromScrollContext(context);
  static bool _getLoopFromScrollContext(ScrollContext context) {
    return (context as _MoonCarouselScrollableState).loop;
  }

  double get velocityFactor => _getVelocityFactorFromScrollContext(context);
  static double _getVelocityFactorFromScrollContext(ScrollContext context) {
    return (context as _MoonCarouselScrollableState).velocityFactor;
  }

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
  double get maxScrollExtent => loop
      ? (super.hasContentDimensions ? super.maxScrollExtent : 0.0)
      : isItemAlwaysCentered
          // Use the sum of carousel items itemExtent as max scroll extent
          ? itemExtent * (itemCount - 1)
          // Use carousel container size as max scroll extent
          : super.maxScrollExtent;

  @override
  MoonCarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    //TODO: uncomment when 3.10: double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    int? itemIndex,
  }) {
    return MoonCarouselExtentMetrics(
      axisDirection: axisDirection ?? this.axisDirection,
      //TODO: uncomment when 3.10: devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : 0.0),
      maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
      pixels: pixels ?? this.pixels,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }
}

/// Physics for the [MoonCarousel].
class MoonCarouselScrollPhysics extends ScrollPhysics {
  /// The index of the last item in the carousel.
  final int lastItemIndex;

  /// Whether all of the items are centered in the viewport (including the first and the last item).
  final bool isItemAlwaysCentered;

  /// Based on Flutter's [FixedExtentScrollPhysics]. Hence, it always lands on a particular item.
  ///
  /// If `loop: false`, friction is applied when user tries to go beyond viewport. The friction factor is calculated the
  /// same  way as in [BouncingScrollPhysics].
  const MoonCarouselScrollPhysics({
    super.parent,
    required this.lastItemIndex,
    this.isItemAlwaysCentered = false,
  });

  @override
  MoonCarouselScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MoonCarouselScrollPhysics(
      parent: buildParent(ancestor),
      lastItemIndex: lastItemIndex,
      isItemAlwaysCentered: isItemAlwaysCentered,
    );
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;

  /// Increase friction for scrolling in out-of-bound areas.
  double frictionFactor(double overscrollFraction) => 0.12 * math.pow(1 - overscrollFraction, 2);

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (position.pixels > position.minScrollExtent && position.pixels < position.maxScrollExtent) {
      return offset;
    }

    final double overscrollPastStart = math.max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd = math.max(position.pixels - position.maxScrollExtent, 0.0);
    final double overscrollPast = math.max(overscrollPastStart, overscrollPastEnd);

    final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) || (overscrollPastEnd > 0.0 && offset > 0.0);

    final double friction = easing
        // Apply less resistance when easing the overscroll vs tensioning.
        ? frictionFactor((overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(overscrollPast / position.viewportDimension);

    final double direction = offset.sign;

    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(double extentOutside, double absDelta, double gamma) {
    assert(absDelta > 0);
    double total = 0.0;

    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;

      if (absDelta < deltaToLimit) return absDelta * gamma;

      total += extentOutside;
      // ignore: parameter_assignments
      absDelta -= deltaToLimit;
    }

    return total + absDelta;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final _MoonCarouselScrollPosition metrics = position as _MoonCarouselScrollPosition;

    // Scenario 1:
    // If we're out of range and not headed back in range, defer to the parent ballistics, which should put us back in
    // range at the scrollable's boundary.
    if ((velocity <= 0.0 && metrics.pixels <= metrics.minScrollExtent) ||
        (velocity >= 0.0 && metrics.pixels >= metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // Create a test simulation to see where it would have ballistically fallen naturally without settling onto items.
    final Simulation? testFrictionSimulation = super.createBallisticSimulation(
      metrics,
      velocity * math.min(metrics.velocityFactor + 0.15, 1.0),
    );

    // Scenario 2:
    // If it was going to end up past the scroll extent, defer back to the parent physics' ballistics again which should
    // put us on the scrollable's boundary.
    if (testFrictionSimulation != null &&
        (testFrictionSimulation.x(double.infinity) == metrics.minScrollExtent ||
            testFrictionSimulation.x(double.infinity) == metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // From the natural final position, find the nearest item it should have settled to.
    final int settlingItemIndex = _getItemFromOffset(
      itemExtent: metrics.itemExtent,
      minScrollExtent: metrics.minScrollExtent,
      maxScrollExtent: metrics.maxScrollExtent,
      offset: testFrictionSimulation?.x(double.infinity) ?? metrics.pixels,
    );

    final centerCorrectionOffset = settlingItemIndex == lastItemIndex
        ? (metrics.viewportDimension - metrics.itemExtent)
        : settlingItemIndex != 0
            ? (metrics.viewportDimension - metrics.itemExtent) / 2
            : 0;

    final double settlingPixels =
        settlingItemIndex * metrics.itemExtent - (!isItemAlwaysCentered ? centerCorrectionOffset : 0);

    // Scenario 3:
    // If there's no velocity and we're already at where we intend to land, do nothing.
    //TODO: uncomment when 3.10: final tolerance = toleranceFor(metrics);
    if (velocity.abs() < tolerance.velocity && (settlingPixels - metrics.pixels).abs() < tolerance.distance) {
      return null;
    }

    // Scenario 4:
    // If we're going to end back at the same item because initial velocity is too low to break past it, use a spring
    // simulation to get back.
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
    // Create a new friction simulation except the drag will be tweaked to land exactly on the item closest to the
    // natural stopping point.
    return FrictionSimulation.through(
      metrics.pixels,
      settlingPixels,
      velocity * metrics.velocityFactor,
      tolerance.velocity * metrics.velocityFactor * velocity.sign,
    );
  }
}
