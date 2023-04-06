import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';

enum MoonPopoverPosition {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
  left,
  right,
  vertical,
  horizontal,
}

class MoonPopover extends StatefulWidget {
  // This is required so only one popover is shown at a time.
  static final List<MoonPopoverState> _openedPopovers = [];

  /// Controls the popover visibility.
  final bool show;

  /// Sets the popover position relative to the target. Defaults to [MoonPopoverPosition.vertical]
  final MoonPopoverPosition popoverPosition;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minWidth;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minHeight;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxWidth;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxHeight;

  /// Padding around the popover content.
  final EdgeInsets? contentPadding;

  /// The distance from the tip of the popover arrow (tail) to the target widget.
  final double? distanceToTarget;

  /// The width of the popover border.
  final double borderWidth;

  /// The border radius of the popover.
  final BorderRadius? borderRadius;

  /// The margin around popover. Used to prevent the popover from touching the edges of the viewport.
  final double popoverMargin;

  /// The color of the popover border.
  final Color borderColor;

  /// The color of the popover background.
  final Color? backgroundColor;

  /// List of popover shadows.
  final List<BoxShadow>? popoverShadows;

  /// Popover transition duration (fade in or out animation).
  final Duration? transitionDuration;

  /// Popover transition curve (fade in or out animation).
  final Curve? transitionCurve;

  /// `RouteObserver` used to listen for route changes that will hide the popover when the widget's route is not active.
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  /// The widget that its placed inside the popover and functions as its content.
  final Widget content;

  /// The [child] widget which the popover will target.
  final Widget child;

  /// MDS popover widget.
  const MoonPopover({
    super.key,
    required this.show,
    this.popoverPosition = MoonPopoverPosition.top,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.contentPadding,
    this.distanceToTarget,
    this.borderRadius,
    this.borderWidth = 0,
    this.popoverMargin = 8,
    this.borderColor = Colors.transparent,
    this.backgroundColor,
    this.transitionDuration,
    this.transitionCurve,
    this.popoverShadows,
    this.routeObserver,
    required this.content,
    required this.child,
  });

  // Causes any current popovers to be removed. Won't remove the supplied popover.
  static void _removeOtherPopovers(MoonPopoverState current) {
    if (_openedPopovers.isNotEmpty) {
      // Avoid concurrent modification.
      final List<MoonPopoverState> openedPopovers = _openedPopovers.toList();
      for (final MoonPopoverState state in openedPopovers) {
        if (state == current) {
          continue;
        }
        state._clearOverlayEntry();
      }
    }
  }

  @override
  MoonPopoverState createState() => MoonPopoverState();
}

class MoonPopoverState extends State<MoonPopover> with RouteAware, SingleTickerProviderStateMixin {
  final GlobalKey _popoverKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;

  bool _routeIsShowing = true;

  OverlayEntry? _overlayEntry;

  bool get shouldShowPopover => widget.show && _routeIsShowing;

  void _showPopover() {
    _overlayEntry = OverlayEntry(builder: (context) => _createOverlayContent());
    Overlay.of(context).insert(_overlayEntry!);

    MoonPopover._openedPopovers.add(this);
    MoonPopover._removeOtherPopovers(this);

    _animationController!.value = 0;
    _animationController!.forward();
  }

  void _updatePopover() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removePopover({bool immediately = false}) {
    if (immediately) {
      _clearOverlayEntry();
    } else {
      _animationController!.value = 1;
      _animationController!.reverse().then((value) => _clearOverlayEntry());
    }
  }

