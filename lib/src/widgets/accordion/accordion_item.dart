import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_item_size_properties.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/effects/hover_effects.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/common/animated_icon_theme.dart';
import 'package:moon_design/src/widgets/common/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/common/icons/icons.dart';

enum MoonAccordionItemSize {
  sm,
  md,
  lg,
  xl,
}

class MoonAccordionItem<T> extends StatefulWidget {
  /// The identity value represented by this accordion.
  final T? identityValue;

  /// The currently selected identity value for a group of accordions.
  ///
  /// This accordion is considered selected if its [identityValue] matches the [groupIdentityValue].
  final T? groupIdentityValue;

  /// Called when the accordion expands or collapses.
  ///
  /// When the accordion expansion changes, this function is called with the [identityValue].
  final ValueChanged<T?>? onExpansionChanged;

  /// Specifies if the accordion is initially expanded (true) or collapsed (false, the default).
  ///
  /// If [identityValue] matches [groupIdentityValue], this parameter is ignored.
  final bool initiallyExpanded;

  /// Whether the accordion content is outside
  final bool hasContentOutside;

  /// The size of the accordion.
  final MoonAccordionItemSize? accordionSize;

  /// The background color of the accordion when expanded.
  final Color? backgroundColor;

  /// The background color of the accordion when collapsed.
  final Color? expandedBackgroundColor;

  /// The color of the border of the accordion.
  final Color? borderColor;

  /// The color of the divider between the header and the body.
  final Color? dividerColor;

  /// The icon color of accordion's expansion arrow icon when the accordion is expanded.
  final Color? iconColor;

  /// The icon color of accordion's expansion arrow icon when the accordion is collapsed.
  final Color? expandedIconColor;

  /// The color of the accordion's titles when the accordion is expanded.
  final Color? textColor;

  /// Whether to show a border around the accordion.
  final bool showBorder;

  /// Whether to show a divider between the header and the body.
  final bool showDivider;

  /// Specifies whether the state of the children is maintained when the accordion expands and collapses.
  ///
  /// When true, the children are kept in the tree while the accordion is collapsed.
  /// When false (default), the children are removed from the tree when the accordion is
  /// collapsed and recreated upon expansion.
  final bool maintainState;

  /// The height of the accordion header.
  final double? headerHeight;

  /// Specifies padding for the accordion header.
  final EdgeInsets? headerPadding;

  /// Specifies padding for [children].
  final EdgeInsetsGeometry? childrenPadding;

  /// The accordion's border radius.
  final BorderRadius? borderRadius;

  /// Specifies the alignment of [children], which are arranged in a column when
  /// the accordion is expanded.
  /// The internals of the expanded accordion make use of a [Column] widget for
  /// [children], and [Align] widget to align the column. The [expandedAlignment]
  /// parameter is passed directly into the [Align].
  ///
  /// Modifying this property controls the alignment of the column within the
  /// expanded accordion, not the alignment of [children] widgets within the column.
  /// To align each child within [children], see [expandedCrossAxisAlignment].
  ///
  /// The width of the column is the width of the widest child widget in [children].
  final Alignment? expandedAlignment;

  /// Specifies the alignment of each child within [children] when the accordion is expanded.
  ///
  /// The internals of the expanded accordion make use of a [Column] widget for
  /// [children], and the `crossAxisAlignment` parameter is passed directly into the [Column].
  ///
  /// Modifying this property controls the cross axis alignment of each child
  /// within its [Column]. Note that the width of the [Column] that houses
  /// [children] will be the same as the widest child widget in [children]. It is
  /// not necessarily the width of [Column] is equal to the width of expanded accordion.
  ///
  /// To align the [Column] along the expanded accordion, use the [expandedAlignment] property
  /// instead.
  ///
  /// When the value is null, the value of [expandedCrossAxisAlignment] is [CrossAxisAlignment.center].
  final CrossAxisAlignment? expandedCrossAxisAlignment;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip? clipBehavior;

  /// Accordion shadows.
  final List<BoxShadow>? shadows;

