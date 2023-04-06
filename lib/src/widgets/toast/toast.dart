// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';

/* final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.toastTheme.colors.lightVariantBackgroundColor ??
        MoonColors.light.gohan;

    final BorderRadius effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.toastTheme.properties.borderRadius ??
        MoonBorders.borders.surfaceSm;

    final EdgeInsets effectiveContentPadding = widget.padding ??
        context.moonTheme?.toastTheme.properties.contentPadding ??
        EdgeInsets.all(MoonSizes.sizes.x2s);

    final double effectiveGap = widget.gap ?? context.moonTheme?.toastTheme.properties.gap ?? MoonSizes.sizes.x2s;

    final Duration effectiveDisplayDuration = widget.displayDuration ??
        context.moonTheme?.toastTheme.properties.displayDuration ??
        const Duration(seconds: 5);

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.toastTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.toastTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final List<BoxShadow> effectiveToastShadows =
        widget.toastShadows ?? context.moonTheme?.toastTheme.shadows.toastShadows ?? MoonShadows.light.lg; */

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
  final Widget label;

  const MoonToast({super.key, required this.label});

  @override
  State<MoonToast> createState() => _MoonToastState();
}

class _MoonToastState extends State<MoonToast> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue, child: widget.label);
  }
}
