import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TagStory extends Story {
  TagStory()
      : super(
          name: "Tag",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
              initial: "MoonTag",
            );

            final colorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Tag.",
              initial: 5, // bulma
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 12,
              initial: 4,
              label: "borderRadius",
              description: "Border radius for Tag.",
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

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            final setUpperCase = context.knobs.boolean(
              label: "isUpperCase",
              description: "Sets the text style of the Tag to upper case.",
            );

            final showLeftIconKnob = context.knobs.boolean(
              label: "Show leftIcon",
              description: "Show widget in the leftIcon slot.",
            );

            final showLabelKnob = context.knobs.boolean(
              label: "Show label",
              description: "Show widget in the label slot.",
              initial: true,
            );

            final showRightIconKnob = context.knobs
                .boolean(label: "Show rightIcon", description: "Show widget in the rightIcon slot.", initial: true);

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    MoonTag(
                      borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                      tagSize: tagSizesKnob,
                      isUpperCase: setUpperCase,
                      backgroundColor: color,
                      leftIcon: showLeftIconKnob ? const Icon(MoonIconsControls.close_small16) : null,
                      label: showLabelKnob
                          ? Text(setUpperCase ? customLabelTextKnob.toUpperCase() : customLabelTextKnob)
                          : null,
                      rightIcon: showRightIconKnob ? const Icon(MoonIconsControls.close_small16) : null,
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
