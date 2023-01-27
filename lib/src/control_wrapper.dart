import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:moon_design/src/theme/theme.dart';

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

  final bool showScaleAnimation;

  final bool showFocusAnimation;

  final bool ensureMinimalTouchTargetSize;

  final bool semanticTypeIsButton;

  final String? semanticLabel;

  final double minTouchTargetSize;

  final double? scaleAnimationLowerBound;

  final double? focusBorderWidth;

  final double? disabledOpacityValue;

  final Color? focusBorderColor;

  final Duration? scaleAnimationDuration;

  final Duration? focusAnimationDuration;

  final Curve? focusAnimationCurve;

  final Curve? scaleAnimationCurve;

  final MouseCursor cursor;

  final MoonControlWrapperBuilder builder;

  const MoonControlWrapper({
    super.key,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.isFocusable = true,
    this.autofocus = false,
    this.showScaleAnimation = true,
    this.showFocusAnimation = true,
    this.ensureMinimalTouchTargetSize = false,
    this.semanticTypeIsButton = false,
    this.semanticLabel,
    this.minTouchTargetSize = 40.0,
    this.scaleAnimationLowerBound,
    this.focusBorderWidth,
    this.disabledOpacityValue,
    this.focusBorderColor,
    this.scaleAnimationCurve,
    this.scaleAnimationDuration,
    this.focusAnimationCurve,
    this.focusAnimationDuration,
    this.cursor = MouseCursor.defer,
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
  late Map<Type, Action<Intent>> _actions;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;
  bool get _canAnimateScale => widget.showScaleAnimation && _isEnabled;
  bool get _canAnimateFocus => widget.showFocusAnimation && _isEnabled && _isFocused || _isPressed;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());
  MouseCursor get _cursor => _isEnabled ? widget.cursor : SystemMouseCursors.forbidden;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.scaleAnimationDuration ??
          context.moonTransitions?.controlScaleEffect.transitionDuration ??
          const Duration(milliseconds: 150),
      debugLabel: "MoonControlWrapper",
    );

    _focusNode = FocusNode(canRequestFocus: _isEnabled);
    _effectiveFocusNode.canRequestFocus = _isEnabled;
    _actions = <Type, Action<Intent>>{ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap())};

    if (widget.autofocus) {
      _effectiveFocusNode.requestFocus();
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

    _effectiveFocusNode.canRequestFocus = _isEnabled;

    if (_isPressed && mounted) {
      if (widget.showScaleAnimation) {
        _controller.forward();
      }
      setState(() => _isPressed = false);
    }
  }

  @override
  void dispose() {
    _focusNode!.dispose();

    if (widget.showScaleAnimation) {
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

      if (widget.showScaleAnimation) {
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
      if (widget.showScaleAnimation) {
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
      if (widget.showScaleAnimation) {
        _controller.forward();
      }
      setState(() => _isPressed = true);
    }
  }

  void _handleLongPressUp() {
    if (_isPressed && mounted) {
      if (widget.showScaleAnimation) {
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
    final focusBorderColor = widget.focusBorderColor ?? context.moonTheme?.colors.jiren ?? Colors.purple;
    final focusBorderWidth = widget.focusBorderWidth ?? context.moonTheme?.borders.borderFocus ?? 2.0;
    final disabledOpacityValue = widget.disabledOpacityValue ?? context.moonTheme?.opacity.disabled ?? 0.5;

    final scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.scaleAnimationCurve ??
          context.moonTheme?.transitions.controlScaleEffect.transitionCurve ??
          Curves.easeInOut,
    );

    final scaleTween = Tween(
      begin: 1.0,
      end: widget.scaleAnimationLowerBound ??
          context.moonTheme?.transitions.controlScaleEffect.transitionLowerBound ??
          0.9,
    );

    final focusAnimationDuration = widget.focusAnimationDuration ??
        context.moonTheme?.transitions.controlFocusEffect.transitionDuration ??
        const Duration(milliseconds: 150);

    final focusAnimationCurve = widget.focusAnimationCurve ??
        context.moonTheme?.transitions.controlFocusEffect.transitionCurve ??
        Curves.easeInOut;

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
        button: widget.semanticTypeIsButton,
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
            focusNode: _effectiveFocusNode,
            autofocus: _isEnabled && widget.autofocus,
            mouseCursor: _cursor,
            onShowHoverHighlight: _handleHover,
            onShowFocusHighlight: _handleFocus,
            onFocusChange: _handleFocusChange,
            actions: _actions,
            child: _InputPadding(
              minSize: widget.ensureMinimalTouchTargetSize
                  ? Size(widget.minTouchTargetSize, widget.minTouchTargetSize)
                  : Size.zero,
              child: ScaleTransition(
                scale: _canAnimateScale ? scaleTween.animate(scaleAnimation) : const AlwaysStoppedAnimation(1.0),
                child: Opacity(
                  opacity: _isEnabled ? 1 : disabledOpacityValue,
                  child: AnimatedContainer(
                    duration: focusAnimationDuration,
                    curve: focusAnimationCurve,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: _canAnimateFocus ? focusBorderColor : Colors.transparent,
                          spreadRadius: focusBorderWidth,
                        )
                      ],
                    ),
                    child: child,
                  ),
                ),
              ),
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
