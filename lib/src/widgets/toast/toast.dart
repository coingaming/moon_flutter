// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:async';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';

/// MoonToastPosition
/// Used to define the position of the Toast on the screen
enum MoonToastPosition {
  top,
  bottom,
  center,
  left,
  topRight,
  bottomLeft,
  bottomRight,
  centerLeft,
  centerRight,
  snackbar,
  none
}

class MoonToast extends StatefulWidget {
  static final List<_MoonToastState> _toastQueue = [];

  final Widget label;

  final Color? backgroundColor;

  final BorderRadius? borderRadius;

  final EdgeInsets? padding;

  final double? gap;

  final List<BoxShadow>? toastShadows;

  final Duration? transitionDuration;

  final Curve? transitionCurve;

  const MoonToast({
    super.key,
    required this.label,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.gap,
    this.toastShadows,
    this.transitionDuration,
    this.transitionCurve,
  });

  @override
  State<MoonToast> createState() => _MoonToastState();
}

class _MoonToastState extends State<MoonToast> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.toastTheme.colors.lightVariantBackgroundColor ??
        MoonColors.light.gohan;

    final BorderRadius effectiveBorderRadius =
        widget.borderRadius ?? context.moonTheme?.toastTheme.properties.borderRadius ?? MoonBorders.borders.surfaceSm;

    final EdgeInsets effectiveContentPadding = widget.padding ??
        context.moonTheme?.toastTheme.properties.contentPadding ??
        EdgeInsets.all(MoonSizes.sizes.x2s);

    final double effectiveGap = widget.gap ?? context.moonTheme?.toastTheme.properties.gap ?? MoonSizes.sizes.x2s;

    final List<BoxShadow> effectiveToastShadows =
        widget.toastShadows ?? context.moonTheme?.toastTheme.shadows.toastShadows ?? MoonShadows.light.lg;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.toastTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.toastTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    return TweenAnimationBuilder(
      duration: effectiveTransitionDuration,
      curve: effectiveTransitionCurve,
      tween: Tween(begin: 0.0, end: _isVisible ? 1.0 : 0.0),
      builder: (context, progress, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Transform(
            transform: Matrix4.translationValues(0, (1 - progress) * 100, 0),
            child: Opacity(
              opacity: progress,
              child: child,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: effectiveContentPadding,
        decoration: ShapeDecoration(
          color: effectiveBackgroundColor,
          shadows: effectiveToastShadows,
          shape: SmoothRectangleBorder(
            borderRadius: effectiveBorderRadius.smoothBorderRadius,
          ),
        ),
        child: widget.label,
      ),
    );
  }
}

void showMoonToast({
  required BuildContext context,
  required MoonToast toast,
  Duration transitionDuration = const Duration(milliseconds: 200),
  Duration displayDuration = const Duration(seconds: 1),
  bool isPersistent = false,
}) {
  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(
      context,
      rootNavigator: isPersistent,
    ).context,
  );

  OverlayState? overlay;

  if (isPersistent) {
    overlay = Navigator.of(
      context,
      rootNavigator: true,
    ).overlay;
  } else {
    overlay = Overlay.of(context);
  }

  final OverlayEntry entry = OverlayEntry(
    builder: (context) {
      return themes.wrap(toast);
    },
  );

  overlay?.insert(entry);

  Timer(displayDuration, () => entry.remove());
}
