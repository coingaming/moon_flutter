import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/common/icons/icons.dart';
import 'package:moon_design/src/widgets/common/icons/moon_icon.dart';

class MoonErrorMessages extends StatelessWidget {
  final List<String> errors;

  /// Default error message widget used in [MoonTextInputGroup].
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

class MoonErrorMessage extends StatelessWidget {
  final String errorText;

  /// Default error message widget used in [MoonTextInput] and [MoonTextArea].
  const MoonErrorMessage({
    super.key,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MoonIcon(MoonIcons.info_16, size: context.moonSizes?.x2s ?? 16),
        SizedBox(width: context.moonSizes?.x5s ?? 4),
        Text(errorText),
      ],
    );
  }
}
