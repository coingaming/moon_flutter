import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

import 'package:moon_design/moon_design.dart';

class BorderContainer extends StatefulWidget {
  final bool expands;
  final Clip clipBehavior;
  final Color? backgroundColor;
  final Decoration? decoration;
  final double? height;
  final double? width;
  final ShapeBorder border;
  final Duration duration;
  final Curve curve;
  final Widget child;

  /// Creates a utility widget for animating the border of a container.
  /// Primarily utilized in [MoonTextInput] and [MoonTextInputGroup].
  const BorderContainer({
    super.key,
    this.expands = false,
    this.clipBehavior = Clip.none,
    this.backgroundColor,
    this.decoration,
    this.height,
    this.width,
    required this.border,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  _BorderContainerState createState() => _BorderContainerState();
}

class _BorderContainerState extends State<BorderContainer>
    with SingleTickerProviderStateMixin {
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
          constraints: BoxConstraints(
            minHeight: widget.height ?? 0,
            minWidth: widget.width ?? 0,
            maxHeight: widget.expands
                ? double.infinity
                : widget.height ?? double.infinity,
            maxWidth: widget.expands
                ? double.infinity
                : widget.width ?? double.infinity,
          ),
          clipBehavior: widget.clipBehavior,
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
