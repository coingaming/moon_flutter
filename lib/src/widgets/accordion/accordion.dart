import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/accordion/accordion_size_properties.dart';
import 'package:moon_design/src/theme/accordion/accordion_sizes.dart';
import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';

import 'package:moon_icons/moon_icons.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonAccordionSize {
  sm,
  md,
  lg,
  xl,
}

class MoonAccordion<T> extends StatefulWidget {
  /// The alignment of [children], which are arranged in a column when the
  /// accordion is expanded.
  ///
  /// Internally, the expanded accordion uses a [Column] widget for [children]
  /// and an [Align] widget to align the column. The [expandedAlignment]
  /// parameter is directly passed into the [Align].
  ///
  /// Modifying this property controls the alignment of the column within the
  /// expanded accordion, not the alignment of [children] widgets within the
  /// column.
  /// To align each child within [children], see [expandedCrossAxisAlignment].
  ///
  /// The width of the column is determined by the widest child widget in
  /// [children].
  final AlignmentGeometry? expandedAlignment;

  /// The alignment of each child within [children] when the accordion is
  /// expanded.
  ///
  /// Internally, the expanded accordion uses a [Column] widget for
  /// [children], and the `crossAxisAlignment` parameter is directly passed into
  /// the [Column].
  ///
  /// Modifying this property controls the cross axis alignment of each child
  /// within its [Column]. The width of the [Column] housing [children] will be
  /// the same as the widest child widget in [children]. It is not necessarily
  /// that the width of the [Column] is equal to the width of the expanded
  /// accordion.
  ///
  /// To align the [Column] along the expanded accordion, use the
  /// [expandedAlignment] property instead.
  final CrossAxisAlignment? expandedCrossAxisAlignment;

  /// Whether to propagate gestures to the children of the accordion.
  /// Defaults to true.
  final bool propagateGesturesToChild;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether to display the accordion content outside of its header.
  final bool hasContentOutside;

  /// Whether the accordion is initially expanded (true) or collapsed (false).
  /// Defaults to collapsed state.
  /// If the [identityValue] matches the [groupIdentityValue], this parameter is
  /// disregarded.
  final bool initiallyExpanded;

  /// Whether the accordion is disabled.
  final bool isDisabled;

  /// Whether to preserve the state of the [children] when the accordion expands
  /// and collapses.
  ///
  /// When true, the children remain in the widget tree even when the accordion
  /// is collapsed. When false (default), the children are removed from the tree
  /// when the accordion is collapsed and recreated when it is expanded.
  final bool maintainState;

  /// Whether to show a border around the accordion.
  final bool showBorder;

  /// Whether to show a dividing line between the accordion header and the body.
  final bool showDivider;

  /// The border radius of the accordion.
  final BorderRadiusGeometry? borderRadius;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip? clipBehavior;

  /// The icon color of the collapsed accordion header.
  final Color? iconColor;

  /// The icon color of the expanded accordion header.
  final Color? expandedIconColor;

  /// The text color of the collapsed accordion header.
  final Color? textColor;

  /// The text color of the expanded accordion header.
  final Color? expandedTextColor;

  /// The background color of the collapsed accordion.
  final Color? backgroundColor;

  /// The background color of the expanded accordion.
  final Color? expandedBackgroundColor;

  /// The border color of the accordion.
  final Color? borderColor;

  /// The color of the line dividing the accordion header from the body.
  final Color? dividerColor;

  /// The custom decoration of the accordion.
  final Decoration? decoration;

  /// The gap between the [leading], [label] and [trailing] widgets of the
  /// accordion header.
  final double? gap;

  /// The height of the accordion header.
  final double? headerHeight;

  /// The duration of the accordion transition animation (expand and collapse).
  final Duration? transitionDuration;

  /// The curve of the accordion transition animation (expand and collapse).
  final Curve? transitionCurve;

  /// The padding of the accordion [children].
  final EdgeInsetsGeometry? childrenPadding;

  /// The padding of the accordion header.
  final EdgeInsetsGeometry? headerPadding;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The list of shadows applied to the accordion.
  final List<BoxShadow>? shadows;

  /// The size of the accordion.
  final MoonAccordionSize? accordionSize;

  /// The semantic label for the accordion.
  final String? semanticLabel;

  /// The identity value represented by this accordion.
  final T? identityValue;

  /// The currently selected identity value for a group of accordions.
  ///
  /// This accordion is considered selected if its [identityValue] is equal to
  /// the [groupIdentityValue].
  final T? groupIdentityValue;

