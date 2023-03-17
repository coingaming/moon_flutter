import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_size_properties.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/shadows.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/common/icons/icons.dart';

const Duration _kExpand = Duration(milliseconds: 200);

enum MoonAccordionSize {
  sm,
  md,
  lg,
  xl,
}

class MoonAccordion extends StatefulWidget {
  /// The size of the accordion.
  final MoonAccordionSize? accordionSize;

  /// The height of the accordion header.
  final double? headerHeight;

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

  /// Called when the accordion expands or collapses.
  ///
  /// When the accordion starts expanding, this function is called with the value
  /// true. When the accordion starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool>? onExpansionChanged;

  /// The widgets that are displayed when the accordion expands.
  final List<Widget> children;

  /// The color to display behind the accordion body when expanded.
  final Color? backgroundColor;

  /// When not null, defines the background color of the accordion header when accordion is collapsed.
  final Color? collapsedBackgroundColor;

  /// A widget to display after the title.
  ///
  /// Note that depending on the value of [controlAffinity], the [trailing] widget
  /// may replace the rotating expansion arrow icon.
  final Widget? trailing;

  /// Specifies if the accordion is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  /// Specifies whether the state of the children is maintained when the accordion expands and collapses.
  ///
  /// When true, the children are kept in the tree while the accordion is collapsed.
  /// When false (default), the children are removed from the tree when the accordion is
  /// collapsed and recreated upon expansion.
  final bool maintainState;

  /// Specifies padding for the accordion header.
  final EdgeInsets? accordionHeaderPadding;

  /// Specifies the alignment of [children], which are arranged in a column when
  /// the accordion is expanded.
  ///
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

  final EdgeInsetsGeometry? childrenPadding;

  /// The icon color of accordion's expansion arrow icon when the accordion is expanded.
  final Color? iconColor;

  /// The icon color of accordion's expansion arrow icon when the accordion is collapsed.
  final Color? collapsedIconColor;

  /// The color of the accordion's titles when the accordion is expanded.
  final Color? textColor;

  /// The color of the accordion's titles when the accordion is collapsed.
  final Color? collapsedTextColor;

  /// The accordion's border shape.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip? clipBehavior;

  /// Accordion transition duration (expand or collapse animation).
  final Duration? transitionDuration;

  /// Accordion transition curve (expand or collapse animation).
  final Curve? transitionCurve;

  /// Accordion shadows.
  final List<BoxShadow>? shadows;

  /// Whether to show a divider between the header and the body.
  final bool showDivider;

  /// MDS accordion widget.
  const MoonAccordion({
    super.key,
    this.accordionSize,
    this.headerHeight,
    this.leading,
    required this.title,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.accordionHeaderPadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.textColor,
    this.collapsedTextColor,
    this.iconColor,
    this.collapsedIconColor,
    this.shape,
    this.clipBehavior,
    this.transitionDuration,
    this.transitionCurve,
    this.shadows,
    this.showDivider = true,
  }) : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        );

  @override
  State<MoonAccordion> createState() => _MoonAccordionState();
}

