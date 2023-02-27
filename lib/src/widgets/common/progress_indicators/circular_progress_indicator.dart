import 'package:flutter/widgets.dart';

import 'package:moon_design/src/widgets/common/progress_indicators/base_progress.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/painters/circular_progress_indicator_painter.dart';

class MoonCircularProgressIndicator extends MoonBaseProgressIndicator {
  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The shape of the line ends used to draw the circle.
  final StrokeCap strokeCap;

  /// Creates a circular progress indicator.
  const MoonCircularProgressIndicator({
    super.key,
    super.value,
    required super.backgroundColor,
    required super.color,
    super.valueColor,
    this.strokeWidth = 4.0,
    this.strokeCap = StrokeCap.round,
    super.semanticsLabel,
    super.semanticsValue,
  });

  /// Color of the circular track being filled by the circular indicator.
  @override
  Color get backgroundColor => super.backgroundColor;

  @override
  State<MoonCircularProgressIndicator> createState() => _MoonCircularProgressIndicatorState();
}

class _MoonCircularProgressIndicatorState extends State<MoonCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  static const double _kMinMoonCircularProgressIndicatorSize = 36.0;
  static const int _kIndeterminateCircularDuration = 1333 * 2222;
  static const int _pathCount = _kIndeterminateCircularDuration ~/ 1333;
  static const int _rotationCount = _kIndeterminateCircularDuration ~/ 2222;

  static final Animatable<double> _strokeHeadTween = CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(curve: const SawTooth(_pathCount)));

  static final Animatable<double> _strokeTailTween = CurveTween(
    curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(curve: const SawTooth(_pathCount)));

  static final Animatable<double> _offsetTween = CurveTween(curve: const SawTooth(_pathCount));
  static final Animatable<double> _rotationTween = CurveTween(curve: const SawTooth(_rotationCount));

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateCircularDuration),
      vsync: this,
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(MoonCircularProgressIndicator oldWidget) {
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

  Widget _buildStaticProgressIndicator(
    BuildContext context,
    double headValue,
    double tailValue,
    double offsetValue,
    double rotationValue,
  ) {
    return widget.buildSemanticsWrapper(
      context: context,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: _kMinMoonCircularProgressIndicatorSize,
          minHeight: _kMinMoonCircularProgressIndicatorSize,
        ),
        child: CustomPaint(
          painter: MoonCircularProgressIndicatorPainter(
            backgroundColor: widget.backgroundColor,
            valueColor: widget.color,
            value: widget.value, // may be null
            headValue: headValue, // remaining arguments are ignored if widget.value is not null
            tailValue: tailValue,
            offsetValue: offsetValue,
            rotationValue: rotationValue,
            strokeWidth: widget.strokeWidth,
            strokeCap: widget.strokeCap,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildStaticProgressIndicator(
          context,
          _strokeHeadTween.evaluate(_controller),
          _strokeTailTween.evaluate(_controller),
          _offsetTween.evaluate(_controller),
          _rotationTween.evaluate(_controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _buildStaticProgressIndicator(context, 0.0, 0.0, 0, 0.0);
    }
    return _buildAnimation();
  }
}
