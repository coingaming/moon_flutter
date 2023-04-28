import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ModalStory extends Story {
  ModalStory()
      : super(
          name: "Modal",
          builder: (context) {
            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonModal background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final barrierColorsKnob = context.knobs.nullable.options(
              label: "barrierColor",
              description: "MoonColors variants for MoonModal barrier.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final barrierColor = colorTable(context)[barrierColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonModal.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            Future<void> modalBuilder(BuildContext context) {
              return showMoonModal<void>(
                context: context,
                useRootNavigator: false,
                barrierColor: barrierColor,
                builder: (_) {
                  return Directionality(
                    textDirection: Directionality.of(context),
                    child: MoonModal(
                      backgroundColor: backgroundColor,
                      borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                              child: Text(
                                "MoonModal title",
                                style: context.moonTypography!.heading.text18,
                              ),
                            ),
                            Container(
                              height: 1,
                              color: context.moonColors!.trunks,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                              child: Text(
                                "Reopen the MoonModal to view the updated knob value.",
                                style: context.moonTypography!.body.text14,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                              child: MoonFilledButton(
                                label: const Text("Okay"),
                                isFullWidth: true,
                                onTap: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  Builder(
                    builder: (context) {
                      return MoonFilledButton(
                        label: const Text("Tap me"),
                        onTap: () => modalBuilder(context),
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
