import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

int _selectedItem = 0;

class DotIndicatorStory extends Story {
  DotIndicatorStory()
      : super(
          name: "DotIndicator",
          builder: (context) {
            final selectedColorsKnob = context.knobs.nullable.options(
              label: "selectedColor",
              description: "MoonColors variants for MoonDotIndicator selected dot.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final selectedColor = colorTable(context)[selectedColorsKnob ?? 40];

            final unselectedColorsKnob = context.knobs.nullable.options(
              label: "unselectedColor",
              description: "MoonColors variants for MoonDotIndicator unselected dots.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final unselectedColor = colorTable(context)[unselectedColorsKnob ?? 40];

            final sizeKnob = context.knobs.nullable.sliderInt(
              label: "size",
              description: "MoonDotIndicator dot size.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final gapKnob = context.knobs.nullable.sliderInt(
              label: "gap",
              description: "Gap between MoonDotIndicator dots.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            return Center(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      MoonDotIndicator(
                        selectedItem: _selectedItem,
                        itemCount: 4,
                        size: sizeKnob?.toDouble(),
                        gap: gapKnob?.toDouble(),
                        selectedColor: selectedColor,
                        unselectedColor: unselectedColor,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MoonFilledButton(
                            label: const Text("1"),
                            onTap: () => setState(() {
                              _selectedItem = 0;
                            }),
                          ),
                          const SizedBox(width: 8),
                          MoonFilledButton(
                            label: const Text("2"),
                            onTap: () => setState(() {
                              _selectedItem = 1;
                            }),
                          ),
                          const SizedBox(width: 8),
                          MoonFilledButton(
                            label: const Text("3"),
                            onTap: () => setState(() {
                              _selectedItem = 2;
                            }),
                          ),
                          const SizedBox(width: 8),
                          MoonFilledButton(
                            label: const Text("4"),
                            onTap: () => setState(() {
                              _selectedItem = 3;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                    ],
                  );
                },
              ),
            );
          },
        );
}
