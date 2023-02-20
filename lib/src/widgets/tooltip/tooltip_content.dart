import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

class MoonTooltipContent extends StatefulWidget {
  final MoonTooltipDirection tooltipDirection;
  final Offset? targetCenter;
  final double borderRadius;
  final double arrowBaseWidth;
  final double arrowTipDistance;
  final Color borderColor;
  final double borderWidth;
  final double arrowLength;
  final Widget content;
  final EdgeInsets contentPadding;
  final Color backgroundColor;
  final List<BoxShadow> shadows;
  final GestureTapCallback? onTap;
  final void Function(MoonTooltipContentSize) onSizeChange;

  const MoonTooltipContent({
    super.key,
    this.targetCenter,
    required this.tooltipDirection,
    required this.borderRadius,
    required this.arrowBaseWidth,
    required this.arrowTipDistance,
    required this.borderColor,
    required this.borderWidth,
    required this.arrowLength,
    required this.content,
    required this.contentPadding,
    required this.backgroundColor,
    required this.shadows,
    this.onTap,
    required this.onSizeChange,
  });

  @override
  _MoonTooltipContentState createState() => _MoonTooltipContentState();
}

class _MoonTooltipContentState extends State<MoonTooltipContent> {
  final GlobalKey _containerKey = GlobalKey();

  MoonTooltipContentSize? _lastSizeNotified;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      final RenderBox? renderBox = _containerKey.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox == null) return;
      final Size size = renderBox.size;
      final position = renderBox.localToGlobal(Offset.zero);

      if (_lastSizeNotified == null ||
          _lastSizeNotified!.size != size ||
          _lastSizeNotified!.globalPosition != position) {
        final contentSize = MoonTooltipContentSize(
          size: size,
          globalPosition: position,
          context: context,
        );
        widget.onSizeChange(contentSize);
        _lastSizeNotified = contentSize;
      }
    });
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        child: Container(
          key: _containerKey,
          decoration: ShapeDecoration(
            shadows: widget.shadows,
            color: widget.backgroundColor,
            shape: _MoonTooltipContentShape(
              widget.tooltipDirection,
              widget.targetCenter,
              widget.borderRadius,
              widget.arrowBaseWidth,
              widget.arrowTipDistance,
              widget.borderColor,
              widget.borderWidth,
              widget.arrowLength,
            ),
          ),
          padding: widget.contentPadding,
          child: widget.content,
        ),
      ),
    );
  }
}

class _MoonTooltipContentShape extends ShapeBorder {
  final Offset? targetCenter;
  final double arrowBaseWidth;
  final double arrowTipDistance;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final MoonTooltipDirection tooltipDirection;
  final double arrowLength;

