import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class LinearProgressStory extends StatelessWidget {
  static const path = '/primitives/progress/linear_progress';

  const LinearProgressStory({super.key});

  @override
  Widget build(BuildContext context) {
    final progressSizeKnob = context.knobs.nullable.options(
      label: "linearProgressSize",
      description: "Size variants for MoonLinearProgress.",
      enabled: false,
      initial: MoonLinearProgressSize.x4s,
      options: const [
        Option(label: "x6s", value: MoonLinearProgressSize.x6s),
        Option(label: "x5s", value: MoonLinearProgressSize.x5s),
        Option(label: "x4s", value: MoonLinearProgressSize.x4s),
        Option(label: "x3s", value: MoonLinearProgressSize.x3s),
        Option(label: "x2s", value: MoonLinearProgressSize.x2s),
      ],
    );

    final progressColorKnob = context.knobs.nullable.options(
      label: "color",
      description: "MoonColors variants for MoonLinearProgress progress.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final color = colorTable(context)[progressColorKnob ?? 40];

    final progressBackgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonLinearProgress background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor =
        colorTable(context)[progressBackgroundColorKnob ?? 40];

    final pinColorKnob = context.knobs.nullable.options(
      label: "pinColor",
      description: "MoonColors variants for MoonLinearProgress pin.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final pinColor = colorTable(context)[pinColorKnob ?? 40];

    final pinBorderColorKnob = context.knobs.nullable.options(
      label: "pinBorderColor",
      description: "MoonColors variants for MoonLinearProgress pin border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final pinBorderColor = colorTable(context)[pinBorderColorKnob ?? 40];

    final thumbColorKnob = context.knobs.nullable.options(
      label: "thumbColor",
      description: "MoonColors variants for MoonLinearProgress thumb.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final thumbColor = colorTable(context)[thumbColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonLinearProgress.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final linearProgressValueKnob = context.knobs.slider(
      label: "value",
      description: "Progress value for MoonLinearProgress.",
      initial: 0.5,
    );

    final showPinKnob = context.knobs.boolean(
      label: "showPin",
      description: "Show pin for MoonLinearProgress.",
    );

    final showMinLabelKnob = context.knobs.boolean(
      label: "showMinLabel",
      description: "Show minimum label for MoonLinearProgress.",
    );

    final showMaxLabelKnob = context.knobs.boolean(
      label: "showMaxLabel",
      description: "Show maximum label for MoonLinearProgress.",
    );

    final showPinShadowKnob = context.knobs.boolean(
      label: "showPinShadow",
      description: "Show pin shadow for MoonLinearProgress.",
      initial: true,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 20),
        child: MoonLinearProgress(
          linearProgressSize: progressSizeKnob,
          value: linearProgressValueKnob,
          color: color,
          backgroundColor: backgroundColor,
          borderRadius: borderRadiusKnob != null
              ? BorderRadius.circular(borderRadiusKnob.toDouble())
              : null,
          showMinLabel: showMinLabelKnob,
          showMaxLabel: showMaxLabelKnob,
          showPin: showPinKnob,
          pinStyle: PinStyle(
            pinColor: pinColor,
            pinBorderColor: pinBorderColor,
            thumbColor: thumbColor,
            showShadow: showPinShadowKnob,
          ),
        ),
      ),
    );
  }
}
