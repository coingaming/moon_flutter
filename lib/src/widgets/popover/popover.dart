import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

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

  /// The border radius of the popover.
  final BorderRadiusGeometry? borderRadius;

  /// The color of the popover background.
  final Color? backgroundColor;

  /// The color of the popover border.
  final Color borderColor;

  /// Custom decoration for the popover.
  final Decoration? decoration;

  /// The width of the popover border.
  final double borderWidth;

  /// The distance from the tip of the popover arrow (tail) to the target widget.
  final double? distanceToTarget;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minHeight;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minWidth;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxHeight;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxWidth;

  /// The margin around popover. Used to prevent the popover from touching the edges of the viewport.
  final double popoverMargin;

  /// Popover transition duration (fade in or out animation).
  final Duration? transitionDuration;

  /// Popover transition curve (fade in or out animation).
  final Curve? transitionCurve;

  /// Padding around the popover content.
  final EdgeInsetsGeometry? contentPadding;

  /// List of popover shadows.
  final List<BoxShadow>? popoverShadows;

  /// Sets the popover position relative to the target. Defaults to [MoonPopoverPosition.vertical]
  final MoonPopoverPosition popoverPosition;

  /// `RouteObserver` used to listen for route changes that will hide the popover when the widget's route is not active.
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  /// The semantic label for the popover.
  final String? semanticLabel;

  /// Callback that is called when the user taps outside the popover.
  final VoidCallback? onTapOutside;

  /// The child (target) of the popover.
  final Widget child;

  /// The widget that its placed inside the popover and functions as its content.
  final Widget content;

  /// MDS popover widget.
  const MoonPopover({
    super.key,
    required this.show,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.decoration,
    this.borderWidth = 0,
    this.distanceToTarget,
    this.minHeight,
    this.minWidth,
    this.maxHeight,
    this.maxWidth,
    this.popoverMargin = 8,
    this.transitionDuration,
    this.transitionCurve,
    this.contentPadding,
    this.popoverShadows,
    this.popoverPosition = MoonPopoverPosition.top,
    this.routeObserver,
    this.semanticLabel,
    this.onTapOutside,
    required this.child,
    required this.content,
  });

  // Causes any current popovers to be removed. Won't remove the supplied popover.
  static void _removeOtherPopovers(MoonPopoverState current) {
    if (_openedPopovers.isNotEmpty) {
      // Avoid concurrent modification.
      final List<MoonPopoverState> openedPopovers = _openedPopovers.toList();

      for (final MoonPopoverState state in openedPopovers) {
        if (state == current) continue;

        state._clearOverlayEntry();
      }
    }
  }

  @override
  MoonPopoverState createState() => MoonPopoverState();
}

class MoonPopoverState extends State<MoonPopover> with RouteAware, SingleTickerProviderStateMixin {
  late final ObjectKey _regionKey = ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;

  OverlayEntry? _overlayEntry;

  bool _routeIsShowing = true;

  bool get shouldShowPopover => widget.show && _routeIsShowing;

  void _showPopover() {
    _overlayEntry = OverlayEntry(builder: (BuildContext context) => _createOverlayContent());
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

  void _handleTapOutside() {
    widget.onTapOutside?.call();
    _removePopover();
  }

  void _clearOverlayEntry() {
    if (_overlayEntry != null) {
      MoonPopover._openedPopovers.remove(this);
      _overlayEntry!.remove();
      _overlayEntry = null;
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
          popoverMaxWidth:
              overlayWidth - ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() - widget.popoverMargin * 2,
        );

      case MoonPopoverPosition.bottom:
        return _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          popoverMaxWidth:
              overlayWidth - ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() - widget.popoverMargin * 2,
        );

      case MoonPopoverPosition.left:
        return _PopoverPositionProperties(
          offset: Offset(-distanceToTarget, 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          popoverMaxWidth: popoverTargetGlobalLeft - distanceToTarget - widget.popoverMargin,
        );

      case MoonPopoverPosition.right:
        return _PopoverPositionProperties(
          offset: Offset(distanceToTarget, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          popoverMaxWidth: overlayWidth - popoverTargetGlobalRight - distanceToTarget - widget.popoverMargin,
        );

      case MoonPopoverPosition.topLeft:
        return _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          popoverMaxWidth: popoverTargetGlobalRight - widget.popoverMargin,
        );

      case MoonPopoverPosition.topRight:
        return _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          popoverMaxWidth: overlayWidth - popoverTargetGlobalLeft - widget.popoverMargin,
        );

      case MoonPopoverPosition.bottomLeft:
        return _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          popoverMaxWidth: popoverTargetGlobalRight - widget.popoverMargin,
        );

