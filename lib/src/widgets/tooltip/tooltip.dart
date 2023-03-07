import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content_shape.dart';

enum MoonTooltipPosition {
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

class MoonTooltip extends StatefulWidget {
  /// Sets a handler for listening to a `tap` event on the tooltip.
  final void Function()? onTooltipTap;

  /// Controls the tooltip visibility.
  final bool show;

  /// Whether the tooltip has an arrow (tail).
  final bool hasArrow;

  /// Whether the tooltip should be dismissed whenever a user taps on it. For more control when to dismiss the tooltip
  /// rely on the [show] property and [onTooltipTap] handler. Defaults to [true].
  final bool hideOnTooltipTap;

  /// Sets the tooltip position relative to the target. Defaults to [MoonTooltipPosition.vertical]
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

class MoonTooltipState extends State<MoonTooltip> with RouteAware, SingleTickerProviderStateMixin {
  AnimationController? animationController;
  CurvedAnimation? curvedAnimation;

  final LayerLink layerLink = LayerLink();

  bool _routeIsShowing = true;

  OverlayEntry? _overlayEntry;

  bool get shouldShowTooltip => widget.show && _routeIsShowing;

  void _showTooltip() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    animationController!.forward();
  }

  void _removeTooltip({bool removeImmediately = false}) {
    if (removeImmediately) {
      _clearOverlayEntry();
    } else {
      animationController!.reverse().then((value) => _clearOverlayEntry());
    }
  }