class _MoonAccordionState extends State<MoonAccordion> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween = CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _animationController;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse().then<void>((void value) {
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
    widget.onExpansionChanged?.call(_isExpanded);
  }

  MoonAccordionSizeProperties _getMoonAccordionSize(BuildContext context, MoonAccordionSize? moonAccordionSize) {
    switch (moonAccordionSize) {
      case MoonAccordionSize.sm:
        return context.moonTheme?.accordionTheme.sizes.sm ?? MoonAccordionSizeProperties.sm;
      case MoonAccordionSize.md:
        return context.moonTheme?.accordionTheme.sizes.md ?? MoonAccordionSizeProperties.md;
      case MoonAccordionSize.lg:
        return context.moonTheme?.accordionTheme.sizes.lg ?? MoonAccordionSizeProperties.lg;
      case MoonAccordionSize.xl:
        return context.moonTheme?.accordionTheme.sizes.xl ?? MoonAccordionSizeProperties.xl;
      default:
        return context.moonTheme?.accordionTheme.sizes.md ?? MoonAccordionSizeProperties.md;
    }
  }

  Color _getTextColor(BuildContext context, {required Color effectiveBackgroundColor}) {
    if (widget.backgroundColor == null && context.moonTypography != null) {
      return context.moonTypography!.colors.bodyPrimary;
    }

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
    _animationController = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _animationController.drive(_easeInTween);
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    _iconColor = _animationController.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor = _animationController.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.maybeOf(context)?.readState(context) as bool? ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.accordionTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveCollapsedBackgroundColor = widget.collapsedBackgroundColor ??
        context.moonTheme?.accordionTheme.colors.collapsedBackgroundColor ??
        MoonColors.light.gohan;

    final Color effectiveIconColor = widget.iconColor ??
        context.moonTheme?.accordionTheme.colors.iconColor ??
        _getTextColor(context, effectiveBackgroundColor: effectiveBackgroundColor);

    final Color effectiveCollapsedIconColor =
        widget.collapsedIconColor ?? context.moonTheme?.accordionTheme.colors.collapsedIconColor ?? effectiveIconColor;

    final ColorScheme colorScheme = theme.colorScheme;

    _headerColorTween
      ..begin = widget.collapsedTextColor ?? theme.textTheme.titleMedium!.color
      ..end = widget.textColor ?? colorScheme.primary;

    _iconColorTween
      ..begin = effectiveCollapsedIconColor
      ..end = effectiveIconColor;

    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = effectiveCollapsedBackgroundColor;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget? _buildIcon(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: _iconColor.value),
      child: RotationTransition(
        turns: _iconTurns,
        child: const Icon(MoonIconsControls.chevron_down24, size: 24),
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color effectiveTextColor = _getTextColor(context, effectiveBackgroundColor: _backgroundColor.value!);

    final MoonAccordionSizeProperties effectiveMoonAccordionSize = _getMoonAccordionSize(context, widget.accordionSize);

    final double effectiveHeaderHeight = widget.headerHeight ?? effectiveMoonAccordionSize.headerHeight;

    final EdgeInsets effectiveHeaderPadding = widget.accordionHeaderPadding ?? effectiveMoonAccordionSize.headerPadding;

    final List<BoxShadow> effectiveShadows =
        widget.shadows ?? context.moonTheme?.accordionTheme.shadows.accordionShadows ?? MoonShadows.light.sm;

    final Duration effectiveDuration = widget.transitionDuration ??
        context.moonTheme?.accordionTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveCurve =
        widget.transitionCurve ?? context.moonTheme?.accordionTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final ShapeBorder effectiveBorderShape = widget.shape ??
        context.moonTheme?.accordionTheme.properties.shapeBorder ??
        SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.all(
            SmoothRadius(
              cornerRadius: MoonBorders.borders.interactiveSm.topLeft.x,
              cornerSmoothing: 1,
            ),
          ),
        );

    return Container(
      clipBehavior: widget.clipBehavior ?? Clip.none,
      decoration: ShapeDecoration(
        color: _backgroundColor.value,
        shape: effectiveBorderShape,
        shadows: effectiveShadows,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: _handleTap,
            child: Container(
              height: effectiveHeaderHeight,
              padding: effectiveHeaderPadding,
              /* decoration: ShapeDecoration(
                color: _backgroundColor.value,
                shape: effectiveBorderShape,
                shadows: effectiveShadows,
              ), */
              child: Row(
                children: [
                  if (widget.leading != null) widget.leading!,
                  AnimatedDefaultTextStyle(
                    style: effectiveMoonAccordionSize.textStyle.copyWith(color: effectiveTextColor),
                    duration: effectiveDuration,
                    curve: effectiveCurve,
                    child: Expanded(child: widget.title),
                  ),
                  widget.trailing ?? _buildIcon(context)!,
                ],
              ),
            ),
          ),
          ClipRect(
            child: Column(
              children: [
                if (widget.showDivider) Container(height: 1, color: Colors.black),
                Align(
                  alignment: widget.expandedAlignment ?? Alignment.topCenter,
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _animationController.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: widget.childrenPadding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
