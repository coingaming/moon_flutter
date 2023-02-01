import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/theme.dart';

class MoonScaleEffect extends StatefulWidget {
  final bool show;
  final double? effectExtent;
  final Curve? effectCurve;
  final Duration? effectDuration;
  final Widget child;

  const MoonScaleEffect({
    super.key,
    this.show = true,
    this.effectExtent,
    this.effectCurve,
    this.effectDuration,
    required this.child,
  });

  @override
  State<MoonScaleEffect> createState() => _MoonScaleEffectState();
}

class _MoonScaleEffectState extends State<MoonScaleEffect> with SingleTickerProviderStateMixin {
  AnimationController? _scaleAnimationController;
  CurvedAnimation? _scaleAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted && _scaleAnimationController == null) {
      final effectiveScaleEffectDuration = widget.effectDuration ??
          context.moonEffects?.controlScaleEffect.effectDuration ??
          MoonControlsEffects.controlScaleEffect.effectDuration;

      final effectiveScaleEffectCurve = widget.effectCurve ??
          context.moonEffects?.controlScaleEffect.effectCurve ??
          MoonControlsEffects.controlScaleEffect.effectCurve;

      _scaleAnimationController = AnimationController(
        vsync: this,
        duration: effectiveScaleEffectDuration,
        debugLabel: "MoonScaleEffect animation controller",
      );

      _scaleAnimation = CurvedAnimation(
        parent: _scaleAnimationController!,
        curve: effectiveScaleEffectCurve,
      );
    }
  }

  @override
  void didUpdateWidget(MoonScaleEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (mounted) {
      if (widget.show) {
        _scaleAnimationController?.forward();
      } else {
        _scaleAnimationController?.reverse();
      }
    }
  }

  @override
  void dispose() {
    if (_scaleAnimationController != null) {
      _scaleAnimationController?.dispose();
      _scaleAnimationController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaleTween = Tween(
      begin: 1.0,
      end: widget.effectExtent ??
          context.moonEffects?.controlScaleEffect.effectLowerBound ??
          MoonControlsEffects.controlScaleEffect.effectLowerBound,
    );

    final scaleAnimation = scaleTween.animate(_scaleAnimation ?? const AlwaysStoppedAnimation(1));

    return ScaleTransition(
      filterQuality: FilterQuality.medium,
      scale: scaleAnimation,
      child: widget.child,
    );
  }
}
