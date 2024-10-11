import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class LinearLoaderStory extends StatelessWidget {
  static const path = '/primitives/loader/linear_loader';

  const LinearLoaderStory({super.key});

  @override
  Widget build(BuildContext context) {
    final linearLoaderSizeKnob = context.knobs.nullable.options(
      label: "linearLoaderSize",
      description: "Size variants for MoonLinearLoader.",
      enabled: false,
      initial: MoonLinearLoaderSize.x4s,
      options: const [
        Option(label: "x6s", value: MoonLinearLoaderSize.x6s),
        Option(label: "x5s", value: MoonLinearLoaderSize.x5s),
        Option(label: "x4s", value: MoonLinearLoaderSize.x4s),
        Option(label: "x3s", value: MoonLinearLoaderSize.x3s),
        Option(label: "x2s", value: MoonLinearLoaderSize.x2s),
      ],
    );

    final loaderColorKnob = context.knobs.nullable.options(
      label: "color",
      description: "MoonColors variants for MoonLinearLoader.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final color = colorTable(context)[loaderColorKnob ?? 40];

    final loaderBackgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonLinearLoader background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor =
        colorTable(context)[loaderBackgroundColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonLinearLoader.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: MoonLinearLoader(
          linearLoaderSize: linearLoaderSizeKnob,
          color: color,
          backgroundColor: backgroundColor,
          borderRadius: borderRadiusKnob != null
              ? BorderRadius.circular(borderRadiusKnob.toDouble())
              : null,
        ),
      ),
    );
  }
}
