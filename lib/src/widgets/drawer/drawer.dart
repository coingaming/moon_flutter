import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

class MoonDrawer extends StatelessWidget {
  /// The border radius of the Drawer.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the Drawer.
  final Color? backgroundColor;

  /// The color of the Drawer barrier.
  final Color? barrierColor;

  /// The width of the Drawer.
  final double? width;

  /// Custom decoration for the Drawer.
  final Decoration? decoration;

  /// List of popover shadows.
  final List<BoxShadow>? drawerShadows;

  /// The semantic label for the Drawer.
  final String? semanticLabel;

  /// The child of the Drawer.
  final Widget child;

  const MoonDrawer({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.barrierColor,
    this.width,
    this.decoration,
    this.drawerShadows,
    this.semanticLabel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? context.moonTheme?.drawerTheme.properties.borderRadius ?? BorderRadius.zero;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.drawerTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveTextColor =
        context.moonTheme?.drawerTheme.colors.textColor ?? MoonTypography.light.colors.bodyPrimary;

    final Color effectiveIconColor =
        context.moonTheme?.drawerTheme.colors.iconColor ?? MoonIconTheme.light.colors.primaryColor;

    final double widthFromTheme = context.moonTheme?.drawerTheme.properties.width ?? 448;

    final double effectiveWidth = width ??
        (MediaQuery.of(context).size.width < widthFromTheme ? MediaQuery.of(context).size.width : widthFromTheme);

    final List<BoxShadow> effectiveDrawerShadows =
        drawerShadows ?? context.moonTheme?.drawerTheme.shadows.drawerShadows ?? MoonShadows.light.lg;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.drawerTheme.properties.textStyle ?? MoonTextStyles.body.textDefault;

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
                    borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                  ),
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}
