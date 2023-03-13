import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/switch/switch_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';

enum MoonSwitchSize {
  x2s,
  xs,
  sm,
}

class MoonSwitch extends StatefulWidget {
  /// Determines if the switch is on or off.
  final bool value;

  /// Callback when the switch is toggled on or off.
  final ValueChanged<bool>? onChanged;

  /// The size of the switch.
  final MoonSwitchSize? switchSize;

  /// Whether the switch has haptic feedback (vibration) when toggled.
  final bool hasHapticFeedback;

  /// The width of the switch.
  final double? width;

  /// The height of the switch.
  final double? height;

  /// The size of the thumb.
  final double? thumbSizeValue;

  /// The color to use on the switch when the switch is on.
  final Color? activeTrackColor;

  /// The color to use on the switch when the switch is off.
  final Color? inactiveTrackColor;

  /// The color of the thumb.
  final Color? thumbColor;

  /// The border of the switch.
  final BoxBorder? trackBorder;

  /// The border of the thumb.
  final BoxBorder? thumbBorder;

  /// The padding of the switch.
  final EdgeInsets? padding;

  /// The duration for the switch animation.
  final Duration? duration;

  /// The curve for the switch animation.
  final Curve? curve;

  /// The widget to display when the switch is on (left slot).
  final Widget? activeTrackWidget;

  /// The widget to display when the switch is off (right slot).
  final Widget? inactiveTrackWidget;

  /// The widget inside the thumb when switch is on.
  final Widget? activeThumbWidget;

  /// The widget inside the thumb when the switch is off.
  final Widget? inactiveThumbWidget;

  const MoonSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.switchSize,
    this.width,
    this.height,
    this.thumbSizeValue,
    this.hasHapticFeedback = true,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.trackBorder,
    this.thumbBorder,
    this.padding,
    this.duration,
    this.curve,
    this.activeTrackWidget,
    this.inactiveTrackWidget,
    this.activeThumbWidget,
    this.inactiveThumbWidget,
  });

  @override
  _MoonSwitchState createState() => _MoonSwitchState();
}

