import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_tokens/moon_tokens.dart';

class MoonMenuItem extends StatefulWidget {
  /// Defines how the [label] and [content] widgets of the menu item are aligned along the cross axis.
  ///
  /// Defaults to the [CrossAxisAlignment.start], which aligns the [label] and [content] widgets
  /// to the start of the menu item.
  final CrossAxisAlignment? crossAxisAlignment;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The border radius of the menu item.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the menu item.
  final Color? backgroundColor;

  /// The custom decoration of the menu item.
  final Decoration? decoration;

  /// The height of the menu item.
  final double? height;

  /// The width of the menu item.
  final double? width;

  /// The horizontal gap between the [leading], [label] and [trailing] widgets of the menu item.
  final double? horizontalGap;

  /// The vertical gap between the [label] and [content] widgets of the menu item.
  final double? verticalGap;

  /// The duration of the menu item hover effect.
  final Duration? hoverEffectDuration;

  /// The curve of the menu item hover effect.
  final Curve? hoverEffectCurve;

  /// The padding of the menu item.
  final EdgeInsetsGeometry? menuItemPadding;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label for the menu item.
  final String? semanticLabel;

  /// The callback that is called when the menu item is tapped or pressed. Null value disables the menu item.
  final VoidCallback? onTap;

  /// The widget to display before the [label] widget of the menu item.
  final Widget? leading;

  /// The primary content of the menu item header.
  final Widget label;

  /// The widget to display below the [label] widget of the menu item. The secondary content of the menu item header.
  final Widget? content;

  /// The widget to display after the [label] widget of the menu item.
  final Widget? trailing;

  /// Creates a Moon Design menu item.
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
    required this.label,
    this.content,
    this.trailing,
  }) : assert(
          crossAxisAlignment != CrossAxisAlignment.baseline,
          'The crossAxisAlignment.baseline is not supported since the label and content of menu item '
          'are aligned in a column, not in a row. Try using another constant.',
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

    final Color effectiveLabelTextColor =
        context.moonTheme?.menuItemTheme.colors.labelTextColor ?? MoonColors.light.textPrimary;

    final Color effectiveContentTextColor =
        context.moonTheme?.menuItemTheme.colors.contentTextColor ?? MoonColors.light.textSecondary;

    final TextStyle effectiveLabelTextStyle =
        context.moonTheme?.menuItemTheme.properties.labelTextStyle ?? MoonTypography.typography.body.textDefault;

    final TextStyle effectiveContentTextStyle =
        context.moonTheme?.menuItemTheme.properties.contentTextStyle ?? MoonTypography.typography.body.text12;

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
                style: effectiveLabelTextStyle.copyWith(color: effectiveLabelTextColor),
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
                          widget.label,
                          if (widget.content != null)
                            DefaultTextStyle(
                              style: effectiveContentTextStyle.copyWith(color: effectiveContentTextColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: effectiveVerticalGap),
                                child: widget.content,
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
