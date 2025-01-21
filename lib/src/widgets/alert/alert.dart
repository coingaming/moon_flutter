import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

import 'package:moon_tokens/moon_tokens.dart';

class MoonAlert extends StatelessWidget {
  /// Whether to show the alert.
  final bool show;

  /// Whether to show a border around the alert.
  final bool showBorder;

  /// The border radius of the alert.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the alert.
  final Color? backgroundColor;

  /// The border color of the alert.
  final Color? borderColor;

  /// The text and icon color of the alert.
  final Color? color;

  /// The border width of the alert.
  final double? borderWidth;

  /// The horizontal gap between the [leading], [label] and [trailing] widgets
  /// of the alert.
  final double? horizontalGap;

  /// The vertical gap between the alert header and [content].
  final double? verticalGap;

  /// The minimum height of the alert.
  final double? minimumHeight;

  /// The duration of the alert transition animation (fade in or out).
  final Duration? transitionDuration;

  /// The curve of the alert transition animation (fade in or out).
  final Curve? transitionCurve;

  /// The padding of the alert.
  final EdgeInsetsGeometry? padding;

  /// The custom decoration of the alert.
  final Decoration? decoration;

  /// The semantic label for the alert.
  final String? semanticLabel;

  /// The widget to display before the [label] widget of the alert.
  final Widget? leading;

  /// The primary content of the alert header.
  final Widget label;

  /// The widget to display after the [label] widget of the alert.
  final Widget? trailing;

  /// The widget to display below the alert header.
  final Widget? content;

  /// Creates a Moon Design base alert.
  ///
  /// See also:
  ///
  ///   * [MoonAlert.filled], Moon Design filled alert.
  ///   * [MoonAlert.outlined], Moon Design outlined alert.
  const MoonAlert({
    super.key,
    this.show = false,
    this.showBorder = false,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.color,
    this.borderWidth,
    this.horizontalGap,
    this.minimumHeight,
    this.verticalGap,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.decoration,
    this.semanticLabel,
    this.leading,
    required this.label,
    this.trailing,
    this.content,
  });

  /// Creates a Moon Design filled alert.
  ///
  /// See also:
  ///
  ///   * [MoonAlert.outlined], Moon Design outlined alert.
  const MoonAlert.filled({
    super.key,
    this.show = false,
    this.borderRadius,
    this.color,
    required this.backgroundColor,
    this.semanticLabel,
    this.leading,
    required this.label,
    this.trailing,
    this.content,
  })  : showBorder = false,
        borderColor = null,
        borderWidth = null,
        decoration = null,
        minimumHeight = null,
        padding = null,
        horizontalGap = null,
        verticalGap = null,
        transitionDuration = null,
        transitionCurve = null;

  /// Creates a Moon Design outlined alert.
  ///
  /// See also:
  ///
  ///   * [MoonAlert.filled], Moon Design filled alert.
  const MoonAlert.outlined({
    super.key,
    this.show = false,
    this.borderRadius,
    this.borderWidth,
    this.color,
    required this.borderColor,
    this.semanticLabel,
    this.leading,
    required this.label,
    this.trailing,
    this.content,
  })  : showBorder = true,
        backgroundColor = Colors.transparent,
        decoration = null,
        minimumHeight = null,
        padding = null,
        horizontalGap = null,
        verticalGap = null,
        transitionDuration = null,
        transitionCurve = null;

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? MoonBorders.borders.interactiveSm;

    final Color effectiveBackgroundColor =
        backgroundColor ?? MoonColors.light.goku;

    final Color effectiveBorderColor = borderColor ?? MoonColors.light.bulma;

    final Color effectiveTextColor = color ?? MoonColors.light.textPrimary;

    final Color effectiveIconColor = color ?? MoonColors.light.iconPrimary;

    final double effectiveBorderWidth =
        borderWidth ?? MoonBorders.borders.defaultBorderWidth;

    final double effectiveHorizontalGap = horizontalGap ?? MoonSizes.sizes.x3s;

    final double effectiveVerticalGap = verticalGap ?? MoonSizes.sizes.x4s;

    final double effectiveMinimumHeight = minimumHeight ?? MoonSizes.sizes.xl;

    final Duration effectiveTransitionDuration = transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve =
        transitionCurve ?? MoonTransitions.transitions.defaultTransitionCurve;

    final EdgeInsetsGeometry effectivePadding =
        padding ?? EdgeInsets.all(MoonSizes.sizes.x2s);

    final TextStyle effectiveLabelTextStyle = content != null
        ? MoonTypography.typography.heading.textDefault
        : MoonTypography.typography.body.textDefault;

    final TextStyle effectiveContentTextStyle =
        MoonTypography.typography.body.textDefault;

    final BoxSpecAttribute effectiveDecoration = decoration != null
        ? decorationToAttribute(decoration!)
        : decorationToAttribute(
            ShapeDecorationWithPremultipliedAlpha(
              color: effectiveBackgroundColor,
              shape: MoonBorder(
                borderRadius: effectiveBorderRadius,
                side: BorderSide(
                  color: effectiveBorderColor,
                  width: showBorder ? effectiveBorderWidth : 0,
                  style: showBorder ? BorderStyle.solid : BorderStyle.none,
                ),
              ),
            ),
          );

    final Style alertStyle = Style(
      $box.chain
        ..padding.as(effectivePadding)
        ..constraints.minHeight(effectiveMinimumHeight),
      effectiveDecoration,
      $flex.chain
        ..gap(effectiveVerticalGap)
        ..mainAxisAlignment.center(),
      $with.iconTheme.data(color: effectiveIconColor),
      $with.defaultTextStyle.style.as(
        effectiveContentTextStyle.copyWith(color: effectiveTextColor),
      ),
    );

    final Style labelTextStyle = Style(
      $with.expanded(),
      $with.defaultTextStyle.style.as(
        effectiveLabelTextStyle.copyWith(color: effectiveTextColor),
      ),
    );

    final Style headerRowStyle = Style(
      $flex.gap(effectiveHorizontalGap),
    );

    return MoonRawAlert(
      show: show,
      style: alertStyle,
      semanticLabel: semanticLabel,
      transitionCurve: effectiveTransitionCurve,
      transitionDuration: effectiveTransitionDuration,
      child: StyledColumn(
        inherit: true,
        children: [
          StyledRow(
            style: headerRowStyle,
            children: [
              if (leading != null) leading!,
              SpecBuilder(
                style: labelTextStyle,
                builder: (BuildContext _) => label,
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (content != null)
            Row(
              children: [
                Expanded(
                  child: content!,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
