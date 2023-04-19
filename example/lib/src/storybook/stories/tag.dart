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

            final tagSizesKnob = context.knobs.options(
              label: "tagSize",
              description: "Tag size variants.",
              initial: MoonTagSize.xs,
              options: const [
                Option(label: "x2s", value: MoonTagSize.x2s),
                Option(label: "xs", value: MoonTagSize.xs),
              ],
            );

            final textColorsKnob = context.knobs.options(
              label: "textColor",
              description: "MoonColors variants for Tag text.",
              initial: 40, // null
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob];

            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Tag background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 12,
              initial: 4,
              label: "borderRadius",
              description: "Border radius for Tag.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in the leading slot.",
            );

            final showLabelKnob = context.knobs.boolean(
              label: "label",
              description: "Show widget in the label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in the trailing slot.",
              initial: true,
            );

            final setUpperCase = context.knobs.boolean(
              label: "isUpperCase",
              description: "Sets the text style of the Tag to upper case.",
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    MoonTag(
                      borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                      onTap: () {},
                      tagSize: tagSizesKnob,
                      isUpperCase: setUpperCase,
                      textColor: textColor,
                      backgroundColor: backgroundColor,
                      leading: showLeadingKnob ? const Icon(MoonIcons.close_small_16) : null,
                      label: showLabelKnob
                          ? Text(setUpperCase ? customLabelTextKnob.toUpperCase() : customLabelTextKnob)
                          : null,
                      trailing: showTrailingKnob ? const Icon(MoonIcons.close_small_16) : null,
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
