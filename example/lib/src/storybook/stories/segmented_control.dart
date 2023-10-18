import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class SegmentedControlStory extends Story {
  SegmentedControlStory()
      : super(
          name: "SegmentedControl",
          builder: (BuildContext context) {
            final segmentedControlSizeKnob = context.knobs.nullable.options(
              label: "segmentedControlSize",
              description: "Size variants for MoonSegmentedControl.",
              enabled: false,
              initial: MoonSegmentedControlSize.md,
              options: const [
                Option(label: "sm", value: MoonSegmentedControlSize.sm),
                Option(label: "md", value: MoonSegmentedControlSize.md),
              ],
            );

            final backgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonSegmentedControl background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

            final selectedSegmentColorKnob = context.knobs.nullable.options(
              label: "selectedSegmentColor",
              description: "MoonColors variants for selected segment.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final selectedSegmentColor = colorTable(context)[selectedSegmentColorKnob ?? 40];

            final textColorKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for default text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorKnob ?? 40];

            final selectedTextColorKnob = context.knobs.nullable.options(
              label: "selectedTextColor",
              description: "MoonColors variants for selected segment text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final selectedTextColor = colorTable(context)[selectedTextColorKnob ?? 40];

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
              max: 12,
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

            final isExpandedKnob = context.knobs.boolean(
              label: "isExpanded",
              description: "Expand MoonSegmentControl horizontally.",
            );

            final isDisabledKnob = context.knobs.boolean(
              label: "isDisabled",
              description: "Disable MoonSegmentedControl.",
            );

            final SegmentStyle segmentStyle = SegmentStyle(
              textColor: textColor,
              selectedTextColor: selectedTextColor,
              selectedSegmentColor: selectedSegmentColor,
              segmentBorderRadius:
                  segmentBorderRadiusKnob != null ? BorderRadius.circular(segmentBorderRadiusKnob.toDouble()) : null,
            );

            final BorderRadiusGeometry? borderRadius =
                borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Column(
                  children: [
                    const TextDivider(
                      text: "Default MoonSegmentedControl",
                      paddingTop: 0,
                    ),
                    Column(
                      children: [
                        MoonSegmentedControl(
                          isDisabled: isDisabledKnob,
                          isExpanded: isExpandedKnob,
                          gap: gapKnob?.toDouble(),
                          segmentedControlSize: segmentedControlSizeKnob,
                          backgroundColor: backgroundColor,
                          borderRadius: borderRadius,
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
                        const TextDivider(text: "Icon MoonSegmentedControl"),
                        MoonSegmentedControl(
                          isDisabled: isDisabledKnob,
                          isExpanded: isExpandedKnob,
                          gap: gapKnob?.toDouble(),
                          segmentedControlSize: segmentedControlSizeKnob,
                          backgroundColor: backgroundColor,
                          borderRadius: borderRadius,
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
                  ],
                ),
              ),
            );
          },
        );
}
