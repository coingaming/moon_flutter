import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/utils/squircle/squircle_border_radius.dart';
import 'package:moon_design/src/widgets/bottom_sheet/utils/bottom_sheet_suspended_curve.dart';
import 'package:moon_design/src/widgets/bottom_sheet/utils/scroll_to_top_status_bar.dart';

const Curve _decelerateEasing = Cubic(0.0, 0.0, 0.2, 1.0);

const Duration _bottomSheetDuration = Duration(milliseconds: 400);
const double _minFlingVelocity = 500.0;
const double _closeProgressThreshold = 0.6;
const double _willPopThreshold = 0.8;

typedef WidgetWithChildBuilder = Widget Function(BuildContext context, Animation<double> animation, Widget child);

/// A Moon Design bottom sheet.
///
/// The [MoonBottomSheet] widget itself is rarely used directly. Instead, prefer to create a modal bottom sheet
/// with [showMoonBottomSheet].
class MoonBottomSheet extends StatefulWidget {
  /// The border radius of the bottom sheet.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the bottom sheet.
  final Color? backgroundColor;

  /// Custom decoration for the bottom sheet.
  final Decoration? decoration;

  /// The semantic label for the bottom sheet.
  final String? semanticLabel;

  /// The closeProgressThreshold parameter
  /// specifies when the bottom sheet will be dismissed when user drags it.
  final double closeProgressThreshold;

  /// The animation controller that controls the bottom sheet's entrance and exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation.
  final AnimationController animationController;

  /// The duration of the animation for showing and dismissing the bottom sheet.
  final Duration? transitionDuration;

  /// The curve used by the animation for showing and dismissing the bottom sheet.
  final Curve? transitionCurve;

  /// Allows the bottom sheet to go beyond the top boundary of the content, but then bounces the content back to the
  /// edge of the top boundary.
  final bool hasBounce;

  // Force the widget to fill the maximum size of the viewport or if false it will fit to the content of the widget.
  final bool isExpanded;

  /// Called when the bottom sheet begins to close.
  ///
  /// A bottom sheet might be prevented from closing (e.g., by user interaction) even after this callback is called.
  /// For this reason, this callback might be called multiple times for a given bottom sheet.
  final void Function() onClosing;

  /// If shouldClose is null, this is ignored.
  /// If return value is true => The dialog closes
  /// If return value is false => The dialog cancels close
  /// Notice that if shouldClose is not null, the dialog will go back to the previous position until the function is
  /// solved.
  final Future<bool> Function()? shouldClose;

  /// A builder for the contents of the sheet.
  final Widget child;

  /// If true, the bottom sheet can be dragged up and down and dismissed by swiping downwards.
  ///
  /// Default is true.
  final bool enableDrag;

  /// The scroll controller of the content of the bottom sheet.
  final ScrollController scrollController;

  /// Determines how fast the sheet should be flinged before closing.
  final double minFlingVelocity;

  /// Determines how far the sheet should be flinged before closing.
  final double willPopThreshold;

  /// Creates a Moon Design modal bottom sheet.
  const MoonBottomSheet({
    super.key,
    required this.animationController,
    this.transitionCurve,
    this.enableDrag = true,
    this.hasBounce = true,
    this.shouldClose,
    required this.scrollController,
    required this.isExpanded,
    required this.onClosing,
    required this.child,
    this.minFlingVelocity = _minFlingVelocity,
    double? closeProgressThreshold,
    this.willPopThreshold = _willPopThreshold,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.semanticLabel,
    this.transitionDuration,
  }) : closeProgressThreshold = closeProgressThreshold ?? _closeProgressThreshold;

  @override
  MoonBottomSheetState createState() => MoonBottomSheetState();

  /// Creates an [AnimationController] suitable for a [MoonBottomSheet.animationController].
  ///
  /// This API available as a convenience for a Material compliant bottom sheet animation. If alternative animation
  /// durations are required, a different animation controller could be provided.
  static AnimationController createAnimationController(
    TickerProvider vsync, {
    Duration? duration,
  }) {
    return AnimationController(
      duration: duration ?? _bottomSheetDuration,
      debugLabel: 'BottomSheet',
      vsync: vsync,
    );
  }
}