  const _MoonTooltipContentShape(
    this.tooltipDirection,
    this.targetCenter,
    this.borderRadius,
    this.arrowBaseWidth,
    this.arrowTipDistance,
    this.borderColor,
    this.borderWidth,
    this.arrowLength,
  );

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10.0);

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
        ..arcToPoint(Offset(rect.left + topLeftRadius, rect.top), radius: Radius.circular(topLeftRadius))
        ..lineTo(rect.right - topRightRadius, rect.top)
        ..arcToPoint(
          Offset(rect.right, rect.top + topRightRadius),
          radius: Radius.circular(topRightRadius),
        );
    }

    Path getBottomRightPath(Rect rect) {
      return Path()
        ..moveTo(rect.left + bottomLeftRadius, rect.bottom)
        ..lineTo(rect.right - bottomRightRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.right, rect.bottom - bottomRightRadius),
          radius: Radius.circular(bottomRightRadius),
          clockwise: false,
        )
        ..lineTo(rect.right, rect.top + topRightRadius)
        ..arcToPoint(
          Offset(rect.right - topRightRadius, rect.top),
          radius: Radius.circular(topRightRadius),
          clockwise: false,
        );
    }

    topLeftRadius = borderRadius;
    topRightRadius = borderRadius;
    bottomLeftRadius = borderRadius;
    bottomRightRadius = borderRadius;

    Offset targetCenter = this.targetCenter ?? rect.center;
    if (tooltipDirection == MoonTooltipDirection.right) {
      targetCenter = rect.centerLeft.translate(-arrowLength, 0);
    } else if (tooltipDirection == MoonTooltipDirection.left) {
      targetCenter = rect.centerRight.translate(arrowLength, 0);
    }

    switch (tooltipDirection) {
      case MoonTooltipDirection.down:
        return getBottomRightPath(rect)
          ..lineTo(
            min(
              max(targetCenter.dx + arrowBaseWidth / 2, rect.left + borderRadius + arrowBaseWidth),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          ..lineTo(targetCenter.dx, rect.top - arrowLength) // up to arrow tip   \
          ..lineTo(
            max(
              min(targetCenter.dx - arrowBaseWidth / 2, rect.right - topLeftRadius - arrowBaseWidth),
              rect.left + topLeftRadius,
            ),
            rect.top,
          ) //  down /

          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: Radius.circular(topLeftRadius),
            clockwise: false,
          )
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: Radius.circular(bottomLeftRadius),
            clockwise: false,
          );

      case MoonTooltipDirection.up:
        return getLeftTopPath(rect)
          ..lineTo(rect.right, rect.bottom - bottomRightRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: Radius.circular(bottomRightRadius),
          )
          ..lineTo(
            min(
              max(targetCenter.dx + arrowBaseWidth / 2, rect.left + bottomLeftRadius + arrowBaseWidth),
              rect.right - bottomRightRadius,
            ),
            rect.bottom,
          )

          // up to arrow tip   \
          ..lineTo(targetCenter.dx, rect.bottom + arrowLength)

          //  down /
          ..lineTo(
            max(
              min(targetCenter.dx - arrowBaseWidth / 2, rect.right - bottomRightRadius - arrowBaseWidth),
              rect.left + bottomLeftRadius,
            ),
            rect.bottom,
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: Radius.circular(bottomLeftRadius),
          )
          ..lineTo(rect.left, rect.top + topLeftRadius)
          ..arcToPoint(
            Offset(rect.left + topLeftRadius, rect.top),
            radius: Radius.circular(topLeftRadius),
          );

      case MoonTooltipDirection.left:
        return getLeftTopPath(rect)
          ..lineTo(
            rect.right,
            max(
              min(targetCenter.dy - arrowBaseWidth / 2, rect.bottom - bottomRightRadius - arrowBaseWidth),
              rect.top + topRightRadius,
            ),
          )
          ..lineTo(targetCenter.dx - arrowTipDistance, targetCenter.dy) // right to arrow tip   \
          //  left /
          ..lineTo(rect.right, min(targetCenter.dy + arrowBaseWidth / 2, rect.bottom - bottomRightRadius))
          ..lineTo(rect.right, rect.bottom - borderRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: Radius.circular(bottomRightRadius),
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: Radius.circular(bottomLeftRadius),
          );

      case MoonTooltipDirection.right:
        return getBottomRightPath(rect)
          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: Radius.circular(topLeftRadius),
            clockwise: false,
          )
          ..lineTo(
            rect.left,
            max(
              min(targetCenter.dy - arrowBaseWidth / 2, rect.bottom - bottomLeftRadius - arrowBaseWidth),
              rect.top + topLeftRadius,
            ),
          )

          //left to arrow tip   /
          ..lineTo(targetCenter.dx + arrowTipDistance, targetCenter.dy)

          //  right \
          ..lineTo(rect.left, min(targetCenter.dy + arrowBaseWidth / 2, rect.bottom - bottomLeftRadius))
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: Radius.circular(bottomLeftRadius),
            clockwise: false,
          );

      default:
        throw AssertionError(tooltipDirection);
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
    return _MoonTooltipContentShape(
      tooltipDirection,
      targetCenter,
      borderRadius,
      arrowBaseWidth,
      arrowTipDistance,
      borderColor,
      borderWidth,
      arrowLength,
    );
  }
}

class MoonTooltipContentSize {
  final Size size;
  final Offset globalPosition;
  final BuildContext context;
  MoonTooltipContentSize({
    required this.size,
    required this.globalPosition,
    required this.context,
  });
}
