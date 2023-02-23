import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

class TooltipContent extends StatefulWidget {
  final GestureTapCallback? onTap;
  final void Function(TooltipContentSize) onSizeChange;
  final MoonTooltipPosition tooltipPosition;
  final Offset? arrowOffset;
  final double arrowBaseWidth;
  final double arrowLength;
  final double arrowTipDistance;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets contentPadding;
  final List<BoxShadow> shadows;
  final TextStyle textStyle;
  final Widget child;

  const TooltipContent({
    super.key,
    this.onTap,
    required this.onSizeChange,
    required this.tooltipPosition,
    this.arrowOffset,
    required this.arrowBaseWidth,
    required this.arrowLength,
    required this.arrowTipDistance,
    required this.borderRadius,
    required this.borderWidth,
    required this.backgroundColor,
    required this.borderColor,
    required this.contentPadding,
    required this.shadows,
    required this.textStyle,
    required this.child,
  });

  @override
  _TooltipContentState createState() => _TooltipContentState();
}

class _TooltipContentState extends State<TooltipContent> {
  final GlobalKey _containerKey = GlobalKey();

  TooltipContentSize? _lastSizeNotified;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final RenderBox? renderBox = _containerKey.currentContext!.findRenderObject() as RenderBox?;

      if (renderBox == null) return;
      final position = renderBox.localToGlobal(Offset.zero);
      final Size size = renderBox.size;

      if (_lastSizeNotified == null ||
          _lastSizeNotified!.size != size ||
          _lastSizeNotified!.globalPosition != position) {
        final contentSize = TooltipContentSize(
          size: size,
          globalPosition: position,
          context: context,
        );

        widget.onSizeChange(contentSize);
        _lastSizeNotified = contentSize;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: DefaultTextStyle(
        style: widget.textStyle,
        child: Container(
          key: _containerKey,
          padding: widget.contentPadding,
          decoration: ShapeDecoration(
            color: widget.backgroundColor,
            shadows: widget.shadows,
            shape: _TooltipContentShape(
              tooltipPosition: widget.tooltipPosition,
              arrowOffset: widget.arrowOffset,
              arrowBaseWidth: widget.arrowBaseWidth,
              arrowLength: widget.arrowLength,
              arrowTipDistance: widget.arrowTipDistance,
              borderColor: widget.borderColor,
              borderRadius: widget.borderRadius,
              borderWidth: widget.borderWidth,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _TooltipContentShape extends ShapeBorder {
  final MoonTooltipPosition tooltipPosition;
  final Offset? arrowOffset;
  final double arrowBaseWidth;
  final double arrowLength;
  final double arrowTipDistance;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;

  const _TooltipContentShape({
    required this.tooltipPosition,
    this.arrowOffset,
    required this.arrowBaseWidth,
    required this.arrowLength,
    required this.arrowTipDistance,
    required this.borderRadius,
    required this.borderWidth,
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
      borderColor: borderColor,
    );
  }
}

class TooltipContentSize {
  final BuildContext context;
  final Size size;
  final Offset globalPosition;

  TooltipContentSize({
    required this.context,
    required this.size,
    required this.globalPosition,
  });
}
