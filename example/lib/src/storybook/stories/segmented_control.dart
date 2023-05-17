import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class SegmentedControlStory extends Story {
  SegmentedControlStory()
      : super(
          name: "SegmentedControl",
          builder: (context) {
            final segmentedControlSizesKnob = context.knobs.nullable.options(
              label: "segmentedControlSize",
              description: "Size variants for MoonSegmentedControl.",
              enabled: false,
              initial: MoonSegmentedControlSize.md,
              options: const [
                Option(label: "sm", value: MoonSegmentedControlSize.sm),
                Option(label: "md", value: MoonSegmentedControlSize.md),
              ],
            );

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonSegmentedControl background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final selectedSegmentColorsKnob = context.knobs.nullable.options(
              label: "selectedSegmentColor",
              description: "MoonColors variants for selected segment.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final selectedSegmentColor = colorTable(context)[selectedSegmentColorsKnob ?? 40];

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for default text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final selectedTextColorsKnob = context.knobs.nullable.options(
              label: "selectedTextColor",
              description: "MoonColors variants for selected segment text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final selectedTextColor = colorTable(context)[selectedTextColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonSegmentedControl.",
              enabled: false,
              initial: 12,
              max: 32,
            );

            final segmentBorderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "segmentBorderRadius",
              description: "Border radius for MoonSegmentedControl segments.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final gapKnob = context.knobs.nullable.sliderInt(
              label: "gap",
              description: "Gap between MoonSegmentedControl segments.",
              enabled: false,
              initial: 4,
              max: 16,
            );

            final isExpandedKnob = context.knobs.boolean(
              label: "isExpanded",
              description: "Whether MoonSegmentControl is horizontally expanded.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in MoonSegmentedControl leading slot.",
            );

            final showLabelKnob = context.knobs.boolean(
              label: "label",
              description: "Show widget in MoonSegmentedControl label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in MoonSegmentedControl trailing slot.",
            );

            final segmentStyle = SegmentStyle(
              textColor: textColor,
              selectedTextColor: selectedTextColor,
              selectedSegmentColor: selectedSegmentColor,
              segmentBorderRadius:
                  segmentBorderRadiusKnob != null ? BorderRadius.circular(segmentBorderRadiusKnob.toDouble()) : null,
            );

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Default MoonSegmentedControl"),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        MoonSegmentedControl(
                          isExpanded: isExpandedKnob,
                          gap: gapKnob?.toDouble(),
                          segmentedControlSize: segmentedControlSizesKnob,
                          backgroundColor: backgroundColor,
                          borderRadius:
                              borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                          segments: [
                            Segment(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              segmentStyle: segmentStyle,
                            ),
                            Segment(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              segmentStyle: segmentStyle,
                            ),
                            Segment(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              segmentStyle: segmentStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const TextDivider(text: "Icon MoonSegmentedControl"),
                        const SizedBox(height: 32),
                        MoonSegmentedControl(
                          isExpanded: isExpandedKnob,
                          gap: gapKnob?.toDouble(),
                          segmentedControlSize: segmentedControlSizesKnob,
                          backgroundColor: backgroundColor,
                          borderRadius:
                              borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                          segments: [
                            Segment(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              segmentStyle: segmentStyle,
                            ),
                            Segment(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              segmentStyle: segmentStyle,
                            ),
                            Segment(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              segmentStyle: segmentStyle,
                            ),
                            Segment(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              segmentStyle: segmentStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
