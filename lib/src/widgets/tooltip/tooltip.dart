import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_shape.dart';
import 'package:moon_tokens/moon_tokens.dart';

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
  // This is required to show only one tooltip at a time.
  static final List<_MoonTooltipState> _openedTooltips = [];

  /// Whether the tooltip has an arrow (tail).
  final bool hasArrow;

  /// Whether to hide (dismiss) the tooltip on tap. Defaults to true.
  /// For finer control over dismissal, use [show] and [onTap] properties.
  final bool hideOnTap;

  /// Whether to show the tooltip.
  final bool show;

  /// The border radius of the tooltip.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the tooltip.
  final Color? backgroundColor;

  /// The border color of the tooltip. Displayed when [borderWidth] is larger than 0.
  final Color borderColor;

  /// The base width of the tooltip arrow (tail).
  final double? arrowBaseWidth;

  /// The length of the tooltip arrow (tail).
  final double? arrowLength;

  /// The offset of the tooltip arrow (tail) from the center of the tooltip.
  final double arrowOffsetValue;

  /// The distance from the tip of the tooltip arrow (tail) to the [child] (target).
  final double? arrowTipDistance;

  /// The width of the tooltip border.
  final double borderWidth;

  /// An optional size constraint for the tooltip [content] to define its minimum height.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the [content].
  final double? minHeight;

  /// An optional size constraint for the tooltip [content] to define its minimum width.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the [content].
  final double? minWidth;

  /// An optional size constraint for the tooltip [content] to define its maximum height.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the [content].
  final double? maxHeight;

  /// An optional size constraint for the tooltip [content] to define its maximum width.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the [content].
  final double? maxWidth;

  /// The margin of the tooltip. Prevents the tooltip from touching the edges of the viewport.
  final double tooltipMargin;

  /// The duration of the tooltip transition animation (fade in or out).
  final Duration? transitionDuration;

  /// The curve of the tooltip transition animation (fade in or out).
  final Curve? transitionCurve;

  /// The padding of the tooltip [content].
  final EdgeInsetsGeometry? contentPadding;

  /// The list of shadows applied to the tooltip.
  final List<BoxShadow>? tooltipShadows;

  /// The tooltip position relative to the [child] (target). Defaults to [MoonTooltipPosition.vertical].
  final MoonTooltipPosition tooltipPosition;

  /// The observer to track route changes and automatically hide the tooltip when the widget's route is not active.
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  /// The semantic label for the tooltip.
  final String? semanticLabel;

  /// The callback that is called when the tooltip is tapped.
  final VoidCallback? onTap;

  /// The widget to display as the child (target) of the tooltip.
  final Widget child;

  /// The widget to display inside the tooltip as its content.
  final Widget content;

  /// Creates a Moon Design tooltip.
  const MoonTooltip({
    super.key,
    this.hasArrow = true,
    this.hideOnTap = true,
    required this.show,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.arrowBaseWidth,
    this.arrowLength,
    this.arrowOffsetValue = 0,
    this.arrowTipDistance,
    this.borderWidth = 0,
    this.minHeight,
    this.minWidth,
    this.maxHeight,
    this.maxWidth,
    this.tooltipMargin = 8,
    this.transitionDuration,
    this.transitionCurve,
    this.contentPadding,
    this.tooltipShadows,
    this.tooltipPosition = MoonTooltipPosition.top,
    this.routeObserver,
    this.semanticLabel,
    this.onTap,
    required this.child,
    required this.content,
  });

  // Clear existing tooltips, excluding the supplied one.
  static void _removeOtherTooltips(_MoonTooltipState current) {
    if (_openedTooltips.isNotEmpty) {
      // Avoid concurrent modification.
      final List<_MoonTooltipState> openedTooltips = _openedTooltips.toList();

      for (final _MoonTooltipState state in openedTooltips) {
        if (state == current) continue;

        state._clearOverlayEntry();
      }
    }
  }

  @override
  _MoonTooltipState createState() => _MoonTooltipState();
}

class _MoonTooltipState extends State<MoonTooltip> with RouteAware, SingleTickerProviderStateMixin {
  final GlobalKey _tooltipKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;

  OverlayEntry? _overlayEntry;

  bool _routeIsShowing = true;

  bool get shouldShowTooltip => widget.show && _routeIsShowing;

  void _showTooltip() {
    _overlayEntry = OverlayEntry(builder: (BuildContext context) => _createOverlayContent());
    Overlay.of(context).insert(_overlayEntry!);

    MoonTooltip._openedTooltips.add(this);
    MoonTooltip._removeOtherTooltips(this);

    _animationController!.value = 0;
    _animationController!.forward();
  }

  void _updateTooltip() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeTooltip({bool immediately = false}) {
    if (immediately) {
      _clearOverlayEntry();
    } else {
      _animationController!.value = 1;
      _animationController!.reverse().then((value) => _clearOverlayEntry());
    }
  }

