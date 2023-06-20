import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ToastStory extends Story {
  ToastStory()
      : super(
          name: "Toast",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "label text",
              initial: "This is a custom MoonToast text",
            );

            final toastPositionKnob = context.knobs.nullable.options(
              label: "position",
              description: "The position of MoonToast.",
              enabled: false,
              initial: MoonToastPosition.bottom,
              options: const [
                Option(label: "top", value: MoonToastPosition.top),
                Option(label: "bottom", value: MoonToastPosition.bottom),
              ],
            );

            final toastVariantKnob = context.knobs.nullable.options(
              label: "variant",
              description: "The color variant of MoonToast.",
              enabled: false,
              initial: MoonToastVariant.original,
              options: const [
                Option(label: "original", value: MoonToastVariant.original),
                Option(label: "inverted", value: MoonToastVariant.inverted),
              ],
            );

            final textColorsKnob = context.knobs.nullable.options(
              label: "Text color",
              description: "MoonColors variants for MoonToast text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final iconColorsKnob = context.knobs.nullable.options(
              label: "Icon color",
              description: "MoonColors variants for MoonToast icon.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final iconColor = colorTable(context)[iconColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonToast background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonToast.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final displayDurationKnob = context.knobs.nullable.sliderInt(
              label: "displayDuration",
              description: "The duration of showing MoonToast.",
              enabled: false,
              initial: 5,
              min: 1,
              max: 10,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  Builder(
                    builder: (context) {
                      return MoonFilledButton(
                        label: const Text("Tap me"),
                        onTap: () {
                          MoonToast().show(
                            context,
                            position: toastPositionKnob ?? MoonToastPosition.bottom,
                            variant: toastVariantKnob ?? MoonToastVariant.original,
                            backgroundColor: backgroundColor,
                            displayDuration:
                                displayDurationKnob != null ? Duration(seconds: displayDurationKnob) : null,
                            borderRadius:
                                borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                            leading: MoonIcon(MoonIcons.info_24, color: iconColor),
                            title: Text(
                              customLabelTextKnob,
                              style: TextStyle(color: textColor),
                            ),
                            trailing: MoonIcon(MoonIcons.star_24, color: iconColor),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
