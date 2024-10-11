import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/breadcrumb/breadcrumb_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/widgets/breadcrumb/breadcrumb_item.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:moon_tokens/moon_tokens.dart';

class MoonBreadcrumb extends StatefulWidget {
  /// The color of the breadcrumb divider.
  final Color? dividerColor;

  /// The icon and text color of the breadcrumb item on hover.
  final Color? hoverEffectColor;

  /// The custom decoration of the breadcrumb item.
  final BoxDecoration? itemDecoration;

  /// The gap between the [divider] widget and the breadcrumb item.
  final double? gap;

  /// The padding of the breadcrumb.
  final EdgeInsetsGeometry? padding;

  /// The total number of the breadcrumb [items] to display.
  final int visibleItemCount;

  /// The semantic label for the breadcrumb default [showMoreWidget].
  final String? semanticLabel;

  /// The text style of the breadcrumb item.
  final TextStyle? itemTextStyle;

  /// The text style of the current breadcrumb item.
  final TextStyle? currentItemTextStyle;

  /// The list of breadcrumb items to display as a sequence of steps.
  final List<MoonBreadcrumbItem> items;

  /// The separating widget to display between the breadcrumb items.
  final Widget? divider;

  /// The single custom widget to replace all the breadcrumb collapsed items
  /// with.
  final MoonBreadcrumbItem? showMoreWidget;

  /// Creates a Moon Design breadcrumb.
  const MoonBreadcrumb({
    super.key,
    this.dividerColor,
    this.hoverEffectColor,
    this.itemDecoration,
    this.gap,
    this.padding,
    this.visibleItemCount = 3,
    this.semanticLabel,
    this.itemTextStyle,
    this.currentItemTextStyle,
    required this.items,
    this.divider,
    this.showMoreWidget,
  });

  @override
  State<MoonBreadcrumb> createState() => _MoonBreadcrumbState();
}

class _MoonBreadcrumbState extends State<MoonBreadcrumb> {
  bool _showFullPath = false;

  List<Widget> _buildItems() {
    final MoonBreadcrumbTheme? theme = context.moonTheme?.breadcrumbTheme;

    final double effectiveGap =
        widget.gap ?? theme?.properties.gap ?? MoonSizes.sizes.x4s;

    final Color effectiveItemTextColor = widget.itemTextStyle?.color ??
        theme?.colors.itemColor ??
        MoonColors.light.textSecondary;

    final Color effectiveCurrentItemTextColor =
        widget.currentItemTextStyle?.color ??
            theme?.colors.currentItemColor ??
            MoonColors.light.textPrimary;

    final Color effectiveHoverEffectColor = widget.hoverEffectColor ??
        theme?.colors.hoverEffectColor ??
        MoonColors.light.textPrimary;

    final TextStyle effectiveItemTextStyle = widget.itemTextStyle ??
        theme?.properties.itemTextStyle ??
        MoonTextStyles.body.textDefault;

    final TextStyle effectiveCurrentItemTextStyle =
        widget.currentItemTextStyle ??
            theme?.properties.currentItemTextStyle ??
            MoonTextStyles.body.textDefault;

    final TextStyle effectiveShowMoreItemTextStyle =
        theme?.properties.showMoreItemTextStyle ??
            MoonTextStyles.body.textDefault;

    final Duration effectiveTransitionDuration =
        theme?.properties.transitionDuration ??
            MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = theme?.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final int resolvedItemCountToShow =
        _showFullPath ? widget.items.length : widget.visibleItemCount;

    final List<MoonBreadcrumbItem> visibleItemsList = _getVisibleItems();

    final List<Widget> customizedVisibleItemsList = visibleItemsList.map(
      (MoonBreadcrumbItem item) {
        return Row(
          children: [
            if (item != visibleItemsList.first) SizedBox(width: effectiveGap),
            _BreadcrumbItemBuilder(
              isCurrent: item == visibleItemsList.last,
              itemColor: effectiveItemTextColor,
              currentItemColor: effectiveCurrentItemTextColor,
              hoverEffectColor: effectiveHoverEffectColor,
              decoration: widget.itemDecoration,
              itemTextStyle: effectiveItemTextStyle,
              currentItemTextStyle: effectiveCurrentItemTextStyle,
              transitionDuration: effectiveTransitionDuration,
              transitionCurve: effectiveTransitionCurve,
              onTap: item.onTap,
              item: item,
            ),
            if (item != visibleItemsList.last) ...[
              SizedBox(width: effectiveGap),
              _buildDivider(),
            ],
          ],
        );
      },
    ).toList();

    if (widget.items.length > resolvedItemCountToShow &&
        resolvedItemCountToShow > 1) {
      customizedVisibleItemsList.insert(
        1,
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: effectiveGap),
              child: _BreadcrumbItemBuilder(
                isCurrent: false,
                itemColor: effectiveItemTextColor,
                currentItemColor: effectiveCurrentItemTextColor,
                hoverEffectColor: effectiveHoverEffectColor,
                decoration: widget.itemDecoration,
                itemTextStyle: effectiveItemTextStyle,
                currentItemTextStyle: effectiveCurrentItemTextStyle,
                transitionDuration: effectiveTransitionDuration,
                transitionCurve: effectiveTransitionCurve,
                onTap: widget.showMoreWidget?.onTap ??
                    () => setState(() => _showFullPath = true),
                item: widget.showMoreWidget ??
                    MoonBreadcrumbItem(
                      semanticLabel: widget.semanticLabel,
                      label: SizedBox(
                        width: 24,
                        child: Text(
                          '...',
                          textAlign: TextAlign.center,
                          style: effectiveShowMoreItemTextStyle,
                        ),
                      ),
                    ),
              ),
            ),
            _buildDivider(),
          ],
        ),
      );
    }

    // Restores the breadcrumb's initial collapsed state during every rebuild.
    _showFullPath = false;

    return customizedVisibleItemsList;
  }

  List<MoonBreadcrumbItem> _getVisibleItems() {
    final int resolvedItemCountToShow =
        _showFullPath ? widget.items.length : widget.visibleItemCount;

    final List<MoonBreadcrumbItem> visibleItems = resolvedItemCountToShow == 0
        ? []
        : widget.items.length > resolvedItemCountToShow
            ? [
                widget.items[0],
                ...List.generate(
                  resolvedItemCountToShow - 1,
                  (index) => widget.items.length - index,
                ).reversed.map((int index) => widget.items[index - 1]),
              ]
            : widget.items;

    return visibleItems;
  }

  Widget _buildDivider() {
    final Color effectiveDividerColor = widget.dividerColor ??
        widget.itemTextStyle?.color ??
        context.moonTheme?.breadcrumbTheme.colors.itemColor ??
        MoonColors.light.iconSecondary;

    return IconTheme(
      data: IconThemeData(color: effectiveDividerColor),
      child: widget.divider ??
          Icon(
            Directionality.of(context) == TextDirection.ltr
                ? MoonIcons.arrows_right_24_light
                : MoonIcons.arrows_left_24_light,
            size: 24,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: widget.padding,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildItems(),
      ),
    );
  }
}

