import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum AuthFieldShape {
  box,
  underline,
  circle,
}

enum ErrorAnimationType {
  noAnimation,
  shake,
}

typedef MoonAuthCodeErrorBuilder = Widget Function(
  BuildContext context,
  String? errorText,
);

class MoonAuthCode extends StatefulWidget {
  /// The shape of the auth code input field.
  final AuthFieldShape? authFieldShape;

  /// Whether to automatically dismiss the keyboard when the last input is entered.
  final bool autoDismissKeyboard;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autoFocus;

  /// Whether to automatically unfocus the auth code.
  final bool autoUnfocus;

  /// Whether the auth code is enabled.
  final bool enabled;

  /// Whether to enable the fill color for the auth code input fields.
  final bool enableInputFill;

  /// Whether to replace all typed characters in the auth code input fields with the [obscuringCharacter].
  final bool obscureText;

  /// Whether to briefly display the typed character before obscuring it with the [obscuringCharacter].
  final bool peekWhenObscuring;

  /// Whether to show the cursor in the selected auth code input field.
  final bool showAuthFieldCursor;

  /// Whether to use haptic feedback (vibration) for auth code error state.
  final bool useHapticFeedback;

  /// The border radius of the auth code input field.
  final BorderRadiusGeometry? borderRadius;

  /// The cursor color of the auth code input field.
  final Color? authFieldCursorColor;

  /// The border color of the selected auth code input field.
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

  /// The duration of the auth code input field transition animation.
  final Duration? animationDuration;

  /// The duration of the auth code error state animation.
  final Duration? errorAnimationDuration;

  /// The duration to display the typed character before it is obscured with [obscuringCharacter].
  /// The [peekWhenObscuring] has to be set to true.
  final Duration? peekDuration;

  /// The curve of the auth code input field transition animation.
  final Curve? animationCurve;

  /// The curve of the auth code error state animation.
  final Curve? errorAnimationCurve;

  /// The animation type for the auth code validation error.
  final ErrorAnimationType errorAnimationType;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The total number of input fields to build for the auth code.
  final int authInputFieldCount;

  /// The list of shadows applied to the auth code input field.
  final List<BoxShadow>? boxShadows;

  /// The list of shadows applied to the auth code input field with input.
  final List<BoxShadow>? activeBoxShadows;

  /// The list of shadows applied to the auth code input field without input.
  final List<BoxShadow>? inActiveBoxShadows;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The placement of the auth code input fields along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The error text can be used to force authentication into an error state (useful for asynchronous errors).
  ///
  /// The validator errors take precedence over the provided [errorText].
  final String? errorText;

  /// The character or placeholder to display in the auth code input field when its value is empty.
  final String? hintCharacter;

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

  /// The text style of the [hintCharacter].
  final TextStyle? hintStyle;

  /// The text style of the auth code.
  final TextStyle? textStyle;

  /// The text style of the auth code in error state.
  final TextStyle? errorTextStyle;

  /// The [TextEditingController] used to edit the text in the auth code input field.
  final TextEditingController? textController;

  /// The input text validator for the auth code [TextFormField].
  /// The validator errors take precedence over the provided [errorText].
  final FormFieldValidator<String> validator;

  /// The callback that is called when the auth code input text changes.
  final ValueChanged<String>? onChanged;

  /// The callback that is called when all the auth code input fields are filled.
  final ValueChanged<String>? onCompleted;

  /// The callback that is called when the 'done' or 'next' action is triggered on the keyboard.
  final ValueChanged<String>? onSubmitted;

  /// The [onEditingComplete] callback runs when editing is finished.
  /// It differs from [onSubmitted] by having a default value which
  /// updates [textController] and yields keyboard focus.
  ///
  /// Set this to empty function if keyboard should not close automatically on 'done' or 'next' press.
  final VoidCallback? onEditingComplete;

  /// A builder to build the auth code error widget.
  final MoonAuthCodeErrorBuilder errorBuilder;

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
    this.showAuthFieldCursor = true,
    this.useHapticFeedback = false,
    this.borderRadius,
    this.authFieldCursorColor,
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
    this.hintCharacter,
    this.obscuringCharacter = '•',
    this.semanticLabel,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.visiblePassword,
    this.errorText,
    this.hintStyle,
    this.textStyle,
    this.errorTextStyle,
    this.textController,
    required this.validator,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    required this.errorBuilder,
    this.obscuringWidget,
  })  : assert(authInputFieldCount > 0),
        assert(height == null || height > 0),
        assert(width == null || width > 0);

  @override
  _MoonAuthCodeState createState() => _MoonAuthCodeState();
}

