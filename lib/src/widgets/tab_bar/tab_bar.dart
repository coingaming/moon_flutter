import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/animated_icon_theme.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_design/src/widgets/common/base_segmented_tab_bar.dart';
import 'package:moon_design/src/widgets/tab_bar/pill_tab.dart';
import 'package:moon_design/src/widgets/tab_bar/pill_tab_style.dart';
import 'package:moon_design/src/widgets/tab_bar/tab.dart';
import 'package:moon_design/src/widgets/tab_bar/tab_style.dart';

enum MoonTabBarVariant {
  indicator,
  pill,
  custom,
}

enum MoonTabBarSize {
  sm,
  md,
}

typedef MoonCustomTabBuilder = Widget Function(BuildContext context, bool isSelected);

class MoonTabBar extends StatefulWidget {
  /// Controls whether MoonTabBar is expanded and takes up all available space horizontally.
  final bool isExpanded;

  /// The gap between MoonTabBar children.
  final double? gap;

  /// The height of the MoonTabBar.
  final double? height;

  /// The width of the MoonTabBar.
  final double? width;

  /// Transition duration of MoonTabBar.
  final Duration? transitionDuration;

  /// Transition curve of MoonTabBar.
  final Curve? transitionCurve;

  /// The padding of the MoonTabBar.
  final EdgeInsetsGeometry? padding;

  /// The index of initially selected tab.
  final int selectedIndex;

  /// The size of the MoonTabBar.
  final MoonTabBarSize? tabBarSize;

  /// Custom decoration of the MoonTabBar.
  final Decoration? decoration;

  /// Controller of MoonTabBar selection and animation state.
  final TabController? tabController;

  /// Callback that returns current selected tab index.
  final ValueChanged<int>? onTabChanged;

  /// The children of MoonTabBar. At least one child is required.
  final List<MoonTab>? tabs;

  /// The children of pill MoonTabBar. At least one child is required.
  final List<MoonPillTab>? pillTabs;

  /// The children of custom MoonTabBar. At least one child is required.
  final List<MoonCustomTabBuilder>? customTabs;

  /// MDS TabBar widget.
  const MoonTabBar({
    super.key,
    this.isExpanded = false,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.selectedIndex = 0,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.tabs,
  })  : assert(height == null || height > 0),
        assert(tabs != null && tabs.length > 0),
        pillTabs = null,
        customTabs = null;

  /// MDS pill TabBar widget.
  const MoonTabBar.pill({
    super.key,
    this.isExpanded = false,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.selectedIndex = 0,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.pillTabs,
  })  : assert(height == null || height > 0),
        assert(pillTabs != null && pillTabs.length > 0),
        tabs = null,
        customTabs = null;

