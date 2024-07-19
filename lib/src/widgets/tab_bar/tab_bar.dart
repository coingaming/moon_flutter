import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tab_bar/tab_bar_size_properties.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_design/src/widgets/common/base_segmented_tab_bar.dart';
import 'package:moon_design/src/widgets/tab_bar/pill_tab.dart';
import 'package:moon_design/src/widgets/tab_bar/pill_tab_style.dart';
import 'package:moon_design/src/widgets/tab_bar/tab.dart';
import 'package:moon_design/src/widgets/tab_bar/tab_style.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonTabBarVariant {
  indicator,
  pill,
  custom,
}

enum MoonTabBarSize {
  sm,
  md,
}

typedef MoonCustomTabBuilder = Widget Function(
  BuildContext context,
  bool isSelected,
);

class MoonTabBar extends StatefulWidget {
  /// Whether the tab bar is expanded to its full available width horizontally
  /// or resizes to fit its content.
  final bool isExpanded;

  /// The gap between the tab bar tabs.
  final double? gap;

  /// The height of the tab bar.
  final double? height;

  /// The width of the tab bar.
  final double? width;

  /// The duration of the tab bar transition animation.
  final Duration? transitionDuration;

  /// The curve of the tab bar transition animation.
  final Curve? transitionCurve;

  /// The padding of the tab bar.
  final EdgeInsetsGeometry? padding;

  /// The index of the initially selected tab.
  /// This property is overridden by the [tabController]'s initial index if
  /// the [tabController] is provided.
  /// For external updates to the tab index, use [tabController].
  final int initialIndex;

  /// The size of the tab bar.
  final MoonTabBarSize? tabBarSize;

  /// The custom decoration of the tab bar.
  final Decoration? decoration;

  /// The external controller for managing tab selection and animation in tab bar.
  /// If tabController is provided, then [initialIndex] is ignored and
  /// tabController's index is used instead.
  final TabController? tabController;

  /// The callback that returns the index of the currently selected tab.
  final ValueChanged<int>? onTabChanged;

  /// The list of tabs to display as the children of the tab bar.
  /// At least one child is required when this property is used.
  /// This property cannot be used in conjunction with the [pillTabs] or
  /// [customTabs] properties; both must be set to null.
  final List<MoonTab>? tabs;

  /// The list of pill tabs to display as the children of the pill tab bar.
  /// At least one child is required when this property is used.
  /// This property cannot be used in conjunction with the [tabs] or [customTabs]
  /// properties; both must be set to null.
  final List<MoonPillTab>? pillTabs;

  /// The list of custom tabs to display as the children of the custom tab bar.
  /// At least one child is required when this property is used.
  /// This property cannot be used in conjunction with the [tabs] or [pillTabs]
  /// properties; both must be set to null.
  final List<MoonCustomTabBuilder>? customTabs;

  /// Creates a Moon Design tab bar.
  ///
  /// See also:
  ///
  ///   * [MoonTabBar.pill], Moon Design pill tab bar.
  ///   * [MoonTabBar.custom], Moon Design custom tab bar.
  const MoonTabBar({
    super.key,
    this.isExpanded = false,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.initialIndex = 0,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.tabs,
  })  : assert(height == null || height > 0),
        assert(tabs != null && tabs.length > 0),
        pillTabs = null,
        customTabs = null;

  /// Creates a Moon Design pill tab bar.
  ///
  /// See also:
  ///
  ///   * [MoonTabBar.custom], Moon Design custom tab bar.
  const MoonTabBar.pill({
    super.key,
    this.isExpanded = false,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.initialIndex = 0,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.pillTabs,
  })  : assert(height == null || height > 0),
        assert(pillTabs != null && pillTabs.length > 0),
        tabs = null,
        customTabs = null;

  /// Creates a Moon Design custom tab bar.
  ///
  /// See also:
  ///
  ///   * [MoonTabBar.pill], Moon Design pill tab bar.
  const MoonTabBar.custom({
    super.key,
    this.isExpanded = false,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.initialIndex = 0,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.customTabs,
  })  : assert(height == null || height > 0),
        assert(customTabs != null && customTabs.length > 0),
        tabs = null,
        pillTabs = null;

  @override
  State<MoonTabBar> createState() => _MoonTabBarState();
}

class _MoonTabBarState extends State<MoonTabBar> {
  late int _selectedIndex = widget.tabController?.index ?? widget.initialIndex;
  late MoonTabBarVariant _tabBarVariant;

  late Duration _effectiveTransitionDuration;
  late Curve _effectiveTransitionCurve;
  late MoonTabBarSizeProperties _effectiveMoonTabBarSize;

