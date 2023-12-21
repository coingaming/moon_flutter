import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Chip extends StatelessWidget {
  const Chip({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MoonChip(
          chipSize: MoonChipSize.sm,
          leading: Icon(MoonIcons.other_frame_24_light),
          label: Text('MoonChip'),
          trailing: Icon(MoonIcons.other_frame_24_light),
        ),
        MoonChip.text(
          chipSize: MoonChipSize.sm,
          leading: Icon(MoonIcons.other_frame_24_light),
          label: Text('MoonChip with text'),
          trailing: Icon(MoonIcons.other_frame_24_light),
        ),
      ],
    );
  }
}