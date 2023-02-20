import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

class MoonTooltipContentTransition extends StatefulWidget {
  final void Function(AnimationStatus)? animationEnd;
  final Duration duration;
  final MoonTooltipDirection tooltipDirection;
  final bool hide;
  final Widget child;

  const MoonTooltipContentTransition({
    super.key,
    required this.duration,
    required this.tooltipDirection,
    this.hide = false,
    this.animationEnd,
    required this.child,
  });

  @override
  MoonTooltipContentTransitionState createState() => MoonTooltipContentTransitionState();
}

class MoonTooltipContentTransitionState extends State<MoonTooltipContentTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: Curves.bounceOut,
      parent: _animationController,
    );
    _rotationAnimation = Tween<double>(begin: pi * .5, end: 0).animate(
      curvedAnimation,
    );
    if (!widget.hide) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _animationController.addStatusListener((status) {
      if ((status == AnimationStatus.completed || status == AnimationStatus.dismissed) && widget.animationEnd != null) {
        widget.animationEnd!(status);
      }
    });
  }

  @override
  void didUpdateWidget(MoonTooltipContentTransition oldWidget) {
    if (widget.hide) {
      _animationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _OpacityAnimationWrapper(
      duration: widget.duration,
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, _) {
          final _ContentTransformation contentTransformation = _ContentTransformation.forAnimationValue(
            _rotationAnimation.value,
            widget.tooltipDirection,
          );
          return Transform(
            alignment: contentTransformation.alignment,
            transform: contentTransformation.transformation,
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _ContentTransformation {
  final Matrix4 transformation;
  final FractionalOffset alignment;

  _ContentTransformation({
    required this.transformation,
    required this.alignment,
  });

  static _ContentTransformation forAnimationValue(double value, MoonTooltipDirection tooltipDirection) {
    late Matrix4 transformation;
    late FractionalOffset alignment;
    if (tooltipDirection == MoonTooltipDirection.up) {
      transformation = Matrix4.rotationX(value);
      alignment = FractionalOffset.bottomCenter;
    } else if (tooltipDirection == MoonTooltipDirection.down) {
      transformation = Matrix4.rotationX(value);
      alignment = FractionalOffset.topCenter;
    } else if (tooltipDirection == MoonTooltipDirection.right) {
      transformation = Matrix4.rotationY(value);
      alignment = FractionalOffset.centerLeft;
    } else if (tooltipDirection == MoonTooltipDirection.left) {
      transformation = Matrix4.rotationY(value);
      alignment = FractionalOffset.centerRight;
    }
    return _ContentTransformation(
      alignment: alignment,
      transformation: transformation,
    );
  }
}

class _OpacityAnimationWrapper extends StatefulWidget {
  final Duration duration;

  const _OpacityAnimationWrapper({
    required this.child,
    required this.duration,
  });

  final Widget child;

  @override
  _OpacityAnimationWrapperState createState() => _OpacityAnimationWrapperState();
}

class _OpacityAnimationWrapperState extends State<_OpacityAnimationWrapper> {
  double _opacity = 0.38;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      opacity: _opacity,
      child: widget.child,
    );
  }
}
