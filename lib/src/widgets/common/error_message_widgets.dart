import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_icons/moon_icons.dart';

class MoonErrorMessages extends StatelessWidget {
  final List<String> errors;

  /// Creates a default error message widget, utilized in [MoonTextInputGroup].
  const MoonErrorMessages({required this.errors});

  List<String> get _nonEmptyErrors => errors.where((String error) => error.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_nonEmptyErrors.length * 2 - 1, (int index) {
        final int derivedIndex = index ~/ 2;

        return index.isEven
            ? MoonErrorMessage(errorText: _nonEmptyErrors[derivedIndex])
            : SizedBox(height: context.moonSizes?.x5s ?? 4);
      }),
    );
  }
}

class MoonErrorMessage extends StatefulWidget {
  final String errorText;
  final Duration duration;
  final Curve curve;

  /// Creates a default error message widget, utilized in [MoonTextInput] and [MoonTextArea].
  const MoonErrorMessage({
    super.key,
    required this.errorText,
    this.duration = const Duration(milliseconds: 167),
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  State<MoonErrorMessage> createState() => _MoonErrorMessageState();
}

class _MoonErrorMessageState extends State<MoonErrorMessage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.curve.flipped,
    );

    _controller
      ..value = 0.0
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Row(
        children: [
          Icon(MoonIcons.generic_info_16_regular, size: context.moonSizes?.x2s ?? 16),
          SizedBox(width: context.moonSizes?.x5s ?? 4),
          Text(widget.errorText),
        ],
      ),
    );
  }
}
