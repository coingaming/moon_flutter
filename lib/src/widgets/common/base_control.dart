import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/touch_target_padding.dart';
import 'package:moon_design/src/widgets/common/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/common/effects/pulse_effect.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

typedef MoonBaseControlBuilder = Widget Function(
  BuildContext context,
  bool isEnabled,
  bool isHovered,
  bool isFocused,
  bool isPressed,
);

class MoonBaseControl extends StatefulWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether this control should be focusable.
  final bool isFocusable;

  /// Whether this control should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether the semantic type of this control is button.
  final bool semanticTypeIsButton;

  /// Whether this control should show a focus effect.
  final bool showFocusEffect;

  /// Whether this control should show a pulse effect.
  final bool showPulseEffect;

  /// Whether this control should jiggle when the pulse effect is shown.
  final bool showPulseEffectJiggle;

  /// Whether this control should show a scale animation.
  final bool showScaleAnimation;

  /// Whether this control should show a tooltip.
  final bool showTooltip;

  /// The border radius of the control.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the control.
  final Color? backgroundColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the pulse effect.
  final Color? pulseEffectColor;

  /// The opacity of the control when it is disabled.
  final double? disabledOpacityValue;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// The extent of the focus effect.
  final double? focusEffectExtent;

  /// The extent of the pulse effect.
  final double? pulseEffectExtent;

  /// The scalar controlling the scaling of the scale effect.
  final double? scaleEffectScalar;

  /// The duration of the focus effect.
  final Duration? focusEffectDuration;

  /// The duration of the pulse effect.
  final Duration? pulseEffectDuration;

  /// The duration of the scale effect.
  final Duration? scaleEffectDuration;

  /// The curve of the focus effect.
  final Curve? focusEffectCurve;

  /// The curve of the pulse effect.
  final Curve? pulseEffectCurve;

  /// The curve of the scale effect.
  final Curve? scaleEffectCurve;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The builder that builds the child of this control.
  ///
  /// This is excusive with [child]. You cannot use both at the same time.
  final MoonBaseControlBuilder? builder;

  /// The mouse cursor of the control.
  final MouseCursor cursor;

  /// The semantic label for this control.
  final String? semanticLabel;

  /// The tooltip message for this control.
  final String tooltipMessage;

  /// The callback that is called when the control is focused or unfocused.
  final void Function(bool)? onFocus;

  /// The callback that is called when the control is hovered or unhovered.
  final void Function(bool)? onHover;

  /// The callback that is called when the control is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the control is long-pressed.
  final VoidCallback? onLongPress;

  /// The child of this control.
  ///
  /// This is excusive with [builder]. You cannot use both at the same time.
  final Widget? child;

  /// MDS base control widget.
  const MoonBaseControl({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.semanticTypeIsButton = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.showTooltip = false,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor,
    this.focusEffectColor,
    this.pulseEffectColor,
    this.disabledOpacityValue,
    this.minTouchTargetSize = 40.0,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectScalar,
    this.focusEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.pulseEffectCurve,
    this.scaleEffectCurve,
    this.focusNode,
    this.builder,
    this.cursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.onFocus,
    this.onHover,
    this.onTap,
    this.onLongPress,
    this.child,
  }) : assert(
          (child == null) != (builder == null),
          "You must provide either a child or a builder, not both.",
        );

  @override
  State<MoonBaseControl> createState() => _MoonBaseControlState();
}

class _MoonBaseControlState extends State<MoonBaseControl> {
  late Map<Type, Action<Intent>> _actions;

  FocusNode? _focusNode;

  bool _isFocused = false;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isLongPressed = false;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;

  bool get _canShowTooltip => widget.showTooltip && _isEnabled && (_isFocused || _isHovered || _isLongPressed);

  bool get _canAnimateFocus => widget.showFocusEffect && _isEnabled && _isFocused;

  bool get _canAnimatePulse => widget.showPulseEffect && _isEnabled;

