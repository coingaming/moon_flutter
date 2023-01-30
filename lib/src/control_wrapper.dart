import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
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

  final bool autofocus;

  final bool isFocusable;

  final bool ensureMinimalTouchTargetSize;

  final bool showFocusAnimation;

  final bool showPulseAnimation;

  final bool showScaleAnimation;

  final bool semanticTypeIsButton;

  final String? semanticLabel;

  final double minTouchTargetSize;

  final double? disabledOpacityValue;

  final double? focusBorderWidth;

  final double? pulseEffectWidth;

  final double? scaleAnimationLowerBound;

  final Color? focusBorderColor;

  final Color? pulseEffectColor;

  final Duration? focusAnimationDuration;

  final Duration? scaleAnimationDuration;

  final Duration? pulseAnimationDuration;

  final Curve? focusAnimationCurve;

  final Curve? pulseAnimationCurve;

  final Curve? scaleAnimationCurve;

  final MouseCursor cursor;

  final BorderRadiusGeometry borderRadius;

  final MoonControlWrapperBuilder builder;

  const MoonControlWrapper({
    super.key,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.showFocusAnimation = true,
    this.showPulseAnimation = false,
    this.showScaleAnimation = true,
    this.semanticTypeIsButton = false,
    this.semanticLabel,
    this.minTouchTargetSize = 40.0,
    this.disabledOpacityValue,
    this.focusBorderWidth,
    this.pulseEffectWidth,
    this.scaleAnimationLowerBound,
    this.focusBorderColor,
    this.pulseEffectColor,
    this.focusAnimationDuration,
    this.pulseAnimationDuration,
    this.scaleAnimationDuration,
    this.focusAnimationCurve,
    this.pulseAnimationCurve,
    this.scaleAnimationCurve,
    this.cursor = MouseCursor.defer,
    required this.borderRadius,
    required this.builder,
  });

  @override
  State<MoonControlWrapper> createState() => _MoonControlWrapperState();
}

