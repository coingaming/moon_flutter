import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TextAreaStory extends StatelessWidget {
  static const path = '/primitives/text_area';

  const TextAreaStory({super.key});

  @override
  Widget build(BuildContext context) {
    final textColorKnob = context.knobs.nullable.options(
      label: "textColor",
      description: "MoonColors variants for MoonTextArea text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final hintTextColorKnob = context.knobs.nullable.options(
      label: "hintTextColor",
      description: "MoonColors variants for MoonTextArea hint text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hintTextColor = colorTable(context)[hintTextColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonTextArea background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final activeBorderColorKnob = context.knobs.nullable.options(
      label: "activeBorderColor",
      description: "MoonColors variants for MoonTextArea active border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeBorderColor = colorTable(context)[activeBorderColorKnob ?? 40];

    final inactiveBorderColorKnob = context.knobs.nullable.options(
      label: "inactiveBorderColor",
      description: "MoonColors variants for MoonTextArea inactive border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveBorderColor =
        colorTable(context)[inactiveBorderColorKnob ?? 40];

    final errorColorKnob = context.knobs.nullable.options(
      label: "errorColor",
      description: "MoonColors variants for MoonTextArea in error state.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final errorColor = colorTable(context)[errorColorKnob ?? 40];

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

    final expandsKnob = context.knobs.boolean(
      label: "expands",
      description: "Whether MoonTextArea can expand to fit its contents.",
    );

    final showHelperKnob = context.knobs.boolean(
      label: "helper",
      description: "Show widget in MoonTextArea helper slot.",
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Form(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MoonTextArea(
                    enabled: enabledKnob,
                    expands: expandsKnob,
                    height: expandsKnob ? null : 200,
                    textColor: textColor,
                    hintTextColor: hintTextColor,
                    backgroundColor: backgroundColor,
                    activeBorderColor: activeBorderColor,
                    inactiveBorderColor: inactiveBorderColor,
                    errorColor: errorColor,
                    borderRadius: borderRadiusKnob != null
                        ? BorderRadius.circular(borderRadiusKnob.toDouble())
                        : null,
                    hintText: "Enter your text here...",
                    validator: (String? value) =>
                        value?.length != null && value!.length < 10
                            ? "The text should be longer than 10 characters."
                            : null,
                    onTapOutside: (PointerDownEvent _) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    helper:
                        showHelperKnob ? const Text("Supporting text") : null,
                  ),
                  const SizedBox(height: 32),
                  MoonFilledButton(
                    label: const Text("Submit"),
                    onTap: () => Form.of(context).validate(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
