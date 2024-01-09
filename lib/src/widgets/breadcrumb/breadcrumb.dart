import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/breadcrumb/breadcrumb_theme.dart';

class MoonBreadcrumb extends StatelessWidget {
  const MoonBreadcrumb({
    required this.items,
    super.key,
    this.divider,
    this.gap,
    this.itemTextStyle,
    this.textColor,
    this.hoverTextColor,
    this.padding,
    this.maxItems = 3,
    TextStyle? currentItemTextStyle,
    Color? currentItemTextColor,
  })  : currentItemTextColor = currentItemTextColor ?? textColor,
        currentItemTextStyle = currentItemTextStyle ?? itemTextStyle;

  /// Widget to display between items.
  final Widget? divider;

  /// The gap between divider and BreadcrumbItem.
  final double? gap;

  /// Items to display as syquence of steps.
  final List<BreadcrumbItem> items;

  /// Amount of items to display in Breadcrumb.
  final int maxItems;

  /// The text style of the segment.
  final TextStyle? itemTextStyle;

  /// Current item text style.
  final TextStyle? currentItemTextStyle;

  /// Text color of breadcrumb item.
  final Color? textColor;

  /// Text color when breadcrumb item hovered.
  final Color? hoverTextColor;

  /// Text color of current breadcrumb item.
  final Color? currentItemTextColor;

  /// Padding around Breadcrumb.
  final EdgeInsetsGeometry? padding;

  Widget _buildDivider(MoonBreadcrumbTheme theme) {
    return IconTheme(
      data: IconThemeData(
        color: theme.colors.textColor,
      ),
      child: divider ??
          Icon(
            theme.properties.dividerIcon,
            size: 24,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.moonTheme?.breadcrumbTheme ?? MoonBreadcrumbTheme(tokens: MoonTokens.light);
    final effectiveGap = gap ?? theme.properties.gap;
    final effectiveTheme = theme.copyWith(
      properties: theme.properties.copyWith(
        itemTextStyle: itemTextStyle,
        currentItemTextStyle: currentItemTextStyle,
      ),
      colors: theme.colors.copyWith(
        textColor: itemTextStyle?.color ?? textColor,
        hoverTextColor: hoverTextColor,
        currentItemTextColor: currentItemTextColor,
      ),
    );

    final divider = _buildDivider(effectiveTheme);
    final itemsLength = items.length;

    final effectivemaxItems = max(2, maxItems);
    final actualItems = itemsLength > effectivemaxItems
        ? [
            items[0],
            ...List.generate(effectivemaxItems - 1, (index) => itemsLength - index)
                .reversed
                .map((index) => items[index - 1]),
          ]
        : items;

    final itemsWidgets = actualItems
        .map(
          (item) => Row(
            children: [
              if (item != actualItems.first) SizedBox(width: effectiveGap),
              _BreadcrumbItemBuilder(
                isCurrent: item == actualItems.last,
                transitionDuration: const Duration(milliseconds: 200),
                transitionCurve: Curves.easeInOut,
                item: item,
                theme: effectiveTheme,
                onPressed: item.onPressed,
              ),
              if (item != actualItems.last) ...[
                SizedBox(width: effectiveGap),
                divider,
              ],
            ],
          ),
        )
        .toList();
    if (itemsLength > effectivemaxItems) {
      itemsWidgets.insert(
        1,
        Row(
          children: [
            _MoreButton(
              items: items.sublist(1, items.length - effectivemaxItems + 1),
              theme: effectiveTheme,
            ),
            divider,
          ],
        ),
      );
    }
    return Padding(
      padding: theme.properties.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: itemsWidgets,
      ),
    );
  }
}

class _MoreButton extends StatefulWidget {
  final List<BreadcrumbItem> items;
  final MoonBreadcrumbTheme theme;

  const _MoreButton({required this.items, required this.theme});
  @override
  State<_MoreButton> createState() => _MoreButtonState();
}

class _MoreButtonState extends State<_MoreButton> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return MoonPopover(
      popoverPosition: MoonPopoverPosition.bottom,
      contentPadding: const EdgeInsets.all(4),
      show: show,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.theme.properties.menuMaxHeight),
        child: SingleChildScrollView(
          child: Column(
            children: widget.items
                .map(
                  (item) => MoonMenuItem(
                    title: DefaultTextStyle(
                      style: widget.theme.properties.menuItemTextStyle,
                      child: item.label ?? Container(),
                    ),
                    leading: item.leading,
                    onTap: item.onPressed,
                    backgroundColor: widget.theme.colors.menuBackgroundColor,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      onTapOutside: () => setState(() => show = false),
      child: MoonButton(
        padding: EdgeInsets.zero,
        label: const Text('...'),
        gap: 0,
        onTap: () {
          setState(() => show = !show);
        },
      ),
    );
  }
}

class _BreadcrumbItemBuilder extends StatefulWidget {
  final bool isCurrent;
  final Duration transitionDuration;
  final Curve transitionCurve;

  final BreadcrumbItem item;
  final MoonBreadcrumbTheme theme;
  final VoidCallback? onPressed;

  const _BreadcrumbItemBuilder({
    required this.isCurrent,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.item,
    required this.theme,
    required this.onPressed,
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
    final TextStyle effectiveTextStyle =
        widget.isCurrent ? widget.theme.properties.currentItemTextStyle : widget.theme.properties.itemTextStyle;

    final Color effectiveTextColor = widget.isCurrent
        ? (widget.theme.colors.currentItemTextColor ?? widget.theme.colors.textColor)
        : widget.theme.colors.textColor;

    final Color effectiveHoveredTextColor = widget.isCurrent
        ? (widget.theme.colors.currentItemTextColor ?? widget.theme.colors.textColor)
        : widget.theme.colors.hoverTextColor ?? widget.theme.colors.textColor;

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