  void _clearOverlayEntry() {
    if (_overlayEntry != null) {
      MoonPopover._openedPopovers.remove(this);
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Color _getTextColor(BuildContext context, {required Color effectiveBackgroundColor}) {
    if (widget.backgroundColor == null && context.moonTypography != null) {
      return context.moonTypography!.colors.bodyPrimary;
    }

    final backgroundLuminance = effectiveBackgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  _PopoverPositionProperties _resolvePopoverPositionParameters({
    required MoonPopoverPosition popoverPosition,
    required double distanceToTarget,
    required double overlayWidth,
    required double popoverTargetGlobalLeft,
    required double popoverTargetGlobalCenter,
    required double popoverTargetGlobalRight,
  }) {
    switch (popoverPosition) {
      case MoonPopoverPosition.top:
        return _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          toolTipMaxWidth:
              overlayWidth - ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() - widget.popoverMargin * 2,
        );

      case MoonPopoverPosition.bottom:
        return _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          toolTipMaxWidth:
              overlayWidth - ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() - widget.popoverMargin * 2,
        );

      case MoonPopoverPosition.left:
        return _PopoverPositionProperties(
          offset: Offset(-distanceToTarget, 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          toolTipMaxWidth: popoverTargetGlobalLeft - distanceToTarget - widget.popoverMargin,
        );

      case MoonPopoverPosition.right:
        return _PopoverPositionProperties(
          offset: Offset(distanceToTarget, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          toolTipMaxWidth: overlayWidth - popoverTargetGlobalRight - distanceToTarget - widget.popoverMargin,
        );

      case MoonPopoverPosition.topLeft:
        return _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          toolTipMaxWidth: popoverTargetGlobalRight - widget.popoverMargin,
        );

      case MoonPopoverPosition.topRight:
        return _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          toolTipMaxWidth: overlayWidth - popoverTargetGlobalLeft - widget.popoverMargin,
        );

      case MoonPopoverPosition.bottomLeft:
        return _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          toolTipMaxWidth: popoverTargetGlobalRight - widget.popoverMargin,
        );

      case MoonPopoverPosition.bottomRight:
        return _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          toolTipMaxWidth: overlayWidth - popoverTargetGlobalLeft - widget.popoverMargin,
        );

      default:
        throw AssertionError(popoverPosition);
    }
  }

  void _handleTap(TapDownDetails details) {
    final RenderBox? popoverRenderBox = _popoverKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? overlayRenderBox = Overlay.of(context).context.findRenderObject() as RenderBox?;
    final popoverPosition = popoverRenderBox?.localToGlobal(Offset.zero, ancestor: overlayRenderBox);

    if (popoverPosition != null && !popoverRenderBox!.size.contains(details.localPosition - popoverPosition)) {
      _removePopover();
    }
  }

  @override
  void didPush() {
    _routeIsShowing = true;
    // Route was pushed onto navigator and is now topmost route.
    if (shouldShowPopover) {
      _removePopover();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _showPopover();
      });
    }
  }

  @override
  void didPushNext() {
    _routeIsShowing = false;
    _removePopover();
  }

  @override
  Future<void> didPopNext() async {
    _routeIsShowing = true;

    if (shouldShowPopover) {
      // Covering route was popped off the navigator.
      _removePopover();
      await Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _showPopover();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    });
  }

  @override
  void didUpdateWidget(MoonPopover oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_routeIsShowing) return;
      if (oldWidget.popoverPosition != widget.popoverPosition) {
        _removePopover(immediately: true);
        _showPopover();
      } else if (shouldShowPopover && _overlayEntry == null) {
        _showPopover();
      } else if (!shouldShowPopover && _overlayEntry != null) {
        _removePopover();
      }

      _updatePopover();
    });
  }

  @override
  void deactivate() {
    if (_overlayEntry != null) {
      _removePopover(immediately: true);
    }

    super.deactivate();
  }

  @override
  void dispose() {
    if (_overlayEntry != null) {
      _removePopover(immediately: true);
    }

    widget.routeObserver?.unsubscribe(this);

    super.dispose();
  }

  Widget _createOverlayContent() {
    MoonPopoverPosition popoverPosition = widget.popoverPosition;

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.popoverTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveTextColor = _getTextColor(context, effectiveBackgroundColor: effectiveBackgroundColor);

    final double effectiveDistanceToTarget =
        widget.distanceToTarget ?? context.moonTheme?.popoverTheme.properties.distanceToTarget ?? 8;

    final EdgeInsets effectiveContentPadding =
        widget.contentPadding ?? context.moonTheme?.popoverTheme.properties.contentPadding ?? const EdgeInsets.all(12);

    final BorderRadius effectiveBorderRadius =
        widget.borderRadius ?? context.moonTheme?.popoverTheme.properties.borderRadius ?? BorderRadius.circular(12);

    final List<BoxShadow> effectivePopoverShadows =
        widget.popoverShadows ?? context.moonTheme?.popoverTheme.shadows.popoverShadows ?? MoonShadows.light.sm;

    final targetRenderBox = context.findRenderObject()! as RenderBox;
    final overlayRenderBox = Overlay.of(context).context.findRenderObject()! as RenderBox;

    final popoverTargetGlobalCenter =
        targetRenderBox.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox);

    final popoverTargetGlobalLeft =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerLeft(Offset.zero), ancestor: overlayRenderBox);

    final popoverTargetGlobalRight =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerRight(Offset.zero), ancestor: overlayRenderBox);

    if (Directionality.of(context) == TextDirection.rtl ||
        popoverPosition == MoonPopoverPosition.horizontal ||
        popoverPosition == MoonPopoverPosition.vertical) {
      switch (popoverPosition) {
        case MoonPopoverPosition.left:
          popoverPosition = MoonPopoverPosition.right;
          break;
        case MoonPopoverPosition.right:
          popoverPosition = MoonPopoverPosition.left;
          break;
        case MoonPopoverPosition.topLeft:
          popoverPosition = MoonPopoverPosition.topRight;
          break;
        case MoonPopoverPosition.topRight:
          popoverPosition = MoonPopoverPosition.topLeft;
          break;
        case MoonPopoverPosition.bottomLeft:
          popoverPosition = MoonPopoverPosition.bottomRight;
          break;
        case MoonPopoverPosition.bottomRight:
          popoverPosition = MoonPopoverPosition.bottomLeft;
          break;
        case MoonPopoverPosition.vertical:
          popoverPosition = popoverTargetGlobalCenter.dy < overlayRenderBox.size.center(Offset.zero).dy
              ? MoonPopoverPosition.bottom
              : MoonPopoverPosition.top;
          break;
        case MoonPopoverPosition.horizontal:
          popoverPosition = popoverTargetGlobalCenter.dx < overlayRenderBox.size.center(Offset.zero).dx
              ? MoonPopoverPosition.right
              : MoonPopoverPosition.left;
          break;
        default:
          break;
      }
    }

    final popoverPositionParameters = _resolvePopoverPositionParameters(
      popoverPosition: popoverPosition,
      distanceToTarget: effectiveDistanceToTarget,
      overlayWidth: overlayRenderBox.size.width,
      popoverTargetGlobalLeft: popoverTargetGlobalLeft.dx,
      popoverTargetGlobalCenter: popoverTargetGlobalCenter.dx,
      popoverTargetGlobalRight: popoverTargetGlobalRight.dx,
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _handleTap,
      child: UnconstrainedBox(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: popoverPositionParameters.offset,
          followerAnchor: popoverPositionParameters.followerAnchor,
          targetAnchor: popoverPositionParameters.targetAnchor,
          child: RepaintBoundary(
            child: FadeTransition(
              opacity: _curvedAnimation!,
              child: DefaultTextStyle(
                style: DefaultTextStyle.of(context).style.copyWith(color: effectiveTextColor),
                child: Container(
                  key: _popoverKey,
                  constraints: BoxConstraints(maxWidth: popoverPositionParameters.toolTipMaxWidth),
                  padding: effectiveContentPadding,
                  decoration: ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shadows: effectivePopoverShadows,
                    shape: SmoothRectangleBorder(
                      borderRadius: effectiveBorderRadius.smoothBorderRadius,
                    ),
                  ),
                  child: widget.content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.popoverTheme.properties.transitionDuration ??
        const Duration(milliseconds: 150);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.popoverTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    _animationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.child,
    );
  }
}

class _PopoverPositionProperties {
  final Offset offset;
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double toolTipMaxWidth;

  _PopoverPositionProperties({
    required this.offset,
    required this.followerAnchor,
    required this.targetAnchor,
    required this.toolTipMaxWidth,
  });
}