class _MoonSwitchState extends State<MoonSwitch> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;
  Animation<Alignment>? _alignmentAnimation;
  Animation<Decoration>? _trackDecorationAnimation;

  bool get isInteractive => widget.onChanged != null;

  // A non-null boolean value that changes to true at the end of a drag if the
  // switch must be animated to the _curvedAnimation indicated by the widget's value.
  bool needsPositionAnimation = false;

  MoonSwitchSizeProperties _getMoonSwitchSize(BuildContext context, MoonSwitchSize? moonSwitchSize) {
    switch (moonSwitchSize) {
      case MoonSwitchSize.x2s:
        return context.moonTheme?.switchTheme.sizes.x2s ?? MoonSwitchSizeProperties.x2s;
      case MoonSwitchSize.xs:
        return context.moonTheme?.switchTheme.sizes.xs ?? MoonSwitchSizeProperties.xs;
      case MoonSwitchSize.sm:
        return context.moonTheme?.switchTheme.sizes.sm ?? MoonSwitchSizeProperties.sm;
      default:
        return context.moonTheme?.switchTheme.sizes.xs ?? MoonSwitchSizeProperties.xs;
    }
  }

  // `isLinear` must be true if the _curvedAnimation animation is trying to move the
  // thumb to the closest end after the most recent drag animation, so the curve
  // does not change when the controller's value is not 0 or 1.
  //
  // It can be set to false when it's an implicit animation triggered by
  // widget.value changes.
  void _resumePositionAnimation({bool isLinear = true}) {
    needsPositionAnimation = false;

    _curvedAnimation!
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? Curves.linear : Curves.ease.flipped;

    if (widget.value) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
    }
  }

  void _handleTap() {
    if (isInteractive) {
      widget.onChanged!(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _emitVibration();
    }
  }

  void _handleDragUpdate({
    required DragUpdateDetails details,
    required double switchWidth,
    required double thumbSizeValue,
    required EdgeInsets padding,
  }) {
    if (isInteractive) {
      _curvedAnimation!
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;

      final double delta = details.primaryDelta! / (switchWidth - (thumbSizeValue + padding.right + padding.left));

      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _animationController!.value -= delta;
          break;
        case TextDirection.ltr:
          _animationController!.value += delta;
          break;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      needsPositionAnimation = true;
    });
    // Call onChanged when the user's intent to change value is clear.
    if (_curvedAnimation!.value >= 0.5 != widget.value) {
      widget.onChanged!(!widget.value);
    }
  }

  void _emitVibration() {
    if (widget.hasHapticFeedback) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  void didUpdateWidget(MoonSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (needsPositionAnimation || oldWidget.value != widget.value) {
      _resumePositionAnimation(isLinear: needsPositionAnimation);
    }

    if (_curvedAnimation!.value == 0.0 || _curvedAnimation!.value == 1.0) {
      _curvedAnimation!
        ..curve = Curves.easeOutBack
        ..reverseCurve = Curves.easeOutBack.flipped;
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (needsPositionAnimation) {
      _resumePositionAnimation();
    }

    final MoonSwitchSizeProperties effectiveMoonSwitchSize = _getMoonSwitchSize(context, widget.switchSize);

    final double effectiveWidth = widget.width ?? effectiveMoonSwitchSize.width;
    final double effectiveHeight = widget.height ?? effectiveMoonSwitchSize.height;
    final double effectiveThumbSizeValue = widget.thumbSizeValue ?? effectiveMoonSwitchSize.thumbSizeValue;
    final EdgeInsets effectivePadding = widget.padding ?? effectiveMoonSwitchSize.padding;

    final Color effectiveActiveTrackColor =
        widget.activeTrackColor ?? context.moonTheme?.switchTheme.colors.activeTrackColor ?? MoonColors.light.piccolo;

    final Color effectiveInactiveTrackColor = widget.inactiveTrackColor ??
        context.moonTheme?.switchTheme.colors.inactiveTrackColor ??
        MoonColors.light.beerus;

    final Color effectiveThumbColor =
        widget.thumbColor ?? context.moonTheme?.switchTheme.colors.thumbColor ?? MoonColors.light.goten;

    final List<BoxShadow> effectiveThumbShadow =
        context.moonTheme?.switchTheme.shadows.thumbShadows ?? MoonShadows.light.sm;

    final Duration effectiveDuration = widget.duration ??
        context.moonTheme?.switchTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveCurve =
        widget.curve ?? context.moonTheme?.switchTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    _animationController ??= AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: effectiveDuration,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveCurve,
    );

    _alignmentAnimation ??= AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_curvedAnimation!);

    _trackDecorationAnimation ??= DecorationTween(
      begin: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveHeight / 2),
        color: effectiveInactiveTrackColor,
      ),
      end: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveHeight / 2),
        color: effectiveActiveTrackColor,
      ),
    ).animate(_curvedAnimation!);

    log("width $effectiveWidth");
    log("height $effectiveHeight");

    return GestureDetector(
      onTap: _handleTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: (DragUpdateDetails details) => _handleDragUpdate(
        details: details,
        switchWidth: effectiveWidth,
        thumbSizeValue: effectiveThumbSizeValue,
        padding: effectivePadding,
      ),
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return AnimatedOpacity(
            opacity: isInteractive ? 1 : 0.32,
            duration: effectiveDuration,
            curve: effectiveCurve,
            child: SizedBox(
              width: effectiveWidth,
              height: effectiveHeight,
              child: DecoratedBoxTransition(
                decoration: _trackDecorationAnimation!,
                child: Padding(
                  padding: effectivePadding,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: _alignmentAnimation!.value,
                        child: Container(
                          width: widget.thumbSizeValue,
                          height: widget.thumbSizeValue,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(effectiveThumbSizeValue / 2),
                            color: effectiveThumbColor,
                            boxShadow: effectiveThumbShadow,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              FadeTransition(
                                opacity: _curvedAnimation!,
                                child:
                                    _curvedAnimation!.value > 0.5 ? FittedBox(child: widget.activeThumbWidget) : null,
                              ),
                              FadeTransition(
                                opacity: Tween<double>(begin: 1, end: 0).animate(_curvedAnimation!),
                                child:
                                    _curvedAnimation!.value < 0.5 ? FittedBox(child: widget.inactiveThumbWidget) : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
