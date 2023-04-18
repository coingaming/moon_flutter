import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TextAreaStory extends Story {
  TextAreaStory()
      : super(
          name: "TextArea",
          builder: (context) {
            final textColorsKnob = context.knobs.options(
              label: "textColor",
              description: "MoonColors variants for MoonTextArea text.",
              initial: 40, // null
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob];

            final hintTextColorsKnob = context.knobs.options(
              label: "hintTextColor",
              description: "MoonColors variants for MoonTextArea hint text.",
              initial: 40, // null
              options: colorOptions,
            );

            final hintTextColor = colorTable(context)[hintTextColorsKnob];

            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonTextArea background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final activeBorderColorsKnob = context.knobs.options(
              label: "activeBorderColor",
              description: "MoonColors variants for MoonTextArea active border.",
              initial: 40, // null
              options: colorOptions,
            );

            final activeBorderColor = colorTable(context)[activeBorderColorsKnob];

            final inactiveBorderColorsKnob = context.knobs.options(
              label: "inactiveBorderColor",
              description: "MoonColors variants for MoonTextArea inactive border.",
              initial: 40, // null
              options: colorOptions,
            );

            final inactiveBorderColor = colorTable(context)[inactiveBorderColorsKnob];

            final errorBorderColorsKnob = context.knobs.options(
              label: "errorBorderColor",
              description: "MoonColors variants for MoonTextArea error border.",
              initial: 40, // null
              options: colorOptions,
            );

            final errorBorderColor = colorTable(context)[errorBorderColorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 32,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for MoonTextArea.",
            );

            final enabledKnob = context.knobs.boolean(
              label: "enabled",
              description: "Switch between enabled and disabled states.",
              initial: true,
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
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
                                height: 300,
                                textColor: textColor,
                                hintTextColor: hintTextColor,
                                backgroundColor: backgroundColor,
                                activeBorderColor: activeBorderColor,
                                inactiveBorderColor: inactiveBorderColor,
                                errorBorderColor: errorBorderColor,
                                borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
              ),
            );
          },
        );
}