  /// Accordion transition duration (expand or collapse animation).
  final Duration? transitionDuration;

  /// Accordion transition curve (expand or collapse animation).
  final Curve? transitionCurve;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  ///
  /// Note that depending on the value of [controlAffinity], the [leading] widget
  /// may replace the rotating expansion arrow icon.
  final Widget? leading;

  /// The primary content of the accordion header.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// A widget to display after the title.
  ///
  /// Note that depending on the value of [controlAffinity], the [trailing] widget
  /// may replace the rotating expansion arrow icon.
  final Widget? trailing;

  /// The widgets that are displayed when the accordion expands.
  final List<Widget> children;

  /// MDS accordion widget.
  const MoonAccordionItem({
    super.key,
    this.identityValue,
    this.groupIdentityValue,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
    this.hasContentOutside = false,
    this.accordionSize,
    this.borderColor,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.dividerColor,
    this.iconColor,
    this.expandedIconColor,
    this.textColor,
    this.showBorder = false,
    this.showDivider = true,
    this.maintainState = false,
    this.headerHeight,
    this.headerPadding,
    this.childrenPadding,
    this.borderRadius,
    this.expandedAlignment,
    this.expandedCrossAxisAlignment,
    this.clipBehavior,
    this.shadows,
    this.transitionDuration,
    this.transitionCurve,
    this.autofocus = false,
    this.focusNode,
    this.leading,
    required this.title,
    this.trailing,
    this.children = const <Widget>[],
  }) : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        );

  bool get _selected => identityValue != null && identityValue == groupIdentityValue;

  @override
  State<MoonAccordionItem<T>> createState() => _MoonAccordionItemState<T>();
}

