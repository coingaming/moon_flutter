import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:moon_design/src/widgets/tooltip/obfuscate_tooltip_item.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content_positioner.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content_transition.dart';

enum MoonTooltipDirection { up, down, right, left, horizontal, vertical }

class MoonTooltip extends StatefulWidget {
  /// The [child] which the tooltip will target to
  final Widget child;

  /// Sets the tooltip direction
  /// defaults to [MoonTooltipDirection.up]
  final MoonTooltipDirection tooltipDirection;

  /// Defines the content that its placed inside the tooltip content.
  final Widget content;

  /// If true, it will display the tool , if false it will hide it
  final bool show;

  /// Sets the content padding
  /// defautls to: `const EdgeInsets.symmetric(horizontal: 20, vertical: 16),`
  final EdgeInsets contentPadding;

  /// sets the duration of the tooltip entrance animation
  /// defaults to [460] milliseconds
  final Duration animationDuration;

  /// [minWidth], [minHeight], [maxWidth], [maxHeight] optional size constraints.
  /// If a constraint is not set the size will adjust to the content
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;

  ///
  /// The distance of the tip of the arrow's tip to the center of the target
  final double arrowTipDistance;

  ///
  /// The length of the Arrow
  final double arrowLength;

  ///
  /// the stroke width of the border
  final double borderWidth;

  ///
  /// The minium padding from the Tooltip to the screen limits
  final double minimumOutSidePadding;

  ///
  /// The corder radii of the border
  final double borderRadius;

  ///
  /// The width of the arrow at its base
  final double arrowBaseWidth;

  ///
  /// The targetCenter where the arrow points to(if null,defaults to center)
  final Offset? targetCenter;

  ///
  /// The color of the border
  final Color borderColor;

  ///
  /// The color of the border
  final Color backgroundColor;

  ///
  /// Set a custom list of [BoxShadow]
  /// defaults to `const BoxShadow(color: const Color(0x45222222), blurRadius: 8, spreadRadius: 2),`
  final List<BoxShadow> customShadows;

  ///
  /// Set a handler for listening to a `tap` event on the tooltip (This is the recommended way to put your logic for dismissing the tooltip)
  final void Function()? tooltipTap;

  ///
  /// If you want to automatically dismiss the tooltip whenever a user taps on it, set this flag to [true]
  /// For more control on when to dismiss the tooltip please rely on the [show] property and [tooltipTap] handler
  /// defaults to [false]
  final bool hideOnTooltipTap;

  ///
  /// Pass a `RouteObserver` so that the widget will listen for route transition and will hide tooltip when
  /// the widget's route is not active
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  const MoonTooltip({
    super.key,
    required this.child,
    this.tooltipDirection = MoonTooltipDirection.up,
    required this.content,
    required this.show,
    this.targetCenter,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    this.maxWidth,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
    this.arrowTipDistance = 6,
    this.arrowLength = 20,
    this.minimumOutSidePadding = 20.0,
    this.arrowBaseWidth = 20.0,
    this.borderRadius = 10,
    this.borderWidth = 2.0,
    this.borderColor = const Color(0xFF50FFFF),
    this.animationDuration = const Duration(milliseconds: 460),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.customShadows = const [
      BoxShadow(color: Color(0x45222222), blurRadius: 8, spreadRadius: 2),
    ],
    this.tooltipTap,
    this.hideOnTooltipTap = false,
    this.routeObserver,
  });

  @override
  MoonTooltipState createState() => MoonTooltipState();
}

class MoonTooltipState extends State<MoonTooltip> with RouteAware {
  bool _displaying = false;

  final LayerLink layerLink = LayerLink();

  bool get shouldShowTooltip => widget.show && !_isBeingObfuscated && _routeIsShowing;

  // To avoid rebuild state of widget for each rebuild
  GlobalKey _transitionKey = GlobalKey();
  final GlobalKey _positionerKey = GlobalKey();

  bool _routeIsShowing = true;

  bool _isBeingObfuscated = false;

  late OverlayEntry _overlayEntry;

  final List<ObfuscateTooltipItemState> _obfuscateItems = [];
  MoonTooltipContentSize? _contentSize;

