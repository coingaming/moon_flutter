import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class LinearProgressStory extends Story {
  LinearProgressStory()
      : super(
          name: "Progress/LinearProgress",
          builder: (context) {
            final progressSizesKnob = context.knobs.options(
              label: "linearProgressSize",
              description: "LinearProgress size variants.",
              initial: MoonLinearProgressSize.x4s,
              options: const [
                Option(label: "x6s", value: MoonLinearProgressSize.x6s),
                Option(label: "x5s", value: MoonLinearProgressSize.x5s),
                Option(label: "x4s", value: MoonLinearProgressSize.x4s),
                Option(label: "x3s", value: MoonLinearProgressSize.x3s),
                Option(label: "x2s", value: MoonLinearProgressSize.x2s),
              ],
            );

            final progressColorKnob = context.knobs.options(
              label: "color",
              description: "MoonColors variants for LinearProgress color.",
              initial: 40, // null
              options: colorOptions,
            );

            final color = colorTable(context)[progressColorKnob];

            final progressBackgroundColorKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for LinearProgress background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[progressBackgroundColorKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 12,
              initial: 8,
              label: "borderRadius",
              description: "LinearProgress border radius.",
            );

            final linearProgressValueKnob = context.knobs.slider(
              label: "value",
              description: "LinearProgress value.",
              initial: 0.5,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonLinearProgress(
                    value: linearProgressValueKnob,
                    linearProgressSize: progressSizesKnob,
                    color: color,
                    backgroundColor: backgroundColor,
                    borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
