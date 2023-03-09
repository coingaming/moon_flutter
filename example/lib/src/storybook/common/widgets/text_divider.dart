import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';

class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: context.moonTypography?.text.text12.copyWith(color: context.moonColors?.trunks),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
