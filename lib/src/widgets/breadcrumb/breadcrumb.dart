import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/breadcrumb/breadcrumb_theme.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

class MoonBreadcrumb extends StatelessWidget {
  /// The MoonBreadcrumb expanded menu background color.
  final Color? menuBackgroundColor;

  /// The text color when MoonBreadcrumb item is hovered.
  final Color? hoverTextColor;

  /// The gap between divider and MoonBreadcrumb item.
  final double? gap;

  /// The MoonBreadcrumb expanded menu max height.
  final double? menuMaxHeight;

  /// The padding around MoonBreadcrumb.
  final EdgeInsetsGeometry? padding;

  /// The count of items to show in MoonBreadcrumb.
  final int? itemsToShow;

  /// The text style of the MoonBreadcrumb item.
  final TextStyle? itemTextStyle;

  /// The current MoonBreadcrumb item text style.
  final TextStyle? currentItemTextStyle;

  /// The MoonBreadcrumb expanded menu item text style.
  final TextStyle? menuItemTextStyle;

  /// The items to display as sequence of steps.
  final List<BreadcrumbItem> items;

  /// The widget to display between items.
  final Widget? divider;

  const MoonBreadcrumb({
    super.key,
    this.menuBackgroundColor,
    this.hoverTextColor,
    this.gap,
    this.menuMaxHeight,
    this.padding,
    this.itemsToShow,
    this.itemTextStyle,
    this.currentItemTextStyle,
    this.menuItemTextStyle,
    required this.items,
    this.divider,
  });

  Widget _buildDivider(BuildContext context) {
    final Color effectiveDividerColor =
        itemTextStyle?.color ?? context.moonTheme?.breadcrumbTheme.colors.textColor ?? MoonColors.light.trunks;

    return IconTheme(
      data: IconThemeData(color: effectiveDividerColor),
      child: divider ?? const Icon(MoonIcons.arrows_right_24_light, size: 24),
    );
  }

  List<Widget> _generateItemsWidgets(
    List<BreadcrumbItem> actualItems,
    BuildContext context,
  ) {
    final MoonBreadcrumbTheme? theme = context.moonTheme?.breadcrumbTheme;

    final double effectiveGap = gap ?? theme?.properties.gap ?? MoonSizes.sizes.x4s;

    final Color effectiveHoveredTextColor = hoverTextColor ?? theme?.colors.hoverTextColor ?? MoonColors.light.bulma;

    final Color effectiveCurrentItemTextColor =
        currentItemTextStyle?.color ?? theme?.colors.currentItemTextColor ?? MoonColors.light.textPrimary;

    final TextStyle effectiveItemTextStyle =
        itemTextStyle ?? theme?.properties.itemTextStyle ?? MoonTextStyles.body.textDefault;

    final TextStyle effectiveCurrentItemTextStyle =
        currentItemTextStyle ?? theme?.properties.currentItemTextStyle ?? MoonTextStyles.body.textDefault;

    final Duration effectiveTransitionDuration =
        theme?.properties.transitionDuration ?? MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve =
        theme?.properties.transitionCurve ?? MoonTransitions.transitions.defaultTransitionCurve;

    final Color effectiveTextColor = itemTextStyle?.color ?? theme?.colors.textColor ?? MoonColors.light.trunks;

    final Widget divider = _buildDivider(context);

    return actualItems
        .map(
          (BreadcrumbItem item) => Row(
            children: [
              if (item != actualItems.first) SizedBox(width: effectiveGap),
              _BreadcrumbItemBuilder(
                isCurrent: item == actualItems.last,
                transitionDuration: effectiveTransitionDuration,
                transitionCurve: effectiveTransitionCurve,
                item: item,
                onPressed: item.onPressed,
                hoveredTextColor: effectiveHoveredTextColor,
                currentItemTextColor: effectiveCurrentItemTextColor,
                itemTextStyle: effectiveItemTextStyle,
                currentItemTextStyle: effectiveCurrentItemTextStyle,
                textColor: effectiveTextColor,
              ),
              if (item != actualItems.last) ...[
                SizedBox(width: effectiveGap),
                divider,
              ],
            ],
          ),
        )
        .toList();
  }

  List<BreadcrumbItem> _generateActualItems(List<BreadcrumbItem> items, int effectiveItemsToShow) {
    final int itemsLength = items.length;

    final List<BreadcrumbItem> actualItems = itemsLength > effectiveItemsToShow
        ? [
            items[0],
            ...List.generate(effectiveItemsToShow - 1, (index) => itemsLength - index)
                .reversed
                .map((int index) => items[index - 1]),
          ]
        : items;
    return actualItems;
  }

