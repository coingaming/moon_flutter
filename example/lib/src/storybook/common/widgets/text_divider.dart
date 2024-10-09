import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final double paddingTop;
  final double paddingBottom;

  const TextDivider({
    super.key,
    required this.text,
    this.paddingTop = 48,
    this.paddingBottom = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      child: Row(
        children: [
          const Expanded(
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              text,
              style: context.moonTypography?.body.text12
                  .copyWith(color: context.moonColors?.trunks),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
