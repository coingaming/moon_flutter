import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
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
    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ??
        context.moonTheme?.drawerTheme.properties.borderRadius ??
        BorderRadius.zero;

    final Color effectiveBackgroundColor = backgroundColor ??
        context.moonTheme?.drawerTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveTextColor =
        context.moonTheme?.drawerTheme.colors.textColor ??
            MoonColors.light.textPrimary;

    final Color effectiveIconColor =
        context.moonTheme?.drawerTheme.colors.iconColor ??
            MoonColors.light.iconPrimary;

    final double effectiveWidthFromTheme =
        context.moonTheme?.drawerTheme.properties.width ?? 448;

    final double effectiveWidth = width ??
        (MediaQuery.of(context).size.width < effectiveWidthFromTheme
            ? MediaQuery.of(context).size.width
            : effectiveWidthFromTheme);

    final List<BoxShadow> effectiveDrawerShadows = drawerShadows ??
        context.moonTheme?.drawerTheme.shadows.drawerShadows ??
        MoonShadows.light.lg;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.drawerTheme.properties.textStyle ??
            MoonTypography.typography.body.textDefault;

    return Semantics(
      explicitChildNodes: true,
      namesRoute: true,
      scopesRoute: true,
      label: semanticLabel,
      child: IconTheme(
        data: IconThemeData(color: effectiveIconColor),
        child: DefaultTextStyle(
          style: effectiveTextStyle.copyWith(color: effectiveTextColor),
          child: Container(
            width: effectiveWidth,
            decoration: decoration ??
                ShapeDecorationWithPremultipliedAlpha(
                  color: effectiveBackgroundColor,
                  shadows: effectiveDrawerShadows,
                  shape: MoonSquircleBorder(
                    borderRadius:
                        effectiveBorderRadius.squircleBorderRadius(context),
                  ),
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}
