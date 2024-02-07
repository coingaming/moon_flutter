import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/common/effects/painters/pulse_effect_painter.dart';

class MoonPulseEffect extends StatefulWidget {
  final bool show;
  final bool showJiggle;
  final BorderRadiusGeometry? childBorderRadius;
  final Color effectColor;
  final double effectExtent;
  final Duration effectDuration;
  final Curve effectCurve;
  final Widget child;

  /// Creates a Moon Design pulse effect.
  const MoonPulseEffect({
    super.key,
    required this.show,
    required this.showJiggle,
    this.childBorderRadius,
    required this.effectColor,
    required this.effectExtent,
    required this.effectDuration,
    required this.effectCurve,
    required this.child,
  });

  @override
  State<MoonPulseEffect> createState() => _MoonPulseEffectState();
}

class _MoonPulseEffectState extends State<MoonPulseEffect> with SingleTickerProviderStateMixin {
  static const double _jiggleTimePercentage = 28.6;
  static const double _jiggleRestTimePercentage = 100 - _jiggleTimePercentage * 2;

  late final AnimationController _animationController = AnimationController(
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
    duration: widget.effectDuration,
    debugLabel: "MoonPulseEffect animation controller.",
  );

  late final CurvedAnimation _pulseAnimation = CurvedAnimation(
    parent: _animationController,
    curve: widget.effectCurve,
  );

  late final Animation<double> _jiggleAnimation = TweenSequence<double>(
    [
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -1.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: _jiggleRestTimePercentage / 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -1.0, end: 0.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: _jiggleRestTimePercentage / 2,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(0.0),
        weight: _jiggleRestTimePercentage,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -1.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: _jiggleRestTimePercentage / 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -1.0, end: 0.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: _jiggleRestTimePercentage / 2,
      ),
    ],
  ).animate(_animationController);

  @override
  void didUpdateWidget(covariant MoonPulseEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.show != oldWidget.show) {
      if (widget.show) {
        _animationController.repeat();
      } else {
        _animationController.forward().then((_) => _animationController.reset());
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
    // TODO: Revisit this at a later date, when Impeller is more stable, to determine if we can
    //  use CurvedAnimation with Interval. Currently, there is a bug in Interval where the internal
    //  method curve.transform(t) causes uneven and buggy animations.
    final BorderRadius resolvedBorderRadius =
        widget.childBorderRadius?.resolve(Directionality.of(context)) ?? BorderRadius.zero;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(widget.showJiggle ? _jiggleAnimation.value : 0.0, 0.0),
          child: CustomPaint(
            isComplex: true,
            willChange: true,
            painter: PulseEffectPainter(
              color: widget.effectColor,
              effectExtent: widget.effectExtent,
              borderRadius: resolvedBorderRadius,
              animation: _pulseAnimation,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