class _BreadcrumbItemBuilder extends StatefulWidget {
  final bool isCurrent;
  final Color itemColor;
  final Color currentItemColor;
  final Color hoverEffectColor;
  final BoxDecoration? decoration;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final TextStyle itemTextStyle;
  final TextStyle currentItemTextStyle;
  final VoidCallback? onTap;
  final MoonBreadcrumbItem item;

  const _BreadcrumbItemBuilder({
    required this.isCurrent,
    required this.itemColor,
    required this.currentItemColor,
    required this.hoverEffectColor,
    required this.decoration,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.itemTextStyle,
    required this.currentItemTextStyle,
    required this.item,
    required this.onTap,
  });

  @override
  State<_BreadcrumbItemBuilder> createState() => _BreadCrumbItemBuilderState();
}

class _BreadCrumbItemBuilderState extends State<_BreadcrumbItemBuilder>
    with SingleTickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _itemColorTween =
      ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _itemColor;

  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) => isActive
      ? _animationController?.forward()
      : _animationController?.reverse();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
      value: widget.isCurrent ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double effectiveGap = widget.item.gap ??
        context.moonTheme?.breadcrumbTheme.properties.itemGap ??
        MoonSizes.sizes.x6s;

    final Color resolvedItemColor =
        widget.isCurrent ? widget.currentItemColor : widget.itemColor;

    final Color resolvedHoverEffectColor =
        widget.isCurrent ? widget.currentItemColor : widget.hoverEffectColor;

    final TextStyle resolvedTextStyle =
        widget.isCurrent ? widget.currentItemTextStyle : widget.itemTextStyle;

    _itemColor ??= _animationController!.drive(
      _itemColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _itemColorTween
      ..begin = resolvedItemColor
      ..end = resolvedHoverEffectColor;

    return MoonBaseControl(
      semanticLabel: widget.item.semanticLabel,
      backgroundColor: widget.decoration?.color,
      borderRadius: widget.decoration?.borderRadius,
      propagateGesturesToChild: true,
      onTap: widget.onTap,
      builder: (
        BuildContext context,
        bool isEnabled,
        bool isHovered,
        bool isFocused,
        bool isPressed,
      ) {
        final bool isActive =
            isEnabled && (widget.isCurrent || isHovered || isPressed);

        _handleActiveEffect(isActive);

        return AnimatedBuilder(
          animation: _animationController!,
          builder: (BuildContext context, Widget? child) {
            return IconTheme(
              data: IconThemeData(
                color: _itemColor!.value,
              ),
              child: DefaultTextStyle(
                style: resolvedTextStyle.copyWith(color: _itemColor?.value),
                child: child!,
              ),
            );
          },
          child: DecoratedBox(
            decoration: widget.decoration ?? const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.item.leading != null) ...[
                  widget.item.leading!,
                  SizedBox(width: widget.item.gap ?? effectiveGap),
                ],
                widget.item.label,
                if (widget.item.trailing != null) ...[
                  SizedBox(width: widget.item.gap ?? effectiveGap),
                  widget.item.trailing!,
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
