import 'package:flutter/material.dart';

import 'package:hugeicons/hugeicons.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/theme.dart';

class MoonErrorMessages extends StatelessWidget {
  final List<String> errors;
  final Color errorColor;

  /// Creates a default error message widget, utilized in [MoonInputGroup].
  const MoonErrorMessages({required this.errors, required this.errorColor});

  List<String> get _nonEmptyErrors =>
      errors.where((String error) => error.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_nonEmptyErrors.length * 2 - 1, (int index) {
        final int derivedIndex = index ~/ 2;

        return index.isEven
            ? MoonMessage(
                text: _nonEmptyErrors[derivedIndex],
                horizontalGap: context.moonSizes?.x5s ?? 4,
                icon: Icon(
                  HugeIcons.strokeRoundedAlertCircle,
                  size: 16,
                  color: errorColor,
                ),
              )
            : SizedBox(height: context.moonSizes?.x5s ?? 4);
      }),
    );
  }
}