  MoonTabBarSizeProperties _getMoonTabBarSize(
    BuildContext context,
    MoonTabBarSize? tabBarSize,
  ) {
    switch (tabBarSize) {
      case MoonTabBarSize.sm:
        return context.moonTheme?.tabBarTheme.sizes.sm ??
            MoonTabBarSizes(tokens: MoonTokens.light).sm;
      case MoonTabBarSize.md:
        return context.moonTheme?.tabBarTheme.sizes.md ??
            MoonTabBarSizes(tokens: MoonTokens.light).md;
      default:
        return context.moonTheme?.tabBarTheme.sizes.md ??
            MoonTabBarSizes(tokens: MoonTokens.light).md;
    }
  }

  void _setSelectedTabBarVariant() {
    if (widget.tabs != null) {
      _tabBarVariant = MoonTabBarVariant.indicator;
    } else if (widget.pillTabs != null) {
      _tabBarVariant = MoonTabBarVariant.pill;
    } else {
      _tabBarVariant = MoonTabBarVariant.custom;
    }
  }

  void _updateTabsSelectedStatus() {
    if (_tabBarVariant == MoonTabBarVariant.indicator) {
      widget.tabs?.asMap().forEach((int index, MoonTab tab) {
        tab.isSelected?.call(index == _selectedIndex);
      });
    } else if (_tabBarVariant == MoonTabBarVariant.pill) {
      widget.pillTabs?.asMap().forEach((int index, MoonPillTab pillTab) {
        pillTab.isSelected?.call(index == _selectedIndex);
      });
    } else {
      widget.customTabs
          ?.asMap()
          .forEach((int index, Widget Function(BuildContext, bool) customTab) {
        customTab.call(context, index == _selectedIndex);
      });
    }
  }

