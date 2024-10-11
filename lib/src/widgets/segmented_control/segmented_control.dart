import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/segmented_control/segmented_control_size_properties.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/utils/color_tween_premul.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_design/src/widgets/common/base_segmented_tab_bar.dart';
import 'package:moon_design/src/widgets/segmented_control/segment.dart';
import 'package:moon_design/src/widgets/segmented_control/segment_style.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonSegmentedControlSize {
  sm,
  md,
}

typedef MoonCustomSegmentBuilder = Widget Function(
  BuildContext context,
  bool isSelected,
);

class MoonSegmentedControl extends StatefulWidget {
  /// Whether the segmented control is disabled.
  final bool isDisabled;

  /// Whether the segmented control is expanded to its full available
  /// width horizontally.
  final bool isExpanded;

  /// The border radius of the segmented control.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the segmented control.
  final Color? backgroundColor;

  /// The gap between the segmented control segments.
  final double? gap;

  /// The height of the segmented control.
  final double? height;

  /// The width of the segmented control.
  final double? width;

  /// The duration of the segmented control transition animation.
  final Duration? transitionDuration;

  /// The curve of the segmented control transition animation.
  final Curve? transitionCurve;

  /// The padding of the segmented control.
  final EdgeInsetsGeometry? padding;

  /// The index of the initially selected segment.
  /// This property is overridden by the [tabController]'s initial index if the
  /// [tabController] is provided. For external updates to the segment index,
  /// use [tabController].
  final int initialIndex;

  /// The size of the segmented control.
  final MoonSegmentedControlSize? segmentedControlSize;

  /// The custom decoration of the segmented control.
  final Decoration? decoration;

  /// The external controller for managing segment selection and animation in
  /// segmented control. If tabController is provided, then [initialIndex] is
  /// ignored and tabController's index is used instead.
  final TabController? tabController;

  /// The callback that returns the index of the currently selected segment.
  final ValueChanged<int>? onSegmentChanged;

  /// The list of segments to display as the children of the segmented control.
  /// At least one child is required when this property is used. Cannot be used
  /// in conjunction with the [customSegments] property, one of them must be
  /// null.
  final List<Segment>? segments;

  /// The list of custom segments to display as the children of the segmented
  /// control. At least one child is required when this property is used. Cannot
  /// be used in conjunction with the [segments] property, one of them must be
  /// null.
  final List<MoonCustomSegmentBuilder>? customSegments;

  /// Creates a Moon Design segmented control.
  ///
  /// See also:
  ///
  ///   * [MoonSegmentedControl.custom], Moon Design custom segmented control.
  const MoonSegmentedControl({
    super.key,
    this.isDisabled = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.initialIndex = 0,
    this.segmentedControlSize,
    this.decoration,
    this.tabController,
    this.onSegmentChanged,
    required this.segments,
  })  : assert(height == null || height > 0),
        assert(segments != null && segments.length > 0),
        customSegments = null;

  /// Creates a Moon Design custom segmented control.
  const MoonSegmentedControl.custom({
    super.key,
    this.isDisabled = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.initialIndex = 0,
    this.segmentedControlSize,
    this.decoration,
    this.tabController,
    this.onSegmentChanged,
    required this.customSegments,
  })  : assert(height == null || height > 0),
        assert(customSegments != null && customSegments.length > 0),
        segments = null;

  @override
  State<MoonSegmentedControl> createState() => _MoonSegmentedControlState();
}

class _MoonSegmentedControlState extends State<MoonSegmentedControl> {
  late final bool _hasDefaultSegments = widget.segments != null;

  late int _selectedIndex = widget.tabController?.index ?? widget.initialIndex;

  MoonSegmentedControlSizeProperties _getMoonSegmentedControlSize(
    BuildContext context,
    MoonSegmentedControlSize? segmentedControlSize,
  ) {
    switch (segmentedControlSize) {
      case MoonSegmentedControlSize.sm:
        return context.moonTheme?.segmentedControlTheme.sizes.sm ??
            MoonSegmentedControlSizes(tokens: MoonTokens.light).sm;
      case MoonSegmentedControlSize.md:
        return context.moonTheme?.segmentedControlTheme.sizes.md ??
            MoonSegmentedControlSizes(tokens: MoonTokens.light).md;
      default:
        return context.moonTheme?.segmentedControlTheme.sizes.md ??
            MoonSegmentedControlSizes(tokens: MoonTokens.light).md;
    }
  }

