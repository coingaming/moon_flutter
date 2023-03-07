import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

class TooltipContentShape extends ShapeBorder {
  final MoonTooltipPosition tooltipPosition;
  final Offset? arrowOffset;
  final double arrowBaseWidth;
  final double arrowLength;
  final double arrowTipDistance;
  final double borderRadius;
  final double borderWidth;
  final double childWidth;
  final Color borderColor;

  const TooltipContentShape({
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
          // To arrow base
          ..lineTo(
            min(
              max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + bottomLeftRadius + arrowBaseWidth),
              rect.right - bottomRightRadius,
            ),
            rect.bottom,
          )
          // To arrow tip
          ..lineTo(arrowOffset.dx, rect.bottom + arrowLength)
          // From arrow tip
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
          // To arrow base
          ..lineTo(
            min(
              max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + borderRadius + arrowBaseWidth),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          // To arrow tip
          ..lineTo(arrowOffset.dx, rect.top - arrowLength)
          // From arrow tip
          ..lineTo(
            max(
              min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - topLeftRadius - arrowBaseWidth),
              rect.left + topLeftRadius,
            ),
            rect.top,
          )
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
          // To arrow base
          ..lineTo(
            rect.right,
            max(
              min(arrowOffset.dy - arrowBaseWidth / 2, rect.bottom - bottomRightRadius - arrowBaseWidth),
              rect.top + topRightRadius,
            ),
          )
          // To arrow tip
          ..lineTo(arrowOffset.dx - arrowTipDistance, arrowOffset.dy)
          // From arrow tip
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
          // To arrow base
          ..lineTo(
            rect.left,
            max(
              min(arrowOffset.dy - arrowBaseWidth / 2, rect.bottom - bottomLeftRadius - arrowBaseWidth),
              rect.top + topLeftRadius,
            ),
          )
          // To arrow tip
          ..lineTo(arrowOffset.dx + arrowTipDistance, arrowOffset.dy)
          // From arrow tip
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
          // To arrow base
          ..lineTo(
            min(
              //max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + bottomLeftRadius + arrowBaseWidth),
              rect.right - bottomRightRadius,
              rect.right - (childWidth / 2) + (arrowBaseWidth / 2),
            ),
            rect.bottom,
          )
          // To arrow tip
          ..lineTo(rect.right - (childWidth / 2), rect.bottom + arrowLength)
          // From arrow tip
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
          // To arrow base
          ..lineTo(
            min(
              //max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + bottomLeftRadius + arrowBaseWidth),
              rect.right - bottomRightRadius,
              rect.left + (childWidth / 2) + (arrowBaseWidth / 2),
            ),
            rect.bottom,
          )
          // To arrow tip
          ..lineTo(rect.left + (childWidth / 2), rect.bottom + arrowLength)
          // From arrow tip
          ..lineTo(
            max(
              //min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - bottomRightRadius - arrowBaseWidth),
              rect.left + (childWidth / 2) - (arrowBaseWidth / 2),
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
          // To arrow base
          ..lineTo(
            min(
              //max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + borderRadius + arrowBaseWidth),
              rect.right - (childWidth / 2) + (arrowBaseWidth / 2),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          // To arrow tip
          ..lineTo(rect.right - (childWidth / 2), rect.top - arrowLength)
          // From arrow tip
          ..lineTo(
            max(
              //min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - topLeftRadius - arrowBaseWidth),
              rect.right - (childWidth / 2) - (arrowBaseWidth / 2),
              rect.left + topLeftRadius,
            ),
            rect.top,
          )
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
          // To arrow base
          ..lineTo(
            min(
              //max(arrowOffset.dx + arrowBaseWidth / 2, rect.left + borderRadius + arrowBaseWidth),
              rect.left + (childWidth / 2) + (arrowBaseWidth / 2),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          // To arrow tip
          ..lineTo(rect.left + (childWidth / 2), rect.top - arrowLength)
          // From arrow tip
          ..lineTo(
            max(
              //min(arrowOffset.dx - arrowBaseWidth / 2, rect.right - topLeftRadius - arrowBaseWidth),
              rect.left + (childWidth / 2) - (arrowBaseWidth / 2),
              rect.left + topLeftRadius,
            ),
            rect.top,
          )
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
      // If borderWidth is set to 0, set the color to be transparent to avoid strange behavior with border
      ..color = borderWidth == 0 ? Colors.transparent : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(getOuterPath(rect), paint);
    canvas.clipPath(getOuterPath(rect));
  }

  @override
  ShapeBorder scale(double t) {
    return TooltipContentShape(
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
