import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';

typedef MoonTextInputGroupErrorBuilder = Widget Function(BuildContext context, String? errorText);

class MoonTextInputGroup extends StatelessWidget {
  /// If false the widget is "disabled": it ignores taps and has a reduced opacity.
  final bool enabled;

  /// The border radius of the text input group.
  final BorderRadiusGeometry? borderRadius;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// The background color of the text input group.
  final Color? backgroundColor;

  /// The border color of the active or focused text input group.
  final Color? activeBorderColor;

  /// The border color of the inactive text input group.
  final Color? inactiveBorderColor;

  /// The border color of the error text input group.
  final Color? errorColor;

  /// The border color of the hovered text input group.
  final Color? hoverBorderColor;

  /// The text color of the text input group.
  final Color? textColor;

  /// The height of the text input group (this does not include the space taken by [MoonTextInputGroup.errorBuilder]).
  final double? height;

  /// The transition duration for disable animation.
  final Duration? transitionDuration;

  /// The transition curve for disable animation.
  final Curve? transitionCurve;

  /// The padding around helper widget or error builder.
  final EdgeInsetsGeometry? helperPadding;

  /// The padding around the text content.
  final EdgeInsetsGeometry? textPadding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// Custom decoration for the text input group.
  final Decoration? decoration;

  /// The semantic label for the widget.
  final String? semanticLabel;

  /// The text style to use for the helper or error state text.
  final TextStyle? helperTextStyle;

  /// The children of the text input group.
  final List<Widget> children;

  /// Builder for the error widget.
  final MoonTextInputGroupErrorBuilder? errorBuilder;

  /// The widget in the helper slot of the text input group.
  final Widget? helper;

  /// MDS TextArea widget
  const MoonTextInputGroup({
    super.key,
    this.enabled = true,
    this.borderRadius,
    this.clipBehavior,
    this.backgroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.hoverBorderColor,
    this.textColor,
    this.height,
    this.transitionDuration,
    this.transitionCurve,
    this.helperPadding,
    this.textPadding,
    this.focusNode,
    this.decoration,
    this.semanticLabel,
    this.helperTextStyle,
    required this.children,
    this.errorBuilder,
    this.helper,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? context.moonTheme?.textInputGroupTheme.properties.borderRadius ?? BorderRadius.circular(8);

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.textInputGroupTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveActiveBorderColor = activeBorderColor ??
        context.moonTheme?.textInputGroupTheme.colors.activeBorderColor ??
        MoonColors.light.piccolo;

    final Color effectiveInactiveBorderColor = inactiveBorderColor ??
        context.moonTheme?.textInputGroupTheme.colors.inactiveBorderColor ??
        MoonColors.light.beerus;

    final Color effectiveErrorColor =
        errorColor ?? context.moonTheme?.textInputGroupTheme.colors.errorColor ?? MoonColors.light.chiChi100;

    final Color effectiveHoverBorderColor =
        hoverBorderColor ?? context.moonTheme?.textInputGroupTheme.colors.hoverBorderColor ?? MoonColors.light.beerus;

    final Color effectiveTextColor = textColor ?? context.moonColors?.textPrimary ?? MoonColors.light.textPrimary;

    final EdgeInsetsGeometry effectiveHelperPadding = helperPadding ??
        context.moonTheme?.textInputGroupTheme.properties.helperPadding ??
        EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s, vertical: MoonSizes.sizes.x4s);

    final EdgeInsetsGeometry effectiveTextPadding =
        textPadding ?? context.moonTheme?.textInputGroupTheme.properties.textPadding ?? const EdgeInsets.all(16);

    final TextStyle effectiveHelperTextStyle = helperTextStyle ??
        context.moonTheme?.textInputGroupTheme.properties.helperTextStyle ??
        MoonTypography.typography.body.text12;

    final Duration effectiveTransitionDuration = transitionDuration ??
        context.moonTheme?.textInputGroupTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = transitionCurve ??
        context.moonTheme?.textInputGroupTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    List<Widget> childrenWithDivider(bool shouldHideDivider) => List.generate(
          children.length * 2 - 1,
          (int index) {
            final int derivedIndex = index ~/ 2;

            return index.isEven
                ? children[derivedIndex]
                : Divider(
                    height: 1,
                    color: shouldHideDivider ? Colors.transparent : effectiveInactiveBorderColor,
                  );
          },
        );

    return MoonBaseControl(
      isFocusable: false,
      showFocusEffect: false,
      showScaleEffect: false,
      onTap: enabled ? () {} : null,
      builder: (BuildContext context, bool isEnabled, bool isHovered, bool isFocused, bool isPressed) {
        return Container(
          decoration: decoration ??
              ShapeDecorationWithPremultipliedAlpha(
                color: effectiveBackgroundColor,
                shape: MoonSquircleBorder(
                  borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                  side: BorderSide(color: effectiveInactiveBorderColor),
                ),
              ),
          child: Column(
            children: childrenWithDivider(isHovered || isFocused),
          ),
        );
      },
    );
  }
}
