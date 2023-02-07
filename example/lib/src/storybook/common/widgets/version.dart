import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';

class MoonVersionWidget extends StatelessWidget {
  final String version;

  const MoonVersionWidget({
    super.key,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MoonBrandIcon(),
            const SizedBox(width: 8.0),
            Text(
              "Moon Design",
              style: MoonTypography.textStyles.text.text16,
            ),
            const SizedBox(width: 6.0),
            Text("v$version", style: MoonTypography.textStyles.heading.text16),
          ],
        ),
      ),
    );
  }
}
