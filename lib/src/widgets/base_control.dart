import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';

import 'package:moon_design/src/theme/effects/controls_effects.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/touch_target_padding.dart';
import 'package:moon_design/src/widgets/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/effects/pulse_effect.dart';

typedef MoonBaseControlBuilder = Widget Function(
  BuildContext context,
  bool isEnabled,
  bool isHovered,
  bool isFocused,
  bool isPressed,
);

class MoonBaseControl extends StatefulWidget {
  final VoidCallback? onTap;

  final VoidCallback? onLongPress;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool isFocusable;

  final bool ensureMinimalTouchTargetSize;

  final bool showBorder;

  final bool showFocusEffect;

  final bool showPulseEffect;

  final bool showPulseEffectJiggle;

  final bool showScaleAnimation;

  final bool semanticTypeIsButton;

  final String? semanticLabel;

  final double minTouchTargetSize;

  final double? borderWidth;

  final double? disabledOpacityValue;

  final double? focusEffectExtent;

  final double? pulseEffectExtent;

  final double? scaleEffectScalar;

  final Color? backgroundColor;

  final Color? borderColor;

  final Color? textColor;

  final Color? focusEffectColor;

  final Color? hoverEffectColor;

  final Color? pulseEffectColor;

  final Duration? focusEffectDuration;

  final Duration? hoverEffectDuration;

  final Duration? scaleEffectDuration;

  final Duration? pulseEffectDuration;

  final Curve? focusEffectCurve;

  final Curve? hoverEffectCurve;

  final Curve? pulseEffectCurve;

  final Curve? scaleEffectCurve;

  final BorderRadius? borderRadius;

  final MouseCursor cursor;

  final MoonBaseControlBuilder builder;

  const MoonBaseControl({
    super.key,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.isFocusable = true,
    this.ensureMinimalTouchTargetSize = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleAnimation = true,
    this.semanticTypeIsButton = false,
    this.semanticLabel,
    this.minTouchTargetSize = 40.0,
    this.borderWidth,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectScalar,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.focusEffectColor,
    this.hoverEffectColor,
    this.pulseEffectColor,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
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

  FocusNode? _focusNode;

  late Map<Type, Action<Intent>> _actions;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;
  bool get _canAnimateFocus => widget.showFocusEffect && _isEnabled && _isFocused;
  bool get _canAnimateHover => _isEnabled && (_isHovered || _isFocused || _isPressed);
  bool get _canAnimatePulse => widget.showPulseEffect && _isEnabled;
  bool get _canAnimateScale => widget.showScaleAnimation && _isEnabled && _isPressed;

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

  void _handleHorizontalDragStart(DragStartDetails dragStartDetails) => _handleLongPressDown(null);

  void _handleHorizontalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  void _handleVerticalDragStart(DragStartDetails dragStartDetails) => _handleLongPressDown(null);

  void _handleVerticalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  Color getFocusColor({required bool isDarkMode, required Color focusColor}) {
    if (widget.backgroundColor != null) {
      return isDarkMode ? widget.backgroundColor!.withOpacity(0.8) : widget.backgroundColor!.withOpacity(0.2);
    } else {
      return focusColor;
    }
  }

  Color getTextColor({required bool isDarkMode, required bool isHovered, required bool isFocused}) {
    if (widget.textColor != null && (!isHovered || !isFocused)) return widget.textColor!;
    if (widget.backgroundColor == null && isDarkMode) return MoonColors.dark.bulma;
    if (widget.backgroundColor == null && !isDarkMode) return MoonColors.light.bulma;

    final backgroundLuminance = widget.backgroundColor!.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
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

    if (_isPressed && mounted) {
      setState(() => _isPressed = false);
    }
  }

  @override
  void dispose() {
    _focusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Disabled opacity
    final double effectiveDisabledOpacityValue =
        widget.disabledOpacityValue ?? context.moonOpacity?.disabled ?? MoonOpacity.opacities.disabled;

    // Border props
    final BorderRadius effectiveBorderRadius = widget.borderRadius ?? BorderRadius.circular(0);
    final Color effectiveBorderColor = widget.borderColor ?? context.moonColors?.trunks ?? MoonColors.light.trunks;
    final double effectiveBorderWidth =
        widget.borderWidth ?? context.moonBorders?.borderWidth ?? MoonBorders.borders.borderWidth;

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

    final Color focusColor = getFocusColor(isDarkMode: context.isDarkMode, focusColor: effectiveFocusEffectColor);

    // Hover effect props
    final Color effectivehoverEffectColor = widget.hoverEffectColor ??
        context.moonEffects?.buttonHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightButtonHoverEffect.primaryHoverColor;

    final Curve effectiveHoverEffectCurve = widget.hoverEffectCurve ??
        context.moonEffects?.buttonHoverEffect.hoverCurve ??
        MoonHoverEffects.lightButtonHoverEffect.hoverCurve;

    final Duration effectiveHoverEffectDuration = widget.hoverEffectDuration ??
        context.moonEffects?.buttonHoverEffect.hoverDuration ??
        MoonHoverEffects.lightButtonHoverEffect.hoverDuration;

    final Color hoverColor = Color.alphaBlend(effectivehoverEffectColor, widget.backgroundColor ?? Colors.transparent);

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

    final Color effectiveTextColor =
        getTextColor(isDarkMode: context.isDarkMode, isHovered: _isHovered, isFocused: _isFocused);

    return RepaintBoundary(
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
              child: DefaultTextStyle(
                style: TextStyle(color: effectiveTextColor),
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
                        curve: Curves.easeInOut,
                        child: AnimatedContainer(
                          duration: effectiveHoverEffectDuration,
                          curve: effectiveHoverEffectCurve,
                          decoration: ShapeDecoration(
                            color: _canAnimateHover ? hoverColor : widget.backgroundColor,
                            shape: SmoothRectangleBorder(
                              side: BorderSide(
                                color: effectiveBorderColor,
                                width: widget.showBorder ? effectiveBorderWidth : 0,
                                style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                              ),
                              borderRadius: SmoothBorderRadius.only(
                                topLeft: SmoothRadius(
                                  cornerRadius: effectiveBorderRadius.topLeft.x,
                                  cornerSmoothing: 1,
                                ),
                                topRight: SmoothRadius(
                                  cornerRadius: effectiveBorderRadius.topRight.x,
                                  cornerSmoothing: 1,
                                ),
                                bottomLeft: SmoothRadius(
                                  cornerRadius: effectiveBorderRadius.bottomLeft.x,
                                  cornerSmoothing: 1,
                                ),
                                bottomRight: SmoothRadius(
                                  cornerRadius: effectiveBorderRadius.bottomRight.x,
                                  cornerSmoothing: 1,
                                ),
                              ),
                            ),
                          ),
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
      ),
    );
  }
}