      case MoonPopoverPosition.bottomRight:
        return _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          popoverMaxWidth: overlayWidth - popoverTargetGlobalLeft - widget.popoverMargin,
        );

      default:
        throw AssertionError("No match: $popoverPosition");
    }
  }

  @override
  void didPush() {
    _routeIsShowing = true;
    // Route was pushed onto navigator and is now topmost route.
    if (shouldShowPopover) {
      _removePopover();

      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
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

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
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

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
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
    if (_overlayEntry != null) _removePopover(immediately: true);

    super.deactivate();
  }

  @override
  void dispose() {
    if (_overlayEntry != null) _removePopover(immediately: true);

    widget.routeObserver?.unsubscribe(this);

    super.dispose();
  }

  Widget _createOverlayContent() {
    MoonPopoverPosition popoverPosition = widget.popoverPosition;

    final BorderRadiusGeometry effectiveBorderRadius =
        widget.borderRadius ?? context.moonTheme?.popoverTheme.properties.borderRadius ?? BorderRadius.circular(12);

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.popoverTheme.colors.backgroundColor ?? MoonColors.light.goku;

    final Color effectiveTextColor = context.moonTheme?.popoverTheme.colors.textColor ?? MoonColors.light.textPrimary;

    final Color effectiveIconColor = context.moonTheme?.popoverTheme.colors.iconColor ?? MoonColors.light.iconPrimary;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.popoverTheme.properties.textStyle ?? MoonTypography.typography.body.textDefault;

    final double effectiveDistanceToTarget =
        widget.distanceToTarget ?? context.moonTheme?.popoverTheme.properties.distanceToTarget ?? 8;

    final EdgeInsetsGeometry effectiveContentPadding =
        widget.contentPadding ?? context.moonTheme?.popoverTheme.properties.contentPadding ?? const EdgeInsets.all(12);

    final EdgeInsets resolvedContentPadding = effectiveContentPadding.resolve(Directionality.of(context));

    final List<BoxShadow> effectivePopoverShadows =
        widget.popoverShadows ?? context.moonTheme?.popoverTheme.shadows.popoverShadows ?? MoonShadows.light.sm;

    final RenderBox overlayRenderBox = Overlay.of(context).context.findRenderObject()! as RenderBox;

    final RenderBox targetRenderBox = context.findRenderObject()! as RenderBox;

    final Offset popoverTargetGlobalCenter =
        targetRenderBox.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox);

    final Offset popoverTargetGlobalLeft =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerLeft(Offset.zero), ancestor: overlayRenderBox);

    final Offset popoverTargetGlobalRight =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerRight(Offset.zero), ancestor: overlayRenderBox);

    if (Directionality.of(context) == TextDirection.rtl ||
        popoverPosition == MoonPopoverPosition.horizontal ||
        popoverPosition == MoonPopoverPosition.vertical) {
      switch (popoverPosition) {
        case MoonPopoverPosition.left:
          popoverPosition = MoonPopoverPosition.right;
        case MoonPopoverPosition.right:
          popoverPosition = MoonPopoverPosition.left;
        case MoonPopoverPosition.topLeft:
          popoverPosition = MoonPopoverPosition.topRight;
        case MoonPopoverPosition.topRight:
          popoverPosition = MoonPopoverPosition.topLeft;
        case MoonPopoverPosition.bottomLeft:
          popoverPosition = MoonPopoverPosition.bottomRight;
        case MoonPopoverPosition.bottomRight:
          popoverPosition = MoonPopoverPosition.bottomLeft;
        case MoonPopoverPosition.vertical:
          popoverPosition = popoverTargetGlobalCenter.dy < overlayRenderBox.size.center(Offset.zero).dy
              ? MoonPopoverPosition.bottom
              : MoonPopoverPosition.top;
        case MoonPopoverPosition.horizontal:
          popoverPosition = popoverTargetGlobalCenter.dx < overlayRenderBox.size.center(Offset.zero).dx
              ? MoonPopoverPosition.right
              : MoonPopoverPosition.left;
        default:
          break;
      }
    }

    final _PopoverPositionProperties popoverPositionParameters = _resolvePopoverPositionParameters(
      popoverPosition: popoverPosition,
      distanceToTarget: effectiveDistanceToTarget,
      overlayWidth: overlayRenderBox.size.width,
      popoverTargetGlobalLeft: popoverTargetGlobalLeft.dx,
      popoverTargetGlobalCenter: popoverTargetGlobalCenter.dx,
      popoverTargetGlobalRight: popoverTargetGlobalRight.dx,
    );

    final double effectiveDropdownWidth =
        widget.maxWidth != null ? widget.maxWidth! : popoverPositionParameters.popoverMaxWidth;

    return Semantics(
      label: widget.semanticLabel,
      child: UnconstrainedBox(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: popoverPositionParameters.offset,
          followerAnchor: popoverPositionParameters.followerAnchor,
          targetAnchor: popoverPositionParameters.targetAnchor,
          child: TapRegion(
            groupId: _regionKey,
            behavior: HitTestBehavior.translucent,
            onTapOutside: (PointerDownEvent _) => _handleTapOutside(),
            child: RepaintBoundary(
              child: FadeTransition(
                opacity: _curvedAnimation!,
                child: IconTheme(
                  data: IconThemeData(color: effectiveIconColor),
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: widget.minHeight ?? 0,
                        maxHeight: widget.maxHeight ?? double.infinity,
                        minWidth: widget.minWidth ?? 0,
                        maxWidth: effectiveDropdownWidth,
                      ),
                      padding: resolvedContentPadding,
                      decoration: widget.decoration ??
                          ShapeDecorationWithPremultipliedAlpha(
                            color: effectiveBackgroundColor,
                            shadows: effectivePopoverShadows,
                            shape: MoonSquircleBorder(
                              borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                              side: BorderSide(color: widget.borderColor),
                            ),
                          ),
                      child: Directionality(
                        textDirection: Directionality.of(context),
                        child: widget.content,
                      ),
                    ),
                  ),
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
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.popoverTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    _animationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    return TapRegion(
      groupId: _regionKey,
      behavior: HitTestBehavior.translucent,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: widget.child,
      ),
    );
  }
}

class _PopoverPositionProperties {
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double popoverMaxWidth;
  final Offset offset;

  _PopoverPositionProperties({
    required this.followerAnchor,
    required this.targetAnchor,
    required this.popoverMaxWidth,
    required this.offset,
  });
}
