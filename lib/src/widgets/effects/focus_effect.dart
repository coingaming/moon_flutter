import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/effects/painters/focus_effect_painter.dart';

class MoonFocusEffect extends StatefulWidget {
  final bool show;
  final double? effectExtent;
  final Color? effectColor;
  final Curve? effectCurve;
  final Duration? effectDuration;
  final BorderRadius childBorderRadius;
  final Widget child;

  const MoonFocusEffect({
    super.key,
    this.show = true,
    this.effectExtent,
    this.effectColor,
    this.effectCurve,
    this.effectDuration,
    required this.childBorderRadius,
    required this.child,
  });

  @override
  State<MoonFocusEffect> createState() => _MoonFocusEffectState();
}

class _MoonFocusEffectState extends State<MoonFocusEffect> with SingleTickerProviderStateMixin {
  AnimationController? _focusAnimationController;
  CurvedAnimation? _focusAnimation;

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

    if (mounted && _focusAnimationController == null) {
      final effectiveFocusEffectDuration = widget.effectDuration ??
          context.moonEffects?.controlFocusEffect.effectDuration ??
          MoonFocusEffects.lightFocusEffect.effectDuration;

      final effectiveFocusEffectCurve = widget.effectCurve ??
          context.moonEffects?.controlFocusEffect.effectCurve ??
          MoonFocusEffects.lightFocusEffect.effectCurve;

      _focusAnimationController = AnimationController(
        vsync: this,
        duration: effectiveFocusEffectDuration,
        debugLabel: "MoonFocusEffect animation controller",
      );

      _focusAnimation = CurvedAnimation(
        parent: _focusAnimationController!,
        curve: effectiveFocusEffectCurve,
      );
    }
  }

  @override
  void didUpdateWidget(MoonFocusEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (mounted) {
      if (widget.show) {
        _focusAnimationController?.forward();
      } else {
        _focusAnimationController?.reverse();
      }
    }
  }

  @override
  void dispose() {
    if (_focusAnimationController != null) {
      _focusAnimationController?.dispose();
      _focusAnimationController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulseEffectEndBorderRadius = maxBorderRadius();

    final effectiveFocusEffectColor = widget.effectColor ??
        context.moonEffects?.controlFocusEffect.effectColor ??
        MoonFocusEffects.lightFocusEffect.effectColor;

    final effectiveFocusEffectExtent = widget.effectExtent ??
        context.moonEffects?.controlFocusEffect.effectExtent ??
        MoonFocusEffects.darkFocusEffect.effectExtent;

    return CustomPaint(
      isComplex: true,
      willChange: true,
      painter: FocusEffectPainter(
        color: effectiveFocusEffectColor,
        effectExtent: effectiveFocusEffectExtent,
        borderRadiusValue: pulseEffectEndBorderRadius,
        animation: _focusAnimation ?? const AlwaysStoppedAnimation(0),
      ),
      child: widget.child,
    );
  }
}
