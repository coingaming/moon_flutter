import 'dart:developer' as dev;
import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/widgets/tooltip/obfuscate_tooltip_item.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_content_transition.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip_position_manager.dart';

enum MoonTooltipPosition {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
  left,
  right,
  horizontal,
  vertical,
}

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
  final LayerLink layerLink = LayerLink();

  double _childWidth = 0;

  bool _isVisible = false;
  bool _routeIsShowing = true;

  OverlayEntry? _overlayEntry;

  bool get shouldShowTooltip => widget.show && _routeIsShowing;

  void _showTooltip() {
    dev.log("show");
    _clearOverlayEntry();

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;
  }

  void _clearOverlayEntry() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry!.dispose();
      _overlayEntry = null;
    }
  }

  void _removeTooltip() {
    dev.log("remove");
    if (!_isVisible) return;

    _clearOverlayEntry();

    _isVisible = false;
  }

  void doShowOrHide() {
    if (shouldShowTooltip) {
      _showTooltip();
    } else {
      _removeTooltip();
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

  _TooltipPositionProperties _resolveTooltipPosition({
    required MoonTooltipPosition tooltipPosition,
    required double arrowTipDistance,
    required double arrowLength,
  }) {
    switch (tooltipPosition) {
      case MoonTooltipPosition.top:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
        );

      case MoonTooltipPosition.bottom:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
        );

      case MoonTooltipPosition.left:
        return _TooltipPositionProperties(
          offset: Offset(-(arrowTipDistance + arrowLength), 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
        );

      case MoonTooltipPosition.right:
        return _TooltipPositionProperties(
          offset: Offset(arrowTipDistance + arrowLength, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
        );

      case MoonTooltipPosition.topLeft:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
        );

      case MoonTooltipPosition.topRight:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
        );

      case MoonTooltipPosition.bottomLeft:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
        );

      case MoonTooltipPosition.bottomRight:
        return _TooltipPositionProperties(
          offset: Offset(0, arrowTipDistance + arrowLength),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
        );

      default:
        return _TooltipPositionProperties(
          offset: Offset(0, -(arrowTipDistance + arrowLength)),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
        );
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
      if (!_routeIsShowing) return;

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

  OverlayEntry _createOverlayEntry() {
    MoonTooltipPosition tooltipPosition = widget.tooltipPosition;

    if (tooltipPosition == MoonTooltipPosition.horizontal || tooltipPosition == MoonTooltipPosition.vertical) {
      // Compute real tooltipPosition based on target position
      final targetRenderBox = context.findRenderObject() as RenderBox?;
      final overlayRenderBox = Overlay.of(context).context.findRenderObject() as RenderBox?;

      final targetGlobalCenter =
          targetRenderBox?.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox) ??
              Offset.zero;

      tooltipPosition = (tooltipPosition == MoonTooltipPosition.vertical)
          ? (targetGlobalCenter.dy < overlayRenderBox!.size.center(Offset.zero).dy
              ? MoonTooltipPosition.bottom
              : MoonTooltipPosition.top)
          : (targetGlobalCenter.dx < overlayRenderBox!.size.center(Offset.zero).dx
              ? MoonTooltipPosition.right
              : MoonTooltipPosition.left);
    }
    final double effectiveArrowBaseWidth = widget.arrowBaseWidth ?? context.moonTooltipTheme?.arrowBaseWidth ?? 16;

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

    final toolTipPosition = _resolveTooltipPosition(
      tooltipPosition: tooltipPosition,
      arrowTipDistance: effectiveArrowTipDistance,
      arrowLength: effectiveArrowLength,
    );

    return OverlayEntry(
      builder: (context) {
        return UnconstrainedBox(
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: toolTipPosition.offset,
            followerAnchor: toolTipPosition.followerAnchor,
            targetAnchor: toolTipPosition.targetAnchor,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _handleTap,
              child: DefaultTextStyle(
                style: effectiveTextStyle,
                child: Container(
                  padding: effectiveContentPadding,
                  decoration: ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shadows: effectiveTooltipShadows,
                    shape: _TooltipContentShape(
                      arrowBaseWidth: effectiveArrowBaseWidth,
                      arrowLength: effectiveArrowLength,
                      arrowOffset: widget.arrowOffset,
                      arrowTipDistance: effectiveArrowTipDistance,
                      borderColor: widget.borderColor,
                      borderRadius: effectiveBorderRadius,
                      borderWidth: widget.borderWidth,
                      childWidth: _childWidth,
                      tooltipPosition: widget.tooltipPosition,
                    ),
                  ),
                  child: widget.content,
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
    _childWidth = context.findRenderObject()?.paintBounds.width ?? 0;
    dev.log(_childWidth.toString());
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

  _TooltipPositionProperties({
    required this.offset,
    required this.followerAnchor,
    required this.targetAnchor,
  });
}

class _TooltipContentShape extends ShapeBorder {
  final MoonTooltipPosition tooltipPosition;
  final Offset? arrowOffset;
  final double arrowBaseWidth;
  final double arrowLength;
  final double arrowTipDistance;
  final double borderRadius;
  final double borderWidth;
  final double childWidth;
  final Color borderColor;

  const _TooltipContentShape({
    required this.tooltipPosition,
    this.arrowOffset,
    required this.arrowBaseWidth,
    required this.arrowLength,
    required this.arrowTipDistance,
    required this.borderRadius,
    required this.borderWidth,
    required this.childWidth,
    required this.borderColor,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    late double topLeftRadius;
    late double topRightRadius;
    late double bottomLeftRadius;
    late double bottomRightRadius;

    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom - bottomLeftRadius)
        ..lineTo(rect.left, rect.top + topLeftRadius)
        ..arcToPoint(
          Offset(rect.left + topLeftRadius, rect.top),
          radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
        )
        ..lineTo(rect.right - topRightRadius, rect.top)
        ..arcToPoint(
          Offset(rect.right, rect.top + topRightRadius),
          radius: SmoothRadius(cornerRadius: topRightRadius, cornerSmoothing: 1),
        );
    }

    Path getBottomRightPath(Rect rect) {
      return Path()
        ..moveTo(rect.left + bottomLeftRadius, rect.bottom)
        ..lineTo(rect.right - bottomRightRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.right, rect.bottom - bottomRightRadius),
          radius: SmoothRadius(cornerRadius: bottomRightRadius, cornerSmoothing: 1),
          clockwise: false,
        )
        ..lineTo(rect.right, rect.top + topRightRadius)
        ..arcToPoint(
          Offset(rect.right - topRightRadius, rect.top),
          radius: SmoothRadius(cornerRadius: topRightRadius, cornerSmoothing: 1),
          clockwise: false,
        );
    }

    topLeftRadius = borderRadius;
    topRightRadius = borderRadius;
    bottomLeftRadius = borderRadius;
    bottomRightRadius = borderRadius;

    Offset arrowOffset = this.arrowOffset ?? rect.center;

    if (tooltipPosition == MoonTooltipPosition.right) {
      arrowOffset = rect.centerLeft.translate(-arrowLength - arrowTipDistance, 0);
    } else if (tooltipPosition == MoonTooltipPosition.left) {
      arrowOffset = rect.centerRight.translate(arrowLength + arrowTipDistance, 0);
    }

    switch (tooltipPosition) {
      case MoonTooltipPosition.top:
        return getLeftTopPath(rect)
          ..lineTo(rect.right, rect.bottom - bottomRightRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomRightRadius, cornerSmoothing: 1),
          )
          ..lineTo(
            min(
              max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + bottomLeftRadius + arrowBaseWidth),
              rect.right - bottomRightRadius,
            ),
            rect.bottom,
          )

          // up to arrow tip   \
          ..lineTo(arrowOffset.dx, rect.bottom + arrowLength)

          //  down /
          ..lineTo(
            max(
              min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - bottomRightRadius - arrowBaseWidth),
              rect.left + bottomLeftRadius,
            ),
            rect.bottom,
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
          )
          ..lineTo(rect.left, rect.top + topLeftRadius)
          ..arcToPoint(
            Offset(rect.left + topLeftRadius, rect.top),
            radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
          );

      case MoonTooltipPosition.bottom:
        return getBottomRightPath(rect)
          ..lineTo(
            min(
              max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + borderRadius + arrowBaseWidth),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          ..lineTo(arrowOffset.dx, rect.top - arrowLength) // up to arrow tip   \
          ..lineTo(
            max(
              min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - topLeftRadius - arrowBaseWidth),
              rect.left + topLeftRadius,
            ),
            rect.top,
          ) //  down /

          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          )
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          );

      case MoonTooltipPosition.left:
        return getLeftTopPath(rect)
          ..lineTo(
            rect.right,
            max(
              min(arrowOffset.dy - arrowBaseWidth / 2, rect.bottom - bottomRightRadius - arrowBaseWidth),
              rect.top + topRightRadius,
            ),
          )
          ..lineTo(arrowOffset.dx - arrowTipDistance, arrowOffset.dy) // right to arrow tip   \
          //  left /
          ..lineTo(rect.right, min(arrowOffset.dy + arrowBaseWidth / 2, rect.bottom - bottomRightRadius))
          ..lineTo(rect.right, rect.bottom - borderRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomRightRadius, cornerSmoothing: 1),
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
          );

      case MoonTooltipPosition.right:
        return getBottomRightPath(rect)
          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          )
          ..lineTo(
            rect.left,
            max(
              min(arrowOffset.dy - arrowBaseWidth / 2, rect.bottom - bottomLeftRadius - arrowBaseWidth),
              rect.top + topLeftRadius,
            ),
          )

          //left to arrow tip   /
          ..lineTo(arrowOffset.dx + arrowTipDistance, arrowOffset.dy)

          //  right \
          ..lineTo(rect.left, min(arrowOffset.dy + arrowBaseWidth / 2, rect.bottom - bottomLeftRadius))
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          );

      case MoonTooltipPosition.topLeft:
        return getLeftTopPath(rect)
          ..lineTo(rect.right, rect.bottom - bottomRightRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomRightRadius, cornerSmoothing: 1),
          )
          ..lineTo(
            min(
              //max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + bottomLeftRadius + arrowBaseWidth),
              rect.right - bottomRightRadius,
              rect.right - (childWidth / 2) + (arrowBaseWidth / 2),
            ),
            rect.bottom,
          )

          // up to arrow tip   \
          ..lineTo(rect.right - (childWidth / 2), rect.bottom + arrowLength)

          //  down /
          ..lineTo(
            max(
              //min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - bottomRightRadius - arrowBaseWidth),
              rect.right - (childWidth / 2) - (arrowBaseWidth / 2),
              rect.left + bottomLeftRadius,
            ),
            rect.bottom,
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
          )
          ..lineTo(rect.left, rect.top + topLeftRadius)
          ..arcToPoint(
            Offset(rect.left + topLeftRadius, rect.top),
            radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
          );

      case MoonTooltipPosition.topRight:
        return getLeftTopPath(rect)
          ..lineTo(rect.right, rect.bottom - bottomRightRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomRightRadius, cornerSmoothing: 1),
          )
          ..lineTo(
            min(
              max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + bottomLeftRadius + arrowBaseWidth),
              rect.right - bottomRightRadius,
            ),
            rect.bottom,
          )

          // up to arrow tip   \
          ..lineTo(arrowOffset.dx, rect.bottom + arrowLength)

          //  down /
          ..lineTo(
            max(
              min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - bottomRightRadius - arrowBaseWidth),
              rect.left + bottomLeftRadius,
            ),
            rect.bottom,
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
          )
          ..lineTo(rect.left, rect.top + topLeftRadius)
          ..arcToPoint(
            Offset(rect.left + topLeftRadius, rect.top),
            radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
          );

      case MoonTooltipPosition.bottomLeft:
        return getBottomRightPath(rect)
          ..lineTo(
            min(
              max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + borderRadius + arrowBaseWidth),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          ..lineTo(arrowOffset.dx, rect.top - arrowLength) // up to arrow tip   \
          ..lineTo(
            max(
              min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - topLeftRadius - arrowBaseWidth),
              rect.left + topLeftRadius,
            ),
            rect.top,
          ) //  down /

          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          )
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          );

      case MoonTooltipPosition.bottomRight:
        return getBottomRightPath(rect)
          ..lineTo(
            min(
              max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + borderRadius + arrowBaseWidth),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          ..lineTo(arrowOffset.dx, rect.top - arrowLength) // up to arrow tip   \
          ..lineTo(
            max(
              min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - topLeftRadius - arrowBaseWidth),
              rect.left + topLeftRadius,
            ),
            rect.top,
          ) //  down /

          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: SmoothRadius(cornerRadius: topLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          )
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: SmoothRadius(cornerRadius: bottomLeftRadius, cornerSmoothing: 1),
            clockwise: false,
          );

      default:
        throw AssertionError(tooltipPosition);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Paint paint = Paint()
      // if borderWidth is set to 0, set the color to be transparent to avoid border to be visible because strange behavior
      ..color = borderWidth == 0 ? Colors.transparent : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(getOuterPath(rect), paint);
    canvas.clipPath(getOuterPath(rect));
  }

  @override
  ShapeBorder scale(double t) {
    return _TooltipContentShape(
      tooltipPosition: tooltipPosition,
      arrowOffset: arrowOffset,
      arrowBaseWidth: arrowBaseWidth,
      arrowLength: arrowLength,
      arrowTipDistance: arrowTipDistance,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      childWidth: childWidth,
      borderColor: borderColor,
    );
  }
}
