import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class StoryErrorWidget extends StatelessWidget {
  final String errorText;

  const StoryErrorWidget({
    super.key,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const MoonIcon(MoonIcons.info_16, size: 16),
        const SizedBox(width: 4),
        Text(errorText),
      ],
    );
  }
}
