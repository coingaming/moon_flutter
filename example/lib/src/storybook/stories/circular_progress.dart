import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CircularProgressStory extends Story {
  CircularProgressStory()
      : super(
          name: "CircularProgress",
          builder: (context) {
            final circularProgressSizesKnob = context.knobs.options(
              label: "MoonCircularProgressSize",
              description: "CircularProgress size variants.",
              initial: MoonCircularProgressSize.md,
              options: const [
                Option(label: "x2s", value: MoonCircularProgressSize.x2s),
                Option(label: "xs", value: MoonCircularProgressSize.xs),
                Option(label: "sm", value: MoonCircularProgressSize.sm),
                Option(label: "md", value: MoonCircularProgressSize.md),
                Option(label: "lg", value: MoonCircularProgressSize.lg),
              ],
            );

            final circularProgressColorKnob = context.knobs.options(
              label: "color",
              description: "MoonColors variants for CircularProgress color.",
              initial: 0, // piccolo
              options: colorOptions,
            );

            final color = colorTable(context)[circularProgressColorKnob];

            final circularProgressBackgroundColorKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for CircularProgress background.",
              initial: 6, // trunks
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[circularProgressBackgroundColorKnob];

            final circularProgressValueKnob = context.knobs.slider(
              label: "value",
              description: "CircularProgress value.",
              initial: 0.75,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonCircularProgress(
                    value: circularProgressValueKnob,
                    color: color,
                    backgroundColor: backgroundColor,
                    circularProgressSize: circularProgressSizesKnob,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
