import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
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

  final bool showFocusEffect;

  final bool showPulseEffect;

  final bool showPulseEffectJiggle;

  final bool showScaleAnimation;

  final bool semanticTypeIsButton;

  final String? semanticLabel;

  final double minTouchTargetSize;

  final double? disabledOpacityValue;

  final double? focusEffectExtent;

  final double? pulseEffectExtent;

  final double? scaleEffectScalar;

  final Color? focusEffectColor;

  final Color? pulseEffectColor;

  final Duration? focusEffectDuration;

  final Duration? scaleEffectDuration;

  final Duration? pulseEffectDuration;

  final Curve? focusEffectCurve;

  final Curve? pulseEffectCurve;

  final Curve? scaleEffectCurve;

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
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.semanticTypeIsButton = false,
    this.semanticLabel,
    this.minTouchTargetSize = 40.0,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectScalar,
    this.focusEffectColor,
    this.pulseEffectColor,
    this.focusEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.pulseEffectCurve,
    this.scaleEffectCurve,
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
  bool get _canAnimatePulse => widget.showPulseEffect && _isEnabled;
  bool get _canAnimateFocus => widget.showFocusEffect && _isEnabled && _isFocused;
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

    // Scale effect props
    final effectiveScaleEffectScalar = widget.scaleEffectScalar ??
        context.moonEffects?.controlScaleEffect.effectScalar ??
        MoonControlsEffects.controlScaleEffect.effectScalar!;

    final effectiveScaleEffectDuration = widget.scaleEffectDuration ??
        context.moonEffects?.controlScaleEffect.effectDuration ??
        MoonControlsEffects.controlScaleEffect.effectDuration;

    final effectiveScaleEffectCurve = widget.scaleEffectCurve ??
        context.moonEffects?.controlScaleEffect.effectCurve ??
        MoonControlsEffects.controlScaleEffect.effectCurve;

    // Focus effect props
    final effectiveFocusEffectColor = widget.focusEffectColor ??
        context.moonEffects?.controlFocusEffect.effectColor ??
        MoonFocusEffects.lightFocusEffect.effectColor;

    final effectiveFocusEffectExtent = widget.focusEffectExtent ??
        context.moonEffects?.controlFocusEffect.effectExtent ??
        MoonFocusEffects.darkFocusEffect.effectExtent;

    final effectiveFocusEffectCurve = widget.focusEffectCurve ??
        context.moonEffects?.controlFocusEffect.effectCurve ??
        MoonFocusEffects.lightFocusEffect.effectCurve;

    final effectiveFocusEffectDuration = widget.focusEffectDuration ??
        context.moonEffects?.controlFocusEffect.effectDuration ??
        MoonFocusEffects.lightFocusEffect.effectDuration;

    // Pulse effect props
    final effectivePulseEffectColor = widget.pulseEffectColor ??
        context.moonEffects?.controlPulseEffect.effectColor ??
        MoonControlsEffects.controlPulseEffect.effectColor!;

    final effectivePulseEffectExtent = widget.pulseEffectExtent ??
        context.moonEffects?.controlPulseEffect.effectExtent ??
        MoonControlsEffects.controlPulseEffect.effectExtent!;

    final effectivePulseEffectDuration = widget.pulseEffectDuration ??
        context.moonEffects?.controlPulseEffect.effectDuration ??
        MoonControlsEffects.controlPulseEffect.effectDuration;

    final effectivePulseEffectCurve = widget.pulseEffectCurve ??
        context.moonEffects?.controlPulseEffect.effectCurve ??
        MoonControlsEffects.controlPulseEffect.effectCurve;

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
                  effectCurve: effectiveScaleEffectCurve,
                  effectDuration: effectiveScaleEffectDuration,
                  effectScalar: effectiveScaleEffectScalar,
                  child: MoonPulseEffect(
                    show: _canAnimatePulse,
                    showJiggle: widget.showPulseEffectJiggle,
                    effectColor: effectivePulseEffectColor,
                    effectExtent: effectivePulseEffectExtent,
                    effectCurve: effectivePulseEffectCurve,
                    effectDuration: effectivePulseEffectDuration,
                    childBorderRadius: widget.borderRadius,
                    child: MoonFocusEffect(
                      show: _canAnimateFocus,
                      effectColor: effectiveFocusEffectColor,
                      effectExtent: effectiveFocusEffectExtent,
                      effectCurve: effectiveFocusEffectCurve,
                      effectDuration: effectiveFocusEffectDuration,
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