class _MoonControlWrapperState extends State<MoonControlWrapper> with TickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;
  FocusNode? _focusNode;

  AnimationController? _scaleAnimationController;
  AnimationController? _pulseAnimationController;
  CurvedAnimation? _scaleAnimation;
  CurvedAnimation? _pulseAnimation;
  late Map<Type, Action<Intent>> _actions;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;
  bool get _canAnimateScale => widget.showScaleAnimation && _isEnabled;
  bool get _canAnimatePulse => widget.showPulseAnimation && _isEnabled;
  bool get _canAnimateFocus => widget.showFocusAnimation && _isEnabled && (_isFocused || _isPressed);
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());
  MouseCursor get _cursor => _isEnabled ? widget.cursor : SystemMouseCursors.forbidden;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          _scaleAnimationController = AnimationController(
            vsync: this,
            duration: widget.scaleAnimationDuration ??
                context.moonEffects?.controlScaleEffect.effectDuration ??
                MoonControlsEffects.controlScaleEffect.effectDuration,
            debugLabel: "MoonControlWrapper scale animation controller",
          );

          _scaleAnimation = CurvedAnimation(
            parent: _scaleAnimationController!,
            curve: widget.scaleAnimationCurve ??
                context.moonEffects?.controlScaleEffect.effectCurve ??
                MoonControlsEffects.controlScaleEffect.effectCurve,
          );

          _pulseAnimationController = AnimationController(
            vsync: this,
            duration: widget.pulseAnimationDuration ??
                context.moonEffects?.controlPulseEffect.effectDuration ??
                MoonControlsEffects.controlPulseEffect.effectDuration,
            debugLabel: "MoonControlWrapper pulse animation controller",
          )..repeat();

          _pulseAnimation = CurvedAnimation(
            parent: _pulseAnimationController!,
            curve: widget.pulseAnimationCurve ??
                context.moonEffects?.controlPulseEffect.effectCurve ??
                MoonControlsEffects.controlPulseEffect.effectCurve,
          );

          setState(() {});
        }
      },
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

    if (_isPressed && mounted && _scaleAnimationController != null) {
      if (widget.showScaleAnimation) {
        _scaleAnimationController?.forward();
      }
      setState(() => _isPressed = false);
    }
  }

  @override
  void dispose() {
    _focusNode!.dispose();

    if (widget.showScaleAnimation && _scaleAnimationController != null) {
      _pulseAnimationController?.dispose();
    }

    if (widget.showPulseAnimation && _pulseAnimationController != null) {
      _pulseAnimationController?.dispose();
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

      if (widget.showScaleAnimation && _scaleAnimationController != null) {
        _scaleAnimationController?.forward().then((_) {
          if (mounted) {
            _scaleAnimationController?.reverse();
          }
        });
      }

      if (mounted) {
        setState(() => _isPressed = false);
      }
    }
  }

  void _handleTapUp(_) {
    if (_isPressed && mounted && _scaleAnimationController != null) {
      if (widget.showScaleAnimation) {
        _scaleAnimationController?.reverse();
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
    if (!_isPressed && mounted && _scaleAnimationController != null) {
      if (widget.showScaleAnimation) {
        _scaleAnimationController?.forward();
      }
      setState(() => _isPressed = true);
    }
  }

  void _handleLongPressUp() {
    if (_isPressed && mounted && _scaleAnimationController != null) {
      if (widget.showScaleAnimation) {
        _scaleAnimationController?.reverse();
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
    final scaleTween = Tween(
      begin: 1.0,
      end: widget.scaleAnimationLowerBound ??
          context.moonEffects?.controlScaleEffect.effectLowerBound ??
          MoonControlsEffects.controlScaleEffect.effectLowerBound,
    );

    final pulseTween = DecorationTween(
      begin: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: widget.pulseEffectColor ??
                context.moonEffects?.controlPulseEffect.effectColor ??
                MoonControlsEffects.controlPulseEffect.effectColor!,
          ),
        ],
      ),
      end: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: widget.pulseEffectColor?.withOpacity(0) ??
                context.moonEffects?.controlPulseEffect.effectColor?.withOpacity(0) ??
                MoonControlsEffects.controlPulseEffect.effectColor!.withOpacity(0),
            spreadRadius: widget.pulseEffectWidth ??
                context.moonEffects?.controlPulseEffect.effectWidth ??
                MoonControlsEffects.controlPulseEffect.effectWidth!,
          ),
        ],
      ),
    );

    final scaleAnimation = _scaleAnimation != null ? scaleTween.animate(_scaleAnimation!) : null;
    final pulseAnimation = _pulseAnimation != null ? pulseTween.animate(_pulseAnimation!) : null;

    final effectiveDisabledOpacityValue =
        widget.disabledOpacityValue ?? context.moonOpacity?.disabled ?? MoonOpacity.opacities.disabled;

    final effectiveFocusBorderColor = widget.focusBorderColor ??
        context.moonEffects?.controlFocusEffect.effectColor ??
        MoonControlsEffects.controlFocusEffect.effectColor!;

    final effectiveFocusBorderWidth = widget.focusBorderWidth ??
        context.moonEffects?.controlFocusEffect.effectWidth ??
        MoonControlsEffects.controlFocusEffect.effectWidth!;

    final effectiveFocusAnimationDuration = widget.focusAnimationDuration ??
        context.moonEffects?.controlFocusEffect.effectDuration ??
        MoonControlsEffects.controlFocusEffect.effectDuration;

    final effectiveFocusAnimationCurve = widget.focusAnimationCurve ??
        context.moonEffects?.controlFocusEffect.effectCurve ??
        MoonControlsEffects.controlFocusEffect.effectCurve;

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
                scale: _canAnimateScale && scaleAnimation != null ? scaleAnimation : const AlwaysStoppedAnimation(1.0),
                child: Opacity(
                  opacity: _isEnabled ? 1 : effectiveDisabledOpacityValue,
                  child: DecoratedBoxTransition(
                    decoration: _canAnimatePulse && pulseAnimation != null
                        ? pulseAnimation
                        : const AlwaysStoppedAnimation(BoxDecoration()),
                    child: AnimatedContainer(
                      duration: effectiveFocusAnimationDuration,
                      curve: effectiveFocusAnimationCurve,
                      decoration: BoxDecoration(
                        borderRadius: widget.borderRadius,
                        boxShadow: [
                          BoxShadow(
                            color: _canAnimateFocus ? effectiveFocusBorderColor : Colors.transparent,
                            spreadRadius: effectiveFocusBorderWidth,
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
