import 'package:flutter/widgets.dart';

import 'package:moon_design/src/widgets/common/progress_indicators/base_progress.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/painters/linear_progress_indicator_painter.dart';

class MoonLinearProgressIndicator extends MoonBaseProgressIndicator {
  /// The minimum height of the linear progress indicator.
  final double minHeight;

  /// The border radius of the linear progress indicator.
  final BorderRadius borderRadius;

  /// Creates a linear progress indicator.
  const MoonLinearProgressIndicator({
    super.key,
    super.value,
    required super.backgroundColor,
    required super.color,
    super.valueColor,
    this.minHeight = 4,
    this.borderRadius = BorderRadius.zero,
    super.semanticsLabel,
    super.semanticsValue,
  }) : assert(minHeight > 0);

  /// Color of the track being filled by the linear indicator.
  @override
  Color get backgroundColor => super.backgroundColor;

  @override
  State<MoonLinearProgressIndicator> createState() => _MoonLinearProgressIndicatorState();
}

class _MoonLinearProgressIndicatorState extends State<MoonLinearProgressIndicator> with SingleTickerProviderStateMixin {
  static const int _kIndeterminateLinearDuration = 1800;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(MoonLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildStaticProgressIndicator(BuildContext context, double animationValue, TextDirection textDirection) {
    return widget.buildSemanticsWrapper(
      context: context,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: widget.minHeight,
        ),
        child: CustomPaint(
          painter: MoonLinearProgressIndicatorPainter(
            backgroundColor: widget.backgroundColor,
            valueColor: widget.color,
            value: widget.value, // may be null
            animationValue: animationValue, // ignored if widget.value is not null
            borderRadius: widget.borderRadius,
            textDirection: textDirection,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);

    if (widget.value != null) {
      return buildStaticProgressIndicator(context, _controller.value, textDirection);
    }

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return buildStaticProgressIndicator(context, _controller.value, textDirection);
      },
    );
  }
}
