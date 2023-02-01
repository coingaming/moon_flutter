import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/effects/painters/pulse_effect_painter.dart';

class MoonPulseEffect extends StatefulWidget {
  final bool show;
  final bool showJiggle;
  final double? effectExtent;
  final Color? effectColor;
  final Curve? effectCurve;
  final Duration? effectDuration;
  final BorderRadius childBorderRadius;
  final Widget child;

  const MoonPulseEffect({
    super.key,
    this.show = false,
    this.showJiggle = true,
    this.effectExtent,
    this.effectColor,
    this.effectCurve,
    this.effectDuration,
    required this.childBorderRadius,
    required this.child,
  });

  @override
  State<MoonPulseEffect> createState() => _MoonPulseEffectState();
}

class _MoonPulseEffectState extends State<MoonPulseEffect> with SingleTickerProviderStateMixin {
  static const double _jiggleTimePercentage = 28.6;
  static const double _jiggleRestTimePercentage = 100 - _jiggleTimePercentage * 2;

  AnimationController? _pulseAnimationController;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted && _pulseAnimationController == null) {
      final effectivePulseAnimationDuration = widget.effectDuration ??
          context.moonEffects?.controlPulseEffect.effectDuration ??
          MoonControlsEffects.controlPulseEffect.effectDuration;

      _pulseAnimationController = AnimationController(
        animationBehavior: AnimationBehavior.preserve,
        vsync: this,
        duration: effectivePulseAnimationDuration,
        debugLabel: "MoonPulseEffect animation controller",
      );

      if (widget.show) _pulseAnimationController!.repeat();
    }
  }

  @override
  void dispose() {
    if (_pulseAnimationController != null) {
      _pulseAnimationController?.dispose();
      _pulseAnimationController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulseEffectEndBorderRadius = maxBorderRadius();

    final effectivePulseEffectColor = widget.effectColor ??
        context.moonEffects?.controlPulseEffect.effectColor ??
        MoonControlsEffects.controlPulseEffect.effectColor!;

    final effectivePulseEffectExtent = widget.effectExtent ??
        context.moonEffects?.controlPulseEffect.effectExtent ??
        MoonControlsEffects.controlPulseEffect.effectExtent!;

    final effectivePulseEffectCurve = widget.effectCurve ??
        context.moonEffects?.controlPulseEffect.effectCurve ??
        MoonControlsEffects.controlPulseEffect.effectCurve;

    // TODO: Review at a later date (when Impeller is stable?) if CurvedAnimation with Interval can be used. Currently
    //interval has a bug where the curve parameters curve.transform(t) internal method causes uneven buggy animation.
    final pulsingAnimation = CurvedAnimation(
      parent: _pulseAnimationController ?? const AlwaysStoppedAnimation(0.0),
      curve: effectivePulseEffectCurve,
    );

    final jiggleAnimation = TweenSequence<double>(
      [
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: -1.0).chain(CurveTween(curve: effectivePulseEffectCurve)),
          weight: _jiggleRestTimePercentage / 2,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -1.0, end: 0.0).chain(CurveTween(curve: effectivePulseEffectCurve)),
          weight: _jiggleRestTimePercentage / 2,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.0),
          weight: _jiggleRestTimePercentage,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: -1.0).chain(CurveTween(curve: effectivePulseEffectCurve)),
          weight: _jiggleRestTimePercentage / 2,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -1.0, end: 0.0).chain(CurveTween(curve: effectivePulseEffectCurve)),
          weight: _jiggleRestTimePercentage / 2,
        ),
      ],
    ).animate(_pulseAnimationController ?? const AlwaysStoppedAnimation(0.0));

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: jiggleAnimation,
        builder: (context, child) => Transform.translate(
          offset: Offset(widget.showJiggle ? jiggleAnimation.value : 0.0, 0.0),
          child: CustomPaint(
            isComplex: true,
            willChange: true,
            painter: PulseEffectPainter(
              color: effectivePulseEffectColor,
              effectExtent: effectivePulseEffectExtent,
              borderRadiusValue: pulseEffectEndBorderRadius,
              animation: pulsingAnimation,
            ),
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
