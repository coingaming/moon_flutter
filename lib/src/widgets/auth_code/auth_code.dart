import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

import 'package:moon_tokens/moon_tokens.dart';

enum AuthFieldShape {
  box,
  underline,
  circle,
}

enum _InputFieldState {
  active,
  inactive,
  selected,
  error,
  selectedAndError,
}

class MoonAuthCode extends StatelessWidget {
  /// The shape of the auth code input field.
  final AuthFieldShape? authFieldShape;

  /// Whether to automatically dismiss the keyboard when the last input is
  /// entered.
  final bool autoDismissKeyboard;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autoFocus;

  /// Whether to automatically unfocus the auth code.
  final bool autoUnfocus;

  /// Whether the auth code is enabled.
  final bool enabled;

  /// Whether to enable the fill color for the auth code input fields.
  final bool enableInputFill;

  /// Whether to replace all typed characters in the auth code input fields with
  /// the [obscuringCharacter].
  final bool obscureText;

  /// Whether to briefly display the typed character before obscuring it with
  /// the [obscuringCharacter].
  final bool peekWhenObscuring;

  /// Whether to show the cursor in the selected auth code input field.
  final bool showCursor;

  /// Whether to use haptic feedback (vibration) for auth code error state.
  final bool useHapticFeedback;

  /// The border radius of the auth code input field.
  final BorderRadiusGeometry? borderRadius;

  /// The cursor color of the selected auth code input field.
  final Color? cursorColor;

  /// The cursor color of the selected auth code input field in error state.
  final Color? cursorErrorColor;

  /// The border color of the currently selected auth code input field.
  final Color? selectedBorderColor;

  /// The border color of the auth code input field with input.
  final Color? activeBorderColor;

  /// The border color of the auth code input field without input.
  final Color? inactiveBorderColor;

  /// The border color of the auth code input field in error state.
  final Color? errorBorderColor;

  /// The fill color of the selected auth code input field.
  ///
  /// [enableInputFill] has to be set true.
  final Color? selectedFillColor;

  /// The fill color of the auth code input field with input.
  ///
  /// [enableInputFill] has to be set true.
  final Color? activeFillColor;

  /// The fill color of the auth code input field without input.
  ///
  /// [enableInputFill] has to be set true.
  final Color? inactiveFillColor;

  /// The border width of the auth code input field.
  final double? borderWidth;

  /// The opacity value of the auth code when [enabled] is false.
  final double? disabledOpacityValue;

  /// The horizontal gap between the auth code input fields.
  final double? gap;

  /// The height of the auth code input field.
  final double? height;

  /// The width of the auth code input field.
  final double? width;

  /// The duration of the transition animation when the auth code input field
  /// switches between enabled and disabled states.
  final Duration? animationDuration;

  /// The curve of the transition animation when the auth code input field
  /// switches between enabled and disabled states.
  final Curve? animationCurve;

  /// The duration of the auth code error state animation,
  /// if [ErrorState.shake] is selected.
  final Duration? errorAnimationDuration;

  /// The curve of the auth code error state animation
  /// if [ErrorState.shake] is selected.
  final Curve? errorAnimationCurve;

  /// The duration to display the typed character before it is obscured with
  /// [obscuringCharacter]. The [peekWhenObscuring] has to be set to true.
  final Duration? peekDuration;

  /// The animation type for the auth code validation error.
  final ErrorAnimationType errorAnimationType;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The total number of input fields to build for the auth code.
  final int authInputFieldCount;

  /// The list of shadows applied to the auth code input field.
  /// For finer control, use [activeBoxShadows] and [inActiveBoxShadows].
  final List<BoxShadow>? boxShadows;

  /// The list of shadows applied to the auth code input field with input.
  /// Takes precedence over [boxShadows].
  final List<BoxShadow>? activeBoxShadows;

  /// The list of shadows applied to the auth code input field without input.
  /// Takes precedence over [boxShadows].
  final List<BoxShadow>? inActiveBoxShadows;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The placement of the auth code input fields along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The error text can be used to force authentication into an error state
  /// (useful for asynchronous errors).
  ///
  /// The validator errors take precedence over the provided [errorText].
  final String? errorText;

  /// The character to use to obscure the text when [obscureText] is true.
  ///
  /// Defaults to Unicode character U+2022 BULLET (•).
  final String obscuringCharacter;

  /// The semantic label for the auth code.
  final String? semanticLabel;

  /// The action to perform by the text input control.
  final TextInputAction textInputAction;

  /// The keyboard [TextInputType] for the auth code.
  final TextInputType keyboardType;

  /// The text style of the auth code.
  final TextStyle? textStyle;

  /// The text style of the auth code in error state.
  final TextStyle? errorTextStyle;

  /// The [TextEditingController] used to edit the text in the auth code input
  /// field.
  final TextEditingController? textController;

  /// The input text validator for the auth code [TextFormField].
  /// The validator errors take precedence over the provided [errorText].
  final FormFieldValidator<String> validator;

