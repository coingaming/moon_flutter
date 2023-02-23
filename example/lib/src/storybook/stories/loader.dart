import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class LoaderStory extends Story {
  LoaderStory()
      : super(
          name: "Loader",
          builder: (context) {
            final loaderSizesKnob = context.knobs.options(
              label: "loaderSize",
              description: "Loader size variants.",
              initial: MoonLoaderSize.md,
              options: const [
                Option(label: "x2s", value: MoonLoaderSize.x2s),
                Option(label: "xs", value: MoonLoaderSize.xs),
                Option(label: "sm", value: MoonLoaderSize.sm),
                Option(label: "md", value: MoonLoaderSize.md),
                Option(label: "lg", value: MoonLoaderSize.lg),
              ],
            );

            final loaderColorKnob = context.knobs.options(
              label: "color",
              description: "MoonColors variants for Loader color.",
              initial: 1, // hit
              options: colorOptions,
            );

            final color = colorTable(context)[loaderColorKnob];

            final loaderBackgroundColorKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Loader background.",
              initial: 39, // none
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[loaderBackgroundColorKnob];

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonLoader(
                    color: color,
                    backgroundColor: backgroundColor,
                    loaderSize: loaderSizesKnob,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
