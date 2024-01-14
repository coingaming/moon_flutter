import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors/colors.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

class MoonAlert extends StatefulWidget {
  /// Controls whether the alert is shown.
  final bool show;

  /// Whether the alert should show a border.
  final bool showBorder;

  /// The border radius of the alert.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the alert.
  final Color? backgroundColor;

  /// The border color of the alert.
  final Color? borderColor;

  /// The text and icon color of the alert.
  final Color? color;

  /// The border width of the alert.
  final double? borderWidth;

  /// The horizontal space between alert leading, trailing and label.
  final double? horizontalGap;

  /// The minimum height of Alert.
  final double? minimumHeight;

  /// The vertical space between alert header and content.
  final double? verticalGap;

  /// Alert transition duration (show and hide animation).
  final Duration? transitionDuration;

  /// Alert transition curve (show and hide animation).
  final Curve? transitionCurve;

  /// The padding of the alert.
  final EdgeInsetsGeometry? padding;

  /// Custom decoration for the alert.
  final Decoration? decoration;

  /// The semantic label for the alert.
  final String? semanticLabel;

  /// The widget in the leading slot of the alert.
  final Widget? leading;

  /// The widget in the label slot of the alert.
  final Widget label;

  /// The widget in the trailing slot of the alert.
  final Widget? trailing;

  /// The widget in the content slot of the alert.
  final Widget? content;

  /// MDS base alert.
  ///
  /// See also:
  ///
  ///   * [MoonFilledAlert], MDS filled alert.
  ///   * [MoonOutlinedAlert], MDS outlined alert.
  const MoonAlert({
    super.key,
    this.show = false,
    this.showBorder = false,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.color,
    this.borderWidth,
    this.horizontalGap,
    this.minimumHeight,
    this.verticalGap,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.decoration,
    this.semanticLabel,
    this.leading,
    required this.label,
    this.trailing,
    this.content,
  });

  /// MDS filled alert variant.
  ///
  /// See also:
  ///
  ///   * [MoonOutlinedAlert], MDS outlined button.
  const MoonAlert.filled({
    super.key,
    this.show = false,
    this.borderRadius,
    this.color,
    required this.backgroundColor,
    this.semanticLabel,
    this.leading,
    required this.label,
    this.trailing,
    this.content,
  })  : showBorder = false,
        borderColor = null,
        borderWidth = null,
        decoration = null,
        minimumHeight = null,
        padding = null,
        horizontalGap = null,
        verticalGap = null,
        transitionDuration = null,
        transitionCurve = null;

  /// MDS outlined alert variant.
  ///
  /// See also:
  ///
  ///   * [MoonFilledAlert], MDS filled button.
  const MoonAlert.outlined({
    super.key,
    this.show = false,
    this.borderRadius,
    this.borderWidth,
    this.color,
    required this.borderColor,
    this.semanticLabel,
    this.leading,
    required this.label,
    this.trailing,
    this.content,
  })  : showBorder = true,
        backgroundColor = Colors.transparent,
        decoration = null,
        minimumHeight = null,
        padding = null,
        horizontalGap = null,
        verticalGap = null,
        transitionDuration = null,
        transitionCurve = null;

  @override
  State<MoonAlert> createState() => _MoonAlertState();
}

class _MoonAlertState extends State<MoonAlert>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;

  AnimationController? _animationController;
  Animation<double>? _curvedAnimation;

  TextStyle _getLabelTextStyle({required BuildContext context}) {
    if (widget.content != null) {
      return context.moonTheme?.alertTheme.properties.labelTextStyle ??
          MoonTypography.typography.heading.textDefault;
    } else {
      return context.moonTheme?.alertTheme.properties.contentTextStyle ??
          MoonTypography.typography.body.textDefault;
    }
  }

  void _showAlert() {
    _animationController!.forward();

    setState(() => _isVisible = true);
  }

  void _hideAlert() {
    _animationController!.reverse().then<void>((void value) {
      if (!mounted) return;

      setState(() => _isVisible = false);
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;

      if (_isVisible) _animationController!.value = 1.0;
    });
  }

  @override
  void didUpdateWidget(MoonAlert oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.show != widget.show) {
      widget.show ? _showAlert() : _hideAlert();
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.alertTheme.properties.borderRadius ??
        MoonBorders.borders.interactiveSm;

    final double effectiveBorderWidth = widget.borderWidth ??
        context.moonBorders?.defaultBorderWidth ??
        MoonBorders.borders.defaultBorderWidth;

    final double effectiveHorizontalGap = widget.horizontalGap ??
        context.moonTheme?.alertTheme.properties.horizontalGap ??
        MoonSizes.sizes.x3s;

    final double effectiveVerticalGap = widget.verticalGap ??
        context.moonTheme?.alertTheme.properties.verticalGap ??
        MoonSizes.sizes.x4s;

    final double effectiveMinimumHeight = widget.minimumHeight ??
        context.moonTheme?.alertTheme.properties.minimumHeight ??
        MoonSizes.sizes.xl;

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.alertTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveBorderColor = widget.borderColor ??
        context.moonTheme?.alertTheme.colors.borderColor ??
        MoonColors.light.bulma;

    final Color effectiveTextColor = widget.color ??
        context.moonTheme?.alertTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    final Color effectiveIconColor = widget.color ??
        context.moonTheme?.alertTheme.colors.iconColor ??
        MoonColors.light.iconPrimary;

    final EdgeInsetsGeometry effectivePadding = widget.padding ??
        context.moonTheme?.alertTheme.properties.padding ??
        EdgeInsets.all(MoonSizes.sizes.x2s);

    final TextStyle effectiveLabelTextStyle =
        _getLabelTextStyle(context: context);

    final TextStyle effectiveContentTextStyle =
        context.moonTheme?.alertTheme.properties.contentTextStyle ??
            MoonTypography.typography.body.textDefault;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.alertTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.alertTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    _animationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    return Visibility(
      visible: _isVisible,
      child: Semantics(
        label: widget.semanticLabel,
        child: RepaintBoundary(
          child: FadeTransition(
            opacity: _curvedAnimation!,
            child: Container(
              padding: effectivePadding,
              constraints: BoxConstraints(minHeight: effectiveMinimumHeight),
              decoration: widget.decoration ??
                  ShapeDecorationWithPremultipliedAlpha(
                    color: effectiveBackgroundColor,
                    shape: MoonSquircleBorder(
                      side: BorderSide(
                        color: effectiveBorderColor,
                        width: widget.showBorder ? effectiveBorderWidth : 0,
                        style: widget.showBorder
                            ? BorderStyle.solid
                            : BorderStyle.none,
                      ),
                      borderRadius:
                          effectiveBorderRadius.squircleBorderRadius(context),
                    ),
                  ),
              child: IconTheme(
                data: IconThemeData(
                  color: effectiveIconColor,
                ),
                child: DefaultTextStyle(
                  style: effectiveContentTextStyle.copyWith(
                      color: effectiveTextColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          if (widget.leading != null)
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  end: effectiveHorizontalGap),
                              child: widget.leading,
                            ),
                          DefaultTextStyle(
                            style: effectiveLabelTextStyle.copyWith(
                                color: effectiveTextColor),
                            child: Expanded(
                              child: widget.label,
                            ),
                          ),
                          if (widget.trailing != null)
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: effectiveHorizontalGap),
                              child: widget.trailing,
                            ),
                        ],
                      ),
                      if (widget.content != null)
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                    top: effectiveVerticalGap),
                                child: widget.content,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