  /// The callback that is called when the auth code input text changes.
  final ValueChanged<String>? onChanged;

  /// The callback that is called when all the auth code input fields are
  /// filled.
  final ValueChanged<String>? onCompleted;

  /// The callback that is called when the 'done' or 'next' action is triggered
  /// on the keyboard.
  final ValueChanged<String>? onSubmitted;

  /// The [onEditingComplete] callback runs when editing is finished.
  /// It differs from [onSubmitted] by having a default value which
  /// updates [textController] and yields keyboard focus.
  ///
  /// Set this to empty function if keyboard should not close automatically on
  /// 'done' or 'next' press.
  final VoidCallback? onEditingComplete;

  /// A builder to build the auth code error widget.
  final MoonAuthCodeErrorBuilder errorBuilder;

  /// The helper text to display below the auth code when provided.
  /// Auth code helper text is not be visible in error state.
  final Widget? helperText;

  /// The character or placeholder to display in the auth code input field when
  /// its value is empty.
  final Widget? hint;

  /// The widget to obscure the auth code input field text.
  ///
  /// Overrides the [obscuringCharacter].
  final Widget? obscuringWidget;

  /// Creates a Moon Design auth code.
  const MoonAuthCode({
    super.key,
    this.authFieldShape = AuthFieldShape.box,
    this.autoDismissKeyboard = true,
    this.autoFocus = false,
    this.autoUnfocus = true,
    this.enabled = true,
    this.enableInputFill = false,
    this.obscureText = false,
    this.peekWhenObscuring = false,
    this.showCursor = true,
    this.useHapticFeedback = false,
    this.borderRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectedBorderColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.selectedFillColor,
    this.activeFillColor,
    this.inactiveFillColor,
    this.borderWidth,
    this.disabledOpacityValue,
    this.gap,
    this.height,
    this.width,
    this.animationDuration,
    this.errorAnimationDuration,
    this.peekDuration,
    this.animationCurve,
    this.errorAnimationCurve,
    this.errorAnimationType = ErrorAnimationType.noAnimation,
    this.focusNode,
    this.authInputFieldCount = 6,
    this.boxShadows,
    this.activeBoxShadows,
    this.inActiveBoxShadows,
    this.inputFormatters,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.hint,
    this.obscuringCharacter = '•',
    this.semanticLabel,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.visiblePassword,
    this.errorText,
    this.textStyle,
    this.errorTextStyle,
    this.textController,
    required this.validator,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    required this.errorBuilder,
    this.helperText,
    this.obscuringWidget,
  })  : assert(authInputFieldCount > 0),
        assert(height == null || height > 0),
        assert(width == null || width > 0);

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? MoonBorders.borders.interactiveSm;

    final double effectiveBorderWidth =
        borderWidth ?? MoonBorders.borders.defaultBorderWidth;

    final double effectiveGap = gap ?? MoonSizes.sizes.x4s;

    final double effectiveHeight = height ?? MoonSizes.sizes.xl;

    final double effectiveWidth = width ?? MoonSizes.sizes.lg;

    final Color effectiveSelectedBorderColor =
        selectedBorderColor ?? MoonColors.light.piccolo;

    final Color effectiveActiveBorderColor =
        activeBorderColor ?? MoonColors.light.beerus;

    final Color effectiveInactiveBorderColor =
        inactiveBorderColor ?? MoonColors.light.beerus;

    final Color effectiveErrorBorderColor =
        errorBorderColor ?? MoonColors.light.chichi;

    final Color effectiveSelectedFillColor =
        selectedFillColor ?? MoonColors.light.goku;

    final Color effectiveActiveFillColor =
        activeFillColor ?? MoonColors.light.goku;

    final Color effectiveInactiveFillColor =
        inactiveFillColor ?? MoonColors.light.goku;

    final Color effectiveTextColor =
        textStyle?.color ?? MoonColors.light.textPrimary;

    final Color effectiveErrorColor =
        errorTextStyle?.color ?? effectiveErrorBorderColor;

    final Duration effectiveAnimationDuration = animationDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveAnimationCurve =
        animationCurve ?? MoonTransitions.transitions.defaultTransitionCurve;

    final Duration effectivePeekDuration =
        peekDuration ?? MoonTransitions.transitions.defaultTransitionDuration;

    final double effectiveDisabledOpacityValue =
        disabledOpacityValue ?? MoonOpacities.opacities.disabled;

    final Duration effectiveErrorAnimationDuration = errorAnimationDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveErrorAnimationCurve = errorAnimationCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final TextStyle effectiveTextStyle = MoonTypography.typography.body.text24;

    final TextStyle effectiveErrorTextStyle =
        MoonTypography.typography.body.text12;

    final TextStyle resolvedInputTextStyle =
        effectiveTextStyle.merge(textStyle).copyWith(color: effectiveTextColor);

    final TextStyle resolvedErrorInputTextStyle = effectiveTextStyle
        .merge(textStyle)
        .copyWith(color: effectiveErrorColor);

