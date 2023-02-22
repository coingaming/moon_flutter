import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

class TooltipPositionManager extends StatefulWidget {
  final BuildContext context;
  final MoonTooltipPosition tooltipPosition;
  final double arrowTipDistance;
  final double arrowLength;
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final double tooltipMargin;
  final LayerLink link;
  final Widget child;

  const TooltipPositionManager({
    super.key,
    required this.context,
    required this.tooltipPosition,
    required this.arrowTipDistance,
    required this.arrowLength,
    required this.maxWidth,
    required this.maxHeight,
    required this.minWidth,
    required this.minHeight,
    required this.tooltipMargin,
    required this.link,
    required this.child,
  });

  @override
  _TooltipPositionManagerState createState() => _TooltipPositionManagerState();
}

class _TooltipPositionManagerState extends State<TooltipPositionManager> {
  final GlobalKey _contentKey = GlobalKey();

  Size? _contentSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(TooltipPositionManager oldWidget) {
    if (widget.tooltipPosition != oldWidget.tooltipPosition) {
      // invalidate content size to perform recalculation
      _contentSize = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext _) {
    final RenderBox? renderBox = widget.context.findRenderObject() as RenderBox?;
    if (renderBox?.attached == false) return Container();

    final cOverlay = Overlay.of(widget.context);

    if (!cOverlay.mounted) return Container();

    final RenderBox? overlay = cOverlay.context.findRenderObject() as RenderBox?;

    if (overlay == null || renderBox?.hasSize == false) return Container();

    late Offset tipTarget;

    const Offset zeroOffset = Offset.zero;

    try {
      if (widget.tooltipPosition == MoonTooltipPosition.top) {
        tipTarget = renderBox!.size.topCenter(zeroOffset);
      } else if (widget.tooltipPosition == MoonTooltipPosition.bottom) {
        tipTarget = renderBox!.size.bottomCenter(zeroOffset);
      } else if (widget.tooltipPosition == MoonTooltipPosition.right) {
        tipTarget = renderBox!.size.centerRight(zeroOffset);
      } else if (widget.tooltipPosition == MoonTooltipPosition.left) {
        tipTarget = renderBox!.size.centerLeft(zeroOffset);
      }
    } catch (e) {
      return Container();
    }

    final globalTipTarget = renderBox?.localToGlobal(
      tipTarget,
      ancestor: overlay,
    );

    final content = CustomSingleChildLayout(
      delegate: _PopupContentLayoutDelegate(
        arrowLength: widget.arrowLength,
        arrowTipDistance: widget.arrowTipDistance,
        maxHeight: widget.maxHeight,
        maxWidth: widget.maxWidth,
        minHeight: widget.minHeight,
        minWidth: widget.minWidth,
        tooltipPosition: widget.tooltipPosition,
        tipTarget: globalTipTarget!,
        tooltipMargin: widget.tooltipMargin,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned(
            child: Container(
              key: _contentKey,
              child: widget.child,
            ),
          ),
        ],
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contentContext = _contentKey.currentContext;
      if (contentContext != null) {
        final contentSize = contentContext.size!;

        final wasNull = _contentSize == null;
        _contentSize = contentSize;

        if (wasNull) {
          setState(() {});
        }
      }
    });

    final offset = getPositionForChild(_contentSize, overlay, globalTipTarget);

    return Stack(
      children: <Widget>[
        CompositedTransformFollower(
          link: widget.link,
          showWhenUnlinked: false,
          offset: tipTarget.translate(offset.dx, offset.dy), //
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                child: Transform.translate(
                  offset: Offset.zero,
                  child: Container(
                    alignment: AlignmentDirectional.bottomStart,
                    child: content,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Offset getPositionForChild(
    Size? childSize,
    RenderBox overlay,
    Offset globalTipTarget,
  ) {
    if (childSize == null) {
      return Offset.zero;
    }
    Offset contentOffset;
    final double halfH = childSize.height / 2;
    final double halfW = childSize.width / 2;
    final Offset centerPosition = Offset(-halfW, -halfH);
    if (widget.tooltipPosition == MoonTooltipPosition.top) {
      final double yOffset = -halfH - widget.arrowLength - widget.arrowTipDistance;
      contentOffset = centerPosition.translate(0, yOffset);
      final maxXOffset = overlay.size.width;
      final globalcontentRightBoundingOffset = globalTipTarget.dx + contentOffset.dx + childSize.width;
      if (globalcontentRightBoundingOffset > maxXOffset) {
        contentOffset = contentOffset.translate(
          maxXOffset - globalcontentRightBoundingOffset - widget.tooltipMargin,
          0,
        );
      }
      const minXOffset = 0;
      final globalcontentLeftBoundingOffset = globalTipTarget.dx + contentOffset.dx;
      if (globalcontentLeftBoundingOffset < minXOffset) {
        contentOffset = contentOffset.translate(
          minXOffset - globalcontentLeftBoundingOffset + widget.tooltipMargin,
          0,
        );
      }
    } else if (widget.tooltipPosition == MoonTooltipPosition.bottom) {
      final double yOffset = halfH + widget.arrowLength + widget.arrowTipDistance;
      contentOffset = centerPosition.translate(0, yOffset);
    } else if (widget.tooltipPosition == MoonTooltipPosition.right) {
      final double xOffset = halfW + widget.arrowLength + widget.arrowTipDistance;
      contentOffset = centerPosition.translate(xOffset, 0);
      final maxXOffset = overlay.size.width;
      final globalcontentRightBoundingOffset = globalTipTarget.dx + contentOffset.dx + childSize.width;
      if (globalcontentRightBoundingOffset > maxXOffset) {
        contentOffset = contentOffset.translate(
          maxXOffset - globalcontentRightBoundingOffset - widget.tooltipMargin,
          0,
        );
      }
    } else if (widget.tooltipPosition == MoonTooltipPosition.left) {
      final double xOffset = -halfW - widget.arrowLength - widget.arrowTipDistance;
      contentOffset = centerPosition.translate(xOffset, 0);
      const minXOffset = 0;
      final globalcontentLeftBoundingOffset = globalTipTarget.dx + contentOffset.dx;
      if (globalcontentLeftBoundingOffset < minXOffset) {
        contentOffset = contentOffset.translate(
          minXOffset - globalcontentLeftBoundingOffset + widget.tooltipMargin,
          0,
        );
      }
    } else {
      contentOffset = centerPosition;
    }
    return contentOffset;
  }
}

class _PopupContentLayoutDelegate extends SingleChildLayoutDelegate {
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final MoonTooltipPosition tooltipPosition;
  final double arrowTipDistance;
  final double arrowLength;
  final Offset tipTarget;
  final double tooltipMargin;

  _PopupContentLayoutDelegate({
    required this.maxWidth,
    required this.maxHeight,
    required this.minWidth,
    required this.minHeight,
    required this.tooltipPosition,
    required this.arrowLength,
    required this.arrowTipDistance,
    required this.tipTarget,
    required this.tooltipMargin,
  });

  @override
  bool shouldRelayout(_PopupContentLayoutDelegate oldDelegate) {
    return oldDelegate.tipTarget.dx != tipTarget.dx || oldDelegate.tipTarget.dy != tipTarget.dy;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double minWidth = this.minWidth ?? constraints.minWidth;
    final double minHeight = this.minHeight ?? constraints.minHeight;

    double maxWidth = this.maxWidth ?? constraints.maxWidth;
    double maxHeight = this.maxHeight ?? constraints.maxHeight;

    if (tooltipPosition == MoonTooltipPosition.top || tooltipPosition == MoonTooltipPosition.bottom) {
      maxWidth = max(
        min(
          (constraints.maxWidth - tipTarget.dx).abs() * 2 - tooltipMargin,
          (tipTarget.dx).abs() * 2 - tooltipMargin,
        ),
        0,
      );
      maxHeight = max(
        constraints.maxHeight - tooltipMargin,
        0,
      );
    } else if (tooltipPosition == MoonTooltipPosition.right) {
      maxWidth = max(
        (constraints.maxWidth - tipTarget.dx).abs() - tooltipMargin - arrowLength - arrowTipDistance,
        0,
      );
      maxHeight = max(
        constraints.maxHeight - tooltipMargin,
        0,
      );
    } else if (tooltipPosition == MoonTooltipPosition.left) {
      maxWidth = max(
        min(
          tipTarget.dx >= constraints.maxWidth
              ? (constraints.maxWidth - tipTarget.dx).abs() - tooltipMargin - arrowLength - arrowTipDistance
              : maxWidth,
          tipTarget.dx - (tooltipMargin * 2) - arrowTipDistance,
        ),
        0,
      );
      maxHeight = max(
        constraints.maxHeight - tooltipMargin,
        0,
      );
    }

    return BoxConstraints(
      maxHeight: this.maxHeight ?? max(maxHeight, minHeight),
      maxWidth: this.maxWidth ?? max(maxWidth, minWidth),
      minHeight: this.minHeight ?? minHeight,
      minWidth: this.minWidth ?? minWidth,
    );
  }
}
