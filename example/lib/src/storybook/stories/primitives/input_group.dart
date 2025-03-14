import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class InputGroupStory extends StatefulWidget {
  static const path = '/primitives/input_group';

  const InputGroupStory({super.key});

  @override
  State<InputGroupStory> createState() => _InputGroupStoryState();
}

class _InputGroupStoryState extends State<InputGroupStory> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final textColorKnob = context.knobs.nullable.options(
      label: "textColor",
      description: "MoonColors variants for MoonInputGroup text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final hintTextColorKnob = context.knobs.nullable.options(
      label: "hintTextColor",
      description: "MoonColors variants for MoonInputGroup hint text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hintTextColor = colorTable(context)[hintTextColorKnob ?? 40];

    final labelColorKnob = context.knobs.nullable.options(
      label: "Label text color",
      description: "MoonColors variants for MoonInputGroup label text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final labelColor = colorTable(context)[labelColorKnob ?? 40];

    final helperTextColorKnob = context.knobs.nullable.options(
      label: "Helper text color",
      description: "MoonColors variants for MoonInputGroup helper text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final helperTextColor = colorTable(context)[helperTextColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonInputGroup background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final borderColorKnob = context.knobs.nullable.options(
      label: "borderColor",
      description: "MoonColors variants for MoonInputGroup border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final borderColor = colorTable(context)[borderColorKnob ?? 40];

    final hoverColorKnob = context.knobs.nullable.options(
      label: "hoverColor",
      description: "MoonColors variants for MoonInputGroup children on hover.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hoverColor = colorTable(context)[hoverColorKnob ?? 40];

    final activeChildrenBorderColorKnob = context.knobs.nullable.options(
      label: "activeBorderColor",
      description:
          "MoonColors variants for MoonInputGroup children active border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeBorderColor =
        colorTable(context)[activeChildrenBorderColorKnob ?? 40];

    final errorColorKnob = context.knobs.nullable.options(
      label: "errorColor",
      description: "MoonColors variants for MoonInputGroup in error state.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final errorColor = colorTable(context)[errorColorKnob ?? 40];

    final orientationKnob = context.knobs.nullable.options(
      label: "orientation",
      description: "MoonInputGroup orientation.",
      enabled: false,
      initial: MoonInputGroupOrientation.vertical,
      options: [
        const Option(
          label: "vertical",
          value: MoonInputGroupOrientation.vertical,
        ),
        const Option(
          label: "horizontal",
          value: MoonInputGroupOrientation.horizontal,
        ),
      ],
    );

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonInputGroup.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final enabledKnob = context.knobs.boolean(
      label: "enabled",
      description: "Switch between enabled and disabled states.",
      initial: true,
    );

    final showLabelKnob = context.knobs.boolean(
      label: "label",
      description: "Show label for MoonInputGroup.",
      initial: true,
    );

    final showHintKnob = context.knobs.boolean(
      label: "hintText",
      description: "Show hint text for MoonInputGroup children.",
      initial: true,
    );

    final showHelperTextKnob = context.knobs.boolean(
      label: "helperText",
      description: "Show helper text for MoonInputGroup.",
    );

    final BorderRadiusGeometry? borderRadius = borderRadiusKnob != null
        ? BorderRadius.circular(borderRadiusKnob.toDouble())
        : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Form(
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MoonInputGroup(
                    enabled: enabledKnob,
                    backgroundColor: backgroundColor,
                    borderColor: borderColor,
                    hoverColor: hoverColor,
                    errorColor: errorColor,
                    hintColor: hintTextColor,
                    label: showLabelKnob
                        ? Text(
                            "Input Group",
                            style: TextStyle(color: labelColor ?? Colors.black),
                          )
                        : null,
                    helperErrorTextStyle: TextStyle(color: helperTextColor),
                    borderRadius: borderRadius,
                    orientation:
                        orientationKnob ?? MoonInputGroupOrientation.vertical,
                    helperText: showHelperTextKnob ? "Supporting text" : null,
                    children: [
                      MoonInput.form(
                        inputSize: MoonInputSize.xl,
                        controller: _textController,
                        textColor: textColor,
                        activeBorderColor: activeBorderColor,
                        hintText: showHintKnob
                            ? "Enter text (over 10 characters)"
                            : null,
                        validator: (String? value) => value?.length != null &&
                                value!.length < 10
                            ? "The text should be longer than 10 characters."
                            : null,
                        onTapOutside: (PointerDownEvent _) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        leading: const Icon(
                          MoonIcons.generic_search_24_light,
                          size: 24,
                        ),
                        trailing: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: const Icon(
                              MoonIcons.controls_close_small_24_light,
                              size: 24,
                            ),
                            onTap: () => _textController.clear(),
                          ),
                        ),
                      ),
                      MoonInput.form(
                        inputSize: MoonInputSize.xl,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _hidePassword,
                        textColor: textColor,
                        activeBorderColor: activeBorderColor,
                        hintText:
                            showHintKnob ? "Enter password (123abc)" : null,
                        validator: (String? value) =>
                            value != "123abc" ? "Wrong password." : null,
                        onTapOutside: (PointerDownEvent _) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        leading: const Icon(
                          MoonIcons.security_password_24_light,
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
                                      .copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                            ),
                            onTap: () =>
                                setState(() => _hidePassword = !_hidePassword),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  MoonFilledButton(
                    label: const Text("Submit"),
                    onTap:
                        enabledKnob ? () => Form.of(context).validate() : null,
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
