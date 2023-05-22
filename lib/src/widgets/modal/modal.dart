import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

class MoonModal extends StatelessWidget {
  /// The border radius of the modal.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the modal.
  final Color? backgroundColor;

  /// Custom shape decoration for the modal.
  final ShapeDecoration? shapeDecoration;

  /// The semantic label for the modal.
  final String? semanticLabel;

  /// The child of the modal.
  final Widget child;

  const MoonModal({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.shapeDecoration,
    this.semanticLabel,
    required this.child,
  });

  Color _getTextColor(BuildContext context, {required bool isDarkMode, required Color effectiveBackgroundColor}) {
    if (backgroundColor == null && context.moonTypography != null) {
      return context.moonTypography!.colors.bodyPrimary;
    }

    final backgroundLuminance = effectiveBackgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? context.moonTheme?.modalTheme.properties.borderRadius ?? MoonBorders.borders.surfaceSm;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.modalTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveTextColor =
        _getTextColor(context, isDarkMode: context.isDarkMode, effectiveBackgroundColor: effectiveBackgroundColor);

    return Semantics(
      label: semanticLabel,
      child: IconTheme(
        data: IconThemeData(color: effectiveTextColor),
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style.copyWith(color: effectiveTextColor),
          child: Center(
            child: Container(
              decoration: shapeDecoration ??
                  ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shape: MoonSquircleBorder(
                      borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                    ),
                  ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays a modal above the current contents of the app, with entrance and exit animations, modal barrier color,
/// and modal barrier behavior (dialog is dismissible with a tap on the barrier). Used together with MoonModal.
Future<T?> showMoonModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  String? barrierLabel = "Dismiss",
  Color? barrierColor,
  Duration? transitionDuration,
  Curve? transitionCurve,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  assert(!barrierDismissible || barrierLabel != null);
  assert(_debugIsActive(context));

  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    ).context,
  );

  final Color effectiveBarrierColor =
      barrierColor ?? context.moonTheme?.modalTheme.colors.barrierColor ?? MoonColors.light.zeno;

  final Duration effectiveTransitionDuration = transitionDuration ??
      context.moonTheme?.modalTheme.properties.transitionDuration ??
      const Duration(milliseconds: 200);

  final Curve effectiveTransitionCurve =
      transitionCurve ?? context.moonTheme?.modalTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

  return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
    MoonModalRoute<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: effectiveBarrierColor,
      transitionDuration: effectiveTransitionDuration,
      transitionCurve: effectiveTransitionCurve,
      useSafeArea: useSafeArea,
      settings: routeSettings,
      anchorPoint: anchorPoint,
      themes: themes,
    ),
  );
}

bool _debugIsActive(BuildContext context) {
  if (context is Element && !context.debugIsActive) {
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('This BuildContext is no longer valid.'),
      ErrorDescription('The showMoonModal function context parameter is a BuildContext that is no longer valid.'),
      ErrorHint(
        'This can commonly occur when the showMoonModal function is called after awaiting a Future. '
        'In this situation the BuildContext might refer to a widget that has already been disposed during the await. '
        'Consider using a parent context instead.',
      ),
    ]);
  }

  return true;
}

class MoonModalRoute<T> extends RawDialogRoute<T> {
  /// A MDS modal route with entrance and exit animations,
  /// modal barrier color, and modal barrier behavior (modal is dismissible
  /// with a tap on the barrier).
  MoonModalRoute({
    required BuildContext context,
    required WidgetBuilder builder,
    CapturedThemes? themes,
    required super.barrierColor,
    super.barrierDismissible,
    required super.transitionDuration,
    required Curve transitionCurve,
    String? barrierLabel,
    bool useSafeArea = true,
    super.settings,
    super.anchorPoint,
  }) : super(
          barrierLabel: barrierLabel ?? MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(builder: builder);

            Widget modal = themes?.wrap(pageChild) ?? pageChild;

            if (useSafeArea) {
              modal = SafeArea(child: modal);
            }

            return modal;
          },
          transitionBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return RepaintBoundary(
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: transitionCurve,
                ),
                child: child,
              ),
            );
          },
        );
}
