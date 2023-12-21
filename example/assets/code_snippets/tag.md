import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Tag extends StatelessWidget {
  const Tag({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonTag(
      tagSize: MoonTagSize.sm,
      onTap: () {},
      leading: const Icon(MoonIcons.controls_close_small_16_light),
      label: const Text('This is MoonTag'),
      trailing: const Icon(MoonIcons.controls_close_small_16_light),
    );
  }
}
