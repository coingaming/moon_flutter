import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TagStory extends Story {
  TagStory()
      : super(
          name: "Tag",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "label text",
              initial: "MoonTag",
            );

            final tagSizesKnob = context.knobs.nullable.options(
              label: "tagSize",
              description: "Size variants for MoonTag.",
              enabled: false,
              initial: MoonTagSize.xs,
              options: const [
                Option(label: "x2s", value: MoonTagSize.x2s),
                Option(label: "xs", value: MoonTagSize.xs),
              ],
            );

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonTag text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonTag background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonTag.",
              enabled: false,
              initial: 4,
              max: 32,
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in MoonTag leading slot.",
            );

            final showLabelKnob = context.knobs.boolean(
              label: "label",
              description: "Show widget in MoonTag label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in MoonTag trailing slot.",
              initial: true,
            );

            final setUpperCase = context.knobs.boolean(
              label: "isUpperCase",
              description: "Sets the text style of MoonTag to upper case.",
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonTag(
                    borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                    onTap: () {},
                    tagSize: tagSizesKnob,
                    isUpperCase: setUpperCase,
                    textColor: textColor,
                    backgroundColor: backgroundColor,
                    leading: showLeadingKnob ? const MoonIcon(MoonIcons.close_small_16) : null,
                    label: showLabelKnob
                        ? Text(setUpperCase ? customLabelTextKnob.toUpperCase() : customLabelTextKnob)
                        : null,
                    trailing: showTrailingKnob ? const MoonIcon(MoonIcons.close_small_16) : null,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
