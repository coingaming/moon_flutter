import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';
import 'package:moon_design/src/utils/extensions.dart';

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

  /// Alert transition curve (show and hide animation).
  final Curve? transitionCurve;

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

  /// The padding of the alert.
  final EdgeInsets? padding;

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

  /// MDS alert widget
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
    this.transitionCurve,
    this.borderWidth,
    this.horizontalGap,
    this.minimumHeight,
    this.verticalGap,
    this.transitionDuration,
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

  void _hideAlert() {
    _animationController!.reverse().then<void>((void value) {
      if (!mounted) return;

      setState(() => _isVisible = false);
    });
  }

  void _showAlert() {
    _animationController!.forward();
    if (!mounted) return;

    setState(() => _isVisible = true);
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

  Color _getTextColor({required Color effectiveBackgroundColor}) {
    if (widget.textColor != null) return widget.textColor!;

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

  @override
  Widget build(BuildContext context) {
    final EdgeInsets effectivePadding =
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
        widget.leadingColor ?? context.moonTheme?.alertTheme.colors.leadingColor ?? MoonColors.light.bulma;

    final Color effectiveTrailingColor =
        widget.trailingColor ?? context.moonTheme?.alertTheme.colors.trailingColor ?? MoonColors.light.bulma;

    final Color effectiveTextColor = _getTextColor(effectiveBackgroundColor: effectiveBackgroundColor);

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
      child: FadeTransition(
        opacity: _curvedAnimation!,
        child: Semantics(
          label: widget.semanticLabel,
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
            child: DefaultTextStyle(
              style: TextStyle(color: effectiveTextColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (widget.leading != null)
                        IconTheme(
                          data: IconThemeData(
                            color: effectiveLeadingColor,
                          ),
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
                        IconTheme(
                          data: IconThemeData(
                            color: effectiveTrailingColor,
                          ),
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
    );
  }
}
