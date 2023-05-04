import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TextAreaStory extends Story {
  TextAreaStory()
      : super(
          name: "TextArea",
          builder: (context) {
            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonTextArea text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final hintTextColorsKnob = context.knobs.nullable.options(
              label: "hintTextColor",
              description: "MoonColors variants for MoonTextArea hint text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final hintTextColor = colorTable(context)[hintTextColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonTextArea background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final activeBorderColorsKnob = context.knobs.nullable.options(
              label: "activeBorderColor",
              description: "MoonColors variants for MoonTextArea active border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeBorderColor = colorTable(context)[activeBorderColorsKnob ?? 40];

            final inactiveBorderColorsKnob = context.knobs.nullable.options(
              label: "inactiveBorderColor",
              description: "MoonColors variants for MoonTextArea inactive border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final inactiveBorderColor = colorTable(context)[inactiveBorderColorsKnob ?? 40];

            final errorBorderColorsKnob = context.knobs.nullable.options(
              label: "errorBorderColor",
              description: "MoonColors variants for MoonTextArea error border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final errorBorderColor = colorTable(context)[errorBorderColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonTextArea.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final enabledKnob = context.knobs.boolean(
              label: "enabled",
              description: "Switch between enabled and disabled states.",
              initial: true,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  Form(
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            MoonTextArea(
                              enabled: enabledKnob,
                              //height: 300,
                              textColor: textColor,
                              hintTextColor: hintTextColor,
                              backgroundColor: backgroundColor,
                              activeBorderColor: activeBorderColor,
                              inactiveBorderColor: inactiveBorderColor,
                              errorBorderColor: errorBorderColor,
                              borderRadius:
                                  borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                              hintText: "Enter your text here...",
                              validator: (value) => value?.length != null && value!.length < 10
                                  ? "The text should be longer than 10 characters."
                                  : null,
                              errorBuilder: (context, errorText) => Text(errorText!),
                            ),
                            const SizedBox(height: 16),
                            MoonFilledButton(
                              label: const Text("Submit"),
                              onTap: () => Form.of(context).validate(),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
