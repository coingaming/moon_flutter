import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/common/effects/painters/focus_effect_painter.dart';

class MoonFocusEffect extends StatefulWidget {
  final bool show;
  final BorderRadius? childBorderRadius;
  final Color effectColor;
  final double effectExtent;
  final Duration effectDuration;
  final Curve effectCurve;
  final Widget child;

  const MoonFocusEffect({
    super.key,
    required this.show,
    this.childBorderRadius,
    required this.effectColor,
    required this.effectExtent,
    required this.effectDuration,
    required this.effectCurve,
    required this.child,
  });

  @override
  State<MoonFocusEffect> createState() => _MoonFocusEffectState();
}

class _MoonFocusEffectState extends State<MoonFocusEffect> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: widget.effectDuration,
    debugLabel: "MoonFocusEffect animation controller",
  );

  late final CurvedAnimation _focusAnimation = CurvedAnimation(
    parent: _animationController,
    curve: widget.effectCurve,
  );

  @override
  void didUpdateWidget(MoonFocusEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.show) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return RepaintBoundary(
          child: CustomPaint(
            willChange: true,
            painter: FocusEffectPainter(
              color: widget.effectColor,
              effectExtent: widget.effectExtent,
              borderRadius: widget.childBorderRadius ?? BorderRadius.zero,
              animation: _focusAnimation,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
