import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CircularLoaderStory extends Story {
  CircularLoaderStory()
      : super(
          name: "Loader/CircularLoader",
          builder: (context) {
            final loaderSizesKnob = context.knobs.options(
              label: "MoonCircularLoaderSize",
              description: "CircularLoader size variants.",
              initial: MoonCircularLoaderSize.md,
              options: const [
                Option(label: "x2s", value: MoonCircularLoaderSize.x2s),
                Option(label: "xs", value: MoonCircularLoaderSize.xs),
                Option(label: "sm", value: MoonCircularLoaderSize.sm),
                Option(label: "md", value: MoonCircularLoaderSize.md),
                Option(label: "lg", value: MoonCircularLoaderSize.lg),
              ],
            );

            final loaderColorKnob = context.knobs.options(
              label: "color",
              description: "MoonColors variants for CircularLoader color.",
              initial: 1, // hit
              options: colorOptions,
            );

            final color = colorTable(context)[loaderColorKnob];

            final loaderBackgroundColorKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for CircularLoader background.",
              initial: 39, // none
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[loaderBackgroundColorKnob];

            final loaderStrokeCapKnob = context.knobs.options(
              label: "strokeCap",
              description: "CircularLoader stroke cap.",
              initial: StrokeCap.round,
              options: const [
                Option(label: "round", value: StrokeCap.round),
                Option(label: "square", value: StrokeCap.square),
                Option(label: "butt", value: StrokeCap.butt),
              ],
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonCircularLoader(
                    color: color,
                    backgroundColor: backgroundColor,
                    loaderSize: loaderSizesKnob,
                    strokeCap: loaderStrokeCapKnob,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