class _MoonAuthCodeState extends State<MoonAuthCode>
    with TickerProviderStateMixin {
  late FocusNode _focusNode;
  late List<String> _inputList;

  late BorderRadiusGeometry _effectiveBorderRadius;
  late Color _effectiveSelectedBorderColor;
  late Color _effectiveActiveBorderColor;
  late Color _effectiveInactiveBorderColor;
  late Color _effectiveErrorBorderColor;
  late Color _effectiveSelectedFillColor;
  late Color _effectiveActiveFillColor;
  late Color _effectiveInactiveFillColor;
  late Color _effectiveTextColor;
  late Color _effectiveCursorColor;
  late double _effectiveBorderWidth;
  late double _effectiveGap;
  late double _effectiveHeight;
  late double _effectiveWidth;
  late TextStyle _effectiveTextStyle;
  late TextStyle _effectiveErrorTextStyle;

  late TextEditingController _textEditingController;
  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;

  AnimationController? _errorAnimationController;
  Animation<Offset>? _errorOffsetAnimation;

  Duration? _peekDuration;
  Duration? _animationDuration;
  Curve? _animationCurve;

  bool _isInErrorMode = false;
  bool _hasPeeked = false;
  int _selectedIndex = 0;
  Timer? _peekDebounce;

  TextStyle get _resolvedTextStyle =>
      _effectiveTextStyle.merge(widget.textStyle).copyWith(
            color: _isInErrorMode
                ? _resolvedErrorTextStyle.color
                : widget.textStyle?.color ?? _effectiveTextColor,
          );

  TextStyle get _hintStyle => _resolvedTextStyle.merge(widget.hintStyle);

  TextStyle get _resolvedErrorTextStyle =>
      _effectiveErrorTextStyle.merge(widget.errorTextStyle).copyWith(
            color: widget.errorTextStyle?.color ?? _effectiveErrorBorderColor,
          );

  Color get _resolvedErrorCursorColor => _isInErrorMode
      ? _resolvedErrorTextStyle.color ?? _effectiveErrorBorderColor
      : _effectiveCursorColor;

  void _initializeFields() {
    _initializeFocusNode();
    _initializeInputList();
    _initializeErrorAnimationListener();
    _initializeTextEditingController();
    _initializeAuthFieldCursor();
  }

  void _initializeFocusNode() {
    _focusNode = (widget.focusNode ?? FocusNode())
      ..addListener(() => setState(() {}));
  }

  void _initializeInputList() {
    _inputList = List<String>.filled(widget.authInputFieldCount, '');
  }

  void _initializeTextEditingController() {
    _textEditingController = widget.textController ?? TextEditingController();

    _textEditingController.addListener(() {
      // Since we use custom error builder, manual input validation is required
      // to trigger validation error. The _validateInput() method returns an
      // error String in case of an validation error, otherwise null.
      if (_validateInput() != null) {
        if (widget.errorAnimationType == ErrorAnimationType.shake) {
          _errorAnimationController!.forward();

          if (widget.useHapticFeedback) HapticFeedback.lightImpact();
        }
        if (!_isInErrorMode) _setState(() => _isInErrorMode = true);
      } else {
        if (_isInErrorMode && widget.errorText == null) {
          _setState(() => _isInErrorMode = false);
        }
      }

      _debounceBlink();

      String currentText = _textEditingController.text;
      if (widget.enabled && _inputList.join() != currentText) {
        if (currentText.length >= widget.authInputFieldCount) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.authInputFieldCount) {
              currentText =
                  currentText.substring(0, widget.authInputFieldCount);
            }
            Future.delayed(
              const Duration(milliseconds: 100),
              () => widget.onCompleted!(currentText),
            );
          }
          if (widget.autoDismissKeyboard) _focusNode.unfocus();
        }
        widget.onChanged?.call(currentText);
      }

      _updateTextField(currentText);
    });

    // If a default value is set for the TextEditingController,
    // update the text field initial value accordingly.
    if (_textEditingController.text.isNotEmpty) {
      _updateTextField(_textEditingController.text);
    }
  }

  void _initializeAuthFieldCursor() {
    _cursorController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _cursorAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _cursorController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.showAuthFieldCursor) _cursorController.repeat();
  }

  void _initializeErrorAnimationListener() {
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;

      _errorAnimationController!.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _errorAnimationController!.reverse();
        }
      });
    });
  }

  void _debounceBlink() {
    _hasPeeked = true;

    if (widget.peekWhenObscuring &&
        _textEditingController.text.length >
            _inputList.where((x) => x.isNotEmpty).length) {
      _setState(() => _hasPeeked = false);

      if (_peekDebounce?.isActive ?? false) _peekDebounce!.cancel();

      _peekDebounce = Timer(_peekDuration!, () {
        _setState(() => _hasPeeked = true);
      });
    }
  }

  void _onFocus() {
    if (widget.autoUnfocus) {
      if (_focusNode.hasFocus &&
          MediaQuery.of(context).viewInsets.bottom == 0) {
        _focusNode.unfocus();
        Future.delayed(
          const Duration(microseconds: 1),
          () => _focusNode.requestFocus(),
        );
      } else {
        _focusNode.requestFocus();
      }
    } else {
      _focusNode.requestFocus();
    }
  }

  Color _getBorderColorFromIndex(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 &&
                index + 1 == widget.authInputFieldCount)) &&
        _focusNode.hasFocus) {
      return _isInErrorMode
          ? _effectiveErrorBorderColor
          : _effectiveSelectedBorderColor;
    } else if (_selectedIndex > index) {
      return _isInErrorMode
          ? _effectiveErrorBorderColor
          : _effectiveActiveBorderColor;
    }

    return _isInErrorMode
        ? _effectiveErrorBorderColor
        : _effectiveInactiveBorderColor;
  }

  Color _getFillColorFromIndex(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 &&
                index + 1 == widget.authInputFieldCount)) &&
        _focusNode.hasFocus) {
      return _effectiveSelectedFillColor;
    } else if (_selectedIndex > index) {
      return _effectiveActiveFillColor;
    }

    return _effectiveInactiveFillColor;
  }

  double _getBorderWidthFromIndex(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 &&
                index + 1 == widget.authInputFieldCount)) &&
        _focusNode.hasFocus) {
      return _effectiveBorderWidth + 1;
    }

    return _effectiveBorderWidth;
  }

  List<BoxShadow>? _getBoxShadowFromIndex(int index) {
    if (_selectedIndex == index) {
      return widget.activeBoxShadows;
    } else if (_selectedIndex > index) {
      return widget.inActiveBoxShadows;
    }

    return [];
  }

  ShapeBorder _getAuthInputFieldShape({required int elementIndex}) {
    final BorderSide borderSide = BorderSide(
      color: _getBorderColorFromIndex(elementIndex),
      width: _getBorderWidthFromIndex(elementIndex),
    );

    switch (widget.authFieldShape) {
      case AuthFieldShape.circle:
        return CircleBorder(side: borderSide);
      case AuthFieldShape.underline:
        return Border(bottom: borderSide);
      default:
        return MoonSquircleBorder(
          borderRadius: _effectiveBorderRadius.squircleBorderRadius(context),
          side: borderSide,
        );
    }
  }

  Future<void> _updateTextField(String text) async {
    final List<String> updatedList =
        List<String>.filled(widget.authInputFieldCount, '');

    for (int i = 0; i < widget.authInputFieldCount; i++) {
      updatedList[i] = text.length > i ? text[i] : '';
    }

    _setState(() {
      _selectedIndex = text.length;
      _inputList = updatedList;
    });
  }

  String? _validateInput() =>
      widget.validator.call(_textEditingController.text);

  void _setState(void Function() function) {
    if (mounted) setState(function);
  }

  @override
  void initState() {
    super.initState();

    _isInErrorMode = widget.errorText != null;

    _initializeFields();
  }

  @override
  void didUpdateWidget(MoonAuthCode oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.errorText != widget.errorText) {
      _setState(() {
        _isInErrorMode = widget.errorText != null || _validateInput() != null;
      });
    }
  }

  @override
  void dispose() {
    if (widget.textController == null) _textEditingController.dispose();
    if (widget.focusNode == null) _focusNode.dispose();

    _errorAnimationController!.dispose();
    _cursorController.dispose();

    super.dispose();
  }

  List<Widget> _generateAuthInputFields() {
    final List<Widget> authInputFields = <Widget>[];

    for (int i = 0; i < widget.authInputFieldCount; i++) {
      authInputFields.add(
        Padding(
          padding: EdgeInsetsDirectional.only(
            end: i == widget.authInputFieldCount - 1 ? 0 : _effectiveGap,
          ),
          child: RepaintBoundary(
            child: Container(
              width: _effectiveWidth,
              height: _effectiveHeight,
              decoration: ShapeDecorationWithPremultipliedAlpha(
                shape: _getAuthInputFieldShape(elementIndex: i),
                color: widget.enableInputFill
                    ? _getFillColorFromIndex(i)
                    : Colors.transparent,
                shadows: (widget.activeBoxShadows != null ||
                        widget.inActiveBoxShadows != null)
                    ? _getBoxShadowFromIndex(i)
                    : widget.boxShadows,
              ),
              child: Center(
                child: _buildChild(i),
              ),
            ),
          ),
        ),
      );
    }

    return authInputFields;
  }

  Widget _buildChild(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 &&
                index + 1 == widget.authInputFieldCount)) &&
        _focusNode.hasFocus &&
        widget.showAuthFieldCursor) {
      final double cursorHeight = _resolvedTextStyle.fontSize!;

      if (_selectedIndex == index + 1 &&
          index + 1 == widget.authInputFieldCount) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: _resolvedTextStyle.fontSize! / 1.5,
                ),
                child: FadeTransition(
                  opacity: _cursorAnimation,
                  child: CustomPaint(
                    size: Size(0, cursorHeight),
                    painter: _CursorPainter(
                      cursorColor: _resolvedErrorCursorColor,
                    ),
                  ),
                ),
              ),
            ),
            _renderAuthInputFieldText(index: index),
          ],
        );
      } else {
        return Center(
          child: FadeTransition(
            opacity: _cursorAnimation,
            child: CustomPaint(
              size: Size(0, cursorHeight),
              painter: _CursorPainter(
                cursorColor: _resolvedErrorCursorColor,
              ),
            ),
          ),
        );
      }
    }
    return _renderAuthInputFieldText(index: index);
  }

  Widget _renderAuthInputFieldText({@required int? index}) {
    assert(index != null);

    final bool showObscured = !widget.peekWhenObscuring ||
        (widget.peekWhenObscuring && _hasPeeked) ||
        index != _inputList.where((x) => x.isNotEmpty).length - 1;

    if (widget.obscuringWidget != null &&
        showObscured &&
        _inputList[index!].isNotEmpty) {
      return widget.obscuringWidget!;
    }

    if (_inputList[index!].isEmpty && widget.hintCharacter != null) {
      return Text(
        widget.hintCharacter!,
        key: ValueKey(_inputList[index]),
        style: _hintStyle,
      );
    }

    final String text =
        widget.obscureText && _inputList[index].isNotEmpty && showObscured
            ? widget.obscuringCharacter
            : _inputList[index];

    return Text(
      text,
      key: ValueKey(_inputList[index]),
      style: _resolvedTextStyle,
    );
  }

  Widget _getTextFormField() {
    final List<TextInputFormatter> inputFormatters = [
      LengthLimitingTextInputFormatter(widget.authInputFieldCount),
    ];

    if (widget.inputFormatters != null) {
      inputFormatters.addAll(widget.inputFormatters!);
    }

    return Directionality(
      textDirection: Directionality.of(context),
      child: SizedBox(
        height: _effectiveHeight,
        child: TextFormField(
          autocorrect: false,
          autofocus: widget.autoFocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _textEditingController,
          cursorWidth: 0.01,
          enabled: widget.enabled,
          enableInteractiveSelection: false,
          enableSuggestions: false,
          focusNode: _focusNode,
          inputFormatters: inputFormatters,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          scrollPadding: const EdgeInsets.all(24.0),
          showCursor: true,
          smartDashesType: SmartDashesType.disabled,
          textInputAction: widget.textInputAction,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          style: const TextStyle(
            color: Colors.transparent,
            fontSize: kIsWeb ? 1 : 0.01,
            height: .01,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.authCodeTheme.properties.borderRadius ??
        MoonBorders.borders.interactiveSm;

    _effectiveBorderWidth = widget.borderWidth ??
        context.moonBorders?.defaultBorderWidth ??
        MoonBorders.borders.defaultBorderWidth;

    _effectiveGap = widget.gap ??
        context.moonTheme?.authCodeTheme.properties.gap ??
        MoonSizes.sizes.x4s;

    _effectiveHeight = widget.height ??
        context.moonTheme?.authCodeTheme.properties.height ??
        MoonSizes.sizes.xl;

    _effectiveWidth = widget.width ??
        context.moonTheme?.authCodeTheme.properties.width ??
        MoonSizes.sizes.lg;

    _effectiveSelectedBorderColor = widget.selectedBorderColor ??
        context.moonTheme?.authCodeTheme.colors.selectedBorderColor ??
        MoonColors.light.piccolo;

    _effectiveActiveBorderColor = widget.activeBorderColor ??
        context.moonTheme?.authCodeTheme.colors.activeBorderColor ??
        MoonColors.light.beerus;

    _effectiveInactiveBorderColor = widget.inactiveBorderColor ??
        context.moonTheme?.authCodeTheme.colors.inactiveBorderColor ??
        MoonColors.light.beerus;

    _effectiveErrorBorderColor = widget.errorBorderColor ??
        context.moonTheme?.authCodeTheme.colors.errorBorderColor ??
        MoonColors.light.chichi;

    _effectiveSelectedFillColor = widget.selectedFillColor ??
        context.moonTheme?.authCodeTheme.colors.selectedFillColor ??
        MoonColors.light.goku;

    _effectiveActiveFillColor = widget.activeFillColor ??
        context.moonTheme?.authCodeTheme.colors.activeFillColor ??
        MoonColors.light.goku;

    _effectiveInactiveFillColor = widget.inactiveFillColor ??
        context.moonTheme?.authCodeTheme.colors.inactiveFillColor ??
        MoonColors.light.goku;

    _effectiveTextStyle =
        context.moonTheme?.authCodeTheme.properties.textStyle ??
            MoonTypography.typography.body.text24;

    _effectiveErrorTextStyle =
        context.moonTheme?.authCodeTheme.properties.errorTextStyle ??
            MoonTypography.typography.body.text12;

    _effectiveTextColor = context.moonTheme?.authCodeTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    _effectiveCursorColor = widget.authFieldCursorColor ??
        context.moonTheme?.authCodeTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    _animationDuration ??= widget.animationDuration ??
        context.moonTheme?.authCodeTheme.properties.animationDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    _animationCurve ??= widget.animationCurve ??
        context.moonTheme?.authCodeTheme.properties.animationCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    _peekDuration ??= widget.peekDuration ??
        context.moonTheme?.authCodeTheme.properties.peekDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final double effectiveDisabledOpacityValue = widget.disabledOpacityValue ??
        context.moonOpacities?.disabled ??
        MoonOpacities.opacities.disabled;

    final Duration effectiveErrorAnimationDuration = widget
            .errorAnimationDuration ??
        context.moonTheme?.authCodeTheme.properties.errorAnimationDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveErrorAnimationCurve = widget.errorAnimationCurve ??
        context.moonTheme?.authCodeTheme.properties.errorAnimationCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    _errorAnimationController ??= AnimationController(
      duration: effectiveErrorAnimationDuration,
      vsync: this,
    );

    _errorOffsetAnimation ??= Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.01, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _errorAnimationController!,
        curve: effectiveErrorAnimationCurve,
      ),
    );

    return Semantics(
      label: widget.semanticLabel,
      child: RepaintBoundary(
        child: AnimatedOpacity(
          duration: _animationDuration!,
          curve: _animationCurve!,
          opacity: widget.enabled ? 1 : effectiveDisabledOpacityValue,
          child: Column(
            children: [
              SlideTransition(
                position: _errorOffsetAnimation!,
                child: Stack(
                  children: <Widget>[
                    AbsorbPointer(
                      child: AutofillGroup(
                        child: _getTextFormField(),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _onFocus(),
                        child: Row(
                          mainAxisAlignment: widget.mainAxisAlignment,
                          children: _generateAuthInputFields(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_isInErrorMode)
                DefaultTextStyle(
                  style: _resolvedErrorTextStyle,
                  child: IconTheme(
                    data: IconThemeData(
                      color: _resolvedErrorTextStyle.color,
                    ),
                    child: widget.errorBuilder(
                      context,
                      _validateInput() ?? widget.errorText,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CursorPainter extends CustomPainter {
  final Color cursorColor;

  _CursorPainter({required this.cursorColor});

  @override
  void paint(Canvas canvas, Size size) {
    const Offset p1 = Offset.zero;
    final Offset p2 = Offset(0, size.height);
    final Paint paint = Paint()
      ..color = cursorColor
      ..strokeWidth = 2;

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