  bool get _canAnimateScale => widget.showScaleAnimation && _isEnabled && (_isPressed || _isLongPressed);

  MouseCursor get _cursor => _isEnabled ? widget.cursor : SystemMouseCursors.basic;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  void _handleHover(bool hover) {
    if (hover != _isHovered) {
      setState(() => _isHovered = hover);

      widget.onHover?.call(hover);
    }
  }

  void _handleFocus(bool focus) {
    if (focus != _isFocused) {
      setState(() => _isFocused = focus);

      widget.onFocus?.call(focus);
    }
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;

      if (!hasFocus) {
        _isPressed = false;
      }
    });
  }

  void _handleTap() {
    if (_isEnabled) {
      setState(() => _isPressed = true);

      widget.onTap?.call();

      setState(() => _isPressed = false);
    }
  }

  void _handleTapDown(_) {
    if (!_isPressed) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(_) {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleLongPress() {
    if (widget.onLongPress == null) return;

    if (_isEnabled) {
      widget.onLongPress?.call();
    }
  }

  void _handleLongPressStart(_) {
    if (!_isLongPressed) {
      setState(() => _isLongPressed = true);
    }

    if (!_isPressed) {
      setState(() => _isPressed = true);
    }
  }

  void _handleLongPressUp() {
    if (widget.onLongPress == null) {
      widget.onTap?.call();
    }

    if (_isLongPressed) {
      setState(() => _isLongPressed = false);
    }

    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleHorizontalDragStart(DragStartDetails dragStartDetails) => _handleTapDown(null);

  void _handleHorizontalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  void _handleVerticalDragStart(DragStartDetails dragStartDetails) => _handleTapDown(null);

  void _handleVerticalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  Color _getFocusColor({required Color focusColor}) {
    if (widget.backgroundColor != null) {
      return context.isDarkMode ? widget.backgroundColor!.withOpacity(0.8) : widget.backgroundColor!.withOpacity(0.2);
    } else {
      return focusColor;
    }
  }

  @override
  void initState() {
    super.initState();

    _actions = <Type, Action<Intent>>{ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap())};

    _focusNode = FocusNode(canRequestFocus: _isEnabled);
    _effectiveFocusNode.canRequestFocus = _isEnabled;

    if (widget.autofocus) {
      _effectiveFocusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(MoonBaseControl oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.onTap != oldWidget.onTap || widget.onLongPress != oldWidget.onLongPress) {
      if (!_isEnabled) {
        _isHovered = _isPressed = false;
      }
    }

    _effectiveFocusNode.canRequestFocus = _isEnabled;
  }

  @override
  void dispose() {
    _focusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double effectiveDisabledOpacityValue =
        widget.disabledOpacityValue ?? context.moonOpacities?.disabled ?? MoonOpacities.opacities.disabled;

    // Focus effect props
    final Color effectiveFocusEffectColor = widget.focusEffectColor ??
        context.moonEffects?.controlFocusEffect.effectColor ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlFocusEffect.effectColor;

    final Color focusColor = _getFocusColor(focusColor: effectiveFocusEffectColor);

    final double effectiveFocusEffectExtent = widget.focusEffectExtent ??
        context.moonEffects?.controlFocusEffect.effectExtent ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlFocusEffect.effectExtent;

    final Duration effectiveFocusEffectDuration = widget.focusEffectDuration ??
        context.moonEffects?.controlFocusEffect.effectDuration ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlFocusEffect.effectDuration;

    final Curve effectiveFocusEffectCurve = widget.focusEffectCurve ??
        context.moonEffects?.controlFocusEffect.effectCurve ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlFocusEffect.effectCurve;

    // Pulse effect props
    final Color effectivePulseEffectColor = widget.pulseEffectColor ??
        context.moonEffects?.controlPulseEffect.effectColor ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlPulseEffect.effectColor!;

    final double effectivePulseEffectExtent = widget.pulseEffectExtent ??
        context.moonEffects?.controlPulseEffect.effectExtent ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlPulseEffect.effectExtent!;

    final Duration effectivePulseEffectDuration = widget.pulseEffectDuration ??
        context.moonEffects?.controlPulseEffect.effectDuration ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlPulseEffect.effectDuration;

    final Curve effectivePulseEffectCurve = widget.pulseEffectCurve ??
        context.moonEffects?.controlPulseEffect.effectCurve ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlPulseEffect.effectCurve;

    // Scale effect props
    final double effectiveScaleEffectScalar = widget.scaleEffectScalar ??
        context.moonEffects?.controlScaleEffect.effectScalar ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlScaleEffect.effectScalar!;

    final Duration effectiveScaleEffectDuration = widget.scaleEffectDuration ??
        context.moonEffects?.controlScaleEffect.effectDuration ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlScaleEffect.effectDuration;

    final Curve effectiveScaleEffectCurve = widget.scaleEffectCurve ??
        context.moonEffects?.controlScaleEffect.effectCurve ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlScaleEffect.effectCurve;

    final Widget child = widget.child ??
        widget.builder!(
          context,
          _isEnabled,
          _isHovered,
          _isFocused,
          _isPressed,
        );

    return MoonTooltip(
      show: _canShowTooltip,
      content: Text(widget.tooltipMessage),
      child: MergeSemantics(
        child: Semantics(
          label: widget.semanticLabel,
          button: widget.semanticTypeIsButton,
          enabled: _isEnabled,
          focusable: _isEnabled,
          focused: _isFocused,
          child: FocusableActionDetector(
            enabled: _isEnabled && widget.isFocusable,
            actions: _actions,
            mouseCursor: _cursor,
            focusNode: _effectiveFocusNode,
            autofocus: _isEnabled && widget.autofocus,
            onFocusChange: _handleFocusChange,
            onShowFocusHighlight: _handleFocus,
            onShowHoverHighlight: _handleHover,
            child: GestureDetector(
              excludeFromSemantics: true,
              behavior: HitTestBehavior.opaque,
              onTap: _handleTap,
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onLongPress: _handleLongPress,
              onLongPressStart: _handleLongPressStart,
              onLongPressUp: _handleLongPressUp,
              onTapCancel: _handleTapCancel,
              onHorizontalDragStart: _handleHorizontalDragStart,
              onHorizontalDragEnd: _handleHorizontalDragEnd,
              onVerticalDragStart: _handleVerticalDragStart,
              onVerticalDragEnd: _handleVerticalDragEnd,
              child: TouchTargetPadding(
                minSize: widget.ensureMinimalTouchTargetSize
                    ? Size(widget.minTouchTargetSize, widget.minTouchTargetSize)
                    : Size.zero,
                child: RepaintBoundary(
                  child: AnimatedScale(
                    scale: _canAnimateScale ? effectiveScaleEffectScalar : 1,
                    duration: effectiveScaleEffectDuration,
                    curve: effectiveScaleEffectCurve,
                    child: MoonPulseEffect(
                      show: _canAnimatePulse,
                      showJiggle: widget.showPulseEffectJiggle,
                      childBorderRadius: widget.borderRadius,
                      effectColor: effectivePulseEffectColor,
                      effectExtent: effectivePulseEffectExtent,
                      effectCurve: effectivePulseEffectCurve,
                      effectDuration: effectivePulseEffectDuration,
                      child: AnimatedOpacity(
                        opacity: _isEnabled ? 1 : effectiveDisabledOpacityValue,
                        duration: context.moonTransitions?.defaultTransitionDuration ??
                            MoonTransitions.transitions.defaultTransitionDuration,
                        curve: context.moonTransitions?.defaultTransitionCurve ??
                            MoonTransitions.transitions.defaultTransitionCurve,
                        child: MoonFocusEffect(
                          show: _canAnimateFocus,
                          effectColor: focusColor,
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
        ),
      ),
    );
  }
}