  /// The callback that is called when the accordion expands or collapses.
  ///
  /// When the accordion expansion changes, this function is called with the
  /// [identityValue].
  final ValueChanged<T?>? onExpansionChanged;

  /// The widget to display before the [label] widget of the accordion.
  ///
  /// Typically, a [CircleAvatar] widget is used.
  final Widget? leading;

  /// The primary content of the accordion header.
  ///
  /// Typically, a [Text] widget is used.
  final Widget label;

  /// The widget to display after the [label] widget of the accordion.
  ///
  /// Depending on the value of [controlAffinity], the [trailing] widget
  /// may replace the rotating expansion arrow icon.
  final Widget? trailing;

  /// The list of widgets to display as the content of the accordion when the
  /// accordion expands.
  final List<Widget> children;

  /// Creates a Moon Design accordion.
  const MoonAccordion({
    super.key,
    this.expandedAlignment,
    this.expandedCrossAxisAlignment,
    this.propagateGesturesToChild = true,
    this.autofocus = false,
    this.hasContentOutside = false,
    this.initiallyExpanded = false,
    this.isDisabled = false,
    this.maintainState = false,
    this.showBorder = false,
    this.showDivider = true,
    this.borderRadius,
    this.clipBehavior,
    this.iconColor,
    this.expandedIconColor,
    this.textColor,
    this.expandedTextColor,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.borderColor,
    this.dividerColor,
    this.decoration,
    this.gap,
    this.headerHeight,
    this.transitionDuration,
    this.transitionCurve,
    this.childrenPadding,
    this.headerPadding,
    this.focusNode,
    this.shadows,
    this.accordionSize,
    this.semanticLabel,
    this.identityValue,
    this.groupIdentityValue,
    this.onExpansionChanged,
    this.leading,
    required this.label,
    this.trailing,
    this.children = const <Widget>[],
  }) : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded '
          'children are aligned in a column, not a row. Try to use another '
          'constant.',
        );

  bool get _selected =>
      identityValue != null && identityValue == groupIdentityValue;

  @override
  State<MoonAccordion<T>> createState() => _MoonAccordionState<T>();
}

