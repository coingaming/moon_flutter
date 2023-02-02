import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/measure_size.dart';
import 'package:moon_design/src/utils/sized_scale_transition.dart';

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

  Size childSize = Size.zero;

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
    final effectiveScaleEffectTarget = widget.effectExtent ??
        context.moonEffects?.controlScaleEffect.effectLowerBound ??
        MoonControlsEffects.controlScaleEffect.effectLowerBound!;

    log(childSize.toString());

    return MeasureSize(
      getInitialSize: true,
      onChange: (size) => childSize = size,
      child: SizedScaleTransition(
        childWidth: childSize.width,
        childHeight: childSize.height,
        scale: _scaleAnimation ?? const AlwaysStoppedAnimation(1),
        targetScale: effectiveScaleEffectTarget,
        filterQuality: FilterQuality.medium,
        child: widget.child,
      ),
    );
  }
}
