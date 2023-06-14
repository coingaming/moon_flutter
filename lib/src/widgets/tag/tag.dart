import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/icons/icon_theme.dart';
import 'package:moon_design/src/theme/tag/tag_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

enum MoonTagSize {
  x2s,
  xs,
}

class MoonTag extends StatelessWidget {
  /// Whether the tag should use upper case text style.
  final bool isUpperCase;

  /// The border radius of the tag.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the tag.
  final Color? backgroundColor;

  /// The height of the tag.
  final double? height;

  /// The width of the tag.
  final double? width;

  /// The gap between the leading or trailing and the label widgets.
  final double? gap;

  /// The padding of the tag.
  final EdgeInsetsGeometry? padding;

  /// The size of the tag.
  final MoonTagSize? tagSize;

  /// Custom decoration for the tag.
  final Decoration? decoration;

  /// The semantic label for the tag.
  final String? semanticLabel;

  /// The callback that is called when the tag is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the tag is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget in the leading slot of the tag.
  final Widget? leading;

  /// The widget in the label slot of the tag.
  final Widget? label;

  /// The widget in the trailing slot of the tag.
  final Widget? trailing;

  /// MDS tag widget.
  const MoonTag({
    super.key,
    this.isUpperCase = true,
    this.borderRadius,
    this.backgroundColor,
    this.height,
    this.width,
    this.gap,
    this.padding,
    this.tagSize,
    this.decoration,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  MoonTagSizeProperties _getMoonTagSize(BuildContext context, MoonTagSize? moonTagSize) {
    switch (moonTagSize) {
      case MoonTagSize.x2s:
        return context.moonTheme?.tagTheme.sizes.x2s ?? MoonTagSizeProperties.x2s;
      case MoonTagSize.xs:
        return context.moonTheme?.tagTheme.sizes.xs ?? MoonTagSizeProperties.xs;
      default:
        return context.moonTheme?.tagTheme.sizes.xs ?? MoonTagSizeProperties.xs;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonTagSizeProperties effectiveMoonTagSize = _getMoonTagSize(context, tagSize);

    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ?? effectiveMoonTagSize.borderRadius;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.tagTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveTextColor =
        context.moonTheme?.tagTheme.colors.textColor ?? MoonTypography.light.colors.bodyPrimary;

    final Color effectiveIconColor =
        context.moonTheme?.tagTheme.colors.iconColor ?? MoonIconTheme.light.colors.primaryColor;

    final double effectiveHeight = height ?? effectiveMoonTagSize.height;

    final double effectiveGap = gap ?? effectiveMoonTagSize.gap;

    final EdgeInsetsGeometry effectivePadding = padding ?? effectiveMoonTagSize.padding;

    final EdgeInsets resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedPadding = padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            leading == null && label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            trailing == null && label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    return Semantics(
      label: semanticLabel,
      button: false,
      focusable: false,
      child: GestureDetector(
        excludeFromSemantics: true,
        onTap: onTap,
        onLongPress: onLongPress,
        child: MouseRegion(
          cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Container(
            height: effectiveHeight,
            padding: correctedPadding,
            constraints: BoxConstraints(minWidth: effectiveHeight),
            decoration: decoration ??
                ShapeDecorationWithPremultipliedAlpha(
                  color: effectiveBackgroundColor,
                  shape: MoonSquircleBorder(
                    borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                  ),
                ),
            child: IconTheme(
              data: IconThemeData(
                color: effectiveIconColor,
                size: effectiveMoonTagSize.iconSizeValue,
              ),
              child: DefaultTextStyle(
                style: isUpperCase
                    ? effectiveMoonTagSize.upperCaseTextStyle.copyWith(color: effectiveTextColor)
                    : effectiveMoonTagSize.textStyle.copyWith(color: effectiveTextColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leading != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                        child: leading,
                      ),
                    if (label != null) label!,
                    if (trailing != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                        child: trailing,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
