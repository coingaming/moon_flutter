import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/utils/squircle/squircle_border_radius.dart';
import 'package:moon_design/src/widgets/bottom_sheet/modal_bottom_sheet.dart';
import 'package:moon_design/src/widgets/bottom_sheet/utils/bottom_sheet_custom_scroll_physics.dart';
import 'package:moon_design/src/widgets/bottom_sheet/utils/bottom_sheet_suspended_curve.dart';
import 'package:moon_design/src/widgets/bottom_sheet/utils/scroll_to_top_status_bar.dart';
import 'package:moon_tokens/moon_tokens.dart';

const double _minFlingVelocity = 500.0;
const double _closeProgressThreshold = 0.6;

typedef WidgetWithChildBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Widget child,
);

/// The Moon Design bottom sheet.
///
/// The MoonBottomSheet widget itself is rarely used directly.
/// Instead, prefer to create a modal bottom sheet with
/// [showMoonModalBottomSheet].
class MoonBottomSheet extends StatefulWidget {
  /// Whether the bottom sheet can be dragged vertically and dismissed by
  /// swiping downwards.
  final bool enableDrag;

  /// Whether the bottom sheet is expanded to its full available width or
  /// resizes to fit its content.
  final bool isExpanded;

  /// The border radius of the bottom sheet.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the bottom sheet.
  final Color? backgroundColor;

  /// The custom decoration of the bottom sheet.
  final Decoration? decoration;

  /// The minimum velocity required for the bottom sheet to close when flung.
  final double minFlingVelocity;

  /// The threshold distance that the bottom sheet must be dragged to before it
  /// triggers dismissal.
  final double closeProgressThreshold;

  /// The fixed height of the bottom sheet or null to adjust to the content
  /// height.
  final double? height;

  /// The duration of the bottom sheet transition animation (slide in or out).
  final Duration? transitionDuration;

  /// The curve of the bottom sheet transition animation (slide in or out).
  final Curve? transitionCurve;

  /// The semantic label for the bottom sheet.
  final String? semanticLabel;

  /// The callback that is called when the bottom sheet begins the closing
  /// process.
  ///
  /// The bottom sheet may not be fully closed (e.g., due to user interaction)
  /// even after this callback is called. Therefore, this callback may be called
  /// multiple times for the same bottom sheet.
  final void Function() onClosing;

  /// The callback that is called to determine whether the bottom sheet should
  /// close based on user interaction.
  ///
  /// If [shouldClose] is null, it is ignored.
  /// If the return value is true, the bottom sheet closes.
  /// If the return value is false, the bottom sheet remains open.
  ///
  /// If [shouldClose] is not null, the bottom sheet will temporarily
  /// return to its previous position until the function returns a value.
  final Future<bool> Function()? shouldClose;

  /// Controls the animation for the bottom sheet entrance and exit transitions.
  ///
  /// The bottom sheet will manipulate the position of this animation controller.
  final AnimationController animationController;

  /// The scroll controller used to navigate the content within the bottom sheet.
  final ScrollController scrollController;

  /// The widget to display inside the bottom sheet as its content.
  final Widget child;

  /// Creates a Moon Design modal bottom sheet.
  const MoonBottomSheet({
    super.key,
    this.enableDrag = true,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    double? closeProgressThreshold,
    this.height,
    this.minFlingVelocity = _minFlingVelocity,
    this.transitionDuration,
    this.transitionCurve,
    this.semanticLabel,
    required this.onClosing,
    this.shouldClose,
    required this.animationController,
    required this.scrollController,
    required this.child,
  }) : closeProgressThreshold =
            closeProgressThreshold ?? _closeProgressThreshold;

  @override
  MoonBottomSheetState createState() => MoonBottomSheetState();

  /// Creates an [AnimationController] specifically designed for a
  /// [MoonBottomSheet.animationController].
  ///
  /// This API serves as a convenient mechanism to create a Material compliant
  /// bottom sheet animation. If custom animation durations are required, a
  /// different animation controller should be utilized.
  static AnimationController createAnimationController(
    TickerProvider vsync,
    Duration duration,
  ) {
    return AnimationController(
      duration: duration,
      debugLabel: 'MoonBottomSheet',
      vsync: vsync,
    );
  }
}

