import 'package:flutter/material.dart';

class TooltipContentTransition extends StatefulWidget {
  final void Function(AnimationStatus)? onTransitionFinished;
  final bool show;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const TooltipContentTransition({
    super.key,
    this.onTransitionFinished,
    this.show = false,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  TooltipContentTransitionState createState() => TooltipContentTransitionState();
}

class TooltipContentTransitionState extends State<TooltipContentTransition> with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    duration: widget.duration,
    vsync: this,
    value: widget.show ? 0.0 : 1.0,
  );

  late CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animationController,
    curve: widget.curve,
  );

  @override
  void initState() {
    super.initState();

    if (widget.show) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(TooltipContentTransition oldWidget) {
    if (!widget.show) {
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
