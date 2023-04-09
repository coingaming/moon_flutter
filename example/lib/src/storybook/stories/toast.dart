import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ToastStory extends Story {
  ToastStory()
      : super(
          name: "Toast",
          builder: (context) {
            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Toast background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final barrierColorsKnob = context.knobs.options(
              label: "barrierColor",
              description: "MoonColors variants for Toast barrier.",
              initial: 40, // null
              options: colorOptions,
            );

            final barrierColor = colorTable(context)[barrierColorsKnob];

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

            /* Future<void> ToastBuilder(BuildContext context) {
              return showMoonToast<void>(
                context: context,
                useRootNavigator: false,
                barrierColor: barrierColor,
                builder: (_) {
                  return MoonToast(
                    backgroundColor: backgroundColor,
                    borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                    child: Directionality(
                      textDirection: Directionality.of(context),
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                              child: Text(
                                "Toast title",
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
                                "Reopen the Toast to view the updated knob value.",
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
            } */

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
                            showMoonToast(context: context, toast: MoonToast(label: Text("YOOOO")));
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