class _MoonAccordionItemState<T> extends State<MoonAccordionItem<T>> with SingleTickerProviderStateMixin {
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  late final Map<Type, Action<Intent>> _actions = {
    ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap())
  };

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;

  late Animation<Color?>? _iconColorAnimation;
  late Animation<Color?>? _backgroundColorAnimation;

  bool _isExpanded = false;
  bool _isFocused = false;
  bool _isHovered = false;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  void _handleHover(bool hover) {
    if (hover != _isHovered && mounted) {
      setState(() => _isHovered = hover);
    }
  }

  void _handleFocus(bool focus) {
    if (focus != _isFocused && mounted) {
      setState(() => _isFocused = focus);
    }
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
    });
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController!.forward();
      } else {
        _animationController!.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });

    widget.onExpansionChanged?.call(_isExpanded ? widget.identityValue : null);
  }

  MoonAccordionItemSizeProperties _getMoonAccordionItemSize(
    BuildContext context,
    MoonAccordionItemSize? moonAccordionItemSize,
  ) {
    switch (moonAccordionItemSize) {
      case MoonAccordionItemSize.sm:
        return context.moonTheme?.accordionTheme.itemSizes.sm ?? MoonAccordionItemSizeProperties.sm;
      case MoonAccordionItemSize.md:
        return context.moonTheme?.accordionTheme.itemSizes.md ?? MoonAccordionItemSizeProperties.md;
      case MoonAccordionItemSize.lg:
        return context.moonTheme?.accordionTheme.itemSizes.lg ?? MoonAccordionItemSizeProperties.lg;
      case MoonAccordionItemSize.xl:
        return context.moonTheme?.accordionTheme.itemSizes.xl ?? MoonAccordionItemSizeProperties.xl;
      default:
        return context.moonTheme?.accordionTheme.itemSizes.md ?? MoonAccordionItemSizeProperties.md;
    }
  }

  Color _getTextColor(BuildContext context, {required Color effectiveBackgroundColor}) {
    final backgroundLuminance = effectiveBackgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  void initState() {
    super.initState();

    _isExpanded =
        PageStorage.maybeOf(context)?.readState(context) as bool? ?? widget.initiallyExpanded || widget._selected;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (_isExpanded) {
        _animationController!.value = 1.0;
      }
    });
  }

  @override
  void didUpdateWidget(MoonAccordionItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.identityValue == null && widget.groupIdentityValue == null) return;

    if (widget._selected) {
      _isExpanded = true;
    } else {
      _isExpanded = false;
    }

    setState(() {
      if (_isExpanded) {
        _animationController!.forward();
      } else {
        _animationController!.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Widget? _buildIcon(BuildContext context) {
    final double iconSize = _getMoonAccordionItemSize(context, widget.accordionSize).iconSizeValue;

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.accordionTheme.itemColors.backgroundColor ??
        MoonColors.light.gohan;

    final Color effectiveIconColor = widget.iconColor ??
        context.moonTheme?.accordionTheme.itemColors.iconColor ??
        _getTextColor(context, effectiveBackgroundColor: effectiveBackgroundColor);

    final Color effectiveExpandedIconColor = widget.expandedIconColor ??
        context.moonTheme?.accordionTheme.itemColors.expandedIconColor ??
        effectiveIconColor;

    _iconColorAnimation =
        ColorTween(begin: effectiveIconColor, end: effectiveExpandedIconColor).animate(_curvedAnimation!);

    return IconTheme(
      data: IconThemeData(color: _iconColorAnimation?.value),
      child: RotationTransition(
        turns: _halfTween.animate(_curvedAnimation!),
        child: Icon(MoonIconsControls.chevron_down24, size: iconSize),
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.accordionTheme.itemColors.backgroundColor ??
        MoonColors.light.gohan;

    final Color effectiveExpandedBackgroundColor = widget.expandedBackgroundColor ??
        context.moonTheme?.accordionTheme.itemColors.expandedBackgroundColor ??
        MoonColors.light.gohan;

    final Color effectiveBorderColor =
        widget.borderColor ?? context.moonTheme?.accordionTheme.itemColors.borderColor ?? MoonColors.light.beerus;

    final MoonAccordionItemSizeProperties effectiveMoonAccordionSize =
        _getMoonAccordionItemSize(context, widget.accordionSize);

    final double effectiveHeaderHeight = widget.headerHeight ?? effectiveMoonAccordionSize.headerHeight;
    final EdgeInsets effectiveHeaderPadding = widget.headerPadding ?? effectiveMoonAccordionSize.headerPadding;

    final List<BoxShadow> effectiveShadows =
        widget.shadows ?? context.moonTheme?.accordionTheme.itemShadows.shadows ?? MoonShadows.light.sm;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.accordionTheme.itemProperties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.accordionTheme.itemProperties.transitionCurve ??
        Curves.easeInOutCubic;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ?? MoonFocusEffects.lightFocusEffect.effectExtent;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ?? MoonFocusEffects.lightFocusEffect.effectColor;

    final Curve effectiveFocusEffectCurve =
        context.moonEffects?.controlFocusEffect.effectCurve ?? MoonFocusEffects.lightFocusEffect.effectCurve;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    final Color effectiveHoverEffectColor = context.moonEffects?.controlHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightHoverEffect.primaryHoverColor;

    final Curve effectiveHoverEffectCurve =
        context.moonEffects?.controlHoverEffect.hoverCurve ?? MoonHoverEffects.lightHoverEffect.hoverCurve;

    final Duration effectiveHoverEffectDuration =
        context.moonEffects?.controlHoverEffect.hoverDuration ?? MoonHoverEffects.lightHoverEffect.hoverDuration;

    final BorderRadius effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.accordionTheme.itemProperties.borderRadius ??
        MoonBorders.borders.interactiveSm;

    _animationController ??= AnimationController(duration: effectiveTransitionDuration, vsync: this);
    _curvedAnimation ??= CurvedAnimation(parent: _animationController!, curve: effectiveTransitionCurve);

    _backgroundColorAnimation =
        ColorTween(begin: effectiveBackgroundColor, end: effectiveExpandedBackgroundColor).animate(_curvedAnimation!);

    final Color? resolvedBackgroundColor = _isHovered || _isFocused
        ? Color.alphaBlend(effectiveHoverEffectColor, _backgroundColorAnimation!.value!)
        : _backgroundColorAnimation!.value;

    final Color effectiveTextColor =
        _getTextColor(context, effectiveBackgroundColor: resolvedBackgroundColor ?? effectiveBackgroundColor);

    return Semantics(
      enabled: _isExpanded,
      focused: _isFocused,
      child: FocusableActionDetector(
        actions: _actions,
        focusNode: _effectiveFocusNode,
        autofocus: widget.autofocus,
        onFocusChange: _handleFocusChange,
        onShowFocusHighlight: _handleFocus,
        onShowHoverHighlight: _handleHover,
        child: RepaintBoundary(
          child: MoonFocusEffect(
            show: _isFocused,
            effectExtent: effectiveFocusEffectExtent,
            effectColor: effectiveFocusEffectColor,
            effectDuration: effectiveFocusEffectDuration,
            effectCurve: effectiveFocusEffectCurve,
            childBorderRadius: effectiveBorderRadius,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _handleTap,
                child: AnimatedIconTheme(
                  duration: effectiveTransitionDuration,
                  color: effectiveTextColor,
                  child: AnimatedDefaultTextStyle(
                    style: DefaultTextStyle.of(context).style.copyWith(color: effectiveTextColor),
                    duration: effectiveTransitionDuration,
                    child: AnimatedContainer(
                      duration: effectiveHoverEffectDuration,
                      curve: effectiveHoverEffectCurve,
                      clipBehavior: widget.clipBehavior ?? Clip.none,
                      decoration: !widget.hasContentOutside
                          ? ShapeDecoration(
                              color: resolvedBackgroundColor,
                              shadows: effectiveShadows,
                              shape: SmoothRectangleBorder(
                                side: widget.showBorder ? BorderSide(color: effectiveBorderColor) : BorderSide.none,
                                borderRadius: effectiveBorderRadius.smoothBorderRadius,
                              ),
                            )
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AnimatedContainer(
                            height: effectiveHeaderHeight,
                            padding: effectiveHeaderPadding,
                            duration: effectiveHoverEffectDuration,
                            curve: effectiveHoverEffectCurve,
                            decoration: widget.hasContentOutside
                                ? ShapeDecoration(
                                    color: resolvedBackgroundColor,
                                    shadows: effectiveShadows,
                                    shape: SmoothRectangleBorder(
                                      side:
                                          widget.showBorder ? BorderSide(color: effectiveBorderColor) : BorderSide.none,
                                      borderRadius: effectiveBorderRadius.smoothBorderRadius,
                                    ),
                                  )
                                : null,
                            child: Row(
                              children: [
                                if (widget.leading != null)
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(end: effectiveHeaderPadding.left),
                                    child: widget.leading,
                                  ),
                                AnimatedDefaultTextStyle(
                                  style: effectiveMoonAccordionSize.textStyle.copyWith(color: effectiveTextColor),
                                  duration: effectiveTransitionDuration,
                                  child: Expanded(child: widget.title),
                                ),
                                widget.trailing ?? _buildIcon(context)!,
                              ],
                            ),
                          ),
                          ClipRect(
                            child: Column(
                              children: [
                                Align(
                                  alignment: widget.expandedAlignment ?? Alignment.topCenter,
                                  heightFactor: _curvedAnimation!.value,
                                  child: child,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.accordionTheme.itemProperties.transitionDuration ??
        const Duration(milliseconds: 200);

    _animationController ??= AnimationController(duration: effectiveTransitionDuration, vsync: this);

    final bool closed = !_isExpanded && _animationController!.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Color effectiveDividerColor =
        widget.dividerColor ?? context.moonTheme?.accordionTheme.itemColors.dividerColor ?? MoonColors.light.beerus;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Column(
          children: [
            if (widget.showDivider && !widget.hasContentOutside) Container(height: 1, color: effectiveDividerColor),
            Padding(
              padding: widget.childrenPadding ?? EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.center,
                children: widget.children,
              ),
            ),
          ],
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController!.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