class MoonBottomSheetState extends State<MoonBottomSheet> with TickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  late AnimationController _bounceDragController;

  // Used in NotificationListener to detect what the ScrollNotifications are before or after the user stop dragging.
  bool _isDragging = false;
  bool _isCheckingShouldClose = false;

  DateTime? _startTime;
  ParametricCurve<double> transitionCurve = Curves.linear;

  // As we cannot access the DragGesture detector of the scroll view we can not know the DragDownDetails and therefore
  // the end velocity. VelocityTracker is used to calculate the end velocity of the scroll when user is trying to close
  // the modal by dragging.
  VelocityTracker? _velocityTracker;

  bool get _dismissUnderway => widget.animationController.status == AnimationStatus.reverse;
  bool get _hasReachedWillPopThreshold => widget.animationController.value < _willPopThreshold;
  bool get _hasReachedCloseThreshold => widget.animationController.value < widget.closeProgressThreshold;
  Curve get _defaultCurve => widget.transitionCurve ?? _decelerateEasing;
  ScrollController get _scrollController => widget.scrollController;

  double? get _childHeight {
    final childContext = _childKey.currentContext;
    final renderBox = childContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height;
  }

  void _close() {
    _isDragging = false;
    widget.onClosing();
  }

  void _cancelClose() {
    widget.animationController.forward().then((value) {
      // When using WillPop, the animation does not end at 1.
      if (!widget.animationController.isCompleted) {
        widget.animationController.value = 1;
      }
    });

    _bounceDragController.reverse();
  }

  FutureOr<bool> shouldClose() async {
    if (_isCheckingShouldClose) return false;
    if (widget.shouldClose == null) return false;

    _isCheckingShouldClose = true;
    final result = await widget.shouldClose?.call();
    _isCheckingShouldClose = false;

    return result ?? false;
  }

  Future<void> _handleDragUpdate(double primaryDelta) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    transitionCurve = Curves.linear;

    if (_dismissUnderway) return;
    _isDragging = true;

    final progress = primaryDelta / (_childHeight ?? primaryDelta);

    if (widget.shouldClose != null && _hasReachedWillPopThreshold) {
      _cancelClose();

      final canClose = await shouldClose();

      if (canClose) {
        _close();
        return;
      } else {
        _cancelClose();
      }
    }

    // Bounce at the top boundary
    final hasBounce = widget.hasBounce == true;
    final shouldBounce = _bounceDragController.value > 0;
    final isBouncing = (widget.animationController.value - progress) > 1;

    if (hasBounce && (shouldBounce || isBouncing)) {
      _bounceDragController.value -= progress * 10;
      return;
    }

    widget.animationController.value -= progress;
  }

  Future<void> _handleDragEnd(double velocity) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    transitionCurve = BottomSheetSuspendedCurve(
      widget.animationController.value,
      curve: _defaultCurve,
    );

    if (_dismissUnderway || !_isDragging) return;

    _isDragging = false;
    _bounceDragController.reverse();

    Future<void> tryClose() async {
      if (widget.shouldClose != null) {
        _cancelClose();
        final bool canClose = await shouldClose();
        if (canClose) {
          _close();
        }
      } else {
        _close();
      }
    }

    // If speed is bigger than _minFlingVelocity try to close it
    if (velocity > widget.minFlingVelocity) {
      tryClose();
    } else if (_hasReachedCloseThreshold) {
      if (widget.animationController.value > 0.0) {
        widget.animationController.fling(velocity: -1.0);
      }
      tryClose();
    } else {
      _cancelClose();
    }
  }

  void _handleScrollUpdate(ScrollNotification notification) {
    assert(notification.context != null);
    // Check if ScrollController is used
    if (!_scrollController.hasClients) return;

    ScrollPosition scrollPosition;

    if (_scrollController.positions.length > 1) {
      scrollPosition = _scrollController.positions.firstWhere(
        (p) => p.isScrollingNotifier.value,
        orElse: () => _scrollController.positions.first,
      );
    } else {
      scrollPosition = _scrollController.position;
    }

    if (scrollPosition.axis == Axis.horizontal) return;

    final isScrollReversed = scrollPosition.axisDirection == AxisDirection.down;
    final offset = isScrollReversed ? scrollPosition.pixels : scrollPosition.maxScrollExtent - scrollPosition.pixels;

    if (offset <= 0) {
      // Clamping Scroll Physics ends with a ScrollEndNotification with a DragEndDetail class while
      // BouncingScrollPhysics or other physics that overflow will not return a drag end info.

      // We use the velocity from DragEndDetails if it is available.
      if (notification is ScrollEndNotification) {
        final dragDetails = notification.dragDetails;
        if (dragDetails != null) {
          _handleDragEnd(dragDetails.primaryVelocity ?? 0);
          _velocityTracker = null;
          _startTime = null;
          return;
        }
      }

      // Otherwise calculate the velocity with a VelocityTracker.
      if (_velocityTracker == null) {
        final pointerKind = defaultPointerDeviceKind(context);
        _velocityTracker = VelocityTracker.withKind(pointerKind);
        _startTime = DateTime.now();
      }

      DragUpdateDetails? dragDetails;

      if (notification is ScrollUpdateNotification) {
        dragDetails = notification.dragDetails;
      }

      if (notification is OverscrollNotification) {
        dragDetails = notification.dragDetails;
      }

      assert(_velocityTracker != null);
      assert(_startTime != null);

      final startTime = _startTime!;
      final velocityTracker = _velocityTracker!;

      if (dragDetails != null) {
        final duration = startTime.difference(DateTime.now());

        velocityTracker.addPosition(duration, Offset(0, offset));

        _handleDragUpdate(dragDetails.delta.dy);
      } else if (_isDragging) {
        final velocity = velocityTracker.getVelocity().pixelsPerSecond.dy;

        _velocityTracker = null;
        _startTime = null;

        _handleDragEnd(velocity);
      }
    }
  }

  @override
  void initState() {
    transitionCurve = _defaultCurve;
    _bounceDragController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.bottomSheetTheme.properties.borderRadius ??
        MoonBorders.borders.surfaceSm;

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.bottomSheetTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveTextColor =
        context.moonTheme?.bottomSheetTheme.colors.textColor ?? MoonTypography.light.colors.bodyPrimary;

    final Color effectiveIconColor =
        context.moonTheme?.bottomSheetTheme.colors.iconColor ?? MoonIconTheme.light.colors.primaryColor;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.bottomSheetTheme.properties.textStyle ?? MoonTextStyles.body.textDefault;

    final bounceAnimation = CurvedAnimation(
      parent: _bounceDragController,
      curve: Curves.easeOutSine,
    );

    return ScrollToTopStatusBarHandler(
      scrollController: _scrollController,
      child: AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, Widget? child) {
          assert(child != null);

          final animationValue = transitionCurve.transform(widget.animationController.value);

          final draggableChild = !widget.enableDrag
              ? child
              : KeyedSubtree(
                  key: _childKey,
                  child: AnimatedBuilder(
                    animation: bounceAnimation,
                    builder: (context, _) => CustomSingleChildLayout(
                      delegate: _BottomSheetChildLayout(bounceAnimation.value),
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) => _handleDragUpdate(details.delta.dy),
                        onVerticalDragEnd: (details) => _handleDragEnd(details.primaryVelocity ?? 0),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification) {
                            _handleScrollUpdate(notification);
                            return false;
                          },
                          child: child!,
                        ),
                      ),
                    ),
                  ),
                );

          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _ModalBottomSheetLayout(
                progress: animationValue,
                isExpanded: widget.isExpanded,
              ),
              child: draggableChild,
            ),
          );
        },
        child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: RepaintBoundary(
            child: Semantics(
              label: widget.semanticLabel,
              child: IconTheme(
                data: IconThemeData(color: effectiveIconColor),
                child: DefaultTextStyle(
                  style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                  child: Container(
                    decoration: widget.decoration ??
                        ShapeDecorationWithPremultipliedAlpha(
                          color: effectiveBackgroundColor,
                          shape: MoonSquircleBorder(
                            borderRadius: MoonSquircleBorderRadius.only(
                              topLeft: effectiveBorderRadius.squircleBorderRadius(context).topLeft,
                              topRight: effectiveBorderRadius.squircleBorderRadius(context).topRight,
                            ),
                          ),
                        ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  final bool isExpanded;
  final double progress;

  _ModalBottomSheetLayout({
    required this.isExpanded,
    required this.progress,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: isExpanded ? constraints.maxHeight : 0,
      maxHeight: isExpanded ? constraints.maxHeight : constraints.minHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _BottomSheetChildLayout extends SingleChildLayoutDelegate {
  _BottomSheetChildLayout(this.progress);

  final double progress;
  double? childHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight + progress * 8,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    childHeight ??= childSize.height;
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_BottomSheetChildLayout oldDelegate) {
    if (progress != oldDelegate.progress) {
      childHeight = oldDelegate.childHeight;
      return true;
    }
    return false;
  }
}

// Checks the device input type of the OS.
// Mobile platforms will be default to `touch` while desktop will do to `mouse`.
// Used with VelocityTracker
// https://github.com/flutter/flutter/pull/64267#issuecomment-694196304
PointerDeviceKind defaultPointerDeviceKind(BuildContext context) {
  final platform = Theme.of(context).platform;
  switch (platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      return PointerDeviceKind.touch;
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return PointerDeviceKind.mouse;
    case TargetPlatform.fuchsia:
      return PointerDeviceKind.unknown;
  }
}
