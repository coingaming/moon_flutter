import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

TextEditingController _textEditingController = TextEditingController();

class TextInputStory extends Story {
  TextInputStory()
      : super(
          name: "TextInput",
          builder: (context) {
            final textInputSizesKnob = context.knobs.nullable.options(
              label: "textInputSize",
              description: "Size variants for MoonTextInput.",
              enabled: false,
              initial: MoonTextInputSize.md,
              options: const [
                Option(label: "sm", value: MoonTextInputSize.sm),
                Option(label: "md", value: MoonTextInputSize.md),
                Option(label: "lg", value: MoonTextInputSize.lg),
                Option(label: "xl", value: MoonTextInputSize.xl)
              ],
            );

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonTextInput text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final hintTextColorsKnob = context.knobs.nullable.options(
              label: "hintTextColor",
              description: "MoonColors variants for MoonTextInput hint text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final hintTextColor = colorTable(context)[hintTextColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonTextInput background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final activeBorderColorsKnob = context.knobs.nullable.options(
              label: "activeBorderColor",
              description: "MoonColors variants for MoonTextInput active border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeBorderColor = colorTable(context)[activeBorderColorsKnob ?? 40];

            final inactiveBorderColorsKnob = context.knobs.nullable.options(
              label: "inactiveBorderColor",
              description: "MoonColors variants for MoonTextInput inactive border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final inactiveBorderColor = colorTable(context)[inactiveBorderColorsKnob ?? 40];

            final errorBorderColorsKnob = context.knobs.nullable.options(
              label: "errorBorderColor",
              description: "MoonColors variants for MoonTextInput error border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final errorBorderColor = colorTable(context)[errorBorderColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonTextInput.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final enabledKnob = context.knobs.boolean(
              label: "enabled",
              description: "Switch between enabled and disabled states.",
              initial: true,
            );

            final hasFocusEffectKnob = context.knobs.boolean(
              label: "hasFocusEffect",
              description: "Whether to display focus effect around MoonTextInput.",
              initial: true,
            );

            final hasFloatingLabelKnob = context.knobs.boolean(
              label: "hasFloatingLabel",
              description: "Whether MoonTextInput has floating label.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in MoonTextInput leading slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in MoonTextInput trailing slot.",
              initial: true,
            );

            final showSupportingKnob = context.knobs.boolean(
              label: "helper",
              description: "Show widget in MoonTextInput helper slot.",
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
                            MoonFormTextInput(
                              controller: _textEditingController,
                              enabled: enabledKnob,
                              textInputSize: textInputSizesKnob,
                              hasFocusEffect: hasFocusEffectKnob,
                              hasFloatingLabel: hasFloatingLabelKnob,
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
                              leading: showLeadingKnob
                                  ? const MoonIcon(
                                      MoonIcons.search_24,
                                      size: 24,
                                    )
                                  : null,
                              trailing: showTrailingKnob
                                  ? MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: const MoonIcon(
                                          MoonIcons.close_small_24,
                                          size: 24,
                                        ),
                                        onTap: () => _textEditingController.clear(),
                                      ),
                                    )
                                  : null,
                              helper: showSupportingKnob ? const Text("Supporting text") : null,
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