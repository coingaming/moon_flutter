import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_size_properties.dart';
import 'package:moon_design/src/theme/accordion/accordion_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/effects/focus_effects.dart';
import 'package:moon_design/src/theme/tokens/effects/hover_effects.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/common/icons/icons.dart';
import 'package:moon_design/src/widgets/common/icons/moon_icon.dart';

enum MoonAccordionSize {
  sm,
  md,
  lg,
  xl,
}

class MoonAccordion<T> extends StatefulWidget {
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
  final AlignmentGeometry? expandedAlignment;

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

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the accordion content is outside
  final bool hasContentOutside;

  /// Specifies if the accordion is initially expanded (true) or collapsed (false, the default).
  ///
  /// If [identityValue] matches [groupIdentityValue], this parameter is ignored.
  final bool initiallyExpanded;

  /// Specifies whether the state of the children is maintained when the accordion expands and collapses.
  ///
  /// When true, the children are kept in the tree while the accordion is collapsed.
  /// When false (default), the children are removed from the tree when the accordion is
  /// collapsed and recreated upon expansion.
  final bool maintainState;

  /// Whether to show a border around the accordion.
  final bool showBorder;

  /// Whether to show a divider between the header and the body.
  final bool showDivider;

  /// The accordion's border radius.
  final BorderRadiusGeometry? borderRadius;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip? clipBehavior;

  /// The background color of the accordion when expanded.
  final Color? backgroundColor;

  /// The background color of the accordion when collapsed.
  final Color? expandedBackgroundColor;

  /// The color of the border of the accordion.
  final Color? borderColor;

  /// The color of the divider between the header and the body.
  final Color? dividerColor;

  /// The color of accordion's trailing icon (downward caret by default) when the accordion is collapsed.
  final Color? trailingIconColor;

  /// The color of accordion's trailing icon (downward caret by default) when the accordion is expanded.
  final Color? expandedTrailingIconColor;

  /// The color of the accordion's header text.
  final Color? headerTextColor;

  /// The color of the expanded accordion's header text.
  final Color? expandedHeaderTextColor;

  /// The color of the accordion's content text.
  final Color? contentTextColor;

  /// The height of the accordion header.
  final double? headerHeight;

  /// Accordion transition duration (expand or collapse animation).
  final Duration? transitionDuration;

  /// Accordion transition curve (expand or collapse animation).
  final Curve? transitionCurve;

  /// Specifies padding for [children].
  final EdgeInsetsGeometry? childrenPadding;

  /// Specifies padding for the accordion header.
  final EdgeInsetsGeometry? headerPadding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// Accordion shadows.
  final List<BoxShadow>? shadows;

  /// The widgets that are displayed when the accordion expands.
  final List<Widget> children;

  /// The size of the accordion.
  final MoonAccordionSize? accordionSize;

  /// Custom decoration for the accordion.
  final Decoration? decoration;

  /// The semantic label for the accordion.
  final String? semanticLabel;

  /// The text style of the accordion's header. If color is provided, it overrides the [headerTextColor].
  final TextStyle? headerTextStyle;

  /// The text style of the accordion's content. If color is provided, it overrides the [contentTextColor].
  final TextStyle? contentTextStyle;

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

  /// MDS accordion widget.
  const MoonAccordion({
    super.key,
    this.expandedAlignment,
    this.expandedCrossAxisAlignment,
    this.autofocus = false,
    this.hasContentOutside = false,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.showBorder = false,
    this.showDivider = true,
    this.borderRadius,
    this.clipBehavior,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.borderColor,
    this.dividerColor,
    this.trailingIconColor,
    this.expandedTrailingIconColor,
    this.headerTextColor,
    this.expandedHeaderTextColor,
    this.contentTextColor,
    this.headerHeight,
    this.transitionDuration,
    this.transitionCurve,
    this.childrenPadding,
    this.headerPadding,
    this.focusNode,
    this.shadows,
    this.children = const <Widget>[],
    this.accordionSize,
    this.decoration,
    this.semanticLabel,
    this.headerTextStyle,
    this.contentTextStyle,
    this.identityValue,
    this.groupIdentityValue,
    this.onExpansionChanged,
    this.leading,
    required this.title,
    this.trailing,
  }) : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        );

  bool get _selected => identityValue != null && identityValue == groupIdentityValue;

  @override
  State<MoonAccordion<T>> createState() => _MoonAccordionState<T>();
}

