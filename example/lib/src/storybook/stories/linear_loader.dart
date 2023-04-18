import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class LinearLoaderStory extends Story {
  LinearLoaderStory()
      : super(
          name: "Loader/LinearLoader",
          builder: (context) {
            final loaderSizesKnob = context.knobs.options(
              label: "MoonLinearLoaderSize",
              description: "LinearLoader size variants.",
              initial: MoonLinearLoaderSize.x4s,
              options: const [
                Option(label: "x6s", value: MoonLinearLoaderSize.x6s),
                Option(label: "x5s", value: MoonLinearLoaderSize.x5s),
                Option(label: "x4s", value: MoonLinearLoaderSize.x4s),
                Option(label: "x3s", value: MoonLinearLoaderSize.x3s),
                Option(label: "x2s", value: MoonLinearLoaderSize.x2s),
              ],
            );

            final loaderColorKnob = context.knobs.options(
              label: "color",
              description: "MoonColors variants for LinearLoader color.",
              initial: 1, // hit
              options: colorOptions,
            );

            final color = colorTable(context)[loaderColorKnob];

            final loaderBackgroundColorKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for LinearLoader background.",
              initial: 39, // none
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[loaderBackgroundColorKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              label: "borderRadius",
              description: "LinearLoader border radius.",
              initial: 8,
              max: 12,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonLinearLoader(
                    loaderSize: loaderSizesKnob,
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
