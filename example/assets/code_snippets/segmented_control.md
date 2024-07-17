import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class SegmentedControl extends StatelessWidget {
  const SegmentedControl({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonSegmentedControl(
      segmentedControlSize: MoonSegmentedControlSize.sm,
      segments: List.generate(
        3,
        (int index) => Segment(
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: Text('Tab${index + 1}'),
          trailing: const Icon(MoonIcons.other_frame_24_light),
        ),
      ),
    );
  }
}