  void _clearOverlayEntry() {
    if (_overlayEntry != null) {
      MoonTooltip._openedTooltips.remove(this);
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _handleTap(TapDownDetails details) {
    final RenderBox? tooltipRenderBox = _tooltipKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? overlayRenderBox = Overlay.of(context).context.findRenderObject() as RenderBox?;
    final Offset? tooltipPosition = tooltipRenderBox?.localToGlobal(Offset.zero, ancestor: overlayRenderBox);

    if (widget.hideOnTap ||
        tooltipPosition != null && !tooltipRenderBox!.size.contains(details.localPosition - tooltipPosition)) {
      _removeTooltip();
    }

    widget.onTap?.call();
  }

  _TooltipPositionProperties _resolveTooltipPositionParameters({
    required MoonTooltipPosition tooltipPosition,
    required double arrowTipDistance,
    required double arrowLength,
    required double overlayWidth,
    required double tooltipTargetGlobalLeft,
    required double tooltipTargetGlobalCenter,
    required double tooltipTargetGlobalRight,
  }) {
    switch (tooltipPosition) {
      case MoonTooltipPosition.top:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          tooltipMaxWidth:
              overlayWidth - ((overlayWidth / 2 - tooltipTargetGlobalCenter) * 2).abs() - widget.tooltipMargin * 2,
        );

      case MoonTooltipPosition.bottom:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          tooltipMaxWidth:
              overlayWidth - ((overlayWidth / 2 - tooltipTargetGlobalCenter) * 2).abs() - widget.tooltipMargin * 2,
        );

      case MoonTooltipPosition.left:
        return _TooltipPositionProperties(
          offset: Offset(-(arrowTipDistance + arrowLength), 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          tooltipMaxWidth: tooltipTargetGlobalLeft - arrowLength - arrowTipDistance - widget.tooltipMargin,
        );

      case MoonTooltipPosition.right:
        return _TooltipPositionProperties(
          offset: Offset(arrowTipDistance + arrowLength, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          tooltipMaxWidth:
              overlayWidth - tooltipTargetGlobalRight - arrowLength - arrowTipDistance - widget.tooltipMargin,
        );

      case MoonTooltipPosition.topLeft:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          tooltipMaxWidth: tooltipTargetGlobalRight - widget.tooltipMargin,
        );

      case MoonTooltipPosition.topRight:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          tooltipMaxWidth: overlayWidth - tooltipTargetGlobalLeft - widget.tooltipMargin,
        );

      case MoonTooltipPosition.bottomLeft:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          tooltipMaxWidth: tooltipTargetGlobalRight - widget.tooltipMargin,
        );

      case MoonTooltipPosition.bottomRight:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          tooltipMaxWidth: overlayWidth - tooltipTargetGlobalLeft - widget.tooltipMargin,
        );