  void addObfuscateItem(ObfuscateTooltipItemState item) {
    _obfuscateItems.add(item);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doCheckForObfuscation();
      doShowOrHide();
    });
  }

  void removeObfuscatedItem(ObfuscateTooltipItemState item) {
    _obfuscateItems.remove(item);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doCheckForObfuscation();
      doShowOrHide();
    });
  }

  @override
  void dispose() {
    _removeTooltip();
    widget.routeObserver?.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (shouldShowTooltip) {
        _showTooltip();
      }
      widget.routeObserver?.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
    });
  }

  @override
  void didUpdateWidget(MoonTooltip oldWidget) {
    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (oldWidget.tooltipDirection != widget.tooltipDirection || (oldWidget.show != widget.show && widget.show)) {
        _transitionKey = GlobalKey();
      }
      if (!_routeIsShowing || _isBeingObfuscated) {
        return;
      }
      doShowOrHide();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: widget.child,
    );
  }

  void _showTooltip({
    bool buildHidding = false,
  }) {
    if (_displaying || !mounted) {
      return;
    }
    _overlayEntry = _buildOverlay(
      buildHidding: buildHidding,
    );
    Overlay.of(context).insert(_overlayEntry);
    _displaying = true;
  }

  void _removeTooltip() {
    if (!_displaying) {
      return;
    }
    _overlayEntry.remove();
    _displaying = false;
  }

  void doShowOrHide() {
    final wasDisplaying = _displaying;
    _removeTooltip();
    if (shouldShowTooltip) {
      _showTooltip();
    } else if (wasDisplaying) {
      _showTooltip(buildHidding: true);
    }
  }

  void doCheckForObfuscation() {
    if (_contentSize == null) return;
    for (final obfuscateItem in _obfuscateItems) {
      final d = obfuscateItem.getPositionAndSize()!;

      final Rect obfuscateItemRect = d.globalPosition & d.size;
      final Rect contentRect = _contentSize!.globalPosition & _contentSize!.size;
      final bool overlaps = contentRect.overlaps(obfuscateItemRect);
      if (overlaps) {
        _isBeingObfuscated = true;
        // no need to keep searching
        return;
      }
    }
    _isBeingObfuscated = false;
  }

  OverlayEntry _buildOverlay({
    bool buildHidding = false,
  }) {
    var direction = widget.tooltipDirection;

    if (direction == MoonTooltipDirection.horizontal || direction == MoonTooltipDirection.vertical) {
      // compute real direction based on target position
      final targetRenderBox = context.findRenderObject() as RenderBox?;
      final overlayRenderBox = Overlay.of(
        context,
      ).context.findRenderObject() as RenderBox?;

      final targetGlobalCenter =
          targetRenderBox?.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox) ??
              Offset.zero;

      direction = (direction == MoonTooltipDirection.vertical)
          ? (targetGlobalCenter.dy < overlayRenderBox!.size.center(Offset.zero).dy
              ? MoonTooltipDirection.down
              : MoonTooltipDirection.up)
          : (targetGlobalCenter.dx < overlayRenderBox!.size.center(Offset.zero).dx
              ? MoonTooltipDirection.right
              : MoonTooltipDirection.left);
    }

    return OverlayEntry(
      builder: (overlayContext) {
        return MoonTooltipContentPositioner(
          context: context,
          arrowLength: widget.arrowLength,
          arrowTipDistance: widget.arrowTipDistance,
          outsidePadding: widget.minimumOutSidePadding,
          key: _positionerKey,
          link: layerLink,
          tooltipDirection: direction,
          maxHeight: widget.maxHeight,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          minWidth: widget.minWidth,
          child: MoonTooltipContentTransition(
            key: _transitionKey,
            duration: widget.animationDuration,
            tooltipDirection: direction,
            hide: buildHidding,
            animationEnd: (status) {
              if (status == AnimationStatus.dismissed) {
                _removeTooltip();
              }
            },
            child: MoonTooltipContent(
              content: widget.content,
              borderRadius: widget.borderRadius,
              arrowBaseWidth: widget.arrowBaseWidth,
              arrowLength: widget.arrowLength,
              targetCenter: widget.targetCenter,
              arrowTipDistance: widget.arrowTipDistance,
              contentPadding: widget.contentPadding,
              borderColor: widget.borderColor,
              borderWidth: widget.borderWidth,
              tooltipDirection: direction,
              backgroundColor: widget.backgroundColor,
              shadows: widget.customShadows,
              onTap: () {
                if (widget.hideOnTooltipTap) {
                  _removeTooltip();
                  _showTooltip(buildHidding: true);
                }

                widget.tooltipTap?.call();
              },
              onSizeChange: (contentSize) {
                if (!mounted) return;
                _contentSize = contentSize;
                doCheckForObfuscation();
                doShowOrHide();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void didPush() {
    _routeIsShowing = true;
    // Route was pushed onto navigator and is now topmost route.
    if (shouldShowTooltip) {
      _removeTooltip();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) return;
        _showTooltip();
      });
    }
  }

  @override
  void didPushNext() {
    _routeIsShowing = false;
    _removeTooltip();
  }

  @override
  Future<void> didPopNext() async {
    _routeIsShowing = true;
    if (shouldShowTooltip) {
      // Covering route was popped off the navigator.
      _removeTooltip();
      await Future.delayed(const Duration(milliseconds: 100), () {});
      if (mounted) _showTooltip();
    }
  }
}
