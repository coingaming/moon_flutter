import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/effects/painters/focus_effect_painter.dart';

class MoonFocusEffect extends StatefulWidget {
  final bool show;
  final double effectExtent;
  final Color effectColor;
  final Curve effectCurve;
  final Duration effectDuration;
  final BorderRadius childBorderRadius;
  final Widget child;

  const MoonFocusEffect({
    super.key,
    required this.show,
    required this.effectExtent,
    required this.effectColor,
    required this.effectCurve,
    required this.effectDuration,
    required this.childBorderRadius,
    required this.child,
  });

  @override
  State<MoonFocusEffect> createState() => _MoonFocusEffectState();
}

class _MoonFocusEffectState extends State<MoonFocusEffect> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _focusAnimation;

  double maxBorderRadius() {
    final maxRadiusValue = [
      max(widget.childBorderRadius.topLeft.x, widget.childBorderRadius.topLeft.y),
      max(widget.childBorderRadius.topRight.x, widget.childBorderRadius.topRight.y),
      max(widget.childBorderRadius.bottomLeft.x, widget.childBorderRadius.bottomLeft.y),
      max(widget.childBorderRadius.bottomRight.x, widget.childBorderRadius.bottomRight.y)
    ].reduce(max);

    return maxRadiusValue > 1 ? maxRadiusValue : 1;
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.effectDuration,
        debugLabel: "MoonFocusEffect animation controller",
      );

      _focusAnimation = CurvedAnimation(
        parent: _animationController,
        curve: widget.effectCurve,
      );
    }
  }

  @override
  void didUpdateWidget(MoonFocusEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (mounted) {
      if (widget.show) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulseEffectEndBorderRadius = maxBorderRadius();

    return CustomPaint(
      isComplex: true,
      willChange: true,
      painter: FocusEffectPainter(
        color: widget.effectColor,
        effectExtent: widget.effectExtent,
        borderRadiusValue: pulseEffectEndBorderRadius,
        animation: _focusAnimation,
      ),
      child: widget.child,
    );
  }
}
