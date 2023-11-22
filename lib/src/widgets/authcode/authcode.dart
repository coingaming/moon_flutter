import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

enum AuthFieldShape {
  box,
  underline,
  circle,
}

enum ErrorAnimationType {
  noAnimation,
  shake,
}

typedef MoonAuthCodeErrorBuilder = Widget Function(BuildContext context, String? errorText);

class MoonAuthCode extends StatefulWidget {
  /// Shape of auth input field.
  final AuthFieldShape? authFieldShape;

  /// Controls the keyboard dismissal on last input enter.
  final bool autoDismissKeyboard;

  /// {@macro flutter.widgets.Focus.autofocus}.
  final bool autoFocus;

  /// Controls whether to auto unfocus.
  final bool autoUnfocus;

  /// Controls whether MoonAuthCode widget is enabled.
  final bool enabled;

  /// Controls whether to show fill color for inputs.
  final bool enableInputFill;

  /// When set to true, all characters in the auth input field are replaced by [obscuringCharacter].
  final bool obscureText;

  /// Controls whether typed character should be briefly shown before being obscured.
  final bool peekWhenObscuring;

  /// Controls if cursor in selected auth input field should be shown.
  final bool showAuthFieldCursor;

  /// Controls if haptic feedback is used.
  final bool useHapticFeedback;

  /// Border radius of auth input field.
  final BorderRadiusGeometry? borderRadius;

  /// Color of the auth input field cursor.
  final Color? authFieldCursorColor;

  /// Border color of the selected auth input field.
  final Color? selectedBorderColor;

  /// Border color of the active auth input field which has input.
  final Color? activeBorderColor;

  /// Border color of the inactive auth input field, which does not have input.
  final Color? inactiveBorderColor;

  /// Border color of the auth input field when in error mode.
  final Color? errorBorderColor;

  /// Fill color of the selected auth input field.
  ///
  /// [enableInputFill] has to be set true.
  final Color? selectedFillColor;

  /// Fill color of the active auth input field which has input.
  ///
  /// [enableInputFill] has to be set true.
  final Color? activeFillColor;

  /// Fill color of the inactive auth input field which does not have input.
  ///
  /// [enableInputFill] has to be set true.
  final Color? inactiveFillColor;

  /// Border width for the auth input field.
  final double? borderWidth;

  /// The opacity value of the AuthCode when disabled.
  final double? disabledOpacityValue;

  /// Horizontal space between input fields.
  final double? gap;

  /// Height of the auth input field.
  final double? height;

  /// Width of the auth input field.
  final double? width;

  /// AuthCode input field animation duration.
  final Duration? animationDuration;

  /// AuthCode error animation duration.
  final Duration? errorAnimationDuration;

  /// Peek duration if [peekWhenObscuring] is set to true.
  final Duration? peekDuration;

  /// AuthCode input field animation curve.
  final Curve? animationCurve;

  /// AuthCode error animation curve.
  final Curve? errorAnimationCurve;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// Validator for the [TextFormField].
  final FormFieldValidator<String> validator;

  /// Count of auth input fields.
  final int authInputFieldCount;

  /// Box shadow for auth input field.
  final List<BoxShadow>? boxShadows;

  /// Box shadow for selected auth input field.
  final List<BoxShadow>? activeBoxShadows;

  /// Box shadow for inactive auth input field.
  final List<BoxShadow>? inActiveBoxShadows;

  /// Controls how auth input fields are aligned on the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// Builder for the error widget.
  final MoonAuthCodeErrorBuilder errorBuilder;

  /// Displays a hint or a placeholder in the input field if it's value is empty.
  final String? hintCharacter;

  /// Character used for obscuring text if [obscureText] is true.
  ///
  /// Defaults to the character U+2022 BULLET (•).
  final String obscuringCharacter;

  /// Semantic label for MoonAuthCode.
  final String? semanticLabel;

  /// MoonAuthCode error stream controller.
  final StreamController<ErrorAnimationType>? errorStreamController;

