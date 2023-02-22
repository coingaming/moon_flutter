import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

class TooltipContentTransition extends StatefulWidget {
  final void Function(AnimationStatus)? onTransitionFinished;
  final MoonTooltipDirection tooltipDirection;
  final bool hide;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const TooltipContentTransition({
    super.key,
    this.onTransitionFinished,
    required this.tooltipDirection,
    this.hide = false,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  TooltipContentTransitionState createState() => TooltipContentTransitionState();
}

class TooltipContentTransitionState extends State<TooltipContentTransition> with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  late CurvedAnimation curvedAnimation = CurvedAnimation(
    curve: Curves.easeInOutCubic,
    parent: animationController,
  );

  @override
  void initState() {
    super.initState();

    if (!widget.hide) {
      animationController.forward();
    } else {
      animationController.reverse();
    }

    animationController.addStatusListener((status) {
      if ((status == AnimationStatus.completed || status == AnimationStatus.dismissed) &&
          widget.onTransitionFinished != null) {
        widget.onTransitionFinished!(status);
      }
    });
  }

  @override
  void didUpdateWidget(TooltipContentTransition oldWidget) {
    if (widget.hide) {
      animationController.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FadeTransition(opacity: curvedAnimation, child: widget.child),
    );
  }
}