  /// MDS custom TabBar widget.
  const MoonTabBar.custom({
    super.key,
    this.isExpanded = false,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.selectedIndex = 0,
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
  late int _selectedIndex = widget.selectedIndex;
  late MoonTabBarVariant _tabBarVariant;

  late Duration _effectiveTransitionDuration;
  late Curve _effectiveTransitionCurve;
  late MoonTabBarSizeProperties _effectiveMoonTabBarSize;

  MoonTabBarSizeProperties _getMoonTabBarSize(BuildContext context, MoonTabBarSize? tabBarSize) {
    switch (tabBarSize) {
      case MoonTabBarSize.sm:
        return context.moonTheme?.tabBarTheme.sizes.sm ?? MoonTabBarSizeProperties.sm;
      case MoonTabBarSize.md:
        return context.moonTheme?.tabBarTheme.sizes.md ?? MoonTabBarSizeProperties.md;
      default:
        return context.moonTheme?.tabBarTheme.sizes.md ?? MoonTabBarSizeProperties.md;
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
      widget.customTabs?.asMap().forEach((int index, Widget Function(BuildContext, bool) customTab) {
        customTab.call(context, index == _selectedIndex);
      });
    }
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

  @override
  void initState() {
    super.initState();

    _setSelectedTabBarVariant();
    _updateTabsSelectedStatus();
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
        const Duration(milliseconds: 200);

    _effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.tabBarTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final double effectiveHeight = widget.height ?? _effectiveMoonTabBarSize.height;

    final double effectiveGap = widget.gap ?? context.moonTheme?.tabBarTheme.properties.gap ?? MoonSizes.sizes.x5s;

    return AnimatedContainer(
      height: effectiveHeight,
      width: widget.width,
      padding: widget.padding,
      decoration: widget.decoration,
      duration: _effectiveTransitionDuration,
      curve: _effectiveTransitionCurve,
      constraints: BoxConstraints(minWidth: effectiveHeight),
      child: BaseSegmentedTabBar(
        gap: effectiveGap,
        isExpanded: widget.isExpanded,
        selectedIndex: widget.selectedIndex,
        tabController: widget.tabController,
        children: _generateTabs(),
        valueChanged: (int newIndex) {
          if (_selectedIndex == newIndex) return;
          if (widget.tabs != null && widget.tabs![newIndex].disabled) return;
          if (widget.pillTabs != null && widget.pillTabs![newIndex].disabled) return;

          widget.onTabChanged?.call(newIndex);
          _updateTabsSelectedStatus();

          setState(() => _selectedIndex = newIndex);
        },
      ),
    );
  }
}

class _IndicatorTabBuilder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final MoonTabStyle? tabStyle = tab.tabStyle;

    final Color effectiveIndicatorColor =
        tabStyle?.indicatorColor ?? context.moonTheme?.tabBarTheme.colors.indicatorColor ?? MoonColors.light.piccolo;

    final Color effectiveTextColor = tabStyle?.textStyle?.color ??
        tabStyle?.textColor ??
        context.moonTheme?.tabBarTheme.colors.textColor ??
        MoonTypography.light.colors.bodyPrimary;

    final Color effectiveSelectedTextColor = tabStyle?.selectedTextColor ??
        context.moonTheme?.tabBarTheme.colors.selectedTextColor ??
        MoonColors.light.piccolo;

    final TextStyle effectiveTextStyle = moonTabBarSizeProperties.textStyle.merge(tabStyle?.textStyle);

    final double effectiveIndicatorHeight = tabStyle?.indicatorHeight ?? moonTabBarSizeProperties.indicatorHeight;

    final double effectiveTabGap = tabStyle?.tabGap ?? moonTabBarSizeProperties.tabGap;

    final EdgeInsetsGeometry effectiveTabPadding = tabStyle?.tabPadding ?? moonTabBarSizeProperties.tabPadding;

    final EdgeInsets resolvedDirectionalPadding = effectiveTabPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedTabPadding = tabStyle?.tabPadding == null
        ? EdgeInsetsDirectional.fromSTEB(
            tab.leading == null && tab.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            tab.trailing == null && tab.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    return MoonBaseControl(
      semanticLabel: tab.semanticLabel,
      onLongPress: tab.disabled ? null : () => {},
      autofocus: tab.autoFocus,
      focusNode: tab.focusNode,
      isFocusable: tab.isFocusable,
      showFocusEffect: tab.showFocusEffect,
      focusEffectColor: tabStyle?.focusEffectColor,
      showScaleAnimation: false,
      cursor: isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final bool isActive = isEnabled && (isSelected || isHovered || isPressed);

        return AnimatedContainer(
          decoration: tabStyle?.decoration,
          duration: transitionDuration,
          curve: transitionCurve,
          child: Stack(
            children: [
              AnimatedIconTheme(
                size: moonTabBarSizeProperties.iconSizeValue,
                duration: transitionDuration,
                color: isActive ? effectiveSelectedTextColor : effectiveTextColor,
                child: AnimatedDefaultTextStyle(
                  duration: transitionDuration,
                  style: effectiveTextStyle.copyWith(color: isActive ? effectiveSelectedTextColor : effectiveTextColor),
                  child: Center(
                    child: Padding(
                      padding: correctedTabPadding,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (tab.leading != null)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                              child: tab.leading,
                            ),
                          if (tab.label != null)
                            ConstrainedBox(
                              constraints: BoxConstraints(minHeight: moonTabBarSizeProperties.iconSizeValue),
                              child: Center(child: tab.label),
                            ),
                          if (tab.trailing != null)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                              child: tab.trailing,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Align(
                      alignment: Directionality.of(context) == TextDirection.ltr
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: AnimatedContainer(
                        duration: transitionDuration,
                        color: effectiveIndicatorColor,
                        height: effectiveIndicatorHeight,
                        width: isActive ? constraints.maxWidth : 0,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _PillTabBuilder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final MoonPillTabStyle? tabStyle = tab.tabStyle;

    final BorderRadiusGeometry effectiveTabBorderRadius =
        tabStyle?.borderRadius ?? moonTabBarSizeProperties.borderRadius;

    final Color effectiveSelectedTabColor = tabStyle?.selectedTabColor ??
        context.moonTheme?.tabBarTheme.colors.selectedPillTabColor ??
        MoonColors.light.gohan;

    final Color effectiveTextColor = tabStyle?.textStyle?.color ??
        tabStyle?.textColor ??
        context.moonTheme?.tabBarTheme.colors.textColor ??
        MoonTypography.light.colors.bodyPrimary;

    final Color effectiveSelectedTextColor = tabStyle?.selectedTextColor ??
        context.moonTheme?.tabBarTheme.colors.selectedPillTextColor ??
        MoonTypography.light.colors.bodyPrimary;

    final TextStyle effectiveTextStyle = moonTabBarSizeProperties.textStyle.merge(tabStyle?.textStyle);

    final double effectiveTabGap = tabStyle?.tabGap ?? moonTabBarSizeProperties.tabGap;

    final EdgeInsetsGeometry effectiveTabPadding = tabStyle?.tabPadding ?? moonTabBarSizeProperties.tabPadding;

    final EdgeInsets resolvedDirectionalPadding = effectiveTabPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedTabPadding = tabStyle?.tabPadding == null
        ? EdgeInsetsDirectional.fromSTEB(
            tab.leading == null && tab.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            tab.trailing == null && tab.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    return MoonBaseControl(
      semanticLabel: tab.semanticLabel,
      onLongPress: tab.disabled ? null : () => {},
      autofocus: tab.autoFocus,
      focusNode: tab.focusNode,
      isFocusable: tab.isFocusable,
      showFocusEffect: tab.showFocusEffect,
      focusEffectColor: tabStyle?.focusEffectColor,
      showScaleAnimation: false,
      borderRadius: effectiveTabBorderRadius.squircleBorderRadius(context),
      cursor: isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final bool isActive = isEnabled && (isSelected || isHovered || isPressed);

        return AnimatedContainer(
          duration: transitionDuration,
          curve: transitionCurve,
          decoration: tabStyle?.decoration ??
              ShapeDecorationWithPremultipliedAlpha(
                color: isActive ? effectiveSelectedTabColor : Colors.transparent,
                shape: MoonSquircleBorder(
                  borderRadius: effectiveTabBorderRadius.squircleBorderRadius(context),
                ),
              ),
          child: AnimatedIconTheme(
            size: moonTabBarSizeProperties.iconSizeValue,
            duration: transitionDuration,
            color: isActive ? effectiveSelectedTextColor : effectiveTextColor,
            child: AnimatedDefaultTextStyle(
              duration: transitionDuration,
              style: effectiveTextStyle.copyWith(color: isActive ? effectiveSelectedTextColor : effectiveTextColor),
              child: Center(
                child: Padding(
                  padding: correctedTabPadding,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tab.leading != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                          child: tab.leading,
                        ),
                      if (tab.label != null) tab.label!,
                      if (tab.trailing != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                          child: tab.trailing,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
