import 'dart:async';

import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/toast/toast_theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

import 'package:moon_tokens/moon_tokens.dart';

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

  /// Creates a Moon Design toast.
  const MoonToast();

  /// Displays a Moon Design toast.
  static void show(
    BuildContext context, {
    /// The alignment (position) of the toast.
    AlignmentGeometry toastAlignment = Alignment.bottomCenter,

    /// Whether the toast is persistent (attaches to root navigator).
    bool isPersistent = true,

    /// Whether to use the [SafeArea] for the toast (takes into account notches
    /// and native system bars).
    bool useSafeArea = true,

    /// The border radius of the toast.
    BorderRadiusGeometry? borderRadius,

    /// The background color of the toast.
    Color? backgroundColor,

    /// The horizontal gap between the leading, label and trailing widgets of
    /// the toast.
    double? horizontalGap,

    /// The vertical gap between the toast header and content.
    double? verticalGap,

    /// The width of the toast. If not specified, adjusts automatically to fit
    /// its child elements.
    double? width,

    /// The duration to display the toast.
    Duration? displayDuration,

    /// The duration of the toast transition animation (slide in or out).
    Duration? transitionDuration,

    /// The curve of the toast transition animation (slide in or out).
    Curve? transitionCurve,

    /// The margin of the toast.
    EdgeInsetsGeometry? margin,

    /// The padding of the toast.
    EdgeInsetsGeometry? padding,

    /// The list of shadows applied to the toast.
    List<BoxShadow>? toastShadows,

    /// The theming color scheme variant for the toast.
    /// Inverted variant flips the theming color scheme (uses dark colors
    /// instead of light colors).
    MoonToastVariant variant = MoonToastVariant.original,

    /// The custom decoration of the toast.
    Decoration? decoration,

    /// The semantic label for the toast.
    String? semanticLabel,

    /// The widget to display before the label widget of the toast.
    Widget? leading,

    /// The primary content of the toast widget.
    required Widget label,

    /// The widget to display after the label widget of the toast.
    Widget? trailing,

    /// The widget to display below the toast header.
    Widget? content,
  }) {
    assert(
      displayDuration == null || (displayDuration > _timeBetweenToasts),
      'The display duration must be greater than the time between toasts '
      '(200 ms).',
    );

    final MoonToastTheme? toastTheme = context.moonTheme?.toastTheme;

    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ??
        toastTheme?.properties.borderRadius ??
        MoonBorders.borders.surfaceSm;

    final Color effectiveBackgroundColor = backgroundColor ??
        (variant == MoonToastVariant.original
            ? (toastTheme?.colors.lightVariantBackgroundColor ??
                MoonColors.light.goku)
            : (toastTheme?.colors.darkVariantBackgroundColor ??
                MoonColors.dark.goku));

    final Color effectiveTextColor = variant == MoonToastVariant.original
        ? (toastTheme?.colors.lightVariantTextColor ??
            MoonColors.light.textPrimary)
        : (toastTheme?.colors.darkVariantTextColor ??
            MoonColors.dark.textPrimary);

    final Color effectiveIconColor = variant == MoonToastVariant.original
        ? (toastTheme?.colors.lightVariantIconColor ??
            MoonColors.light.iconPrimary)
        : (toastTheme?.colors.darkVariantIconColor ??
            MoonColors.dark.iconPrimary);

    final TextStyle effectiveTextStyle = toastTheme?.properties.textStyle ??
        MoonTypography.typography.body.textDefault;

    final double effectiveHorizontalGap = horizontalGap ??
        toastTheme?.properties.horizontalGap ??
        MoonSizes.sizes.x2s;

    final double effectiveVerticalGap = verticalGap ??
        toastTheme?.properties.verticalGap ??
        MoonSizes.sizes.x3s;

    final Duration effectiveDisplayDuration = displayDuration ??
        toastTheme?.properties.displayDuration ??
        const Duration(seconds: 3);

    final Duration effectiveTransitionDuration = transitionDuration ??
        toastTheme?.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = transitionCurve ??
        toastTheme?.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final EdgeInsetsGeometry effectiveContentPadding = padding ??
        toastTheme?.properties.contentPadding ??
        EdgeInsets.all(MoonSizes.sizes.x2s);

    final EdgeInsets resolvedContentPadding =
        effectiveContentPadding.resolve(Directionality.of(context));

    final List<BoxShadow> effectiveToastShadows = toastShadows ??
        toastTheme?.shadows.toastShadows ??
        MoonShadows.light.lg;

    final effectiveContext = isPersistent
        ? (Navigator.maybeOf(context, rootNavigator: true)?.context ?? context)
        : context;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(effectiveContext).context,
    );

    final OverlayEntry entry = OverlayEntry(
      builder: (BuildContext context) {
        return RepaintBoundary(
          child: TweenAnimationBuilder(
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
                  child: Transform(
                    transform: Matrix4.translationValues(
                      switch (toastAlignment) {
                        Alignment.topLeft ||
                        Alignment.centerLeft ||
                        Alignment.bottomLeft =>
                          -_toastTravelDistance +
                              progress * _toastTravelDistance,
                        Alignment.topRight ||
                        Alignment.centerRight ||
                        Alignment.bottomRight =>
                          (1 - progress) * _toastTravelDistance,
                        _ => 0
                      },
                      switch (toastAlignment) {
                        Alignment.topCenter => -_toastTravelDistance +
                            progress * _toastTravelDistance,
                        Alignment.bottomCenter =>
                          (1 - progress) * _toastTravelDistance,
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
              );
            },
            child: themes.wrap(
              Semantics(
                label: semanticLabel,
                child: IconTheme(
                  data: IconThemeData(color: effectiveIconColor),
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(
                      color: effectiveTextColor,
                    ),
                    child: Container(
                      margin: margin ?? resolvedContentPadding,
                      padding: resolvedContentPadding,
                      width: width,
                      decoration: decoration ??
                          ShapeDecorationWithPremultipliedAlpha(
                            color: effectiveBackgroundColor,
                            shadows: effectiveToastShadows,
                            shape: MoonSquircleBorder(
                              borderRadius: effectiveBorderRadius
                                  .squircleBorderRadius(context),
                            ),
                          ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: width != null
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                            textDirection: Directionality.of(context),
                            children: [
                              if (leading != null) ...[
                                leading,
                                SizedBox(width: effectiveHorizontalGap),
                              ],
                              Flexible(child: label),
                              if (trailing != null) ...[
                                SizedBox(width: effectiveHorizontalGap),
                                trailing,
                              ],
                            ],
                          ),
                          if (content != null) ...[
                            SizedBox(height: effectiveVerticalGap),
                            content,
                          ],
                        ],
                      ),
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
      () {
        if (toastEntry.buildContext.mounted) {
          Navigator.of(toastEntry.buildContext).overlay?.insert(_entry!);
        }
      },
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
