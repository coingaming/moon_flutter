import 'package:flutter/material.dart';

class MoonScaleEffect extends StatefulWidget {
  final bool show;
  final bool? reverseScaling;
  final Curve effectCurve;
  final Duration effectDuration;
  final double effectScalar;
  final double? parentWidth;
  final double? parentHeight;
  final Widget child;

  const MoonScaleEffect({
    super.key,
    required this.show,
    this.reverseScaling = false,
    required this.effectCurve,
    required this.effectDuration,
    required this.effectScalar,
    this.parentWidth,
    this.parentHeight,
    required this.child,
  });

  @override
  State<MoonScaleEffect> createState() => _MoonScaleEffectState();
}

class _MoonScaleEffectState extends State<MoonScaleEffect> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.effectDuration,
        debugLabel: "MoonScaleEffect animation controller",
      );

      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: widget.effectScalar,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: widget.effectCurve,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(covariant MoonScaleEffect oldWidget) {
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
    return ScaleTransition(
      scale: _scaleAnimation,
      filterQuality: FilterQuality.medium,
      child: widget.child,
    );
  }
}