    final TextStyle resolvedErrorTextStyle = effectiveErrorTextStyle
        .merge(errorTextStyle)
        .copyWith(color: effectiveErrorColor);

    final TextStyle resolvedHelperTextStyle =
        resolvedErrorTextStyle.copyWith(color: effectiveTextColor);

    ShapeDecorationWithPremultipliedAlpha decoration(_InputFieldState state) {
      final double borderWidth = switch (state) {
        _InputFieldState.selected => effectiveBorderWidth + 1,
        _InputFieldState.selectedAndError => effectiveBorderWidth + 1,
        _ => effectiveBorderWidth
      };

      final Color borderColor = switch (state) {
        _InputFieldState.active => effectiveActiveBorderColor,
        _InputFieldState.inactive => effectiveInactiveBorderColor,
        _InputFieldState.selected => effectiveSelectedBorderColor,
        _ => effectiveErrorBorderColor,
      };

      final Color fillColor = switch (state) {
        _InputFieldState.active => effectiveActiveFillColor,
        _InputFieldState.inactive => effectiveInactiveFillColor,
        _InputFieldState.error => effectiveActiveFillColor,
        _ => effectiveSelectedFillColor,
      };

      final List<BoxShadow>? boxShadow = switch (state) {
        _InputFieldState.inactive => inActiveBoxShadows ?? boxShadows,
        _ => activeBoxShadows ?? boxShadows,
      };

      final BorderSide borderSide =
          BorderSide(color: borderColor, width: borderWidth);

      final OutlinedBorder shape = switch (authFieldShape) {
        AuthFieldShape.circle => CircleBorder(side: borderSide),
        AuthFieldShape.underline => LinearBorder.bottom(side: borderSide),
        _ => MoonBorder(borderRadius: effectiveBorderRadius, side: borderSide),
      };

      return ShapeDecorationWithPremultipliedAlpha(
        color: enableInputFill ? fillColor : Colors.transparent,
        shape: shape,
        shadows: boxShadow,
      );
    }

    final Style inputFieldStyle = Style(
      $box.chain
        ..height(effectiveHeight)
        ..width(effectiveWidth)
        ..shapeDecoration.as(decoration(_InputFieldState.inactive)),
      $flex.chain
        ..gap(effectiveGap)
        ..mainAxisAlignment(mainAxisAlignment),
      $text.color(effectiveTextColor),
      $with.defaultTextStyle.style.as(resolvedInputTextStyle),
      $with.animatedOpacity(
        opacity: enabled ? 1 : effectiveDisabledOpacityValue,
        duration: effectiveAnimationDuration,
        curve: effectiveAnimationCurve,
      ),
      $on.active(
        $box.shapeDecoration.as(decoration(_InputFieldState.active)),
      ),
      $on.selected(
        $box.shapeDecoration.as(decoration(_InputFieldState.selected)),
      ),
      $on.error(
        $box.shapeDecoration.as(decoration(_InputFieldState.error)),
        $text.color(effectiveErrorColor),
        $with.defaultTextStyle.style.as(resolvedErrorInputTextStyle),
        $with.iconTheme.data.color(effectiveErrorColor),
      ),
      ($on.selected & $on.error)(
        $box.shapeDecoration.as(decoration(_InputFieldState.selectedAndError)),
      ),
    );

    final Style errorTextDefaultStyle = Style(
      $with.defaultTextStyle.style.as(resolvedErrorTextStyle),
      $with.iconTheme.data.color(effectiveErrorColor),
    );

    final Style helperTextDefaultStyle = Style(
      $with.defaultTextStyle.style.as(resolvedHelperTextStyle),
      $with.iconTheme.data.color(effectiveTextColor),
    );

    return MoonRawAuthCode(
      enabled: enabled,
      authInputFieldCount: authInputFieldCount,
      semanticLabel: semanticLabel,
      useHapticFeedback: useHapticFeedback,
      showCursor: showCursor,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      autoFocus: autoFocus,
      autoUnfocus: autoUnfocus,
      keyboardType: keyboardType,
      autoDismissKeyboard: autoDismissKeyboard,
      inputFieldStyle: inputFieldStyle,
      errorText: errorText,
      errorAnimationType: errorAnimationType,
      errorAnimationCurve: effectiveErrorAnimationCurve,
      errorAnimationDuration: effectiveErrorAnimationDuration,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      obscuringWidget: obscuringWidget,
      peekDuration: effectivePeekDuration,
      peekWhenObscuring: peekWhenObscuring,
      textController: textController,
      validator: validator,
      onChanged: onChanged,
      onCompleted: onCompleted,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      hint: hint,
      errorBuilder: (BuildContext _, String? errorText) => SpecBuilder(
        style: errorTextDefaultStyle,
        builder: (BuildContext context) => errorBuilder(context, errorText),
      ),
      helperText: SpecBuilder(
        style: helperTextDefaultStyle,
        builder: (BuildContext _) => helperText ?? const SizedBox.shrink(),
      ),
    );
  }
}
