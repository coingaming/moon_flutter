import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TextareaStory extends Story {
  TextareaStory()
      : super(
          name: "Textarea",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
              initial: "This is a custom MoonToast text",
            );

            final toastPositionKnob = context.knobs.options(
              label: "MoonToastPosition",
              description: "The position of the MoonToast.",
              initial: MoonToastPosition.bottom,
              options: const [
                Option(label: "top", value: MoonToastPosition.top),
                Option(label: "bottom", value: MoonToastPosition.bottom),
              ],
            );

            final toastVariantKnob = context.knobs.options(
              label: "MoonToastVariant",
              description: "The color variant of the MoonToast.",
              initial: MoonToastVariant.original,
              options: const [
                Option(label: "original", value: MoonToastVariant.original),
                Option(label: "inverted", value: MoonToastVariant.inverted),
              ],
            );

            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonToast background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final displayDurationKnob = context.knobs.sliderInt(
              min: 1,
              max: 10,
              initial: 5,
              label: "displayDuration",
              description: "The duration to show the MoonToast.",
            );

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 20,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for MoonToast.",
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
                    SizedBox(
                      height: 300,
                      child: TextField(
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Enter your text here',
                          border: OutlineInputBorder(), // Adds a border around the TextField
                        ),
                      ),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
