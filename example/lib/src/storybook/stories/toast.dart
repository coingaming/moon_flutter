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
              label: "Custom label text",
              initial: "This is a custom toast text",
            );

            final toastPositionKnob = context.knobs.options(
              label: "MoonToastPosition",
              description: "The position of the toast.",
              initial: MoonToastPosition.bottom,
              options: const [
                Option(label: "top", value: MoonToastPosition.top),
                Option(label: "bottom", value: MoonToastPosition.bottom),
              ],
            );

            final toastVariantKnob = context.knobs.options(
              label: "MoonToastVariant",
              description: "The color variant of the toast.",
              initial: MoonToastVariant.original,
              options: const [
                Option(label: "original", value: MoonToastVariant.original),
                Option(label: "inverted", value: MoonToastVariant.inverted),
              ],
            );

            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Toast background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final displayDurationKnob = context.knobs.sliderInt(
              min: 1,
              max: 10,
              initial: 5,
              label: "displayDuration",
              description: "The duration to show the toast.",
            );

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 20,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for Toast.",
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
                    Builder(
                      builder: (context) {
                        return MoonFilledButton(
                          label: const Text("Tap me"),
                          onTap: () {
                            MoonToast().show(
                              context,
                              position: toastPositionKnob,
                              variant: toastVariantKnob,
                              backgroundColor: backgroundColor,
                              displayDuration: Duration(seconds: displayDurationKnob),
                              borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                              leading: const Icon(MoonIcons.info_24),
                              title: Text(customLabelTextKnob),
                              trailing: const Icon(MoonIcons.star_24),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
