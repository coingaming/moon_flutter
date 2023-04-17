import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/common/animated_icon_theme.dart';

class MoonAlert extends StatefulWidget {
  /// Controls whether the alert is shown.
  final bool show;

  /// Whether the alert should show a border.
  final bool showBorder;

  /// The border radius of the alert.
  final BorderRadius? borderRadius;

  /// The background color of the alert.
  final Color? backgroundColor;

  /// The border color of the alert.
  final Color? borderColor;

  /// The color of the widget in leading slot of the alert.
  final Color? leadingColor;

  /// The text color of the alert.
  final Color? textColor;

  /// The color of the widget in trailing slot of the alert.
  final Color? trailingColor;

  /// The border width of the alert.
  final double? borderWidth;

  /// The horizontal space between alert leading, trailing and title.
  final double? horizontalGap;

  /// The minimum height of Alert.
  final double? minimumHeight;

  /// The vertical space between alert header and body.
  final double? verticalGap;

  /// Alert transition duration (show and hide animation).
  final Duration? transitionDuration;

  /// Alert transition curve (show and hide animation).
  final Curve? transitionCurve;

  /// The padding of the alert.
  final EdgeInsetsGeometry? padding;

  /// The semantic label for the alert.
  final String? semanticLabel;

  /// The text style for body
  final TextStyle? bodyTextStyle;

  /// The text style for title
  final TextStyle? titleTextStyle;

  /// The widget in the body slot of the alert.
  final Widget? body;

  /// The widget in the leading slot of the alert.
  final Widget? leading;

  /// The widget in the title slot of the alert.
  final Widget title;

  /// The widget in the trailing slot of the alert.
  final Widget? trailing;

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
    this.leadingColor,
    this.textColor,
    this.trailingColor,
    this.borderWidth,
    this.horizontalGap,
    this.minimumHeight,
    this.verticalGap,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.semanticLabel,
    this.bodyTextStyle,
    this.titleTextStyle,
    this.body,
    this.leading,
    required this.title,
    this.trailing,
  });

  @override
  State<MoonAlert> createState() => _MoonAlertState();
}

class _MoonAlertState extends State<MoonAlert> with SingleTickerProviderStateMixin {
  bool _isVisible = true;

  AnimationController? _animationController;
  Animation<double>? _curvedAnimation;

  Color _getElementColor({required Color effectiveBackgroundColor, required Color? elementColor}) {
    if (elementColor != null) return elementColor;

    final backgroundLuminance = effectiveBackgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  TextStyle _getTextStyle({required BuildContext context}) {
    if (widget.titleTextStyle != null) return widget.titleTextStyle!;

    if (widget.body != null) {
      return context.moonTheme?.alertTheme.properties.titleTextStyle ?? MoonTextStyles.heading.text14;
    } else {
      return context.moonTheme?.alertTheme.properties.bodyTextStyle ?? MoonTextStyles.body.text14;
    }
  }

  void _showAlert() {
    if (!mounted) return;
    _animationController!.forward();

    setState(() => _isVisible = true);
  }

  void _hideAlert() {
    if (!mounted) return;

    _animationController!.reverse().then<void>((void value) {
      if (!mounted) return;

      setState(() => _isVisible = false);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (_isVisible) {
        _animationController!.value = 1.0;
      }
    });
  }

  @override
  void didUpdateWidget(MoonAlert oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      if (oldWidget.show != widget.show) {
        if (widget.show) {
          _showAlert();
        } else {
          _hideAlert();
        }
      }
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry effectivePadding =
        widget.padding ?? context.moonTheme?.alertTheme.properties.padding ?? EdgeInsets.all(MoonSizes.sizes.x2s);

    final double effectiveHorizontalGap =
        widget.horizontalGap ?? context.moonTheme?.alertTheme.properties.horizontalGap ?? MoonSizes.sizes.x3s;

    final double effectiveVerticalGap =
        widget.verticalGap ?? context.moonTheme?.alertTheme.properties.verticalGap ?? MoonSizes.sizes.x4s;

    final double effectiveMinimumHeight =
        widget.minimumHeight ?? context.moonTheme?.alertTheme.properties.minimumHeight ?? MoonSizes.sizes.xl;

    final BorderRadius effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.alertTheme.properties.borderRadius ??
        MoonBorders.borders.interactiveSm;

    final double effectiveBorderWidth =
        widget.borderWidth ?? context.moonBorders?.borderWidth ?? MoonBorders.borders.borderWidth;

    final Color effectiveBorderColor =
        widget.borderColor ?? context.moonTheme?.alertTheme.colors.borderColor ?? MoonColors.light.bulma;

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.alertTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveLeadingColor =
        _getElementColor(effectiveBackgroundColor: effectiveBackgroundColor, elementColor: widget.leadingColor);

    final Color effectiveTrailingColor =
        _getElementColor(effectiveBackgroundColor: effectiveBackgroundColor, elementColor: widget.trailingColor);

    final Color effectiveTextColor =
        _getElementColor(effectiveBackgroundColor: effectiveBackgroundColor, elementColor: widget.textColor);

    final TextStyle effectiveTitleTextStyle = _getTextStyle(context: context);

    final TextStyle effectiveBodyTextStyle =
        widget.bodyTextStyle ?? context.moonTheme?.alertTheme.properties.bodyTextStyle ?? MoonTextStyles.body.text14;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.alertTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.alertTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

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
              decoration: ShapeDecoration(
                color: effectiveBackgroundColor,
                shape: SmoothRectangleBorder(
                  side: BorderSide(
                    color: effectiveBorderColor,
                    width: widget.showBorder ? effectiveBorderWidth : 0,
                    style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                  ),
                  borderRadius: effectiveBorderRadius.smoothBorderRadius,
                ),
              ),
              child: AnimatedDefaultTextStyle(
                duration: effectiveTransitionDuration,
                style: TextStyle(color: effectiveTextColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        if (widget.leading != null)
                          AnimatedIconTheme(
                            duration: effectiveTransitionDuration,
                            color: effectiveLeadingColor,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end: effectiveHorizontalGap),
                              child: widget.leading,
                            ),
                          ),
                        DefaultTextStyle.merge(
                          style: effectiveTitleTextStyle,
                          child: Expanded(
                            child: widget.title,
                          ),
                        ),
                        if (widget.trailing != null)
                          AnimatedIconTheme(
                            duration: effectiveTransitionDuration,
                            color: effectiveTrailingColor,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: effectiveHorizontalGap),
                              child: widget.trailing,
                            ),
                          ),
                      ],
                    ),
                    if (widget.body != null)
                      Row(
                        children: [
                          DefaultTextStyle.merge(
                            style: effectiveBodyTextStyle,
                            child: Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(top: effectiveVerticalGap),
                                child: widget.body,
                              ),
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
    );
  }
}
