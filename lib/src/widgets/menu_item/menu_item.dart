import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';

class MoonMenuItem extends StatefulWidget {
  /// Specifies the alignment of title and description of menu item.
  ///
  /// Default value is [CrossAxisAlignment.start].
  final CrossAxisAlignment? crossAxisAlignment;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The menu item's border radius.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the menu item.
  final Color? backgroundColor;

  /// Custom decoration for the menu item.
  final Decoration? decoration;

  /// The height of the menu item.
  final double? height;

  /// The width of the menu item.
  final double? width;

  /// The horizontal gap between the leading, title/description and trailing widgets.
  final double? horizontalGap;

  /// The vertical space between title and description.
  final double? verticalGap;

  /// Menu item hover effect duration.
  final Duration? hoverEffectDuration;

  /// Menu item hover effect curve.
  final Curve? hoverEffectCurve;

  /// Padding for the menu item.
  final EdgeInsetsGeometry? menuItemPadding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The semantic label for the menu item.
  final String? semanticLabel;

  /// Callback when menu item is tapped. When null, the MoonMenuItem is disabled.
  final VoidCallback? onTap;

  /// A widget to display before the menu item header.
  final Widget? leading;

  /// The primary content of the menu item header.
  final Widget title;

  /// The secondary content of the menu item header.
  final Widget? description;

  /// A widget to display after the menu item header.
  final Widget? trailing;

  /// MDS MenuItem widget.
  const MoonMenuItem({
    super.key,
    this.crossAxisAlignment,
    this.autofocus = false,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.height,
    this.width,
    this.horizontalGap,
    this.verticalGap,
    this.hoverEffectDuration,
    this.hoverEffectCurve,
    this.menuItemPadding,
    this.focusNode,
    this.semanticLabel,
    this.onTap,
    this.leading,
    required this.title,
    this.description,
    this.trailing,
  }) : assert(
          crossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the title and description of menu item '
          'are aligned in a column, not in a row. Try to use another constant.',
        );

  static Iterable<Widget> divideMenuItems({
    required BuildContext context,
    required Iterable<Widget> menuItems,
    Color? color,
    double? width,
  }) {
    menuItems = menuItems.toList();

    if (menuItems.isEmpty || menuItems.length == 1) return menuItems;

    final Color effectiveColor =
        color ?? context.moonTheme?.menuItemTheme.colors.dividerColor ?? MoonColors.light.beerus;

    Widget wrapMenuItem(Widget menuItems) {
      return DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(
              context,
              color: effectiveColor,
              width: width,
            ),
          ),
        ),
        child: menuItems,
      );
    }

    return <Widget>[
      ...menuItems.take(menuItems.length - 1).map(wrapMenuItem),
      menuItems.last,
    ];
  }

  @override
  State<MoonMenuItem> createState() => _MoonMenuItemState();
}

class _MoonMenuItemState extends State<MoonMenuItem> with TickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _backgroundColorTween = ColorTweenWithPremultipliedAlpha();

  AnimationController? _animationController;
  Animation<Color?>? _backgroundColor;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? FocusNode();

  void _handleActiveStatus(bool isActive) {
    isActive ? _animationController!.forward() : _animationController!.reverse();
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.menuItemTheme.properties.borderRadius ??
        MoonBorders.borders.interactiveSm;

    final double effectiveMinimumHeaderHeight =
        widget.height ?? context.moonTheme?.menuItemTheme.properties.minimumHeight ?? MoonSizes.sizes.md;

    final double effectiveVerticalGap =
        widget.verticalGap ?? context.moonTheme?.menuItemTheme.properties.verticalGap ?? MoonSizes.sizes.x5s;

    final EdgeInsetsGeometry effectiveHeaderPadding = widget.menuItemPadding ??
        context.moonTheme?.menuItemTheme.properties.padding ??
        EdgeInsets.all(MoonSizes.sizes.x3s);

    final EdgeInsets resolvedDirectionalHeaderPadding = effectiveHeaderPadding.resolve(Directionality.of(context));

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.menuItemTheme.colors.backgroundColor ?? Colors.transparent;

    final Color effectiveIconColor = context.moonTheme?.menuItemTheme.colors.iconColor ?? MoonColors.light.iconPrimary;

    final Color effectiveTitleTextColor =
        context.moonTheme?.menuItemTheme.colors.titleTextColor ?? MoonColors.light.textPrimary;

    final Color effectiveDescriptionTextColor =
        context.moonTheme?.menuItemTheme.colors.descriptionTextColor ?? MoonColors.light.textSecondary;

    final TextStyle effectiveTitleTextStyle =
        context.moonTheme?.menuItemTheme.properties.titleTextStyle ?? MoonTypography.typography.body.textDefault;

    final TextStyle effectiveDescriptionTextStyle =
        context.moonTheme?.menuItemTheme.properties.descriptionTextStyle ?? MoonTypography.typography.body.text12;

    final Color effectiveHoverEffectColor = context.moonEffects?.controlHoverEffect.primaryHoverColor ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlHoverEffect.primaryHoverColor;

    final Color resolvedHoverColor =
        Color.alphaBlend(effectiveHoverEffectColor, widget.backgroundColor ?? Colors.transparent);

    final Duration effectiveHoverEffectDuration = widget.hoverEffectDuration ??
        context.moonEffects?.controlHoverEffect.hoverDuration ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlHoverEffect.hoverDuration;

    final Curve effectiveHoverEffectCurve = widget.hoverEffectCurve ??
        context.moonEffects?.controlHoverEffect.hoverCurve ??
        MoonEffectsTheme(tokens: MoonTokens.light).controlHoverEffect.hoverCurve;

    _animationController ??= AnimationController(duration: effectiveHoverEffectDuration, vsync: this);

    _backgroundColor ??=
        _animationController!.drive(_backgroundColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));

    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = resolvedHoverColor;

    return Semantics(
      label: widget.semanticLabel,
      enabled: widget.onTap != null,
      child: MoonBaseControl(
        onTap: widget.onTap,
        autofocus: widget.autofocus,
        focusNode: _effectiveFocusNode,
        borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
        showScaleAnimation: false,
        builder: (BuildContext context, bool isEnabled, bool isHovered, bool isFocused, bool isPressed) {
          final bool isActive = isHovered || isFocused;

          _handleActiveStatus(isActive);

          return AnimatedBuilder(
            animation: _animationController!,
            builder: (BuildContext context, Widget? child) {
              return Container(
                height: widget.height,
                width: widget.width,
                constraints: BoxConstraints(minHeight: effectiveMinimumHeaderHeight),
                padding: resolvedDirectionalHeaderPadding,
                decoration: widget.decoration ??
                    ShapeDecoration(
                      color: _backgroundColor!.value,
                      shape: MoonSquircleBorder(
                        borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                      ),
                    ),
                child: child,
              );
            },
            child: IconTheme(
              data: IconThemeData(color: effectiveIconColor),
              child: DefaultTextStyle(
                style: effectiveTitleTextStyle.copyWith(color: effectiveTitleTextColor),
                child: Row(
                  children: [
                    if (widget.leading != null)
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: widget.horizontalGap ?? resolvedDirectionalHeaderPadding.left,
                        ),
                        child: widget.leading,
                      ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.start,
                        children: [
                          widget.title,
                          if (widget.description != null)
                            DefaultTextStyle(
                              style: effectiveDescriptionTextStyle.copyWith(color: effectiveDescriptionTextColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: effectiveVerticalGap),
                                child: widget.description,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (widget.trailing != null)
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: widget.horizontalGap ?? resolvedDirectionalHeaderPadding.right,
                        ),
                        child: widget.trailing,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
