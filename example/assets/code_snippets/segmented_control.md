import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class SegmentedControl extends StatelessWidget {
    const SegmentedControl({super.key});

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                MoonSegmentedControl(
                    segmentedControlSize: MoonSegmentedControlSize.sm,
                    segments: const [
                        Segment(
                            leading: Icon(MoonIcons.other_frame_24_light),
                            label: Text('Tab1'),
                            trailing: Icon(MoonIcons.other_frame_24_light),
                        ),
                        Segment(
                            leading: Icon(MoonIcons.other_frame_24_light),
                            label: Text('Tab2'),
                            trailing: Icon(MoonIcons.other_frame_24_light),
                        ),
                        Segment(
                            leading: Icon(MoonIcons.other_frame_24_light),
                            label: Text('Tab3'),
                            trailing: Icon(MoonIcons.other_frame_24_light),
                        ),
                    ],
                ),
            ],
        );
    }
}