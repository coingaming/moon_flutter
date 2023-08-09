import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

TextEditingController _textController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

bool _hidePassword = true;

class TextInputStory extends Story {
  TextInputStory()
      : super(
          name: "TextInput",
          builder: (BuildContext context) {
            final textInputSizeKnob = context.knobs.nullable.options(
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

            final textColorKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonTextInput text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorKnob ?? 40];

            final hintTextColorKnob = context.knobs.nullable.options(
              label: "hintTextColor",
              description: "MoonColors variants for MoonTextInput hint text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final hintTextColor = colorTable(context)[hintTextColorKnob ?? 40];

            final backgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonTextInput background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

            final activeBorderColorKnob = context.knobs.nullable.options(
              label: "activeBorderColor",
              description: "MoonColors variants for MoonTextInput active border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final activeBorderColor = colorTable(context)[activeBorderColorKnob ?? 40];

            final inactiveBorderColorKnob = context.knobs.nullable.options(
              label: "inactiveBorderColor",
              description: "MoonColors variants for MoonTextInput inactive border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final inactiveBorderColor = colorTable(context)[inactiveBorderColorKnob ?? 40];

            final errorBorderColorKnob = context.knobs.nullable.options(
              label: "errorBorderColor",
              description: "MoonColors variants for MoonTextInput error border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final errorBorderColor = colorTable(context)[errorBorderColorKnob ?? 40];

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

            final showFocusEffectKnob = context.knobs.boolean(
              label: "showFocusEffect",
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

            final showHelperKnob = context.knobs.boolean(
              label: "helper",
              description: "Show widget in MoonTextInput helper slot.",
            );

            final BorderRadiusGeometry? borderRadius =
                borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Form(
                child: Builder(
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoonFormTextInput(
                          controller: _textController,
                          enabled: enabledKnob,
                          textInputSize: textInputSizeKnob,
                          showFocusEffect: showFocusEffectKnob,
                          hasFloatingLabel: hasFloatingLabelKnob,
                          textColor: textColor,
                          hintTextColor: hintTextColor,
                          backgroundColor: backgroundColor,
                          activeBorderColor: activeBorderColor,
                          inactiveBorderColor: inactiveBorderColor,
                          errorBorderColor: errorBorderColor,
                          borderRadius: borderRadius,
                          hintText: "Enter your text here (over 10 characters)",
                          validator: (String? value) => value?.length != null && value!.length < 10
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
                                    onTap: () => _textController.clear(),
                                  ),
                                )
                              : null,
                          helper: showHelperKnob ? const Text("Supporting text") : null,
                          errorBuilder: (BuildContext context, String? errorText) =>
                              StoryErrorWidget(errorText: errorText!),
                        ),
                        const SizedBox(height: 16),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return MoonFormTextInput(
                              controller: _passwordController,
                              enabled: enabledKnob,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _hidePassword,
                              textInputSize: textInputSizeKnob,
                              showFocusEffect: showFocusEffectKnob,
                              hasFloatingLabel: hasFloatingLabelKnob,
                              textColor: textColor,
                              hintTextColor: hintTextColor,
                              backgroundColor: backgroundColor,
                              activeBorderColor: activeBorderColor,
                              inactiveBorderColor: inactiveBorderColor,
                              errorBorderColor: errorBorderColor,
                              borderRadius: borderRadius,
                              hintText: "Enter password (123abc)",
                              validator: (String? value) => value != "123abc" ? "Wrong password." : null,
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
                                        child: IntrinsicWidth(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              _hidePassword ? "Show" : "Hide",
                                              style: DefaultTextStyle.of(context)
                                                  .style
                                                  .copyWith(decoration: TextDecoration.underline),
                                            ),
                                          ),
                                        ),
                                        onTap: () => setState(() => _hidePassword = !_hidePassword),
                                      ),
                                    )
                                  : null,
                              helper: showHelperKnob ? const Text("Supporting text") : null,
                              errorBuilder: (BuildContext context, String? errorText) =>
                                  StoryErrorWidget(errorText: errorText!),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        MoonFilledButton(
                          label: const Text("Submit"),
                          onTap: () => Form.of(context).validate(),
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
}