class MoonBottomSheetState extends State<MoonBottomSheet>
    with TickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  // Used in NotificationListener to identify distinct ScrollNotification events
  // before and after the dragging gesture.
  bool _isDragging = false;

  bool _verifyingShouldClose = false;

  Curve? _defaultCurve;

  ParametricCurve<double>? transitionCurve;

  DateTime? _startTime;

  // The DragGesture detector of the scroll view cannot be directly accessed,
  // therefore a VelocityTracker is used to determine the scroll end velocity
  // when attempting to dismiss the modal via dragging.
  VelocityTracker? _velocityTracker;

  bool get needsVerifyShouldClose => widget.shouldClose != null;

  bool get _dismissUnderway =>
      widget.animationController.status == AnimationStatus.reverse;

  bool get _hasReachedCloseThreshold =>
      widget.animationController.value < widget.closeProgressThreshold;

  double? get _childHeight =>
      (_childKey.currentContext?.findRenderObject() as RenderBox?)?.size.height;

  ScrollController get _scrollController => widget.scrollController;

  void _close() {
    _isDragging = false;
    widget.onClosing();
  }

  void _cancelClose() {
    widget.animationController.forward().then((value) {
      if (!widget.animationController.isCompleted) {
        widget.animationController.value = 1;
      }
    });
  }

  FutureOr<bool> shouldClose() async {
    if (_verifyingShouldClose) return false;
    _verifyingShouldClose = true;

    final bool? result = await widget.shouldClose?.call();
    _verifyingShouldClose = false;

    return result ?? false;
  }

  Future<void> _handleDragUpdate(double primaryDelta) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    transitionCurve = Curves.linear;

    if (_dismissUnderway) return;
    _isDragging = true;

    final double progress = primaryDelta / (_childHeight ?? primaryDelta);

    if (widget.shouldClose != null) {
      _cancelClose();

      final bool canClose = await shouldClose();

      if (canClose) {
        _close();
        return;
      } else {
        _cancelClose();
      }
    }

    widget.animationController.value -= progress;
  }

  Future<void> _handleDragEnd(double velocity) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    if (_dismissUnderway || !_isDragging) return;

    transitionCurve = BottomSheetSuspendedCurve(
      widget.animationController.value,
      curve: _defaultCurve!,
    );

    _isDragging = false;

    Future<void> tryClose() async {
      if (widget.shouldClose != null) {
        _cancelClose();

        final bool canClose = await shouldClose();

        if (canClose) _close();
      } else {
        _close();
      }
    }

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

    final bool isScrollReversed =
        scrollPosition.axisDirection == AxisDirection.down;
    final double offset = isScrollReversed
        ? scrollPosition.pixels
        : scrollPosition.maxScrollExtent - scrollPosition.pixels;

    if (offset <= 0) {
      // ClampingScrollPhysics terminates with a ScrollEndNotification that
      // encompasses a DragEndDetails class, while BouncingScrollPhysics and
      // other physics that permit overflow do not provide drag end information.

      // We utilize the velocity from DragEndDetails if it is accessible.
      if (notification is ScrollEndNotification) {
        final DragEndDetails? dragDetails = notification.dragDetails;

        if (dragDetails != null) {
          _handleDragEnd(dragDetails.primaryVelocity ?? 0);
          _velocityTracker = null;
          _startTime = null;

          return;
        }
      }

      // Otherwise, the velocity is calculated using a VelocityTracker.
      if (_velocityTracker == null) {
        final PointerDeviceKind pointerKind =
            _defaultPointerDeviceKind(context);

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

      if (notification is UserScrollNotification) return;

      assert(_velocityTracker != null);
      assert(_startTime != null);

      final startTime = _startTime!;
      final velocityTracker = _velocityTracker!;

      if (dragDetails != null) {
        final Duration duration = startTime.difference(DateTime.now());

        velocityTracker.addPosition(duration, Offset(0, offset));

        _handleDragUpdate(dragDetails.delta.dy);

        return;
      } else if (_isDragging) {
        final double velocity =
            velocityTracker.getVelocity().pixelsPerSecond.dy;

        _velocityTracker = null;
        _startTime = null;

        _handleDragEnd(velocity);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.bottomSheetTheme.properties.borderRadius ??
        MoonBorders.borders.surfaceSm;

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.bottomSheetTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveIconColor =
        context.moonTheme?.bottomSheetTheme.colors.iconColor ??
            MoonColors.light.iconPrimary;

    final Color effectiveTextColor =
        context.moonTheme?.bottomSheetTheme.colors.textColor ??
            MoonColors.light.textPrimary;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.bottomSheetTheme.properties.textStyle ??
            MoonTypography.typography.body.textDefault;

    _defaultCurve ??= widget.transitionCurve ??
        context.moonTheme?.bottomSheetTheme.properties.transitionCurve ??
        const Cubic(0.0, 0.0, 0.2, 1.0);

    transitionCurve ??= _defaultCurve;

    return ScrollToTopStatusBarHandler(
      scrollController: _scrollController,
      child: AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget? child) {
          assert(child != null);

          final double animationValue =
              transitionCurve!.transform(widget.animationController.value);

          final draggableChild = widget.enableDrag
              ? KeyedSubtree(
                  key: _childKey,
                  child: GestureDetector(
                    onVerticalDragUpdate: (DragUpdateDetails details) =>
                        _handleDragUpdate(details.delta.dy),
                    onVerticalDragEnd: (DragEndDetails details) =>
                        _handleDragEnd(details.primaryVelocity ?? 0),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        _handleScrollUpdate(notification);

                        return false;
                      },
                      child: child!,
                    ),
                  ),
                )
              : child;

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
          behavior: const ScrollBehavior().copyWith(
            overscroll: false,
            scrollbars: false,
            physics: CustomModalScrollPhysics(
              controller: widget.animationController,
              parent: const BouncingScrollPhysics(),
            ),
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: RepaintBoundary(
            child: Semantics(
              label: widget.semanticLabel,
              child: IconTheme(
                data: IconThemeData(color: effectiveIconColor),
                child: DefaultTextStyle(
                  style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                  child: Container(
                    height: widget.height,
                    decoration: widget.decoration ??
                        ShapeDecorationWithPremultipliedAlpha(
                          color: effectiveBackgroundColor,
                          shape: MoonSquircleBorder(
                            borderRadius: MoonSquircleBorderRadius.only(
                              topLeft: effectiveBorderRadius
                                  .squircleBorderRadius(context)
                                  .topLeft,
                              topRight: effectiveBorderRadius
                                  .squircleBorderRadius(context)
                                  .topRight,
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

  _ModalBottomSheetLayout({required this.isExpanded, required this.progress});

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

// Determines the input type of the device's operating system.
// Mobile platforms default to 'touch' input and desktop to 'mouse' input.
// Used with VelocityTracker.
// https://github.com/flutter/flutter/pull/64267#issuecomment-694196304
PointerDeviceKind _defaultPointerDeviceKind(BuildContext context) {
  final TargetPlatform platform = Theme.of(context).platform;

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