  /// [TextEditingController] for an editable text field.
  final TextEditingController? textController;

  /// An action user has requested the text input control to perform.
  final TextInputAction textInputAction;

  /// [TextInputType] for MoonAuthCode.
  final TextInputType keyboardType;

  /// Text style of [hintCharacter].
  final TextStyle? hintStyle;

  /// MoonAuthCode text style.
  final TextStyle? textStyle;

  /// MoonAuthCode error text style.
  final TextStyle? errorTextStyle;

  /// Returns current auth input text.
  final ValueChanged<String>? onChanged;

  /// Returns auth input text when all auth input fields are filled.
  final ValueChanged<String>? onCompleted;

  /// Returns auth input text on done/next action on the keyboard.
  final ValueChanged<String>? onSubmitted;

  /// [onEditingComplete] callback runs when editing is finished.
  /// It differs from [onSubmitted] by having a default value which
  /// updates [textController] and yields keyboard focus.
  ///
  /// Set this to empty function if keyboard should not close automatically on done/next press.
  final VoidCallback? onEditingComplete;

  /// Widget used to obscure text.
  ///
  /// Overrides the [obscuringCharacter].
  final Widget? obscuringWidget;

  /// MDS authcode widget.
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
    this.height,
    this.width,
    this.borderWidth,
    this.disabledOpacityValue,
    this.gap,
    this.errorAnimationCurve,
    this.animationCurve,
    this.errorAnimationDuration,
    this.animationDuration,
    this.peekDuration,
    this.focusNode,
    required this.validator,
    this.authInputFieldCount = 6,
    this.boxShadows,
    this.activeBoxShadows,
    this.inActiveBoxShadows,
    this.mainAxisAlignment = MainAxisAlignment.center,
    required this.errorBuilder,
    this.hintCharacter,
    this.obscuringCharacter = '•',
    this.semanticLabel,
    this.errorStreamController,
    this.textController,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.visiblePassword,
    this.hintStyle,
    this.textStyle,
    this.errorTextStyle,
    this.onChanged,
    this.onCompleted,
    this.onEditingComplete,
    this.onSubmitted,
    this.obscuringWidget,
  })  : assert(authInputFieldCount > 0),
        assert(height == null || height > 0),
        assert(width == null || width > 0);

  @override
  _MoonAuthCodeState createState() => _MoonAuthCodeState();
}

class _MoonAuthCodeState extends State<MoonAuthCode> with TickerProviderStateMixin {
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

  StreamSubscription<ErrorAnimationType>? _errorAnimationSubscription;
  AnimationController? _errorAnimationController;
  Animation<Offset>? _errorOffsetAnimation;
  Duration? _peekDuration;
  Duration? _animationDuration;
  Curve? _animationCurve;

  bool _isInErrorMode = false;
  bool _hasPeeked = false;
  int _selectedIndex = 0;
  Timer? _peekDebounce;

  TextStyle get _resolvedTextStyle => _effectiveTextStyle
      .merge(widget.textStyle)
      .copyWith(color: _isInErrorMode ? _resolvedErrorTextStyle.color : widget.textStyle?.color ?? _effectiveTextColor);

  TextStyle get _hintStyle => _resolvedTextStyle.merge(widget.hintStyle);

  TextStyle get _resolvedErrorTextStyle => _effectiveErrorTextStyle
      .merge(widget.errorTextStyle)
      .copyWith(color: widget.errorTextStyle?.color ?? _effectiveErrorBorderColor);

  Color get _resolvedErrorCursorColor =>
      _isInErrorMode ? _resolvedErrorTextStyle.color ?? _effectiveErrorBorderColor : _effectiveCursorColor;

  void _initializeFields() {
    _initializeFocusNode();
    _initializeInputList();
    _initializeTextEditingController();
    _initializeAuthFieldCursor();
    _initializeErrorAnimationListener();
  }