  void _updateSegmentsSelectedStatus() {
    if (_hasDefaultSegments) {
      widget.segments?.asMap().forEach((int index, Segment segment) {
        segment.isSelected?.call(index == _selectedIndex);
      });
    } else {
      widget.customSegments?.asMap().forEach(
          (int index, Widget Function(BuildContext, bool) customSegment) {
        customSegment.call(context, index == _selectedIndex);
      });
    }
  }

  void _handleSegmentChange() {
    final int animationValue =
        widget.tabController?.animation?.value.round() ?? 0;
    if (animationValue != _selectedIndex) {
      setState(() {
        _selectedIndex = animationValue;

        widget.onSegmentChanged?.call(animationValue);
        _updateSegmentsSelectedStatus();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _updateSegmentsSelectedStatus();

    widget.tabController?.animation?.addListener(_handleSegmentChange);
  }

  @override
  void dispose() {
    widget.tabController?.animation?.removeListener(_handleSegmentChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoonSegmentedControlSizeProperties effectiveMoonSegmentControlSize =
        _getMoonSegmentedControlSize(context, widget.segmentedControlSize);

    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.segmentedControlTheme.properties.borderRadius ??
        MoonBorders.borders.interactiveMd;

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.segmentedControlTheme.colors.backgroundColor ??
        MoonColors.light.gohan;

    final double effectiveDisabledOpacityValue =
        context.moonOpacities?.disabled ?? MoonOpacities.opacities.disabled;

    final double effectiveHeight =
        widget.height ?? effectiveMoonSegmentControlSize.height;

    final double effectiveGap = widget.gap ??
        context.moonTheme?.segmentedControlTheme.properties.gap ??
        MoonSizes.sizes.x5s;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context
            .moonTheme?.segmentedControlTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.segmentedControlTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final EdgeInsetsGeometry effectivePadding = widget.padding ??
        context.moonTheme?.segmentedControlTheme.properties.padding ??
        const EdgeInsets.all(4);

    return AnimatedOpacity(
      opacity: widget.isDisabled ? effectiveDisabledOpacityValue : 1,
      duration: effectiveTransitionDuration,
      child: Container(
        height: effectiveHeight,
        width: widget.width,
        padding: effectivePadding,
        constraints: BoxConstraints(minWidth: effectiveHeight),
        decoration: widget.decoration ??
            ShapeDecorationWithPremultipliedAlpha(
              color: effectiveBackgroundColor,
              shape: MoonSquircleBorder(
                borderRadius:
                    effectiveBorderRadius.squircleBorderRadius(context),
              ),
            ),
        child: BaseSegmentedTabBar(
          gap: effectiveGap,
          isExpanded: widget.isExpanded,
          tabController: widget.tabController,
          valueChanged: (int newIndex) {
            if (_selectedIndex == newIndex) return;
            if (widget.isDisabled) return;

            setState(() {
              _selectedIndex = newIndex;

              if (widget.tabController == null) {
                widget.onSegmentChanged?.call(newIndex);
                _updateSegmentsSelectedStatus();
              }
            });
          },
          children: _hasDefaultSegments
              ? List.generate(
                  widget.segments!.length,
                  (int index) {
                    return _SegmentBuilder(
                      isDisabled: widget.isDisabled,
                      transitionDuration: effectiveTransitionDuration,
                      transitionCurve: effectiveTransitionCurve,
                      isSelected: index == _selectedIndex,
                      backgroundColor: effectiveBackgroundColor,
                      moonSegmentedControlSizeProperties:
                          effectiveMoonSegmentControlSize,
                      segment: widget.segments![index],
                    );
                  },
                )
              : List.generate(
                  widget.customSegments!.length,
                  (int index) {
                    return widget.customSegments![index](
                      context,
                      index == _selectedIndex,
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _SegmentBuilder extends StatefulWidget {
  final bool isDisabled;
  final bool isSelected;
  final Color backgroundColor;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final MoonSegmentedControlSizeProperties moonSegmentedControlSizeProperties;
  final Segment segment;

  const _SegmentBuilder({
    required this.isDisabled,
    required this.isSelected,
    required this.backgroundColor,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.moonSegmentedControlSizeProperties,
    required this.segment,
  });

  @override
  State<_SegmentBuilder> createState() => _SegmentBuilderState();
}

class _SegmentBuilderState extends State<_SegmentBuilder>
    with SingleTickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _segmentColorTween =
      ColorTweenWithPremultipliedAlpha();
  final ColorTweenWithPremultipliedAlpha _textColorTween =
      ColorTweenWithPremultipliedAlpha();

  Animation<Color?>? _segmentColor;
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

    _animationController =
        AnimationController(duration: widget.transitionDuration, vsync: this);

    if (widget.isSelected) _animationController?.value = 1;
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SegmentStyle? segmentStyle = widget.segment.segmentStyle;

    final BorderRadiusGeometry effectiveSegmentBorderRadius =
        segmentStyle?.segmentBorderRadius ??
            widget.moonSegmentedControlSizeProperties.segmentBorderRadius;

    final Color effectiveSelectedSegmentColor = segmentStyle
            ?.selectedSegmentColor ??
        context.moonTheme?.segmentedControlTheme.colors.selectedSegmentColor ??
        MoonColors.light.goku;

    final Color effectiveTextColor = segmentStyle?.textStyle?.color ??
        segmentStyle?.textColor ??
        context.moonTheme?.segmentedControlTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    final Color effectiveSelectedTextColor = segmentStyle?.selectedTextColor ??
        context.moonTheme?.segmentedControlTheme.colors.selectedTextColor ??
        MoonColors.light.piccolo;

    final TextStyle effectiveTextStyle = widget
        .moonSegmentedControlSizeProperties.textStyle
        .merge(segmentStyle?.textStyle);

    final double effectiveSegmentGap = segmentStyle?.segmentGap ??
        widget.moonSegmentedControlSizeProperties.segmentGap;

    final EdgeInsetsGeometry effectiveSegmentPadding =
        segmentStyle?.segmentPadding ??
            widget.moonSegmentedControlSizeProperties.segmentPadding;

    final EdgeInsets resolvedDirectionalPadding =
        effectiveSegmentPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedSegmentPadding =
        segmentStyle?.segmentPadding == null
            ? EdgeInsetsDirectional.fromSTEB(
                widget.segment.leading == null && widget.segment.label != null
                    ? resolvedDirectionalPadding.left
                    : 0,
                resolvedDirectionalPadding.top,
                widget.segment.trailing == null && widget.segment.label != null
                    ? resolvedDirectionalPadding.right
                    : 0,
                resolvedDirectionalPadding.bottom,
              )
            : resolvedDirectionalPadding;

    _segmentColor ??= _animationController!.drive(
      _segmentColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _textColor ??= _animationController!.drive(
      _textColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _segmentColorTween.end = effectiveSelectedSegmentColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveSelectedTextColor;

    return MoonBaseControl(
      onLongPress: widget.isDisabled ? null : () => {},
      autofocus: widget.segment.autoFocus,
      focusNode: widget.segment.focusNode,
      isFocusable: widget.segment.isFocusable,
      showFocusEffect: widget.segment.showFocusEffect,
      focusEffectColor: segmentStyle?.focusEffectColor,
      semanticLabel: widget.segment.semanticLabel,
      borderRadius: effectiveSegmentBorderRadius.squircleBorderRadius(context),
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
              decoration: segmentStyle?.decoration ??
                  ShapeDecoration(
                    color: _segmentColor!.value,
                    shape: MoonSquircleBorder(
                      borderRadius: effectiveSegmentBorderRadius
                          .squircleBorderRadius(context),
                    ),
                  ),
              child: IconTheme(
                data: IconThemeData(
                  size: widget.moonSegmentedControlSizeProperties.iconSizeValue,
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
              padding: correctedSegmentPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.segment.leading != null)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: effectiveSegmentGap),
                      child: widget.segment.leading,
                    ),
                  if (widget.segment.label != null) widget.segment.label!,
                  if (widget.segment.trailing != null)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: effectiveSegmentGap),
                      child: widget.segment.trailing,
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
