import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedIconTheme extends StatefulWidget {
  final Color color;
  final double? size;
  final Curve curve;
  final Duration duration;
  final Widget child;

  const AnimatedIconTheme({
    super.key,
    required this.color,
    this.size,
    required this.curve,
    required this.duration,
    required this.child,
  });

  @override
  State<AnimatedIconTheme> createState() => _AnimatedIconThemeState();
}

class _AnimatedIconThemeState extends State<AnimatedIconTheme> with SingleTickerProviderStateMixin {
  Color _initialColor = Colors.transparent;
  Color _targetColor = Colors.transparent;

  AnimationController get controller => _controller;
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    debugLabel: kDebugMode ? widget.toStringShort() : null,
    vsync: this,
  );

  Animation<double> get animation => _animation;
  late CurvedAnimation _animation = _createCurve();

  CurvedAnimation _createCurve() {
    return CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void initState() {
    super.initState();
    _initialColor = widget.color;
  }

  @override
  void didUpdateWidget(AnimatedIconTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) {
      _animation.dispose();
      _animation = _createCurve();
    }

    _controller.duration = widget.duration;

    if (widget.color != oldWidget.color) {
      _targetColor = widget.color;
      _initialColor = oldWidget.color;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => IconTheme(
          data: IconThemeData.lerp(
            IconThemeData(color: _initialColor, size: widget.size),
            IconThemeData(color: _targetColor, size: widget.size),
            _animation.value,
          ),
          child: child!,
        ),
        child: widget.child,
      ),
    );
  }
}
