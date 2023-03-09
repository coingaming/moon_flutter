import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/theme.dart';
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
  /// The callback that is called when the control is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the control is long-pressed.
  final VoidCallback? onLongPress;

  /// The focus node for this control.
  final FocusNode? focusNode;

  /// Whether this control should autofocus when it is first added to the tree.
  final bool autofocus;

  /// Whether this control should be focusable.
  final bool isFocusable;

  /// Whether this control should ensure that it has a minimal touch target size.
  final bool ensureMinimalTouchTargetSize;

  /// Whether this control should show a tooltip.
  final bool showTooltip;

  /// Whether this control should show a focus effect.
  final bool showFocusEffect;

  /// Whether this control should show a pulse effect.
  final bool showPulseEffect;

  /// Whether this control should jiggle when the pulse effect is shown.
  final bool showPulseEffectJiggle;

  /// Whether this control should show a scale animation.
  final bool showScaleAnimation;

  /// Whether the semantic type of this control is button.
  final bool semanticTypeIsButton;

  /// The semantic label for this control.
  final String? semanticLabel;

  /// The tooltip message for this control.
  final String tooltipMessage;

  /// The minimum size of the touch target.
  final double minTouchTargetSize;

  /// The opacity of the control when it is disabled.
  final double? disabledOpacityValue;

  /// The extent of the focus effect.
  final double? focusEffectExtent;

  /// The extent of the pulse effect.
  final double? pulseEffectExtent;

  /// The scalar controlling the scaling of the scale effect.
  final double? scaleEffectScalar;

  /// The background color of the control.
  final Color? backgroundColor;

  /// The color of the focus effect.
  final Color? focusEffectColor;

  /// The color of the pulse effect.
  final Color? pulseEffectColor;

  /// The duration of the focus effect.
  final Duration? focusEffectDuration;

  /// The duration of the scale effect.
  final Duration? scaleEffectDuration;

  /// The duration of the pulse effect.
  final Duration? pulseEffectDuration;

  /// The curve of the focus effect.
  final Curve? focusEffectCurve;

  /// The curve of the pulse effect.
  final Curve? pulseEffectCurve;

  /// The curve of the scale effect.
  final Curve? scaleEffectCurve;

  /// The border radius of the control.
  final BorderRadius? borderRadius;

  /// The mouse cursor of the control.
  final MouseCursor cursor;

  /// The builder that builds the child of this control.
  final MoonBaseControlBuilder builder;

  /// MDS base control widget.
  const MoonBaseControl({
    super.key,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.showTooltip = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.semanticTypeIsButton = false,
    this.semanticLabel,
    this.tooltipMessage = "",
    this.minTouchTargetSize = 40.0,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectScalar,
    this.backgroundColor,
    this.focusEffectColor,
    this.pulseEffectColor,
    this.focusEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.pulseEffectCurve,
    this.scaleEffectCurve,
    this.borderRadius = BorderRadius.zero,
    this.cursor = MouseCursor.defer,
    required this.builder,
  });

  @override
  State<MoonBaseControl> createState() => _MoonBaseControlState();
}

class _MoonBaseControlState extends State<MoonBaseControl> {
  bool _isFocused = false;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isLongPressed = false;

  FocusNode? _focusNode;

  late Map<Type, Action<Intent>> _actions;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;
  bool get _canShowTooltip => widget.showTooltip && _isEnabled && (_isFocused || _isHovered || _isLongPressed);
  bool get _canAnimateFocus => widget.showFocusEffect && _isEnabled && _isFocused;
  bool get _canAnimatePulse => widget.showPulseEffect && _isEnabled;
  bool get _canAnimateScale => widget.showScaleAnimation && _isEnabled && (_isPressed || _isLongPressed);

  MouseCursor get _cursor => _isEnabled ? widget.cursor : SystemMouseCursors.forbidden;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

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