  List<Widget> _addShowMoreButton({
    required BuildContext context,
    required int itemsToShow,
    required List<Widget> itemsWidgets,
  }) {
    final MoonBreadcrumbTheme? theme = context.moonTheme?.breadcrumbTheme;

    final double effectiveMenuMaxHeight = menuMaxHeight ?? theme?.properties.menuMaxHeight ?? 300;

    final Color effectiveMenuBackgroundColor =
        menuBackgroundColor ?? theme?.colors.menuBackgroundColor ?? MoonColors.light.goku;

    return itemsWidgets
      ..insert(
        1,
        Row(
          children: [
            _ShowMoreButton(
              items: items.sublist(1, items.length - itemsToShow + 1),
              menuMaxHeight: effectiveMenuMaxHeight,
              menuItemTextStyle: menuItemTextStyle,
              menuBackgroundColor: effectiveMenuBackgroundColor,
            ),
            _buildDivider(context),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final MoonBreadcrumbTheme? theme = context.moonTheme?.breadcrumbTheme;

    final EdgeInsetsGeometry effectivePadding = padding ?? theme?.properties.padding ?? EdgeInsets.zero;

    final int itemsLength = items.length;

    final int effectiveItemsToShow = max(2, itemsToShow ?? 3);

    final List<BreadcrumbItem> actualItems = _generateActualItems(items, effectiveItemsToShow);

    List<Widget> itemsWidgets = _generateItemsWidgets(actualItems, context);

    if (itemsLength > effectiveItemsToShow) {
      itemsWidgets =
          _addShowMoreButton(context: context, itemsWidgets: itemsWidgets, itemsToShow: effectiveItemsToShow);
    }

    return Padding(
      padding: effectivePadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: itemsWidgets,
      ),
    );
  }
}

class _ShowMoreButton extends StatefulWidget {
  final double menuMaxHeight;

  final TextStyle? menuItemTextStyle;

  final Color menuBackgroundColor;

  final List<BreadcrumbItem> items;

  const _ShowMoreButton({
    required this.items,
    required this.menuMaxHeight,
    required this.menuItemTextStyle,
    required this.menuBackgroundColor,
  });
  @override
  State<_ShowMoreButton> createState() => _ShowMoreButtonState();
}

class _ShowMoreButtonState extends State<_ShowMoreButton> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final MoonBreadcrumbTheme? theme = context.moonTheme?.breadcrumbTheme;

    final TextStyle effectiveMenuItemTextStyle =
        widget.menuItemTextStyle ?? theme?.properties.menuItemTextStyle ?? MoonTextStyles.body.textDefault;

    final Color effectiveMenuItemTextColor =
        widget.menuItemTextStyle?.color ?? theme?.colors.menuItemTextColor ?? MoonColors.light.textPrimary;

    return MoonPopover(
      popoverPosition: MoonPopoverPosition.bottom,
      contentPadding: const EdgeInsets.all(4),
      show: show,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.menuMaxHeight),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: widget.items
              .map(
                (BreadcrumbItem item) => MoonMenuItem(
                  label: DefaultTextStyle(
                    style: effectiveMenuItemTextStyle.copyWith(color: effectiveMenuItemTextColor),
                    child: item.label ?? Container(),
                  ),
                  leading: item.leading,
                  onTap: item.onPressed,
                  backgroundColor: widget.menuBackgroundColor,
                ),
              )
              .toList(),
        ),
      ),
      onTapOutside: () => setState(() => show = false),
      child: MoonButton(
        padding: EdgeInsets.zero,
        label: const Text('...'),
        gap: 0,
        onTap: () => setState(() => show = !show),
      ),
    );
  }
}

class _BreadcrumbItemBuilder extends StatefulWidget {
  final bool isCurrent;

  final Duration transitionDuration;

  final Curve transitionCurve;

  final BreadcrumbItem item;

  final TextStyle currentItemTextStyle;

  final TextStyle itemTextStyle;

  final VoidCallback? onPressed;

  final Color textColor;

  final Color currentItemTextColor;

  final Color hoveredTextColor;

  const _BreadcrumbItemBuilder({
    required this.isCurrent,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.item,
    required this.onPressed,
    required this.currentItemTextStyle,
    required this.itemTextStyle,
    required this.currentItemTextColor,
    required this.textColor,
    required this.hoveredTextColor,
  });

  @override
  State<_BreadcrumbItemBuilder> createState() => _BreadCrumbItemBuilderState();
}

class _BreadCrumbItemBuilderState extends State<_BreadcrumbItemBuilder> with SingleTickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _textColorTween = ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _textColor;

  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) {
    isActive ? _animationController?.forward() : _animationController?.reverse();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: widget.transitionDuration, vsync: this);

    if (widget.isCurrent) _animationController?.value = 1;
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveTextStyle = widget.isCurrent ? widget.currentItemTextStyle : widget.itemTextStyle;

    final Color effectiveTextColor = widget.isCurrent ? (widget.currentItemTextColor) : widget.textColor;

    final Color effectiveHoveredTextColor = widget.isCurrent ? (widget.currentItemTextColor) : widget.hoveredTextColor;

    _textColor ??= _animationController!.drive(
      _textColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveHoveredTextColor;

    return MoonBaseControl(
      disabledOpacityValue: 1,
      onTap: widget.onPressed,
      semanticLabel: widget.item.semanticLabel,
      builder: (
        BuildContext context,
        bool isEnabled,
        bool isHovered,
        bool isFocused,
        bool isPressed,
      ) {
        final bool isActive = isEnabled && (widget.isCurrent || isHovered || isPressed);

        _handleActiveEffect(isActive);

        return AnimatedBuilder(
          animation: _animationController!,
          builder: (BuildContext context, Widget? child) {
            return IconTheme(
              data: IconThemeData(
                color: _textColor!.value,
              ),
              child: DefaultTextStyle(
                style: effectiveTextStyle.copyWith(color: _textColor?.value),
                child: child!,
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.item.leading != null) widget.item.leading!,
              if (widget.item.label != null) widget.item.label!,
            ],
          ),
        );
      },
    );
  }
}
