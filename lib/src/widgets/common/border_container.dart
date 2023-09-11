import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

/// Used to animate the border of a container. Mainly used in [MoonTextInput] and [MoonTextInputGroup]
class BorderContainer extends StatefulWidget {
  final Color backgroundColor;
  final Decoration? decoration;
  final double? height;
  final ShapeBorder border;
  final Duration duration;
  final Curve curve;
  final Widget child;

  /// Utility widget used to animate the border of a container.
  const BorderContainer({
    required this.backgroundColor,
    this.decoration,
    required this.height,
    required this.border,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  _BorderContainerState createState() => _BorderContainerState();
}

class _BorderContainerState extends State<BorderContainer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _borderAnimation;
  late ShapeBorderTween _border;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _borderAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.curve.flipped,
    );
    _border = ShapeBorderTween(
      begin: widget.border,
      end: widget.border,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(BorderContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.border != oldWidget.border) {
      _border = ShapeBorderTween(
        begin: oldWidget.border,
        end: widget.border,
      );
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderAnimation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          decoration: widget.decoration ??
              ShapeDecorationWithPremultipliedAlpha(
                color: widget.backgroundColor,
                shape: _border.evaluate(_borderAnimation)!,
              ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
