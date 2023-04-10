import 'dart:async';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/common/animated_icon_theme.dart';

enum MoonToastPosition {
  top,
  bottom,
}

class MoonToast {
  static const double _toastTravelDistance = 64.0;
  static const Duration _timeBetweenToasts = Duration(milliseconds: 200);
  static final MoonToast _singleton = MoonToast._internal();

  final _toastQueue = <_ToastEntry>[];

  Timer? _timer;
  OverlayEntry? _entry;

  /// MDS toast.
  factory MoonToast() {
    return _singleton;
  }

  MoonToast._internal();

  /// Shows a toast.
  void show(
    BuildContext context, {
    /// The position of the toast.
    MoonToastPosition position = MoonToastPosition.bottom,

    /// The background color of the toast.
    Color? backgroundColor,

    /// The border radius of the toast.
    BorderRadius? borderRadius,

    /// Whether the toast is persistent (attaches to root navigator).
    bool isPersistent = true,

    /// The margin around toast.
    EdgeInsets? margin,

    ///The padding around toast children.
    EdgeInsets? padding,

    /// The horizontal space between toast children.
    double? gap,

    /// Toast shadows.
    List<BoxShadow>? toastShadows,

    /// Toast display duration.
    Duration? displayDuration,

    /// Toast transition duration (show animation).
    Duration? transitionDuration,

    /// Toast transition curve (show animation).
    Curve? transitionCurve,

    /// The widget in the leading slot of the alert.
    Widget? leading,

    /// The widget in the title slot of the alert.
    required Widget title,

    /// The widget in the trailing slot of the alert.
    Widget? trailing,
  }) {
    Color getElementColor({required Color effectiveBackgroundColor}) {
      final backgroundLuminance = effectiveBackgroundColor.computeLuminance();

      if (backgroundLuminance > 0.5) {
        return MoonColors.light.bulma;
      } else {
        return MoonColors.dark.bulma;
      }
    }

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.toastTheme.colors.lightVariantBackgroundColor ?? MoonColors.light.gohan;

    final Color effectiveElementColor = getElementColor(effectiveBackgroundColor: effectiveBackgroundColor);

    final BorderRadius effectiveBorderRadius =
        borderRadius ?? context.moonTheme?.toastTheme.properties.borderRadius ?? MoonBorders.borders.surfaceSm;

    final EdgeInsets effectiveContentPadding =
        padding ?? context.moonTheme?.toastTheme.properties.contentPadding ?? EdgeInsets.all(MoonSizes.sizes.x2s);

    final double effectiveGap = gap ?? context.moonTheme?.toastTheme.properties.gap ?? MoonSizes.sizes.x2s;

    final List<BoxShadow> effectiveToastShadows =
        toastShadows ?? context.moonTheme?.toastTheme.shadows.toastShadows ?? MoonShadows.light.lg;

    final Duration effectiveDisplayDuration = displayDuration ??
        context.moonTheme?.toastTheme.properties.displayDuration ??
        const Duration(milliseconds: 5000);

    final Duration effectiveTransitionDuration = transitionDuration ??
        context.moonTheme?.toastTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        transitionCurve ?? context.moonTheme?.toastTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(context, rootNavigator: isPersistent).context,
    );

    final OverlayEntry entry = OverlayEntry(
      builder: (_) {
        return TweenAnimationBuilder(
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, progress, child) {
            return Align(
              alignment: position == MoonToastPosition.bottom ? Alignment.bottomCenter : Alignment.topCenter,
              child: Transform(
                transform: Matrix4.translationValues(
                  0,
                  position == MoonToastPosition.bottom
                      ? ((1 - progress) * _toastTravelDistance)
                      : (-_toastTravelDistance + progress * _toastTravelDistance),
                  0,
                ),
                child: Opacity(
                  opacity: progress,
                  child: child,
                ),
              ),
            );
          },
          child: themes.wrap(
            AnimatedIconTheme(
              duration: effectiveTransitionDuration,
              color: effectiveElementColor,
              child: AnimatedDefaultTextStyle(
                duration: effectiveTransitionDuration,
                style: DefaultTextStyle.of(context).style.copyWith(color: effectiveElementColor),
                child: Container(
                  margin: margin ?? effectiveContentPadding,
                  padding: effectiveContentPadding,
                  decoration: ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shadows: effectiveToastShadows,
                    shape: SmoothRectangleBorder(
                      borderRadius: effectiveBorderRadius.smoothBorderRadius,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: Directionality.of(context),
                    children: [
                      if (leading != null) ...[
                        leading,
                        SizedBox(width: effectiveGap),
                      ],
                      title,
                      if (trailing != null) ...[
                        SizedBox(width: effectiveGap),
                        trailing,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    final toastEntry = _ToastEntry(
      buildContext: context,
      overlayEntry: entry,
    );

    _toastQueue.add(toastEntry);

    if (_timer == null) _showToastOverlay(duration: effectiveDisplayDuration);
  }

  void _showToastOverlay({
    required Duration duration,
    bool isPersistent = false,
  }) {
    if (_toastQueue.isEmpty) {
      _entry = null;
      return;
    }

    final toastEntry = _toastQueue.removeAt(0);

    _entry = toastEntry.overlayEntry;
    _timer = Timer(duration, () => _removeToastOverlay(duration: duration));

    Future.delayed(_timeBetweenToasts, () {
      OverlayState? overlay;

      if (isPersistent) {
        overlay = Navigator.of(
          toastEntry.buildContext,
          rootNavigator: true,
        ).overlay;
      } else {
        overlay = Overlay.of(toastEntry.buildContext);
      }

      overlay?.insert(_entry!);
    });
  }

  void _removeToastOverlay({required Duration duration}) {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;

    _showToastOverlay(duration: duration);
  }
}

class _ToastEntry {
  final BuildContext buildContext;
  final OverlayEntry overlayEntry;

  _ToastEntry({
    required this.buildContext,
    required this.overlayEntry,
  });
}