class _MoonAccordionState<T> extends State<MoonAccordion<T>> with TickerProviderStateMixin {
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  late final Map<Type, Action<Intent>> _actions = {
    ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap())
  };

  late MoonAccordionSizeProperties _effectiveMoonAccordionSize;
  late BorderRadiusGeometry _effectiveBorderRadius;
  late EdgeInsetsGeometry _effectiveHeaderPadding;
  late EdgeInsets _resolvedDirectionalHeaderPadding;
  late double _effectiveHeaderHeight;

  final ColorTweenWithPremultipliedAlpha _backgroundColorTween = ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _iconColorTween = ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _hoverColorTween = ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _textColorTween = ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _backgroundColor;
  Animation<Color?>? _iconColor;
  Animation<Color?>? _hoverColor;
  Animation<Color?>? _textColor;

  AnimationController? _expansionAnimationController;
  AnimationController? _hoverAnimationController;

  CurvedAnimation? _expansionCurvedAnimation;

  FocusNode? _focusNode;

  Color? _effectiveHoverEffectColor;

  bool _isExpanded = false;
  bool _isFocused = false;
  bool _isHovered = false;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  void _handleHover(bool hover) {
    if (hover != _isHovered) {
      setState(() => _isHovered = hover);

      if (hover) {
        _hoverAnimationController!.forward();
      } else {
        _hoverAnimationController!.reverse();
      }
    }
  }

  void _handleFocus(bool focus) {
    if (focus != _isFocused) {
      setState(() => _isFocused = focus);

      if (focus) {
        _hoverAnimationController!.forward();
      } else {
        _hoverAnimationController!.reverse();
      }
    }
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() => _isFocused = hasFocus);
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expansionAnimationController!.forward();
      } else {
        _expansionAnimationController!.reverse().then<void>((void value) {
          if (!mounted) return;

          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });

    widget.onExpansionChanged?.call(_isExpanded ? widget.identityValue : null);
  }

  MoonAccordionSizeProperties _getMoonAccordionSize(
    BuildContext context,
    MoonAccordionSize? moonAccordionSize,
  ) {
    switch (moonAccordionSize) {
      case MoonAccordionSize.sm:
        return context.moonTheme?.accordionTheme.sizes.sm ?? MoonAccordionSizes(tokens: MoonTokens.light).sm;
      case MoonAccordionSize.md:
        return context.moonTheme?.accordionTheme.sizes.md ?? MoonAccordionSizes(tokens: MoonTokens.light).md;
      case MoonAccordionSize.lg:
        return context.moonTheme?.accordionTheme.sizes.lg ?? MoonAccordionSizes(tokens: MoonTokens.light).lg;
      case MoonAccordionSize.xl:
        return context.moonTheme?.accordionTheme.sizes.xl ?? MoonAccordionSizes(tokens: MoonTokens.light).xl;
      default:
        return context.moonTheme?.accordionTheme.sizes.md ?? MoonAccordionSizes(tokens: MoonTokens.light).md;
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
        _expansionAnimationController!.value = 1.0;
      }
    });
  }

  @override
  void didUpdateWidget(MoonAccordion<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.identityValue == null && widget.groupIdentityValue == null) return;

    if (widget._selected) {
      _isExpanded = true;
    } else {
      _isExpanded = false;
    }

    setState(() {
      if (_isExpanded) {
        _expansionAnimationController!.forward();
      } else {
        _expansionAnimationController!.reverse().then<void>((void value) {
          if (!mounted) return;

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
    _expansionAnimationController!.dispose();
    _hoverAnimationController!.dispose();

    super.dispose();
  }

  Widget? _buildIcon(BuildContext context) {
    final double iconSize = _getMoonAccordionSize(context, widget.accordionSize).iconSizeValue;

    final Color effectiveIconColor = widget.trailingIconColor ??
        context.moonTheme?.accordionTheme.colors.trailingIconColor ??
        MoonTypography.light.colors.bodySecondary;

    final Color effectiveExpandedIconColor = widget.expandedTrailingIconColor ??
        context.moonTheme?.accordionTheme.colors.expandedTrailingIconColor ??
        MoonTypography.light.colors.bodyPrimary;

    _iconColor ??= _iconColorTween.animate(_expansionCurvedAnimation!);

    _iconColorTween
      ..begin = effectiveIconColor
      ..end = effectiveExpandedIconColor;

    return IconTheme(
      data: IconThemeData(color: _iconColor?.value),
      child: RotationTransition(
        turns: _halfTween.animate(_expansionCurvedAnimation!),
        child: MoonIcon(
          MoonIcons.chevron_down_small_16,
          size: iconSize,
        ),
      ),
    );
  }

  Widget _buildHeader({bool isContentOutsideHeader = false, required Widget child}) {
    final Color effectiveBorderColor =
        widget.borderColor ?? context.moonTheme?.accordionTheme.colors.borderColor ?? MoonColors.light.beerus;

    final List<BoxShadow> effectiveShadows =
        widget.shadows ?? context.moonTheme?.accordionTheme.shadows.shadows ?? MoonShadows.light.sm;

    final Color effectiveHeaderTextColor = widget.headerTextStyle?.color ??
        widget.headerTextColor ??
        context.moonTheme?.accordionTheme.colors.headerTextColor ??
        MoonTypography.light.colors.bodyPrimary;

    final Color effectiveExpandedHeaderTextColor = widget.expandedHeaderTextColor ??
        context.moonTheme?.accordionTheme.colors.expandedHeaderTextColor ??
        MoonTypography.light.colors.bodyPrimary;

    final TextStyle effectiveHeaderTextStyle = widget.headerTextStyle ?? _effectiveMoonAccordionSize.headerTextStyle;

    _textColor ??= _textColorTween.animate(_expansionCurvedAnimation!);

    _textColorTween
      ..begin = effectiveHeaderTextColor
      ..end = effectiveExpandedHeaderTextColor;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _hoverAnimationController!,
        builder: (context, child) {
          return IconTheme(
            data: IconThemeData(color: _textColor!.value),
            child: DefaultTextStyle(
              style: effectiveHeaderTextStyle.copyWith(color: _textColor!.value),
              child: Container(
                height: isContentOutsideHeader ? _effectiveHeaderHeight : null,
                padding: isContentOutsideHeader ? _resolvedDirectionalHeaderPadding : null,
                clipBehavior: widget.clipBehavior ?? Clip.none,
                decoration: widget.decoration ??
                    ((widget.hasContentOutside && isContentOutsideHeader) ||
                            (!widget.hasContentOutside && !isContentOutsideHeader)
                        ? ShapeDecoration(
                            color: _hoverColor!.value,
                            shadows: effectiveShadows,
                            shape: MoonSquircleBorder(
                              side: widget.showBorder ? BorderSide(color: effectiveBorderColor) : BorderSide.none,
                              borderRadius: _effectiveBorderRadius.squircleBorderRadius(context),
                            ),
                          )
                        : null),
                child: child,
              ),
            ),
          );
        },
        child: child,
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget? rootChild) {
    _effectiveHoverEffectColor ??= context.moonEffects?.controlHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightHoverEffect.primaryHoverColor;

    _effectiveMoonAccordionSize = _getMoonAccordionSize(context, widget.accordionSize);

    _effectiveBorderRadius = widget.borderRadius ?? _effectiveMoonAccordionSize.borderRadius;

    _effectiveHeaderHeight = widget.headerHeight ?? _effectiveMoonAccordionSize.headerHeight;

    _effectiveHeaderPadding = widget.headerPadding ?? _effectiveMoonAccordionSize.headerPadding;

    _resolvedDirectionalHeaderPadding = _effectiveHeaderPadding.resolve(Directionality.of(context));

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.accordionTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveExpandedBackgroundColor = widget.expandedBackgroundColor ??
        context.moonTheme?.accordionTheme.colors.expandedBackgroundColor ??
        MoonColors.light.gohan;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ?? MoonFocusEffects.lightFocusEffect.effectExtent;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ?? MoonFocusEffects.lightFocusEffect.effectColor;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    final Curve effectiveFocusEffectCurve =
        context.moonEffects?.controlFocusEffect.effectCurve ?? MoonFocusEffects.lightFocusEffect.effectCurve;

    final Color effectiveHoverEffectColor = context.moonEffects?.controlHoverEffect.primaryHoverColor ??
        MoonHoverEffects.lightHoverEffect.primaryHoverColor;

    final Color effectiveContentTextColor = widget.contentTextStyle?.color ??
        widget.contentTextColor ??
        context.moonTheme?.accordionTheme.colors.contentTextColor ??
        MoonTypography.light.colors.bodyPrimary;

    final TextStyle effectiveContentTextStyle = widget.contentTextStyle ?? _effectiveMoonAccordionSize.contentTextStyle;

    final Duration effectiveHoverEffectDuration =
        context.moonEffects?.controlHoverEffect.hoverDuration ?? MoonHoverEffects.lightHoverEffect.hoverDuration;

    final Curve effectiveHoverEffectCurve =
        context.moonEffects?.controlHoverEffect.hoverCurve ?? MoonHoverEffects.lightHoverEffect.hoverCurve;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.accordionTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.accordionTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    _expansionAnimationController ??= AnimationController(duration: effectiveTransitionDuration, vsync: this);

    _expansionCurvedAnimation ??=
        CurvedAnimation(parent: _expansionAnimationController!, curve: effectiveTransitionCurve);

    _backgroundColor ??= _backgroundColorTween.animate(_expansionCurvedAnimation!);

    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = effectiveExpandedBackgroundColor;

    _hoverAnimationController ??= AnimationController(duration: effectiveHoverEffectDuration, vsync: this);

    _hoverColor ??=
        _hoverAnimationController!.drive(_hoverColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));

    _hoverColorTween
      ..begin = _backgroundColor!.value
      ..end = Color.alphaBlend(effectiveHoverEffectColor, _backgroundColor!.value!);

    return Semantics(
      label: widget.semanticLabel,
      enabled: _isExpanded,
      focused: _isFocused,
      child: FocusableActionDetector(
        actions: _actions,
        focusNode: _effectiveFocusNode,
        autofocus: widget.autofocus,
        onFocusChange: _handleFocusChange,
        onShowFocusHighlight: _handleFocus,
        onShowHoverHighlight: _handleHover,
        child: MoonFocusEffect(
          show: _isFocused,
          childBorderRadius: _effectiveBorderRadius,
          effectColor: effectiveFocusEffectColor,
          effectDuration: effectiveFocusEffectDuration,
          effectCurve: effectiveFocusEffectCurve,
          effectExtent: effectiveFocusEffectExtent,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _handleTap,
              child: _buildHeader(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildHeader(
                      isContentOutsideHeader: true,
                      child: Row(
                        children: [
                          if (widget.leading != null)
                            Padding(
                              padding: EdgeInsetsDirectional.only(end: _resolvedDirectionalHeaderPadding.left),
                              child: widget.leading,
                            ),
                          Expanded(child: widget.title),
                          widget.trailing ?? _buildIcon(context)!,
                        ],
                      ),
                    ),
                    ClipRect(
                      child: Column(
                        children: [
                          DefaultTextStyle(
                            style: effectiveContentTextStyle.copyWith(color: effectiveContentTextColor),
                            child: Align(
                              alignment: widget.expandedAlignment ?? Alignment.topCenter,
                              heightFactor: _expansionCurvedAnimation!.value,
                              child: rootChild,
                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveDividerColor =
        widget.dividerColor ?? context.moonTheme?.accordionTheme.colors.dividerColor ?? MoonColors.light.beerus;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.accordionTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    _expansionAnimationController ??= AnimationController(duration: effectiveTransitionDuration, vsync: this);

    final bool isClosed = !_isExpanded && _expansionAnimationController!.isDismissed;
    final bool shouldRemoveChildren = isClosed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: isClosed,
      child: TickerMode(
        enabled: !isClosed,
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
      animation: _expansionAnimationController!.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
