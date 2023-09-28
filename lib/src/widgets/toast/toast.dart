import 'dart:async';

import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

enum MoonToastVariant {
  original,
  inverted,
}

class MoonToast {
  static const double _toastTravelDistance = 64.0;
  static const Duration _timeBetweenToasts = Duration(milliseconds: 200);

  static final _toastQueue = <_ToastEntry>[];

  static Timer? _timer;
  static OverlayEntry? _entry;

  /// MDS toast.
  const MoonToast();

  /// Show a MoonToast.
  static void show(
    BuildContext context, {
    /// The alignment (position) of the toast.
    AlignmentGeometry toastAlignment = Alignment.bottomCenter,

    /// Whether the toast is persistent (attaches to root navigator).
    bool isPersistent = true,

    /// Whether the toast respects the SafeArea (eg takes into account notches and native system bars).
    bool useSafeArea = true,

    /// The border radius of the toast.
    BorderRadiusGeometry? borderRadius,

    /// The background color of the toast.
    Color? backgroundColor,

    /// The horizontal space between toast children.
    double? gap,

    /// The width of the toast. If null the toast will be as wide as its children.
    double? width,

    /// Toast display duration.
    Duration? displayDuration,

    /// Toast transition duration (show animation).
    Duration? transitionDuration,

    /// Toast transition curve (show animation).
    Curve? transitionCurve,

    /// The margin around toast.
    EdgeInsetsGeometry? margin,

    /// The padding around toast children.
    EdgeInsetsGeometry? padding,

    /// Toast shadows.
    List<BoxShadow>? toastShadows,

    /// The variant of the toast. Inverted variant flips the color scheme from theming, eg instead of light colors,
    /// uses dark colors.
    MoonToastVariant variant = MoonToastVariant.original,

    /// Custom decoration for the toast.
    Decoration? decoration,

    /// The semantic label for the toast.
    String? semanticLabel,

    /// The widget in the leading slot of the toast.
    Widget? leading,

    /// The widget in the title slot of the toast.
    required Widget title,

    /// The widget in the trailing slot of the toast.
    Widget? trailing,
  }) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? context.moonTheme?.toastTheme.properties.borderRadius ?? MoonBorders.borders.surfaceSm;

    final Color effectiveBackgroundColor = backgroundColor ??
        (variant == MoonToastVariant.original
            ? (context.moonTheme?.toastTheme.colors.lightVariantBackgroundColor ?? MoonColors.light.goku)
            : (context.moonTheme?.toastTheme.colors.darkVariantBackgroundColor ?? MoonColors.dark.goku));

    final Color effectiveTextColor = variant == MoonToastVariant.original
        ? (context.moonTheme?.toastTheme.colors.lightVariantTextColor ?? MoonColors.light.textPrimary)
        : (context.moonTheme?.toastTheme.colors.darkVariantTextColor ?? MoonColors.dark.textPrimary);

    final Color effectiveIconColor = variant == MoonToastVariant.original
        ? (context.moonTheme?.toastTheme.colors.lightVariantIconColor ?? MoonColors.light.iconPrimary)
        : (context.moonTheme?.toastTheme.colors.darkVariantIconColor ?? MoonColors.dark.iconPrimary);

    final TextStyle effectiveTextStyle =
        context.moonTheme?.toastTheme.properties.textStyle ?? MoonTypography.typography.body.textDefault;

    final double effectiveGap = gap ?? context.moonTheme?.toastTheme.properties.gap ?? MoonSizes.sizes.x2s;

    final Duration effectiveDisplayDuration =
        displayDuration ?? context.moonTheme?.toastTheme.properties.displayDuration ?? const Duration(seconds: 3);

    final Duration effectiveTransitionDuration = transitionDuration ??
        context.moonTheme?.toastTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = transitionCurve ??
        context.moonTheme?.toastTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final EdgeInsetsGeometry effectiveContentPadding =
        padding ?? context.moonTheme?.toastTheme.properties.contentPadding ?? EdgeInsets.all(MoonSizes.sizes.x2s);

    final EdgeInsets resolvedContentPadding = effectiveContentPadding.resolve(Directionality.of(context));

    final List<BoxShadow> effectiveToastShadows =
        toastShadows ?? context.moonTheme?.toastTheme.shadows.toastShadows ?? MoonShadows.light.lg;

    final effectiveContext =
        isPersistent ? (Navigator.maybeOf(context, rootNavigator: true)?.context ?? context) : context;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(effectiveContext).context,
    );

    final OverlayEntry entry = OverlayEntry(
      builder: (BuildContext context) {
        return TweenAnimationBuilder(
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (BuildContext context, double progress, Widget? child) {
            return SafeArea(
              left: useSafeArea,
              top: useSafeArea,
              right: useSafeArea,
              bottom: useSafeArea,
              maintainBottomViewPadding: true,
              child: Align(
                alignment: toastAlignment,
                child: RepaintBoundary(
                  child: Transform(
                    transform: Matrix4.translationValues(
                      switch (toastAlignment) {
                        Alignment.topLeft ||
                        Alignment.centerLeft ||
                        Alignment.bottomLeft =>
                          -_toastTravelDistance + progress * _toastTravelDistance,
                        Alignment.topRight ||
                        Alignment.centerRight ||
                        Alignment.bottomRight =>
                          (1 - progress) * _toastTravelDistance,
                        _ => 0
                      },
                      switch (toastAlignment) {
                        Alignment.topCenter => -_toastTravelDistance + progress * _toastTravelDistance,
                        Alignment.bottomCenter => (1 - progress) * _toastTravelDistance,
                        _ => 0
                      },
                      0,
                    ),
                    child: Opacity(
                      opacity: progress,
                      child: child,
                    ),
                  ),
                ),
              ),
            );
          },
          child: themes.wrap(
            Semantics(
              label: semanticLabel,
              child: IconTheme(
                data: IconThemeData(color: effectiveIconColor),
                child: DefaultTextStyle(
                  style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                  child: Container(
                    margin: margin ?? resolvedContentPadding,
                    padding: resolvedContentPadding,
                    width: width,
                    decoration: decoration ??
                        ShapeDecorationWithPremultipliedAlpha(
                          color: effectiveBackgroundColor,
                          shadows: effectiveToastShadows,
                          shape: MoonSquircleBorder(
                            borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                          ),
                        ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: width != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                      textDirection: Directionality.of(context),
                      children: [
                        if (leading != null) ...[
                          leading,
                          SizedBox(width: effectiveGap),
                        ],
                        Flexible(child: title),
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
          ),
        );
      },
    );

    final toastEntry = _ToastEntry(
      buildContext: effectiveContext,
      overlayEntry: entry,
    );

    _toastQueue.add(toastEntry);

    if (_timer == null) _showToastOverlay(duration: effectiveDisplayDuration);
  }

  /// Clear the toast queue.
  static void clearToastQueue() {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;

    _toastQueue.clear();
  }

  static void _showToastOverlay({required Duration duration}) {
    if (_toastQueue.isEmpty) {
      _entry = null;
      return;
    }

    final toastEntry = _toastQueue.removeAt(0);

    if (!toastEntry.buildContext.mounted) {
      clearToastQueue();
      return;
    }

    _entry = toastEntry.overlayEntry;
    _timer = Timer(duration, () => _removeToastOverlay(duration: duration));

    Future.delayed(
      _timeBetweenToasts,
      () => Navigator.of(toastEntry.buildContext).overlay?.insert(_entry!),
    );
  }

  static void _removeToastOverlay({required Duration duration}) {
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
