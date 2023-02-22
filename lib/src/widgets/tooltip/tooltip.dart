import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/widgets/tooltip/obfuscate_tooltip_item.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content_transition.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_position_manager.dart';

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
  final EdgeInsets? contentPadding;

  /// sets the duration of the tooltip entrance animation
  /// defaults to [460] milliseconds
  final Duration? transitionDuration;

  /// sets the duration of the tooltip entrance animation
  /// defaults to [460] milliseconds
  final Curve? transitionCurve;

  /// [minWidth], [minHeight], [maxWidth], [maxHeight] optional size constraints.
  /// If a constraint is not set the size will adjust to the content
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;

  ///
  /// The distance of the tip of the arrow's tip to the center of the target
  final double? arrowTipDistance;

  ///
  /// The length of the Arrow
  final double? arrowLength;

  ///
  /// the stroke width of the border
  final double borderWidth;

  ///
  /// The minium padding from the Tooltip to the screen limits
  final double minimumOutSidePadding;

  ///
  /// The corder radii of the border
  final double? borderRadius;

  ///
  /// The width of the arrow at its base
  final double? arrowBaseWidth;

  ///
  /// The targetCenter where the arrow points to(if null,defaults to center)
  final Offset? targetCenter;

  ///
  /// The color of the border
  final Color borderColor;

  ///
  /// The color of the border
  final Color? backgroundColor;

  ///
  /// Set a custom list of [BoxShadow]
  /// defaults to `const BoxShadow(color: const Color(0x45222222), blurRadius: 8, spreadRadius: 2),`
  final List<BoxShadow>? tooltipShadows;

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
    this.tooltipDirection = MoonTooltipDirection.up,
    required this.content,
    required this.show,
    this.targetCenter,
    this.contentPadding,
    this.maxWidth,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
    this.arrowTipDistance,
    this.arrowLength,
    this.minimumOutSidePadding = 8,
    this.arrowBaseWidth,
    this.borderRadius,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.transitionDuration,
    this.transitionCurve,
    this.backgroundColor,
    this.tooltipShadows,
    this.tooltipTap,
    this.hideOnTooltipTap = true,
    this.routeObserver,
    required this.child,
  });

  @override
  MoonTooltipState createState() => MoonTooltipState();
}

class MoonTooltipState extends State<MoonTooltip> with RouteAware {
  // To avoid excessive rebuilds
  final GlobalKey _positionManagerKey = GlobalKey();
  final LayerLink layerLink = LayerLink();
  final List<ObfuscateTooltipItemState> _obfuscateItems = [];

  bool _displaying = false;
  bool _routeIsShowing = true;
  bool _isBeingObfuscated = false;
  GlobalKey _transitionKey = GlobalKey();
  TooltipContentSize? _contentSize;

  late OverlayEntry _overlayEntry;

  bool get shouldShowTooltip => widget.show && !_isBeingObfuscated && _routeIsShowing;

  void addObfuscateItem(ObfuscateTooltipItemState item) {
    _obfuscateItems.add(item);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doCheckForObfuscation();
      doShowOrHide();
    });
  }

  void removeObfuscatedItem(ObfuscateTooltipItemState item) {
    _obfuscateItems.remove(item);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doCheckForObfuscation();
      doShowOrHide();
    });
  }

  void _showTooltip({bool buildHidding = false}) {
    if (_displaying || !mounted) return;

    _overlayEntry = _buildOverlay(buildHidding: buildHidding);
    Overlay.of(context).insert(_overlayEntry);
    _displaying = true;
  }

  void _removeTooltip() {
    if (!_displaying) return;

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

  Color _getTextColor({required Color backgroundColor}) {
    final backgroundLuminance = backgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  void didPush() {
    _routeIsShowing = true;
    // Route was pushed onto navigator and is now topmost route.
    if (shouldShowTooltip) {
      _removeTooltip();
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
      await Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _showTooltip();
      });
    }
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
  void dispose() {
    _removeTooltip();
    widget.routeObserver?.unsubscribe(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: widget.child,
    );
  }

  OverlayEntry _buildOverlay({bool buildHidding = false}) {
    MoonTooltipDirection direction = widget.tooltipDirection;

    if (direction == MoonTooltipDirection.horizontal || direction == MoonTooltipDirection.vertical) {
      // Compute real direction based on target position
      final targetRenderBox = context.findRenderObject() as RenderBox?;
      final overlayRenderBox = Overlay.of(context).context.findRenderObject() as RenderBox?;

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
    final double effectiveArrowBaseWidth = widget.arrowLength ?? context.moonTooltipTheme?.arrowBaseWidth ?? 16;

    final double effectiveArrowLength = widget.arrowLength ?? context.moonTooltipTheme?.arrowLength ?? 8;

    final double effectiveArrowTipDistance = widget.arrowTipDistance ?? context.moonTooltipTheme?.arrowTipDistance ?? 8;

    final Duration effectiveTransitionDuration =
        widget.transitionDuration ?? context.moonTooltipTheme?.transitionDuration ?? const Duration(milliseconds: 150);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTooltipTheme?.transitionCurve ?? Curves.easeInOutCubic;

    final EdgeInsets effectiveContentPadding =
        widget.contentPadding ?? context.moonTooltipTheme?.contentPadding ?? const EdgeInsets.all(12);

    final double effectiveBorderRadius = widget.borderRadius ?? context.moonTooltipTheme?.borderRadius.topLeft.x ?? 4;

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonColors?.gohan ?? MoonColors.light.gohan;

    final Color effectiveTextColor = _getTextColor(backgroundColor: effectiveBackgroundColor);

    final TextStyle effectiveTextStyle = context.moonTooltipTheme?.textStyle.copyWith(color: effectiveTextColor) ??
        MoonTextStyles.text.text12.copyWith(color: effectiveTextColor);

    final List<BoxShadow> effectiveTooltipShadows = widget.tooltipShadows ??
        context.moonShadows?.sm ??
        const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 1,
          ),
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 6,
            offset: Offset(0, 6),
          ),
        ];

    return OverlayEntry(
      builder: (overlayContext) {
        return TooltipPositionManager(
          context: context,
          arrowLength: effectiveArrowLength,
          arrowTipDistance: effectiveArrowTipDistance,
          outsidePadding: widget.minimumOutSidePadding,
          key: _positionManagerKey,
          link: layerLink,
          tooltipDirection: direction,
          maxHeight: widget.maxHeight,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          minWidth: widget.minWidth,
          child: TooltipContentTransition(
            key: _transitionKey,
            hide: buildHidding,
            tooltipDirection: direction,
            duration: effectiveTransitionDuration,
            curve: effectiveTransitionCurve,
            onTransitionFinished: (status) {
              if (status == AnimationStatus.dismissed) {
                _removeTooltip();
              }
            },
            child: TooltipContent(
              borderRadius: effectiveBorderRadius,
              arrowBaseWidth: effectiveArrowBaseWidth,
              arrowLength: effectiveArrowLength,
              targetCenter: widget.targetCenter,
              arrowTipDistance: effectiveArrowTipDistance,
              contentPadding: effectiveContentPadding,
              borderColor: widget.borderColor,
              borderWidth: widget.borderWidth,
              tooltipDirection: direction,
              backgroundColor: effectiveBackgroundColor,
              shadows: effectiveTooltipShadows,
              textStyle: effectiveTextStyle,
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
              child: widget.content,
            ),
          ),
        );
      },
    );
  }
}
