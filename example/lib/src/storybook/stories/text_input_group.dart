import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

TextEditingController _textController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

bool _hidePassword = true;

class TextInputGroupStory extends Story {
  TextInputGroupStory()
      : super(
          name: "TextInputGroup",
          builder: (BuildContext context) {
            final textColorKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonTextInputGroup text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorKnob ?? 40];

            final hintTextColorKnob = context.knobs.nullable.options(
              label: "hintTextColor",
              description: "MoonColors variants for MoonTextInputGroup hint text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final hintTextColor = colorTable(context)[hintTextColorKnob ?? 40];

            final backgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonTextInputGroup background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

            final activeBorderColorKnob = context.knobs.nullable.options(
              label: "activeBorderColor",
              description: "MoonColors variants for MoonTextInputGroup active border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final activeBorderColor = colorTable(context)[activeBorderColorKnob ?? 40];

            final inactiveBorderColorKnob = context.knobs.nullable.options(
              label: "inactiveBorderColor",
              description: "MoonColors variants for MoonTextInputGroup inactive border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final inactiveBorderColor = colorTable(context)[inactiveBorderColorKnob ?? 40];

            final errorColorKnob = context.knobs.nullable.options(
              label: "errorColor",
              description: "MoonColors variants for MoonTextInputGroup error.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final errorColor = colorTable(context)[errorColorKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonTextInputGroup.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final enabledKnob = context.knobs.boolean(
              label: "enabled",
              description: "Switch between enabled and disabled states.",
              initial: true,
            );

            final showHelperKnob = context.knobs.boolean(
              label: "helper",
              description: "Show widget in MoonTextInputGroup helper slot.",
            );

            final BorderRadiusGeometry? borderRadius =
                borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Form(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MoonTextInputGroup(
                            errorTexts: {0: "BOOOO", 1: "sdfgsdg"},
                            enabled: enabledKnob,
                            textColor: textColor,
                            backgroundColor: backgroundColor,
                            inactiveBorderColor: inactiveBorderColor,
                            errorColor: errorColor,
                            borderRadius: borderRadius,
                            helper: showHelperKnob ? const Text("Supporting text") : null,
                            errorBuilder: (BuildContext context, List<String> errorMessages) =>
                                _StoryErrorMessageWidget(errors: errorMessages),
                            children: [
                              MoonFormTextInput(
                                textInputSize: MoonTextInputSize.xl,
                                controller: _textController,
                                enabled: enabledKnob,
                                hasFloatingLabel: true,
                                textColor: textColor,
                                hintTextColor: hintTextColor,
                                activeBorderColor: activeBorderColor,
                                errorColor: errorColor,
                                borderRadius: borderRadius,
                                hintText: "Enter text (over 10 characters)",
                                validator: (String? value) => value?.length != null && value!.length < 10
                                    ? "The text should be longer than 10 characters."
                                    : null,
                                leading: const MoonIcon(
                                  MoonIcons.search_24,
                                  size: 24,
                                ),
                                trailing: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: const MoonIcon(
                                      MoonIcons.close_small_24,
                                      size: 24,
                                    ),
                                    onTap: () => _textController.clear(),
                                  ),
                                ),
                              ),
                              MoonFormTextInput(
                                textInputSize: MoonTextInputSize.xl,
                                controller: _passwordController,
                                enabled: enabledKnob,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _hidePassword,
                                hasFloatingLabel: true,
                                textColor: textColor,
                                hintTextColor: hintTextColor,
                                activeBorderColor: activeBorderColor,
                                errorColor: errorColor,
                                borderRadius: borderRadius,
                                hintText: "Enter password (123abc)",
                                validator: (String? value) => value != "123abc" ? "Wrong password." : null,
                                leading: const MoonIcon(
                                  MoonIcons.password_24,
                                  size: 24,
                                ),
                                trailing: MouseRegion(
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
                                ),
                              ),
                            ],
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
              ),
            );
          },
        );
}

class _StoryErrorMessageWidget extends StatelessWidget {
  final List<String> errors;

  const _StoryErrorMessageWidget({required this.errors});

  List<String> get _nonEmptyErrors => errors.where((String error) => error.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    print(_nonEmptyErrors);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_nonEmptyErrors.length * 2 - 1, (int index) {
        final int derivedIndex = index ~/ 2;

        return index.isEven ? StoryErrorWidget(errorText: _nonEmptyErrors[derivedIndex]) : const SizedBox(height: 4);
      }),
    );
  }
}
