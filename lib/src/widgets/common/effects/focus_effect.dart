import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/max_border_radius.dart';
import 'package:moon_design/src/widgets/common/effects/painters/focus_effect_painter.dart';

class MoonFocusEffect extends StatefulWidget {
  final bool show;
  final double effectExtent;
  final Color effectColor;
  final Duration effectDuration;
  final Curve effectCurve;
  final BorderRadius? childBorderRadius;
  final Widget child;

  const MoonFocusEffect({
    super.key,
    required this.show,
    required this.effectExtent,
    required this.effectColor,
    required this.effectDuration,
    required this.effectCurve,
    this.childBorderRadius,
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
    final double focusEffectBorderRadius = maxBorderRadius(widget.childBorderRadius);

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            willChange: true,
            painter: FocusEffectPainter(
              color: widget.effectColor,
              effectExtent: widget.effectExtent,
              borderRadiusValue: focusEffectBorderRadius,
              animation: _focusAnimation,
            ),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
