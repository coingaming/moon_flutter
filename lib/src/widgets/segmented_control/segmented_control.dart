import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_size_properties.dart';

enum MoonSegmentedControlSize {
  sm,
  md,
}

typedef MoonCustomSegmentBuilder = Widget Function(BuildContext context, bool isSelected);

class MoonSegmentedControl extends StatefulWidget {
  /// Whether MoonSegmentedControl is expanded and takes up all available space horizontally.
  final bool isExpanded;

  /// The border radius of MoonSegmentedControl.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of MoonSegmentedControl.
  final Color? backgroundColor;

  /// The gap between MoonSegmentedControl segments.
  final double? gap;

  /// The height of the MoonSegmentedControl.
  final double? height;

  /// The width of the MoonSegmentedControl.
  final double? width;

  /// MoonSegmentedControl transition duration.
  final Duration? transitionDuration;

  /// MoonSegmentedControl transition curve.
  final Curve? transitionCurve;

  /// The padding of the MoonSegmentedControl.
  final EdgeInsetsGeometry? padding;

  /// The index of initially selected segment.
  final int selectedIndex;

  /// The size of the MoonSegmentedControl.
  final MoonSegmentedControlSize? segmentedControlSize;

  /// Custom shape for the MoonSegmentedControl.
  final ShapeBorder? shape;

  /// Controller of MoonSegmentedControl selection and animation state.
  final TabController? tabController;

  /// Returns current selected segment index.
  final ValueChanged<int>? onSegmentChanged;

  /// The children of MoonSegmentedControl. At least one child is required.
  final List<Segment>? segments;

  /// The custom children of MoonSegmentedControl. At least one child is required.
  final List<MoonCustomSegmentBuilder>? customSegments;

  /// MDS SegmentedControl widget.
  const MoonSegmentedControl({
    super.key,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.selectedIndex = 0,
    this.segmentedControlSize,
    this.shape,
    this.tabController,
    this.onSegmentChanged,
    required this.segments,
  })  : assert(height == null || height > 0),
        assert(segments != null && segments.length > 0),
        customSegments = null;

  /// MDS custom SegmentedControl widget.
  const MoonSegmentedControl.custom({
    super.key,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.selectedIndex = 0,
    this.segmentedControlSize,
    this.shape,
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
  late int _selectedIndex = widget.selectedIndex;

  @override
  void initState() {
    super.initState();

    _updateSegmentsSelectedStatus();
  }

  void _updateSegmentsSelectedStatus() {
    if (_hasDefaultSegments) {
      widget.segments?.asMap().forEach((int index, Segment segment) {
        segment.isSelected?.call(index == _selectedIndex);
      });
    } else {
      widget.customSegments?.asMap().forEach((int index, Widget Function(BuildContext, bool) customSegment) {
        customSegment.call(context, index == _selectedIndex);
      });
    }
  }

  MoonSegmentedControlSizeProperties _getMoonSegmentedControlSize(
    BuildContext context,
    MoonSegmentedControlSize? segmentedControlSize,
  ) {
    switch (segmentedControlSize) {
      case MoonSegmentedControlSize.sm:
        return context.moonTheme?.segmentedControlTheme.sizes.sm ?? MoonSegmentedControlSizeProperties.sm;
      case MoonSegmentedControlSize.md:
        return context.moonTheme?.segmentedControlTheme.sizes.md ?? MoonSegmentedControlSizeProperties.md;
      default:
        return context.moonTheme?.segmentedControlTheme.sizes.md ?? MoonSegmentedControlSizeProperties.md;
    }
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
        MoonColors.light.goku;

    final double effectiveHeight = widget.height ?? effectiveMoonSegmentControlSize.height;

    final double effectiveGap =
        widget.gap ?? context.moonTheme?.segmentedControlTheme.properties.gap ?? MoonSizes.sizes.x5s;

    final EdgeInsetsGeometry effectivePadding =
        widget.padding ?? context.moonTheme?.segmentedControlTheme.properties.padding ?? const EdgeInsets.all(4);

    final EdgeInsets resolvedContentPadding = effectivePadding.resolve(Directionality.of(context));

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.segmentedControlTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.segmentedControlTheme.properties.transitionCurve ??
        Curves.easeInOutCubic;

    return AnimatedContainer(
      height: effectiveHeight,
      width: widget.width,
      padding: resolvedContentPadding,
      duration: effectiveTransitionDuration,
      curve: effectiveTransitionCurve,
      constraints: BoxConstraints(minWidth: effectiveHeight),
      decoration: ShapeDecoration(
        color: effectiveBackgroundColor,
        shape: widget.shape ??
            SmoothRectangleBorder(
              borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
            ),
      ),
      child: BaseSegmentedTabBar(
        selectedIndex: widget.selectedIndex,
        tabController: widget.tabController,
        isExpanded: widget.isExpanded,
        children: _hasDefaultSegments
            ? List.generate(
                widget.segments!.length,
                (int index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : effectiveGap),
                    child: _SegmentBuilder(
                      transitionDuration: effectiveTransitionDuration,
                      transitionCurve: effectiveTransitionCurve,
                      isSelected: index == _selectedIndex,
                      backgroundColor: effectiveBackgroundColor,
                      moonSegmentedControlSizeProperties: effectiveMoonSegmentControlSize,
                      segment: widget.segments![index],
                    ),
                  );
                },
              )
            : List.generate(
                widget.customSegments!.length,
                (int index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : effectiveGap),
                    child: widget.customSegments![index](context, index == _selectedIndex),
                  );
                },
              ),
        valueChanged: (int newIndex) {
          widget.onSegmentChanged?.call(newIndex);
          _updateSegmentsSelectedStatus();

          setState(() => _selectedIndex = newIndex);
        },
      ),
    );
  }
}