      default:
        throw AssertionError(tooltipPosition);
    }
  }

  @override
  void didPush() {
    _routeIsShowing = true;
    // Route was added to the navigator and is now the top-most route.
    if (shouldShowTooltip) {
      _removeTooltip();

      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
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
      // The covering route was popped off the navigator.
      _removeTooltip();

      await Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _showTooltip();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);

      if (widget.show) {
        _showTooltip();
      }
    });
  }

  @override
  void didUpdateWidget(MoonTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!_routeIsShowing) return;

      if (oldWidget.tooltipPosition != widget.tooltipPosition) {
        _removeTooltip(immediately: true);
        _showTooltip();
      } else if (shouldShowTooltip && _overlayEntry == null) {
        _showTooltip();
      } else if (!shouldShowTooltip && _overlayEntry != null) {
        _removeTooltip();
      }

      _updateTooltip();
    });
  }

  @override
  void deactivate() {
    if (_overlayEntry != null) {
      _removeTooltip(immediately: true);
    }

    super.deactivate();
  }

  @override
  void dispose() {
    if (_overlayEntry != null) {
      _removeTooltip(immediately: true);
    }

    widget.routeObserver?.unsubscribe(this);

    super.dispose();
  }

  Widget _createOverlayContent() {
    MoonTooltipPosition tooltipPosition = widget.tooltipPosition;

    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.tooltipTheme.properties.borderRadius ??
        MoonBorders.borders.interactiveXs;

    final resolvedBorderRadius = effectiveBorderRadius.resolve(Directionality.of(context));

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.tooltipTheme.colors.backgroundColor ?? MoonColors.light.goku;

    final Color effectiveTextColor = context.moonTheme?.tooltipTheme.colors.textColor ?? MoonColors.light.textPrimary;

    final Color effectiveIconColor = context.moonTheme?.tooltipTheme.colors.iconColor ?? MoonColors.light.iconPrimary;

    final double effectiveArrowBaseWidth =
        widget.arrowBaseWidth ?? context.moonTheme?.tooltipTheme.properties.arrowBaseWidth ?? 16;

    final double effectiveArrowLength =
        widget.hasArrow ? (widget.arrowLength ?? context.moonTheme?.tooltipTheme.properties.arrowLength ?? 8) : 0;

    final double effectiveArrowTipDistance =
        widget.arrowTipDistance ?? context.moonTheme?.tooltipTheme.properties.arrowTipDistance ?? 8;

    final EdgeInsetsGeometry effectiveContentPadding =
        widget.contentPadding ?? context.moonTheme?.tooltipTheme.properties.contentPadding ?? const EdgeInsets.all(12);

    final EdgeInsets resolvedContentPadding = effectiveContentPadding.resolve(Directionality.of(context));

    final List<BoxShadow> effectiveTooltipShadows =
        widget.tooltipShadows ?? context.moonTheme?.tooltipTheme.shadows.tooltipShadows ?? MoonShadows.light.sm;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.tooltipTheme.properties.textStyle ?? MoonTypography.typography.body.text12;

    final overlayRenderBox = Overlay.of(context).context.findRenderObject()! as RenderBox;

    final targetRenderBox = context.findRenderObject()! as RenderBox;

    final tooltipTargetGlobalCenter =
        targetRenderBox.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox);

    final tooltipTargetGlobalLeft =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerLeft(Offset.zero), ancestor: overlayRenderBox);

    final tooltipTargetGlobalRight =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerRight(Offset.zero), ancestor: overlayRenderBox);

    if (Directionality.of(context) == TextDirection.rtl ||
        tooltipPosition == MoonTooltipPosition.horizontal ||
        tooltipPosition == MoonTooltipPosition.vertical) {
      switch (tooltipPosition) {
        case MoonTooltipPosition.left:
          tooltipPosition = MoonTooltipPosition.right;
        case MoonTooltipPosition.right:
          tooltipPosition = MoonTooltipPosition.left;
        case MoonTooltipPosition.topLeft:
          tooltipPosition = MoonTooltipPosition.topRight;
        case MoonTooltipPosition.topRight:
          tooltipPosition = MoonTooltipPosition.topLeft;
        case MoonTooltipPosition.bottomLeft:
          tooltipPosition = MoonTooltipPosition.bottomRight;
        case MoonTooltipPosition.bottomRight:
          tooltipPosition = MoonTooltipPosition.bottomLeft;
        case MoonTooltipPosition.vertical:
          tooltipPosition = tooltipTargetGlobalCenter.dy < overlayRenderBox.size.center(Offset.zero).dy
              ? MoonTooltipPosition.bottom
              : MoonTooltipPosition.top;
        case MoonTooltipPosition.horizontal:
          tooltipPosition = tooltipTargetGlobalCenter.dx < overlayRenderBox.size.center(Offset.zero).dx
              ? MoonTooltipPosition.right
              : MoonTooltipPosition.left;
        default:
          break;
      }
    }

    final tooltipPositionParameters = _resolveTooltipPositionParameters(
      tooltipPosition: tooltipPosition,
      arrowTipDistance: effectiveArrowTipDistance,
      arrowLength: effectiveArrowLength,
      overlayWidth: overlayRenderBox.size.width,
      tooltipTargetGlobalLeft: tooltipTargetGlobalLeft.dx,
      tooltipTargetGlobalCenter: tooltipTargetGlobalCenter.dx,
      tooltipTargetGlobalRight: tooltipTargetGlobalRight.dx,
    );

    return Semantics(
      label: widget.semanticLabel,
      child: GestureDetector(
        excludeFromSemantics: true,
        behavior: HitTestBehavior.translucent,
        onTapDown: _handleTap,
        child: UnconstrainedBox(
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: tooltipPositionParameters.offset,
            followerAnchor: tooltipPositionParameters.followerAnchor,
            targetAnchor: tooltipPositionParameters.targetAnchor,
            child: RepaintBoundary(
              child: FadeTransition(
                opacity: _curvedAnimation!,
                child: DefaultTextStyle(
                  style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                  child: IconTheme(
                    data: IconThemeData(color: effectiveIconColor),
                    child: Container(
                      key: _tooltipKey,
                      constraints: BoxConstraints(maxWidth: tooltipPositionParameters.tooltipMaxWidth),
                      padding: resolvedContentPadding,
                      decoration: ShapeDecorationWithPremultipliedAlpha(
                        color: effectiveBackgroundColor,
                        shadows: effectiveTooltipShadows,
                        shape: TooltipShape(
                          arrowBaseWidth: effectiveArrowBaseWidth,
                          arrowLength: effectiveArrowLength,
                          arrowOffset: widget.arrowOffsetValue,
                          arrowTipDistance: effectiveArrowTipDistance,
                          borderColor: widget.borderColor,
                          borderRadius: resolvedBorderRadius,
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.tooltipTheme.properties.transitionDuration ??
        const Duration(milliseconds: 150);

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.tooltipTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

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

class _TooltipPositionProperties {
  final Offset offset;
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double tooltipMaxWidth;

  _TooltipPositionProperties({
    required this.offset,
    required this.followerAnchor,
    required this.targetAnchor,
    required this.tooltipMaxWidth,
  });
}
