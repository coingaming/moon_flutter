import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class BottomSheetStory extends Story {
  BottomSheetStory()
      : super(
          name: "BottomSheet",
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

            Future<dynamic> bottomSheetBuilder(BuildContext context) {
              return showMoonModalBottomSheet(
                context: context,
                enableDrag: true,
                isDismissible: true,
                builder: (context) => SizedBox(
                  height: 600,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 41,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                        ),
                      ),
                      ListView.builder(
                        itemCount: 100,
                        itemBuilder: (_, index) => Container(
                          height: 4,
                          padding: const EdgeInsets.all(16),
                          //color: index.isOdd ? Colors.red : Colors.blue,
                          child: Row(
                            children: [Text("Item nr:"), const Spacer(), Text("$index")],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                        onTap: () => bottomSheetBuilder(context),
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