  void _clearOverlayEntry() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry!.dispose();
      _overlayEntry = null;
    }
  }

  void updateTooltip() {
    dev.log("update");
    _removeTooltip(removeImmediately: true);

    if (shouldShowTooltip) {
      _showTooltip();
    }
  }

  Color _getTextColor({required Color backgroundColor}) {
    final backgroundLuminance = backgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  void _handleTap() {
    if (widget.hideOnTooltipTap) {
      _removeTooltip();
    }
    widget.onTooltipTap?.call();
  }

  _TooltipPositionProperties _resolveTooltipPositionParameters({
    required MoonTooltipPosition tooltipPosition,
    required double arrowTipDistance,
    required double arrowLength,
    required double overlayWidth,
    required double tooltipGlobalLeft,
    required double tooltipGlobalCenter,
    required double tooltipGlobalRight,
  }) {
    switch (tooltipPosition) {
      case MoonTooltipPosition.top:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          toolTipMaxWidth:
              overlayWidth - ((overlayWidth / 2 - tooltipGlobalCenter) * 2).abs() - widget.tooltipMargin * 2,
        );

      case MoonTooltipPosition.bottom:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          toolTipMaxWidth:
              overlayWidth - ((overlayWidth / 2 - tooltipGlobalCenter) * 2).abs() - widget.tooltipMargin * 2,
        );

      case MoonTooltipPosition.left:
        return _TooltipPositionProperties(
          offset: Offset(-(arrowTipDistance + arrowLength), 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          toolTipMaxWidth: tooltipGlobalLeft - arrowLength - arrowTipDistance - widget.tooltipMargin,
        );

      case MoonTooltipPosition.right:
        return _TooltipPositionProperties(
          offset: Offset(arrowTipDistance + arrowLength, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          toolTipMaxWidth: overlayWidth - tooltipGlobalRight - arrowLength - arrowTipDistance - widget.tooltipMargin,
        );

      case MoonTooltipPosition.topLeft:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          toolTipMaxWidth: tooltipGlobalRight - widget.tooltipMargin,
        );

      case MoonTooltipPosition.topRight:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          toolTipMaxWidth: overlayWidth - tooltipGlobalLeft - widget.tooltipMargin,
        );

      case MoonTooltipPosition.bottomLeft:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          toolTipMaxWidth: tooltipGlobalRight - widget.tooltipMargin,
        );

      case MoonTooltipPosition.bottomRight:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          toolTipMaxWidth: overlayWidth - tooltipGlobalLeft - widget.tooltipMargin,
        );

      default:
        throw AssertionError(tooltipPosition);
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
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    });
  }

  @override
  void didUpdateWidget(MoonTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_routeIsShowing) return;
      updateTooltip();
    });
  }

  @override
  void dispose() {
    _removeTooltip(removeImmediately: true);
    widget.routeObserver?.unsubscribe(this);

    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    dev.log("create");
    MoonTooltipPosition tooltipPosition = widget.tooltipPosition;

    final double effectiveArrowBaseWidth = widget.arrowBaseWidth ?? context.moonTooltipTheme?.arrowBaseWidth ?? 16;

    final double effectiveArrowLength =
        widget.hasArrow ? (widget.arrowLength ?? context.moonTooltipTheme?.arrowLength ?? 8) : 0;

    final double effectiveArrowTipDistance = widget.arrowTipDistance ?? context.moonTooltipTheme?.arrowTipDistance ?? 8;

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

    final targetRenderBox = context.findRenderObject()! as RenderBox;
    final overlayRenderBox = Overlay.of(context).context.findRenderObject()! as RenderBox;

    final tooltipGlobalCenter =
        targetRenderBox.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox);

    final tooltipGlobalLeft =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerLeft(Offset.zero), ancestor: overlayRenderBox);

    final tooltipGlobalRight =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerRight(Offset.zero), ancestor: overlayRenderBox);

    if (tooltipPosition == MoonTooltipPosition.horizontal || tooltipPosition == MoonTooltipPosition.vertical) {
      // Compute real tooltipPosition based on target position
      tooltipPosition = (tooltipPosition == MoonTooltipPosition.vertical)
          ? (tooltipGlobalCenter.dy < overlayRenderBox.size.center(Offset.zero).dy
              ? MoonTooltipPosition.bottom
              : MoonTooltipPosition.top)
          : (tooltipGlobalCenter.dx < overlayRenderBox.size.center(Offset.zero).dx
              ? MoonTooltipPosition.right
              : MoonTooltipPosition.left);
    }

    final tooltipPositionParameters = _resolveTooltipPositionParameters(
      tooltipPosition: tooltipPosition,
      arrowTipDistance: effectiveArrowTipDistance,
      arrowLength: effectiveArrowLength,
      overlayWidth: overlayRenderBox.size.width,
      tooltipGlobalLeft: tooltipGlobalLeft.dx,
      tooltipGlobalCenter: tooltipGlobalCenter.dx,
      tooltipGlobalRight: tooltipGlobalRight.dx,
    );

    return OverlayEntry(
      builder: (context) {
        return UnconstrainedBox(
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: tooltipPositionParameters.offset,
            followerAnchor: tooltipPositionParameters.followerAnchor,
            targetAnchor: tooltipPositionParameters.targetAnchor,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _handleTap,
              child: RepaintBoundary(
                child: FadeTransition(
                  opacity: curvedAnimation!,
                  child: DefaultTextStyle(
                    style: effectiveTextStyle,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: tooltipPositionParameters.toolTipMaxWidth),
                      padding: effectiveContentPadding,
                      decoration: ShapeDecoration(
                        color: effectiveBackgroundColor,
                        shadows: effectiveTooltipShadows,
                        shape: TooltipContentShape(
                          arrowBaseWidth: effectiveArrowBaseWidth,
                          arrowLength: effectiveArrowLength,
                          arrowOffset: widget.arrowOffset,
                          arrowTipDistance: effectiveArrowTipDistance,
                          borderColor: widget.borderColor,
                          borderRadius: effectiveBorderRadius,
                          borderWidth: widget.borderWidth,
                          childWidth: targetRenderBox.size.width,
                          tooltipPosition: tooltipPosition,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Duration effectiveTransitionDuration =
        widget.transitionDuration ?? context.moonTooltipTheme?.transitionDuration ?? const Duration(milliseconds: 150);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTooltipTheme?.transitionCurve ?? Curves.easeInOutCubic;

    animationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    curvedAnimation ??= CurvedAnimation(
      parent: animationController!,
      curve: effectiveTransitionCurve,
    );

    return CompositedTransformTarget(
      link: layerLink,
      child: widget.child,
    );
  }
}

class _TooltipPositionProperties {
  final Offset offset;
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double toolTipMaxWidth;

  _TooltipPositionProperties({
    required this.offset,
    required this.followerAnchor,
    required this.targetAnchor,
    required this.toolTipMaxWidth,
  });
}
