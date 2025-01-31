import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

import 'package:moon_tokens/moon_tokens.dart';

class MoonDrawer extends StatelessWidget {
  /// The border radius of the drawer.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the drawer.
  final Color? backgroundColor;

  /// The custom decoration of the drawer.
  final Decoration? decoration;

  /// The width of the drawer.
  final double? width;

  /// The list of shadows applied to the drawer.
  final List<BoxShadow>? drawerShadows;

  /// The semantic label for the drawer.
  final String? semanticLabel;

  /// The widget to display inside the drawer as its content.
  final Widget child;

  /// Creates a Moon Design drawer.
  const MoonDrawer({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.width,
    this.drawerShadows,
    this.semanticLabel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? BorderRadius.zero;

    final Color effectiveBackgroundColor =
        backgroundColor ?? MoonColors.light.goku;

    final Color effectiveTextColor = MoonColors.light.textPrimary;

    final Color effectiveIconColor = MoonColors.light.iconPrimary;

    const double effectiveWidthFromTheme = 448;

    final double effectiveWidth = width ??
        (MediaQuery.of(context).size.width < effectiveWidthFromTheme
            ? MediaQuery.of(context).size.width
            : effectiveWidthFromTheme);

    final List<BoxShadow> effectiveDrawerShadows =
        drawerShadows ?? MoonShadows.light.lg;

    final TextStyle effectiveTextStyle =
        MoonTypography.typography.body.textDefault;

    final TextStyle resolvedTextStyle =
        effectiveTextStyle.copyWith(color: effectiveTextColor);

    final Style drawerStyle = Style(
      $box.width(effectiveWidth),
      decorationToAttribute(
        decoration ??
            ShapeDecorationWithPremultipliedAlpha(
              color: effectiveBackgroundColor,
              shadows: effectiveDrawerShadows,
              shape: MoonBorder(borderRadius: effectiveBorderRadius),
            ),
      ),
      $with.defaultTextStyle.style.as(resolvedTextStyle),
      $with.iconTheme.data.color(effectiveIconColor),
    );

    return Semantics(
      explicitChildNodes: true,
      namesRoute: true,
      scopesRoute: true,
      label: semanticLabel,
      child: Box(
        style: drawerStyle,
        child: child,
      ),
    );
  }
}