  void _handleTabChange() {
    final int animationValue =
        widget.tabController?.animation?.value.round() ?? 0;

    if (animationValue != _selectedIndex) {
      setState(() {
        _selectedIndex = animationValue;

        widget.onTabChanged?.call(animationValue);
        _updateTabsSelectedStatus();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _setSelectedTabBarVariant();
    _updateTabsSelectedStatus();

    widget.tabController?.animation?.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    super.dispose();

    widget.tabController?.animation?.removeListener(_handleTabChange);
  }

  List<Widget> _generateTabs() {
    switch (_tabBarVariant) {
      case MoonTabBarVariant.indicator:
        return _generateIndicatorTabs();
      case MoonTabBarVariant.pill:
        return _generatePillTabs();
      default:
        return _generateCustomTabs();
    }
  }

  List<Widget> _generateIndicatorTabs() {
    return List.generate(
      widget.tabs!.length,
      (int index) {
        return _IndicatorTabBuilder(
          transitionDuration: _effectiveTransitionDuration,
          transitionCurve: _effectiveTransitionCurve,
          isSelected: index == _selectedIndex,
          moonTabBarSizeProperties: _effectiveMoonTabBarSize,
          tab: widget.tabs![index],
        );
      },
    );
  }

  List<Widget> _generatePillTabs() {
    return List.generate(
      widget.pillTabs!.length,
      (int index) {
        return _PillTabBuilder(
          transitionDuration: _effectiveTransitionDuration,
          transitionCurve: _effectiveTransitionCurve,
          isSelected: index == _selectedIndex,
          moonTabBarSizeProperties: _effectiveMoonTabBarSize,
          tab: widget.pillTabs![index],
        );
      },
    );
  }

  List<Widget> _generateCustomTabs() {
    return List.generate(
      widget.customTabs!.length,
      (int index) {
        return widget.customTabs![index](context, index == _selectedIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _effectiveMoonTabBarSize = _getMoonTabBarSize(context, widget.tabBarSize);

    _effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.tabBarTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    _effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.tabBarTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final double effectiveHeight =
        widget.height ?? _effectiveMoonTabBarSize.height;

    final double effectiveGap = widget.gap ??
        context.moonTheme?.tabBarTheme.properties.gap ??
        MoonSizes.sizes.x5s;

    return Container(
      height: effectiveHeight,
      width: widget.width,
      padding: widget.padding,
      decoration: widget.decoration,
      constraints: BoxConstraints(minWidth: effectiveHeight),
      child: BaseSegmentedTabBar(
        gap: effectiveGap,
        isExpanded: widget.isExpanded,
        tabController: widget.tabController,
        valueChanged: (int newIndex) {
          if (_selectedIndex == newIndex) return;
          if (widget.tabs != null && widget.tabs![newIndex].disabled) return;
          if (widget.pillTabs != null && widget.pillTabs![newIndex].disabled) {
            return;
          }

          setState(() {
            _selectedIndex = newIndex;

            if (widget.tabController == null) {
              widget.onTabChanged?.call(newIndex);
              _updateTabsSelectedStatus();
            }
          });
        },
        children: _generateTabs(),
      ),
    );
  }
}

class _IndicatorTabBuilder extends StatefulWidget {
  final bool isSelected;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final MoonTabBarSizeProperties moonTabBarSizeProperties;
  final MoonTab tab;

  const _IndicatorTabBuilder({
    required this.isSelected,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.moonTabBarSizeProperties,
    required this.tab,
  });

  @override
  State<_IndicatorTabBuilder> createState() => _IndicatorTabBuilderState();
}

class _IndicatorTabBuilderState extends State<_IndicatorTabBuilder>
    with SingleTickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _indicatorColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _textColorTween =
      ColorTweenWithPremultipliedAlpha();
  final Tween<double> _indicatorWidthTween = Tween<double>(begin: 0, end: 0);

  Animation<Color?>? _indicatorColor;
  Animation<Color?>? _textColor;
  Animation<double?>? _indicatorWidth;

  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) {
    isActive
        ? _animationController?.forward()
        : _animationController?.reverse();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    if (widget.isSelected) _animationController?.value = 1;
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoonTabStyle? tabStyle = widget.tab.tabStyle;

    final Color effectiveIndicatorColor = tabStyle?.indicatorColor ??
        context.moonTheme?.tabBarTheme.colors.indicatorColor ??
        MoonColors.light.piccolo;

    final Color effectiveTextColor = tabStyle?.textStyle?.color ??
        tabStyle?.textColor ??
        context.moonTheme?.tabBarTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    final Color effectiveSelectedTextColor = tabStyle?.selectedTextColor ??
        context.moonTheme?.tabBarTheme.colors.selectedTextColor ??
        MoonColors.light.piccolo;

    final TextStyle effectiveTextStyle =
        widget.moonTabBarSizeProperties.textStyle.merge(tabStyle?.textStyle);

    final double effectiveIndicatorHeight = tabStyle?.indicatorHeight ??
        widget.moonTabBarSizeProperties.indicatorHeight;

    final double effectiveTabGap =
        tabStyle?.tabGap ?? widget.moonTabBarSizeProperties.tabGap;

    final EdgeInsetsGeometry effectiveTabPadding =
        tabStyle?.tabPadding ?? widget.moonTabBarSizeProperties.tabPadding;

    final EdgeInsets resolvedDirectionalPadding =
        effectiveTabPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedTabPadding = tabStyle?.tabPadding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.tab.leading == null && widget.tab.label != null
                ? resolvedDirectionalPadding.left
                : 0,
            resolvedDirectionalPadding.top,
            widget.tab.trailing == null && widget.tab.label != null
                ? resolvedDirectionalPadding.right
                : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    _indicatorColor ??= _animationController!.drive(
      _indicatorColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _textColor ??= _animationController!.drive(
      _textColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _indicatorWidth ??= _animationController!.drive(
      _indicatorWidthTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _indicatorColorTween.end = effectiveIndicatorColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveSelectedTextColor;

    return MoonBaseControl(
      semanticLabel: widget.tab.semanticLabel,
      onLongPress: widget.tab.disabled ? null : () => {},
      autofocus: widget.tab.autoFocus,
      focusNode: widget.tab.focusNode,
      isFocusable: widget.tab.isFocusable,
      showFocusEffect: widget.tab.showFocusEffect,
      focusEffectColor: tabStyle?.focusEffectColor,
      cursor: widget.isSelected
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      builder: (
        BuildContext context,
        bool isEnabled,
        bool isHovered,
        bool isFocused,
        bool isPressed,
      ) {
        final bool isActive =
            isEnabled && (widget.isSelected || isHovered || isPressed);

        _handleActiveEffect(isActive);

        return Container(
          decoration: tabStyle?.decoration,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animationController!,
                builder: (BuildContext context, Widget? child) {
                  return IconTheme(
                    data: IconThemeData(
                      color: _textColor!.value,
                      size: widget.moonTabBarSizeProperties.iconSizeValue,
                    ),
                    child: DefaultTextStyle(
                      style: effectiveTextStyle.copyWith(
                        color: _textColor!.value,
                      ),
                      child: child!,
                    ),
                  );
                },
                child: Center(
                  child: Padding(
                    padding: correctedTabPadding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.tab.leading != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: effectiveTabGap,
                            ),
                            child: widget.tab.leading,
                          ),
                        if (widget.tab.label != null)
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight:
                                  widget.moonTabBarSizeProperties.iconSizeValue,
                            ),
                            child: Center(child: widget.tab.label),
                          ),
                        if (widget.tab.trailing != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: effectiveTabGap,
                            ),
                            child: widget.tab.trailing,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    _indicatorWidthTween.end = constraints.maxWidth;

                    return Align(
                      alignment: Directionality.of(context) == TextDirection.ltr
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: AnimatedBuilder(
                        animation: _animationController!,
                        builder: (BuildContext context, Widget? child) {
                          return Container(
                            color: effectiveIndicatorColor,
                            height: effectiveIndicatorHeight,
                            width: _indicatorWidth!.value,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PillTabBuilder extends StatefulWidget {
  final bool isSelected;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final MoonTabBarSizeProperties moonTabBarSizeProperties;
  final MoonPillTab tab;

  const _PillTabBuilder({
    required this.isSelected,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.moonTabBarSizeProperties,
    required this.tab,
  });

  @override
  State<_PillTabBuilder> createState() => _PillTabBuilderState();
}

class _PillTabBuilderState extends State<_PillTabBuilder>
    with SingleTickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _tabColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _textColorTween =
      ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _tabColor;
  Animation<Color?>? _textColor;

  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) {
    isActive
        ? _animationController?.forward()
        : _animationController?.reverse();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    if (widget.isSelected) _animationController?.value = 1;
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoonPillTabStyle? tabStyle = widget.tab.tabStyle;

    final BorderRadiusGeometry effectiveTabBorderRadius =
        tabStyle?.borderRadius ?? widget.moonTabBarSizeProperties.borderRadius;

    final Color effectiveSelectedTabColor = tabStyle?.selectedTabColor ??
        context.moonTheme?.tabBarTheme.colors.selectedPillTabColor ??
        MoonColors.light.goku;

    final Color effectiveTextColor = tabStyle?.textStyle?.color ??
        tabStyle?.textColor ??
        context.moonTheme?.tabBarTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    final Color effectiveSelectedTextColor = tabStyle?.selectedTextColor ??
        context.moonTheme?.tabBarTheme.colors.selectedPillTextColor ??
        MoonColors.light.textPrimary;

    final TextStyle effectiveTextStyle =
        widget.moonTabBarSizeProperties.textStyle.merge(tabStyle?.textStyle);

    final double effectiveTabGap =
        tabStyle?.tabGap ?? widget.moonTabBarSizeProperties.tabGap;

    final EdgeInsetsGeometry effectiveTabPadding =
        tabStyle?.tabPadding ?? widget.moonTabBarSizeProperties.tabPadding;

    final EdgeInsets resolvedDirectionalPadding =
        effectiveTabPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedTabPadding = tabStyle?.tabPadding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.tab.leading == null && widget.tab.label != null
                ? resolvedDirectionalPadding.left
                : 0,
            resolvedDirectionalPadding.top,
            widget.tab.trailing == null && widget.tab.label != null
                ? resolvedDirectionalPadding.right
                : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    _tabColor ??= _animationController!.drive(
      _tabColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _textColor ??= _animationController!.drive(
      _textColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _tabColorTween.end = effectiveSelectedTabColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveSelectedTextColor;

    return MoonBaseControl(
      semanticLabel: widget.tab.semanticLabel,
      onLongPress: widget.tab.disabled ? null : () => {},
      autofocus: widget.tab.autoFocus,
      focusNode: widget.tab.focusNode,
      isFocusable: widget.tab.isFocusable,
      showFocusEffect: widget.tab.showFocusEffect,
      focusEffectColor: tabStyle?.focusEffectColor,
      borderRadius: effectiveTabBorderRadius.squircleBorderRadius(context),
      cursor: widget.isSelected
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      builder: (
        BuildContext context,
        bool isEnabled,
        bool isHovered,
        bool isFocused,
        bool isPressed,
      ) {
        final bool isActive =
            isEnabled && (widget.isSelected || isHovered || isPressed);

        _handleActiveEffect(isActive);

        return AnimatedBuilder(
          animation: _animationController!,
          builder: (BuildContext context, Widget? child) {
            return DecoratedBox(
              decoration: tabStyle?.decoration ??
                  ShapeDecoration(
                    color: _tabColor!.value,
                    shape: MoonSquircleBorder(
                      borderRadius: effectiveTabBorderRadius
                          .squircleBorderRadius(context),
                    ),
                  ),
              child: IconTheme(
                data: IconThemeData(
                  size: widget.moonTabBarSizeProperties.iconSizeValue,
                  color: _textColor!.value,
                ),
                child: DefaultTextStyle(
                  style: effectiveTextStyle.copyWith(color: _textColor!.value),
                  child: child!,
                ),
              ),
            );
          },
          child: Center(
            child: Padding(
              padding: correctedTabPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.tab.leading != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: effectiveTabGap,
                      ),
                      child: widget.tab.leading,
                    ),
                  if (widget.tab.label != null) widget.tab.label!,
                  if (widget.tab.trailing != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: effectiveTabGap,
                      ),
                      child: widget.tab.trailing,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