  void _initializeFocusNode() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => _setState(() {}));
  }

  void _initializeInputList() {
    _inputList = List<String>.filled(widget.authInputFieldCount, '');
  }

  void _initializeTextEditingController() {
    _textEditingController = widget.textController ?? TextEditingController();

    _textEditingController.addListener(() {
      if (_isInErrorMode) {
        _setState(() => _isInErrorMode = false);
      }

      if (widget.useHapticFeedback) HapticFeedback.lightImpact();

      _debounceBlink();

      String currentText = _textEditingController.text;
      if (widget.enabled && _inputList.join() != currentText) {
        if (currentText.length >= widget.authInputFieldCount) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.authInputFieldCount) {
              currentText = currentText.substring(0, widget.authInputFieldCount);
            }
            Future.delayed(const Duration(milliseconds: 100), () => widget.onCompleted!(currentText));
          }
          if (widget.autoDismissKeyboard) _focusNode.unfocus();
        }
        widget.onChanged?.call(currentText);
      }

      _updateTextField(currentText);
    });

    // Update UI if a default value is set for TextEditingController
    if (_textEditingController.text.isNotEmpty) _updateTextField(_textEditingController.text);
  }

  void _initializeAuthFieldCursor() {
    _cursorController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
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
        if (status == AnimationStatus.completed) _errorAnimationController!.reverse();
      });

      if (widget.errorStreamController != null) {
        _errorAnimationSubscription = widget.errorStreamController!.stream.listen((ErrorAnimationType errorAnimation) {
          if (errorAnimation == ErrorAnimationType.shake) {
            _errorAnimationController!.forward();
          }
          _setState(() => _isInErrorMode = true);

          if (widget.useHapticFeedback) HapticFeedback.vibrate();
        });
      }
    });
  }

  void _debounceBlink() {
    _hasPeeked = true;

    if (widget.peekWhenObscuring && _textEditingController.text.length > _inputList.where((x) => x.isNotEmpty).length) {
      _setState(() => _hasPeeked = false);

      if (_peekDebounce?.isActive ?? false) _peekDebounce!.cancel();

      _peekDebounce = Timer(_peekDuration!, () {
        _setState(() => _hasPeeked = true);
      });
    }
  }

  void _onFocus() {
    if (widget.autoUnfocus) {
      if (_focusNode.hasFocus && MediaQuery.of(context).viewInsets.bottom == 0) {
        _focusNode.unfocus();
        Future.delayed(const Duration(microseconds: 1), () => _focusNode.requestFocus());
      } else {
        _focusNode.requestFocus();
      }
    } else {
      _focusNode.requestFocus();
    }
  }

  Color _getBorderColorFromIndex(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.authInputFieldCount)) &&
        _focusNode.hasFocus) {
      return _isInErrorMode ? _effectiveErrorBorderColor : _effectiveSelectedBorderColor;
    } else if (_selectedIndex > index) {
      return _isInErrorMode ? _effectiveErrorBorderColor : _effectiveActiveBorderColor;
    }

    return _isInErrorMode ? _effectiveErrorBorderColor : _effectiveInactiveBorderColor;
  }

  Color _getFillColorFromIndex(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.authInputFieldCount)) &&
        _focusNode.hasFocus) {
      return _effectiveSelectedFillColor;
    } else if (_selectedIndex > index) {
      return _effectiveActiveFillColor;
    }

    return _effectiveInactiveFillColor;
  }

  double _getBorderWidthFromIndex(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.authInputFieldCount)) &&
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
    final List<String> updatedList = List<String>.filled(widget.authInputFieldCount, '');

    for (int i = 0; i < widget.authInputFieldCount; i++) {
      updatedList[i] = text.length > i ? text[i] : '';
    }

    _setState(() {
      _selectedIndex = text.length;
      _inputList = updatedList;
    });
  }

  String? _validateInput() => widget.validator.call(_textEditingController.text);

  void _setState(void Function() function) {
    if (mounted) setState(function);
  }

  @override
  void initState() {
    super.initState();

    _initializeFields();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _errorAnimationController!.dispose();
    _cursorController.dispose();
    _focusNode.dispose();
    _errorAnimationSubscription?.cancel();

    super.dispose();
  }

  List<Widget> _generateAuthInputFields() {
    final List<Widget> authInputFields = <Widget>[];

    for (int i = 0; i < widget.authInputFieldCount; i++) {
      authInputFields.add(
        Padding(
          padding: EdgeInsetsDirectional.only(end: i == widget.authInputFieldCount - 1 ? 0 : _effectiveGap),
          child: RepaintBoundary(
            child: Container(
              width: _effectiveWidth,
              height: _effectiveHeight,
              decoration: ShapeDecorationWithPremultipliedAlpha(
                shape: _getAuthInputFieldShape(elementIndex: i),
                color: widget.enableInputFill ? _getFillColorFromIndex(i) : Colors.transparent,
                shadows: (widget.activeBoxShadows != null || widget.inActiveBoxShadows != null)
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
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.authInputFieldCount)) &&
        _focusNode.hasFocus &&
        widget.showAuthFieldCursor) {
      final double cursorHeight = _resolvedTextStyle.fontSize!;

      if (_selectedIndex == index + 1 && index + 1 == widget.authInputFieldCount) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: _resolvedTextStyle.fontSize! / 1.5),
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

    if (widget.obscuringWidget != null && showObscured && _inputList[index!].isNotEmpty) {
      return widget.obscuringWidget!;
    }

    if (_inputList[index!].isEmpty && widget.hintCharacter != null) {
      return Text(
        widget.hintCharacter!,
        key: ValueKey(_inputList[index]),
        style: _hintStyle,
      );
    }

    final String text = widget.obscureText && _inputList[index].isNotEmpty && showObscured
        ? widget.obscuringCharacter
        : _inputList[index];

    return Text(
      text,
      key: ValueKey(_inputList[index]),
      style: _resolvedTextStyle,
    );
  }

  Widget _getTextFormField() {
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
          inputFormatters: [LengthLimitingTextInputFormatter(widget.authInputFieldCount)],
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

    _effectiveBorderWidth =
        widget.borderWidth ?? context.moonBorders?.defaultBorderWidth ?? MoonBorders.borders.defaultBorderWidth;

    _effectiveGap = widget.gap ?? context.moonTheme?.authCodeTheme.properties.gap ?? MoonSizes.sizes.x4s;

    _effectiveHeight = widget.height ?? context.moonTheme?.authCodeTheme.properties.height ?? MoonSizes.sizes.xl;

    _effectiveWidth = widget.width ?? context.moonTheme?.authCodeTheme.properties.width ?? MoonSizes.sizes.lg;

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
        MoonColors.light.chiChi100;

    _effectiveSelectedFillColor =
        widget.selectedFillColor ?? context.moonTheme?.authCodeTheme.colors.selectedFillColor ?? MoonColors.light.goku;

    _effectiveActiveFillColor =
        widget.activeFillColor ?? context.moonTheme?.authCodeTheme.colors.activeFillColor ?? MoonColors.light.goku;

    _effectiveInactiveFillColor =
        widget.inactiveFillColor ?? context.moonTheme?.authCodeTheme.colors.inactiveFillColor ?? MoonColors.light.goku;

    _effectiveTextStyle =
        context.moonTheme?.authCodeTheme.properties.textStyle ?? MoonTypography.typography.body.text24;

    _effectiveErrorTextStyle =
        context.moonTheme?.authCodeTheme.properties.errorTextStyle ?? MoonTypography.typography.body.text12;

    _effectiveTextColor = context.moonTheme?.authCodeTheme.colors.textColor ?? MoonColors.light.textPrimary;

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

    final double effectiveDisabledOpacityValue =
        widget.disabledOpacityValue ?? context.moonOpacities?.disabled ?? MoonOpacities.opacities.disabled;

    final Duration effectiveErrorAnimationDuration = widget.errorAnimationDuration ??
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
                    child: widget.errorBuilder(context, _validateInput()),
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
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
