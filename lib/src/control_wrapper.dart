import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef MoonControlWrapperBuilder = Widget Function(
  BuildContext context,
  bool isEnabled,
  bool isHovered,
  bool isFocused,
  bool isPressed,
);

class MoonControlWrapper extends StatefulWidget {
  final VoidCallback? onTap;

  final VoidCallback? onLongPress;

  final FocusNode? focusNode;

  final bool isFocusable;

  final bool autofocus;

  final bool showAnimation;

  final bool ensureMinimalTouchTargetSize;

  final double minTouchTargetSize;

  final double scaleAnimationLowerBound;

  final Duration animationDuration;

  final Duration reverseAnimationDuration;

  final Curve animationCurve;

  final Curve reverseAnimationCurve;

  final MouseCursor cursor;

  final String? semanticLabel;

  final MoonControlWrapperBuilder builder;

  const MoonControlWrapper({
    super.key,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.isFocusable = true,
    this.autofocus = false,
    this.showAnimation = true,
    this.ensureMinimalTouchTargetSize = false,
    this.minTouchTargetSize = 48.0,
    this.scaleAnimationLowerBound = 0.8,
    this.animationCurve = Curves.easeOut,
    this.reverseAnimationCurve = Curves.easeIn,
    this.animationDuration = const Duration(milliseconds: 300),
    this.reverseAnimationDuration = const Duration(milliseconds: 200),
    this.cursor = MouseCursor.defer,
    this.semanticLabel,
    required this.builder,
  });

  @override
  State<MoonControlWrapper> createState() => _MoonControlWrapperState();
}

class _MoonControlWrapperState extends State<MoonControlWrapper> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;
  FocusNode? _focusNode;

  late AnimationController _controller;
  late Animation<double> _animation;
  late Curve _reverseAnimationCurve;
  late Tween<double> _scaleTween;
  late Map<Type, Action<Intent>> _actions;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;
  bool get _canAnimate => widget.showAnimation && _isEnabled;
  FocusNode get _currentFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();

    _reverseAnimationCurve = widget.reverseAnimationCurve;
    _scaleTween = Tween(begin: 1.0, end: widget.scaleAnimationLowerBound);

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.reverseAnimationDuration,
      debugLabel: 'MoonControlWrapper',
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
      reverseCurve: _reverseAnimationCurve,
    );
    _focusNode = FocusNode(canRequestFocus: _isEnabled);
    _currentFocusNode.canRequestFocus = _isEnabled;
    _actions = <Type, Action<Intent>>{ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap())};

    if (widget.autofocus) {
      _currentFocusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(MoonControlWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.onTap != oldWidget.onTap || widget.onLongPress != oldWidget.onLongPress) {
      if (!_isEnabled) {
        _isHovered = _isPressed = false;
      }
    }

    _currentFocusNode.canRequestFocus = _isEnabled;

    if (_isPressed && mounted) {
      if (widget.showAnimation) {
        _controller.forward();
      }
      setState(() => _isPressed = false);
    }
  }

  @override
  void dispose() {
    _focusNode!.dispose();

    if (widget.showAnimation) {
      _controller.dispose();
    }

    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;

      if (!hasFocus) {
        _isPressed = false;
      }
    });
  }

  Future<void> _handleTap() async {
    if (_isEnabled) {
      if (mounted) {
        setState(() => _isPressed = true);
      }

      widget.onTap?.call();

      if (widget.showAnimation) {
        _controller.forward().then((_) {
          if (mounted) {
            _controller.reverse();
          }
        });
      }

      if (mounted) {
        setState(() => _isPressed = false);
      }
    }
  }

  void _handleTapUp(_) {
    if (_isPressed && mounted) {
      if (widget.showAnimation) {
        _controller.reverse();
      }
      setState(() => _isPressed = false);
    }
  }

  void _handleLongPress() {
    if (_isEnabled) {
      widget.onLongPress?.call();
    }
  }

  void _handleLongPressDown(_) {
    if (!_isPressed && mounted) {
      if (widget.showAnimation) {
        _controller.forward();
      }
      setState(() => _isPressed = true);
    }
  }

  void _handleLongPressUp() {
    if (_isPressed && mounted) {
      if (widget.showAnimation) {
        _controller.reverse();
      }
      setState(() => _isPressed = false);
    }
  }

  void _handleHover(bool hover) {
    if (hover != _isHovered && mounted) {
      setState(() => _isHovered = hover);
    }
  }

  void _handleFocus(bool focus) {
    if (focus != _isFocused && mounted) {
      setState(() => _isFocused = focus);
    }
  }

  void _handleHorizontalDragStart(DragStartDetails dragStartDetails) => _handleLongPressDown(null);

  void _handleHorizontalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  void _handleVerticalDragStart(DragStartDetails dragStartDetails) => _handleLongPressDown(null);

  void _handleVerticalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  @override
  Widget build(BuildContext context) {
    final Widget child = widget.builder(
      context,
      _isEnabled,
      _isHovered,
      _isFocused,
      _isPressed,
    );

    return MergeSemantics(
      child: Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: _isEnabled,
        focusable: _isEnabled,
        focused: _isFocused,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleTap,
          onLongPress: _handleLongPress,
          onLongPressDown: _handleLongPressDown,
          onLongPressUp: _handleLongPressUp,
          onHorizontalDragStart: _handleHorizontalDragStart,
          onHorizontalDragEnd: _handleHorizontalDragEnd,
          onVerticalDragStart: _handleVerticalDragStart,
          onVerticalDragEnd: _handleVerticalDragEnd,
          child: FocusableActionDetector(
            enabled: _isEnabled && widget.isFocusable,
            focusNode: _currentFocusNode,
            autofocus: _isEnabled && widget.autofocus,
            mouseCursor: widget.cursor,
            onShowHoverHighlight: _handleHover,
            onShowFocusHighlight: _handleFocus,
            onFocusChange: _handleFocusChange,
            actions: _actions,
            child: _InputPadding(
              minSize: widget.ensureMinimalTouchTargetSize
                  ? Size(widget.minTouchTargetSize, widget.minTouchTargetSize)
                  : Size.zero,
              child: _canAnimate
                  ? ScaleTransition(
                      scale: _scaleTween.animate(_animation),
                      child: child,
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}

class _InputPadding extends SingleChildRenderObjectWidget {
  final Size minSize;

  const _InputPadding({
    super.child,
    required this.minSize,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInputPadding(minSize);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderInputPadding renderObject) {
    renderObject.minSize = minSize;
  }
}

class _RenderInputPadding extends RenderShiftedBox {
  Size _minSize;

  _RenderInputPadding(this._minSize, [RenderBox? child]) : super(child);

  Size get minSize => _minSize;

  set minSize(Size value) {
    if (_minSize == value) {
      return;
    }
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null) {
      return math.max(child!.getMinIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null) {
      return math.max(child!.getMinIntrinsicHeight(width), minSize.height);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null) {
      return math.max(child!.getMaxIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null) {
      return math.max(child!.getMaxIntrinsicHeight(width), minSize.height);
    }
    return 0.0;
  }

  Size _computeSize({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    if (child != null) {
      final Size childSize = layoutChild(child!, constraints);
      final double height = math.max(childSize.width, minSize.width);
      final double width = math.max(childSize.height, minSize.height);
      return constraints.constrain(Size(height, width));
    }
    return Size.zero;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    if (child != null) {
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final Offset center = child!.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (BoxHitTestResult result, Offset position) {
        assert(position == center);
        return child!.hitTest(result, position: center);
      },
    );
  }
}