class _MoonAccordionState<T> extends State<MoonAccordion<T>>
    with TickerProviderStateMixin {
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  late MoonAccordionSizeProperties _effectiveMoonAccordionSize;
  late BorderRadiusGeometry _effectiveBorderRadius;
  late EdgeInsetsGeometry _effectiveHeaderPadding;
  late EdgeInsets _resolvedDirectionalHeaderPadding;
  late double _effectiveHeaderHeight;

  final ColorTweenWithPremultipliedAlpha _textColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _iconColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _backgroundColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _hoverColorTween =
      ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _textColor;
  Animation<Color?>? _iconColor;
  Animation<Color?>? _backgroundColor;
  Animation<Color?>? _hoverColor;

  AnimationController? _expansionAnimationController;
  AnimationController? _hoverAnimationController;

  CurvedAnimation? _expansionCurvedAnimation;

  FocusNode? _focusNode;

  Color? _effectiveHoverEffectColor;

  bool _isExpanded = false;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _handleActiveState(bool isActive) {
    isActive
        ? _hoverAnimationController!.forward()
        : _hoverAnimationController!.reverse();
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
        return context.moonTheme?.accordionTheme.sizes.sm ??
            MoonAccordionSizes(tokens: MoonTokens.light).sm;
      case MoonAccordionSize.md:
        return context.moonTheme?.accordionTheme.sizes.md ??
            MoonAccordionSizes(tokens: MoonTokens.light).md;
      case MoonAccordionSize.lg:
        return context.moonTheme?.accordionTheme.sizes.lg ??
            MoonAccordionSizes(tokens: MoonTokens.light).lg;
      case MoonAccordionSize.xl:
        return context.moonTheme?.accordionTheme.sizes.xl ??
            MoonAccordionSizes(tokens: MoonTokens.light).xl;
      default:
        return context.moonTheme?.accordionTheme.sizes.md ??
            MoonAccordionSizes(tokens: MoonTokens.light).md;
    }
  }

  @override
  void initState() {
    super.initState();

    _isExpanded = PageStorage.maybeOf(context)?.readState(context) as bool? ??
        widget.initiallyExpanded || widget._selected;

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;

      if (_isExpanded) {
        _expansionAnimationController!.value = 1.0;
      }
    });
  }

  @override
  void didUpdateWidget(MoonAccordion<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.identityValue == null && widget.groupIdentityValue == null) {
      return;
    }

    _isExpanded = widget._selected;

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
    final double iconSize =
        _getMoonAccordionSize(context, widget.accordionSize).iconSizeValue;

    final Color effectiveTrailingIconColor = widget.iconColor ??
        context.moonTheme?.accordionTheme.colors.trailingIconColor ??
        MoonColors.light.textSecondary;

    final Color effectiveExpandedTrailingIconColor = widget.expandedIconColor ??
        context.moonTheme?.accordionTheme.colors.expandedTrailingIconColor ??
        MoonColors.light.textPrimary;

    _iconColor ??= _iconColorTween.animate(_expansionCurvedAnimation!);

    _iconColorTween
      ..begin = effectiveTrailingIconColor
      ..end = effectiveExpandedTrailingIconColor;

    return IconTheme(
      data: IconThemeData(color: _iconColor?.value),
      child: RotationTransition(
        turns: _halfTween.animate(_expansionCurvedAnimation!),
        child: Icon(
          switch (iconSize) {
            16 => MoonIcons.controls_chevron_down_small_16_light,
            24 => MoonIcons.controls_chevron_down_small_24_light,
            _ => MoonIcons.controls_chevron_down_small_32_regular,
          },
          size: iconSize,
        ),
      ),
    );
  }

  Widget _buildDecorationContainer({required Widget child}) {
    final Color effectiveBorderColor = widget.borderColor ??
        context.moonTheme?.accordionTheme.colors.borderColor ??
        MoonColors.light.beerus;

    final List<BoxShadow> effectiveShadows = widget.shadows ??
        context.moonTheme?.accordionTheme.shadows.shadows ??
        MoonShadows.light.sm;

    return MoonBaseControl(
      onTap: widget.isDisabled ? null : _handleTap,
      propagateGesturesToChild: widget.propagateGesturesToChild,
      autofocus: widget.autofocus,
      focusNode: _effectiveFocusNode,
      borderRadius: _effectiveBorderRadius.squircleBorderRadius(context),
      builder: (
        BuildContext context,
        bool isEnabled,
        bool isHovered,
        bool isFocused,
        bool isPressed,
      ) {
        final bool isActive = isHovered || isFocused;

        _handleActiveState(isActive);

        return AnimatedBuilder(
          animation: _hoverAnimationController!,
          builder: (BuildContext context, Widget? child) {
            return Container(
              clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
              decoration: widget.decoration ??
                  ShapeDecoration(
                    color: _hoverColor!.value,
                    shadows: effectiveShadows,
                    shape: MoonSquircleBorder(
                      side: widget.showBorder
                          ? BorderSide(color: effectiveBorderColor)
                          : BorderSide.none,
                      borderRadius:
                          _effectiveBorderRadius.squircleBorderRadius(context),
                    ),
                  ),
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, Widget? rootChild) {
    _effectiveHoverEffectColor ??=
        context.moonEffects?.controlHoverEffect.primaryHoverColor ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlHoverEffect
                .primaryHoverColor;

    _effectiveMoonAccordionSize =
        _getMoonAccordionSize(context, widget.accordionSize);

    _effectiveBorderRadius =
        widget.borderRadius ?? _effectiveMoonAccordionSize.borderRadius;

    _effectiveHeaderHeight =
        widget.headerHeight ?? _effectiveMoonAccordionSize.headerHeight;

    _effectiveHeaderPadding =
        widget.headerPadding ?? _effectiveMoonAccordionSize.headerPadding;

    _resolvedDirectionalHeaderPadding =
        _effectiveHeaderPadding.resolve(Directionality.of(context));

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.accordionTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveExpandedBackgroundColor =
        widget.expandedBackgroundColor ??
            context.moonTheme?.accordionTheme.colors.expandedBackgroundColor ??
            MoonColors.light.goku;

    final Color effectiveIconColor = widget.iconColor ??
        context.moonTheme?.accordionTheme.colors.iconColor ??
        MoonColors.light.iconPrimary;

    final Color effectiveExpandedIconColor = widget.expandedIconColor ??
        context.moonTheme?.accordionTheme.colors.expandedIconColor ??
        MoonColors.light.iconPrimary;

    final Color effectiveTextColor = widget.textColor ??
        context.moonTheme?.accordionTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    final Color effectiveExpandedTextColor = widget.expandedTextColor ??
        context.moonTheme?.accordionTheme.colors.expandedTextColor ??
        MoonColors.light.textPrimary;

    final Color effectiveContentTextColor =
        context.moonTheme?.accordionTheme.colors.contentColor ??
            MoonColors.light.textPrimary;

    final TextStyle effectiveHeaderTextStyle =
        _effectiveMoonAccordionSize.headerTextStyle;

    final TextStyle effectiveContentTextStyle =
        _effectiveMoonAccordionSize.contentTextStyle;

    final Color effectiveHoverEffectColor =
        context.moonEffects?.controlHoverEffect.primaryHoverColor ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlHoverEffect
                .primaryHoverColor;

    final Duration effectiveHoverEffectDuration =
        context.moonEffects?.controlHoverEffect.hoverDuration ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlHoverEffect
                .hoverDuration;

    final Curve effectiveHoverEffectCurve =
        context.moonEffects?.controlHoverEffect.hoverCurve ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlHoverEffect
                .hoverCurve;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.accordionTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.accordionTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    _expansionAnimationController ??=
        AnimationController(duration: effectiveTransitionDuration, vsync: this);

    _expansionCurvedAnimation ??= CurvedAnimation(
      parent: _expansionAnimationController!,
      curve: effectiveTransitionCurve,
    );

    _hoverAnimationController ??= AnimationController(
      duration: effectiveHoverEffectDuration,
      vsync: this,
    );

    _backgroundColor ??=
        _backgroundColorTween.animate(_expansionCurvedAnimation!);
    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = effectiveExpandedBackgroundColor;

    _hoverColor ??= _hoverAnimationController!.drive(
      _hoverColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)),
    );
    _hoverColorTween
      ..begin = _backgroundColor!.value
      ..end = Color.alphaBlend(
        effectiveHoverEffectColor,
        _backgroundColor!.value!,
      );

    _textColor ??= _textColorTween.animate(_expansionCurvedAnimation!);
    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveExpandedTextColor;

    _iconColor ??= _iconColorTween.animate(_expansionCurvedAnimation!);
    _iconColorTween
      ..begin = effectiveIconColor
      ..end = effectiveExpandedIconColor;

    final Widget header = SizedBox(
      height: _effectiveHeaderHeight,
      child: Padding(
        padding: _resolvedDirectionalHeaderPadding,
        child: IconTheme(
          data: IconThemeData(color: _iconColor!.value),
          child: DefaultTextStyle(
            style: effectiveHeaderTextStyle.copyWith(color: _textColor!.value),
            child: Row(
              children: [
                if (widget.leading != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: widget.gap ?? _resolvedDirectionalHeaderPadding.left,
                    ),
                    child: widget.leading,
                  ),
                Expanded(child: widget.label),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start:
                        widget.gap ?? _resolvedDirectionalHeaderPadding.right,
                  ),
                  child: widget.trailing ?? _buildIcon(context)!,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final Widget childWrapper = ClipRect(
      child: IconTheme(
        data: IconThemeData(color: effectiveContentTextColor),
        child: DefaultTextStyle(
          style: effectiveContentTextStyle.copyWith(
            color: effectiveContentTextColor,
          ),
          child: Align(
            alignment: widget.expandedAlignment ?? Alignment.topCenter,
            heightFactor: _expansionCurvedAnimation!.value,
            child: rootChild,
          ),
        ),
      ),
    );

    return switch (widget.hasContentOutside) {
      true => Semantics(
          label: widget.semanticLabel,
          enabled: _isExpanded,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildDecorationContainer(child: header),
              childWrapper,
            ],
          ),
        ),
      false => Semantics(
          label: widget.semanticLabel,
          enabled: _isExpanded,
          child: _buildDecorationContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                header,
                childWrapper,
              ],
            ),
          ),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveDividerColor = widget.dividerColor ??
        context.moonTheme?.accordionTheme.colors.dividerColor ??
        MoonColors.light.beerus;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.accordionTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    _expansionAnimationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    final bool isClosed =
        !_isExpanded && _expansionAnimationController!.isDismissed;

    final bool shouldRemoveChildren = isClosed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: isClosed,
      child: TickerMode(
        enabled: !isClosed,
        child: Column(
          children: [
            if (widget.showDivider && !widget.hasContentOutside)
              Container(height: 1, color: effectiveDividerColor),
            Padding(
              padding: widget.childrenPadding ?? EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: widget.expandedCrossAxisAlignment ??
                    CrossAxisAlignment.center,
                children: widget.children,
              ),
            ),
          ],
        ),
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _expansionAnimationController!.view,
        builder: _buildContent,
        child: shouldRemoveChildren ? null : result,
      ),
    );
  }
}
