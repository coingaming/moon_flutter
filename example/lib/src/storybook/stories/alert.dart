import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AlertStory extends Story {
  AlertStory()
      : super(
          name: "Alert",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
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

            final showRightIconKnob = context.knobs.boolean(
              label: "Show rightIcon",
              description: "Show widget in the rightIcon slot.",
              initial: true,
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
                    MoonAlert(title: Text("Alert title")),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}