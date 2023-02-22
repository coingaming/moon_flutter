import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/widgets/tooltip/obfuscate_tooltip_item.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content_transition.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_position_manager.dart';

enum MoonTooltipPosition { top, bottom, left, right, horizontal, vertical }

class MoonTooltip extends StatefulWidget {
  /// Sets a handler for listening to a `tap` event on the tooltip.
  final void Function()? onTooltipTap;

  /// Controls the tooltip visibility.
  final bool show;

  /// Whether the tooltip has an arrow (tail).
  final bool hasArrow;

  /// Whether the tooltip should be dismissed whenever a user taps on it. For more control when to dismiss the tooltip
  /// rely on the [show] property and [onTooltipTap] handler.
  /// Defaults to [true].
  final bool hideOnTooltipTap;

  /// Sets the tooltip position relative to the target.
  /// Defaults to [MoonTooltipPosition.top]
  final MoonTooltipPosition tooltipPosition;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minWidth;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minHeight;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxWidth;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxHeight;

  /// Padding around the tooltip content.
  final EdgeInsets? contentPadding;

  /// The width of the tooltip arrow (tail) at its base.
  final double? arrowBaseWidth;

  /// The length of the tooltip arrow (tail).
  final double? arrowLength;

  /// The offset of the tooltip arrow (tail) from the center of the tooltip.
  final Offset? arrowOffset;

  /// The distance from the tip of the tooltip arrow (tail) to the target widget.
  final double? arrowTipDistance;

  /// The width of the tooltip border.
  final double borderWidth;

  /// The border radius value of the tooltip.
  final double? borderRadius;

  /// The margin around tooltip. Used to prevent the tooltip from touching the edges of the viewport.
  final double tooltipMargin;

  /// The color of the tooltip border.
  final Color borderColor;

  /// The color of the tooltip background.
  final Color? backgroundColor;

  /// List of tooltip shadows.
  final List<BoxShadow>? tooltipShadows;

  /// Tooltip transition duration (fade in or out animation).
  final Duration? transitionDuration;

  /// Tooltip transition curve (fade in or out animation).
  final Curve? transitionCurve;

  /// `RouteObserver` used to listen for route changes that will hide the tooltip when the widget's route is not active.
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  /// The widget that its placed inside the tooltip and functions as its content.
  final Widget content;

  /// The [child] widget which the tooltip will target.
  final Widget child;

  const MoonTooltip({
    super.key,
    this.onTooltipTap,
    required this.show,
    this.hasArrow = true,
    this.hideOnTooltipTap = true,
    this.tooltipPosition = MoonTooltipPosition.top,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.contentPadding,
    this.arrowBaseWidth,
    this.arrowLength,
    this.arrowOffset,
    this.arrowTipDistance,
    this.borderRadius,
    this.borderWidth = 0,
    this.tooltipMargin = 8,
    this.borderColor = Colors.transparent,
    this.backgroundColor,
    this.transitionDuration,
    this.transitionCurve,
    this.tooltipShadows,
    this.routeObserver,
    required this.content,
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
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    });
  }

  @override
  void didUpdateWidget(MoonTooltip oldWidget) {
    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (oldWidget.tooltipPosition != widget.tooltipPosition || (oldWidget.show != widget.show && widget.show)) {
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
    MoonTooltipPosition direction = widget.tooltipPosition;

    if (direction == MoonTooltipPosition.horizontal || direction == MoonTooltipPosition.vertical) {
      // Compute real direction based on target position
      final targetRenderBox = context.findRenderObject() as RenderBox?;
      final overlayRenderBox = Overlay.of(context).context.findRenderObject() as RenderBox?;

      final targetGlobalCenter =
          targetRenderBox?.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox) ??
              Offset.zero;

      direction = (direction == MoonTooltipPosition.vertical)
          ? (targetGlobalCenter.dy < overlayRenderBox!.size.center(Offset.zero).dy
              ? MoonTooltipPosition.bottom
              : MoonTooltipPosition.top)
          : (targetGlobalCenter.dx < overlayRenderBox!.size.center(Offset.zero).dx
              ? MoonTooltipPosition.right
              : MoonTooltipPosition.left);
    }
    final double effectiveArrowBaseWidth = widget.arrowLength ?? context.moonTooltipTheme?.arrowBaseWidth ?? 16;

    final double effectiveArrowLength =
        widget.hasArrow ? (widget.arrowLength ?? context.moonTooltipTheme?.arrowLength ?? 8) : 0;

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
          key: _positionManagerKey,
          context: context,
          arrowLength: effectiveArrowLength,
          arrowTipDistance: effectiveArrowTipDistance,
          maxHeight: widget.maxHeight,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          minWidth: widget.minWidth,
          tooltipPosition: direction,
          tooltipMargin: widget.tooltipMargin,
          link: layerLink,
          child: TooltipContentTransition(
            key: _transitionKey,
            hide: buildHidding,
            tooltipPosition: direction,
            duration: effectiveTransitionDuration,
            curve: effectiveTransitionCurve,
            onTransitionFinished: (status) {
              if (status == AnimationStatus.dismissed) {
                _removeTooltip();
              }
            },
            child: TooltipContent(
              tooltipPosition: direction,
              borderRadius: effectiveBorderRadius,
              arrowBaseWidth: effectiveArrowBaseWidth,
              arrowLength: effectiveArrowLength,
              arrowOffset: widget.arrowOffset,
              arrowTipDistance: effectiveArrowTipDistance,
              contentPadding: effectiveContentPadding,
              borderWidth: widget.borderWidth,
              borderColor: widget.borderColor,
              backgroundColor: effectiveBackgroundColor,
              shadows: effectiveTooltipShadows,
              textStyle: effectiveTextStyle,
              onTap: () {
                if (widget.hideOnTooltipTap) {
                  _removeTooltip();
                  _showTooltip(buildHidding: true);
                }

                widget.onTooltipTap?.call();
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