class _SegmentBuilder extends StatelessWidget {
  final bool isSelected;
  final Color backgroundColor;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final MoonSegmentedControlSizeProperties moonSegmentedControlSizeProperties;
  final Segment segment;

  const _SegmentBuilder({
    required this.isSelected,
    required this.backgroundColor,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.moonSegmentedControlSizeProperties,
    required this.segment,
  });

  Color _getTextColor(BuildContext context, {required Color? textColor, required Color backgroundColor}) {
    if (textColor != null) return textColor;

    final backgroundLuminance = backgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  Widget build(BuildContext context) {
    final SegmentStyle? segmentStyle = segment.segmentStyle;

    final BorderRadiusGeometry effectiveSegmentBorderRadius =
        segmentStyle?.segmentBorderRadius ?? moonSegmentedControlSizeProperties.segmentBorderRadius;

    final Color effectiveSelectedSegmentColor = segmentStyle?.selectedSegmentColor ??
        context.moonTheme?.segmentedControlTheme.colors.selectedSegmentColor ??
        MoonColors.light.gohan;

    final double effectiveSegmentGap = segmentStyle?.segmentGap ?? moonSegmentedControlSizeProperties.segmentGap;

    final EdgeInsetsGeometry effectiveSegmentPadding =
        segmentStyle?.segmentPadding ?? moonSegmentedControlSizeProperties.segmentPadding;

    final EdgeInsets resolvedDirectionalPadding = effectiveSegmentPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry correctedSegmentPadding = segmentStyle?.segmentPadding == null
        ? EdgeInsetsDirectional.fromSTEB(
            segment.leading == null && segment.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            segment.trailing == null && segment.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    final TextStyle effectiveTextStyle = moonSegmentedControlSizeProperties.textStyle;

    return MoonBaseControl(
      onLongPress: () => {},
      showScaleAnimation: false,
      showFocusEffect: segment.showFocusEffect,
      autofocus: segment.autoFocus,
      focusNode: segment.focusNode,
      isFocusable: segment.isFocusable,
      semanticLabel: segment.semanticLabel,
      borderRadius: effectiveSegmentBorderRadius.smoothBorderRadius(context),
      cursor: isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final bool isActive = isSelected || isHovered || isPressed;

        final Color effectiveTextColor = _getTextColor(
          context,
          textColor: isActive ? segmentStyle?.selectedTextColor : segmentStyle?.textColor,
          backgroundColor: isActive ? effectiveSelectedSegmentColor : backgroundColor,
        );

        final TextStyle resolvedTextStyle = effectiveTextStyle
            .merge(segmentStyle?.textStyle)
            .copyWith(color: segmentStyle?.textStyle?.color ?? effectiveTextColor);

        return AnimatedContainer(
          duration: transitionDuration,
          curve: transitionCurve,
          decoration: ShapeDecoration(
            color: isActive ? effectiveSelectedSegmentColor : backgroundColor,
            shape: segmentStyle?.shape ??
                SmoothRectangleBorder(
                  borderRadius: effectiveSegmentBorderRadius.smoothBorderRadius(context),
                ),
          ),
          child: AnimatedIconTheme(
            size: moonSegmentedControlSizeProperties.iconSizeValue,
            duration: transitionDuration,
            color: effectiveTextColor,
            child: AnimatedDefaultTextStyle(
              duration: transitionDuration,
              style: resolvedTextStyle,
              child: Center(
                child: Padding(
                  padding: correctedSegmentPadding,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (segment.leading != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: effectiveSegmentGap),
                          child: segment.leading,
                        ),
                      if (segment.label != null) segment.label!,
                      if (segment.trailing != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: effectiveSegmentGap),
                          child: segment.trailing,
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

class Segment {
  /// {@macro flutter.widgets.Focus.autofocus}.
  final bool autoFocus;

  /// Whether this segment should be focusable.
  final bool isFocusable;

  /// Whether this segment should show a focus effect.
  final bool showFocusEffect;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The semantic label for the segment.
  final String? semanticLabel;

  /// The styling options for the segment.
  final SegmentStyle? segmentStyle;

  /// Returns value if segment is currently selected or not.
  final ValueChanged<bool>? isSelected;

  /// The widget in the leading slot of the segment.
  final Widget? leading;

  /// The widget in the label slot of the segment.
  final Widget? label;

  /// The widget in the trailing slot of the segment.
  final Widget? trailing;

  const Segment({
    this.autoFocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.focusNode,
    this.semanticLabel,
    this.segmentStyle,
    this.isSelected,
    this.leading,
    this.label,
    this.trailing,
  });
}

class SegmentStyle {
  /// The border radius of segment.
  final BorderRadiusGeometry? segmentBorderRadius;

  /// The color of the selected segment.
  final Color? selectedSegmentColor;

  /// The text color of unselected segments.
  final Color? textColor;

  /// The text color of selected segment.
  final Color? selectedTextColor;

  /// The gap between the leading, label and trailing widgets of segment.
  final double? segmentGap;

  /// The padding of the segment.
  final EdgeInsetsGeometry? segmentPadding;

  /// Custom shape for the segment.
  final ShapeBorder? shape;

  /// The text style of the segment.
  ///
  /// If [TextStyle] color is used, then it overrides the [textColor] and [selectedTextColor].
  final TextStyle? textStyle;

  const SegmentStyle({
    this.segmentBorderRadius,
    this.selectedSegmentColor,
    this.textColor,
    this.selectedTextColor,
    this.segmentGap,
    this.segmentPadding,
    this.shape,
    this.textStyle,
  });
}