      if (mounted) {
        setState(() => _isPressed = false);
      }
    }
  }

  void _handleTapDown(_) {
    if (!_isPressed && mounted) {
      setState(() => _isPressed = true);
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

  void _handleLongPressStart(_) {
    if (!_isLongPressed && mounted) {
      setState(() => _isLongPressed = true);
    }

    if (!_isPressed && mounted) {
      setState(() => _isPressed = true);
    }
  }

  void _handleLongPressUp() {
    if (_isLongPressed && mounted) {
      setState(() => _isLongPressed = false);
    }

    if (_isPressed && mounted) {
      setState(() => _isPressed = false);
    }
  }

  void _handleHorizontalDragStart(DragStartDetails dragStartDetails) => _handleTapDown(null);

  void _handleHorizontalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  void _handleVerticalDragStart(DragStartDetails dragStartDetails) => _handleTapDown(null);

  void _handleVerticalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  Color _getFocusColor({required bool isDarkMode, required Color focusColor}) {
    if (widget.backgroundColor != null) {
      return isDarkMode ? widget.backgroundColor!.withOpacity(0.8) : widget.backgroundColor!.withOpacity(0.2);
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
        widget.disabledOpacityValue ?? context.moonOpacity?.disabled ?? MoonOpacity.opacities.disabled;

    // Focus effect props
    final Color effectiveFocusEffectColor = widget.focusEffectColor ??
        context.moonEffects?.controlFocusEffect.effectColor ??
        MoonFocusEffects.lightFocusEffect.effectColor;

    final double effectiveFocusEffectExtent = widget.focusEffectExtent ??
        context.moonEffects?.controlFocusEffect.effectExtent ??
        MoonFocusEffects.darkFocusEffect.effectExtent;

    final Curve effectiveFocusEffectCurve = widget.focusEffectCurve ??
        context.moonEffects?.controlFocusEffect.effectCurve ??
        MoonFocusEffects.lightFocusEffect.effectCurve;

    final Duration effectiveFocusEffectDuration = widget.focusEffectDuration ??
        context.moonEffects?.controlFocusEffect.effectDuration ??
        MoonFocusEffects.lightFocusEffect.effectDuration;

    final Color focusColor = _getFocusColor(isDarkMode: context.isDarkMode, focusColor: effectiveFocusEffectColor);

    // Pulse effect props
    final Color effectivePulseEffectColor = widget.pulseEffectColor ??
        context.moonEffects?.controlPulseEffect.effectColor ??
        MoonControlsEffects.controlPulseEffect.effectColor!;

    final double effectivePulseEffectExtent = widget.pulseEffectExtent ??
        context.moonEffects?.controlPulseEffect.effectExtent ??
        MoonControlsEffects.controlPulseEffect.effectExtent!;

    final Duration effectivePulseEffectDuration = widget.pulseEffectDuration ??
        context.moonEffects?.controlPulseEffect.effectDuration ??
        MoonControlsEffects.controlPulseEffect.effectDuration;

    final Curve effectivePulseEffectCurve = widget.pulseEffectCurve ??
        context.moonEffects?.controlPulseEffect.effectCurve ??
        MoonControlsEffects.controlPulseEffect.effectCurve;

    // Scale effect props
    final double effectiveScaleEffectScalar = widget.scaleEffectScalar ??
        context.moonEffects?.controlScaleEffect.effectScalar ??
        MoonControlsEffects.controlScaleEffect.effectScalar!;

    final Duration effectiveScaleEffectDuration = widget.scaleEffectDuration ??
        context.moonEffects?.controlScaleEffect.effectDuration ??
        MoonControlsEffects.controlScaleEffect.effectDuration;

    final Curve effectiveScaleEffectCurve = widget.scaleEffectCurve ??
        context.moonEffects?.controlScaleEffect.effectCurve ??
        MoonControlsEffects.controlScaleEffect.effectCurve;

    final Widget child = widget.builder(
      context,
      _isEnabled,
      _isHovered,
      _isFocused,
      _isPressed,
    );

    return MoonTooltip(
      show: _canShowTooltip,
      content: Text(widget.tooltipMessage),
      child: RepaintBoundary(
        child: MergeSemantics(
          child: Semantics(
            label: widget.semanticLabel,
            button: widget.semanticTypeIsButton,
            enabled: _isEnabled,
            focusable: _isEnabled,
            focused: _isFocused,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _handleTap,
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onLongPress: _handleLongPress,
              onLongPressStart: _handleLongPressStart,
              onLongPressUp: _handleLongPressUp,
              onHorizontalDragStart: _handleHorizontalDragStart,
              onHorizontalDragEnd: _handleHorizontalDragEnd,
              onVerticalDragStart: _handleVerticalDragStart,
              onVerticalDragEnd: _handleVerticalDragEnd,
              child: FocusableActionDetector(
                enabled: _isEnabled && widget.isFocusable,
                actions: _actions,
                mouseCursor: _cursor,
                focusNode: _effectiveFocusNode,
                autofocus: _isEnabled && widget.autofocus,
                onFocusChange: _handleFocusChange,
                onShowFocusHighlight: _handleFocus,
                onShowHoverHighlight: _handleHover,
                child: TouchTargetPadding(
                  minSize: widget.ensureMinimalTouchTargetSize
                      ? Size(widget.minTouchTargetSize, widget.minTouchTargetSize)
                      : Size.zero,
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
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOutCubic,
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
