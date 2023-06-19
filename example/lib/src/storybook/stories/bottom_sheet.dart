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
                barrierColor: Colors.yellow.withOpacity(0.5),
                backgroundColor: Colors.red.withOpacity(0.5),
                context: context,
                enableDrag: true,
                isDismissible: true,
                containerWidget: (context, animation, child) => Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(/* borderRadiusKnob?.toDouble() ?? */ 32),
                  ),
                  child: child,
                ),
                builder: (context) => ListView.builder(
                  itemBuilder: (_, index) => Container(
                    //color: index.isOdd ? Colors.red : Colors.blue,
                    child: Text(index.toString()),
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
