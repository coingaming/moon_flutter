import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

import 'package:moon_tokens/moon_tokens.dart';

enum MoonToastVariant {
  original,
  inverted,
}

class MoonToast {
  /// Creates a Moon Design toast.
  const MoonToast();

  /// Displays a Moon Design toast.
  static void show(
    BuildContext context, {
    /// The alignment (position) of the toast.
    AlignmentGeometry toastAlignment = Alignment.bottomCenter,

    /// The alignment of the [leading], [label] and [trailing] slots of the
    /// toast header. Applies only when the [width] is specified.
    MainAxisAlignment? headerAlignment,

    /// Whether the toast is persistent (attaches to root navigator).
    bool isPersistent = true,

    /// Whether to use the [SafeArea] for the toast.
    /// Takes into account notches and native system bars.
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
    Duration displayDuration = const Duration(seconds: 3),

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
    final MainAxisAlignment effectiveHeaderAlignment = width != null
        ? headerAlignment ?? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.center;

    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? MoonBorders.borders.surfaceSm;

    final bool isOriginal = variant == MoonToastVariant.original;

    final Color effectiveBackgroundColor = backgroundColor ??
        (isOriginal ? MoonColors.light.goku : MoonColors.dark.goku);

    final Color effectiveTextColor =
        isOriginal ? MoonColors.light.textPrimary : MoonColors.dark.textPrimary;

    final Color effectiveIconColor =
        isOriginal ? MoonColors.light.iconPrimary : MoonColors.dark.iconPrimary;

    final double effectiveHorizontalGap = horizontalGap ?? MoonSizes.sizes.x2s;

    final double effectiveVerticalGap = verticalGap ?? MoonSizes.sizes.x3s;

    final Duration effectiveTransitionDuration = transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve =
        transitionCurve ?? MoonTransitions.transitions.defaultTransitionCurve;

    final EdgeInsetsGeometry effectiveContentPadding =
        padding ?? EdgeInsets.all(MoonSizes.sizes.x2s);

    final EdgeInsets resolvedContentPadding =
        effectiveContentPadding.resolve(Directionality.of(context));

    final List<BoxShadow> effectiveToastShadows =
        toastShadows ?? MoonShadows.light.lg;

    final TextStyle effectiveTextStyle =
        MoonTypography.typography.body.textDefault;

    final TextStyle resolvedTextStyle =
        effectiveTextStyle.copyWith(color: effectiveTextColor);

    final Style toastStyle = Style(
      $box.chain
        ..margin.as(margin ?? resolvedContentPadding)
        ..padding.as(resolvedContentPadding),
      width != null ? $box.width(width) : null,
      decorationToAttribute(
        decoration ??
            ShapeDecorationWithPremultipliedAlpha(
              color: effectiveBackgroundColor,
              shadows: effectiveToastShadows,
              shape: MoonBorder(borderRadius: effectiveBorderRadius),
            ),
      ),
      $with.defaultTextStyle.style.as(resolvedTextStyle),
      $with.iconTheme.data.color(effectiveIconColor),
    );

    final Style childColumnStyle = Style(
      $flex.chain
        ..mainAxisSize.min()
        ..gap.call(effectiveVerticalGap),
    );

    final Style childHeaderStyle = Style(
      $flex.chain
        ..gap.call(effectiveHorizontalGap)
        ..textDirection.call(Directionality.of(context))
        ..mainAxisAlignment.call(effectiveHeaderAlignment),
      width == null ? $flex.mainAxisSize.min() : null,
    );

    final Widget child = StyledColumn(
      style: childColumnStyle,
      children: [
        StyledRow(
          style: childHeaderStyle,
          children: [
            if (leading != null) leading,
            label,
            if (trailing != null) trailing,
          ],
        ),
        if (content != null) content,
      ],
    );

    MoonRawToast.show(
      context,
      style: toastStyle,
      semanticLabel: semanticLabel,
      transitionCurve: effectiveTransitionCurve,
      transitionDuration: effectiveTransitionDuration,
      isPersistent: isPersistent,
      displayDuration: displayDuration,
      toastAlignment: toastAlignment,
      useSafeArea: useSafeArea,
      child: child,
    );
  }
}
