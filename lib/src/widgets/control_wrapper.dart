import 'package:flutter/material.dart';

//import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/touch_target_padding.dart';
import 'package:moon_design/src/widgets/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/effects/pulse_effect.dart';
import 'package:moon_design/src/widgets/effects/scale_effect.dart';

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

  final bool showPulseAnimationJiggle;

  final bool showScaleAnimation;

  final bool semanticTypeIsButton;

  final String? semanticLabel;

  final double minTouchTargetSize;

  final double? disabledOpacityValue;

  final double? focusEffectExtent;

  final double? pulseEffectExtent;

  final double? scaleAnimationLowerBound;

  final Color? focusEffectColor;

  final Color? pulseEffectColor;

  final Duration? focusAnimationDuration;

  final Duration? scaleAnimationDuration;

  final Duration? pulseAnimationDuration;

  final Curve? focusAnimationCurve;

  final Curve? pulseAnimationCurve;

  final Curve? scaleAnimationCurve;

  final MouseCursor cursor;

  final BorderRadius borderRadius;

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
    this.showPulseAnimationJiggle = true,
    this.showScaleAnimation = true,
    this.semanticTypeIsButton = false,
    this.semanticLabel,
    this.minTouchTargetSize = 40.0,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleAnimationLowerBound,
    this.focusEffectColor,
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

class _MoonControlWrapperState extends State<MoonControlWrapper> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;
  FocusNode? _focusNode;

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
      setState(() => _isPressed = false);
    }
  }

  @override
  void dispose() {
    _focusNode!.dispose();

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
    /* final effectiveScaleAnimationDuration = widget.scaleAnimationDuration ??
        context.moonEffects?.controlScaleEffect.effectDuration ??
        MoonControlsEffects.controlScaleEffect.effectDuration; */

    if (_isEnabled) {
      if (mounted) {
        setState(() => _isPressed = true);
      }

      widget.onTap?.call();

      if (mounted) {
        setState(() => _isPressed = false);
      }

      /* if (mounted) {
        Future.delayed(effectiveScaleAnimationDuration, () {
          setState(() => _isPressed = false);
        });
      } */
    }
  }

  void _handleTapUp(_) {
    if (_isPressed && mounted) {
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
      setState(() => _isPressed = true);
    }
  }

  void _handleLongPressUp() {
    if (_isPressed && mounted) {
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
    final effectiveDisabledOpacityValue =
        widget.disabledOpacityValue ?? context.moonOpacity?.disabled ?? MoonOpacity.opacities.disabled;

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
            child: TouchTargetPadding(
              minSize: widget.ensureMinimalTouchTargetSize
                  ? Size(widget.minTouchTargetSize, widget.minTouchTargetSize)
                  : Size.zero,
              child: Opacity(
                opacity: _isEnabled ? 1 : effectiveDisabledOpacityValue,
                child: MoonScaleEffect(
                  show: _canAnimateScale && _isPressed,
                  effectExtent: widget.scaleAnimationLowerBound,
                  effectCurve: widget.scaleAnimationCurve,
                  effectDuration: widget.scaleAnimationDuration,
                  child: MoonPulseEffect(
                    show: _canAnimatePulse,
                    showJiggle: widget.showPulseAnimationJiggle,
                    effectColor: widget.pulseEffectColor,
                    effectExtent: widget.pulseEffectExtent,
                    effectCurve: widget.pulseAnimationCurve,
                    effectDuration: widget.pulseAnimationDuration,
                    childBorderRadius: widget.borderRadius,
                    child: MoonFocusEffect(
                      show: _canAnimateFocus,
                      effectColor: widget.focusEffectColor,
                      effectExtent: widget.focusEffectExtent,
                      effectCurve: widget.focusAnimationCurve,
                      effectDuration: widget.focusAnimationDuration,
                      childBorderRadius: widget.borderRadius,
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
