import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

import 'package:moon_tokens/moon_tokens.dart';

/// Displays a modal overlay over the app's current content, incorporating
/// entrance and exit animations, modal barrier color, and modal barrier
/// behavior, enabling modal dismissal via barrier taps. Intended for use in
/// conjunction with [MoonModal].
Future<T?> showMoonModal<T>({
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  bool useSafeArea = true,
  Color? barrierColor,
  Curve? transitionCurve,
  Duration? transitionDuration,
  Offset? anchorPoint,
  RouteSettings? routeSettings,
  String? barrierLabel = "Dismiss",
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  final Color effectiveBarrierColor = barrierColor ?? MoonColors.light.zeno;

  final Duration effectiveTransitionDuration = transitionDuration ??
      MoonTransitions.transitions.defaultTransitionDuration;

  final Curve effectiveTransitionCurve =
      transitionCurve ?? MoonTransitions.transitions.defaultTransitionCurve;

  return showMoonRawModal(
    context: context,
    builder: builder,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    barrierColor: effectiveBarrierColor,
    transitionDuration: effectiveTransitionDuration,
    transitionCurve: effectiveTransitionCurve,
    useSafeArea: useSafeArea,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}

class MoonModal extends StatelessWidget {
  /// The alignment of the modal.
  final AlignmentGeometry? alignment;

  /// The border radius of the modal.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the modal.
  final Color? backgroundColor;

  /// The custom decoration of the modal.
  final Decoration? decoration;

  /// The semantic label for the modal.
  final String? semanticLabel;

  /// The widget to display inside the modal as its content.
  final Widget child;

  /// Creates a Moon Design modal.
  const MoonModal({
    super.key,
    this.alignment,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.semanticLabel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? MoonBorders.borders.surfaceSm;

    final Color effectiveBackgroundColor =
        backgroundColor ?? MoonColors.light.goku;

    final Color effectiveTextColor = MoonColors.light.textPrimary;

    final Color effectiveIconColor = MoonColors.light.iconPrimary;

    final TextStyle effectiveTextStyle =
        MoonTypography.typography.body.textDefault;

    final TextStyle resolvedTextStyle =
        effectiveTextStyle.copyWith(color: effectiveTextColor);

    final Style modalStyle = Style(
      decorationToAttribute(
        decoration ??
            ShapeDecorationWithPremultipliedAlpha(
              color: effectiveBackgroundColor,
              shape: MoonBorder(borderRadius: effectiveBorderRadius),
            ),
      ),
      $with.align(alignment: alignment ?? Alignment.center),
      $with.iconTheme.data.color(effectiveIconColor),
      $with.defaultTextStyle.style.as(resolvedTextStyle),
    );
    return Semantics(
      label: semanticLabel,
      child: Box(
        style: modalStyle,
        child: child,
      ),
    );
  }
}
