import 'package:flutter/material.dart';

class MoonCheckbox extends StatelessWidget {
  /// Determines if the checkbox is toggled on or off.
  final bool? value;

  /// Callback when the switch is toggled on or off.
  final ValueChanged<bool?>? onChanged;

  const MoonCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      splashRadius: 0,
    );
  }
}
