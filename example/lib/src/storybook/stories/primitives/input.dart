import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class InputStory extends StatefulWidget {
  static const path = '/primitives/input';

  const InputStory({super.key});

  @override
  State<InputStory> createState() => _InputStoryState();
}

class _InputStoryState extends State<InputStory> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final inputSizeKnob = context.knobs.nullable.options(
      label: "inputSize",
      description: "Size variants for MoonInput.",
      enabled: false,
      initial: MoonInputSize.md,
      options: const [
        Option(label: "sm", value: MoonInputSize.sm),
        Option(label: "md", value: MoonInputSize.md),
        Option(label: "lg", value: MoonInputSize.lg),
        Option(label: "xl", value: MoonInputSize.xl),
      ],
    );

    final textColorKnob = context.knobs.nullable.options(
      label: "textColor",
      description: "MoonColors variants for MoonInput text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final hintTextColorKnob = context.knobs.nullable.options(
      label: "hintTextColor",
      description: "MoonColors variants for MoonInput hint text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hintTextColor = colorTable(context)[hintTextColorKnob ?? 40];

    final helperTextColorKnob = context.knobs.nullable.options(
      label: "Helper text color",
      description: "MoonColors variants for MoonInput helper text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final helperTextColor = colorTable(context)[helperTextColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonInput background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final activeBorderColorKnob = context.knobs.nullable.options(
      label: "activeBorderColor",
      description: "MoonColors variants for MoonInput active border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeBorderColor = colorTable(context)[activeBorderColorKnob ?? 40];

    final inactiveBorderColorKnob = context.knobs.nullable.options(
      label: "inactiveBorderColor",
      description: "MoonColors variants for MoonInput inactive border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveBorderColor =
        colorTable(context)[inactiveBorderColorKnob ?? 40];

    final hoverColorKnob = context.knobs.nullable.options(
      label: "hoverColor",
      description: "MoonColors variants for MoonInput on hover.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hoverColor = colorTable(context)[hoverColorKnob ?? 40];

    final errorColorKnob = context.knobs.nullable.options(
      label: "errorColor",
      description: "MoonColors variants for MoonInput in error state.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final errorColor = colorTable(context)[errorColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonInput.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final enabledKnob = context.knobs.boolean(
      label: "enabled",
      description: "Switch between enabled and disabled states.",
      initial: true,
    );

    final hasFloatingLabelKnob = context.knobs.boolean(
      label: "hasFloatingLabel",
      description: "Whether MoonInput has floating label.",
    );

    final showLeadingKnob = context.knobs.boolean(
      label: "leading",
      description: "Show widget in MoonInput leading slot.",
      initial: true,
    );

    final showTrailingKnob = context.knobs.boolean(
      label: "trailing",
      description: "Show widget in MoonInput trailing slot.",
      initial: true,
    );

    final showLabelKnob = context.knobs.boolean(
      label: "label",
      description: "Show label for MoonInput.",
      initial: true,
    );

    final showHintKnob = context.knobs.boolean(
      label: "hintText",
      description: "Show hint text for MoonInput.",
      initial: true,
    );

    final showHelperKnob = context.knobs.boolean(
      label: "helperText",
      description: "Show helper text for MoonInput.",
    );

    final BorderRadiusGeometry? borderRadius = borderRadiusKnob != null
        ? BorderRadius.circular(borderRadiusKnob.toDouble())
        : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Form(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MoonInput.form(
                    controller: _textController,
                    enabled: enabledKnob,
                    inputSize: inputSizeKnob,
                    hasFloatingLabel: hasFloatingLabelKnob,
                    textColor: textColor,
                    hintTextColor: hintTextColor,
                    helperErrorTextStyle: TextStyle(color: helperTextColor),
                    backgroundColor: backgroundColor,
                    activeBorderColor: activeBorderColor,
                    inactiveBorderColor: inactiveBorderColor,
                    hoverColor: hoverColor,
                    errorColor: errorColor,
                    borderRadius: borderRadius,
                    validator: (String? value) =>
                        value != null && value.length < 10
                            ? "The text should be longer than 10 characters."
                            : null,
                    onTapOutside: (PointerDownEvent _) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    label: showLabelKnob ? const Text("Label") : null,
                    hintText:
                        showHintKnob ? "Enter text (over 10 characters)" : null,
                    helperText: showHelperKnob ? 'Supporting Text' : null,
                    leading: showLeadingKnob
                        ? const Icon(
                            MoonIcons.generic_search_24_light,
                            size: 24,
                          )
                        : null,
                    trailing: showTrailingKnob
                        ? MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: const Icon(
                                MoonIcons.controls_close_small_24_light,
                                size: 24,
                              ),
                              onTap: () => _textController.clear(),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return MoonInput.form(
                        controller: _passwordController,
                        enabled: enabledKnob,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _hidePassword,
                        inputSize: inputSizeKnob,
                        hasFloatingLabel: hasFloatingLabelKnob,
                        textColor: textColor,
                        hintTextColor: hintTextColor,
                        helperErrorTextStyle: TextStyle(color: helperTextColor),
                        backgroundColor: backgroundColor,
                        activeBorderColor: activeBorderColor,
                        inactiveBorderColor: inactiveBorderColor,
                        hoverColor: hoverColor,
                        errorColor: errorColor,
                        borderRadius: borderRadius,
                        validator: (String? value) =>
                            value != "123abc" ? "Wrong password." : null,
                        onTapOutside: (PointerDownEvent _) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        label: showLabelKnob ? const Text("Label") : null,
                        hintText:
                            showHintKnob ? "Enter password (123abc)" : null,
                        helperText: showHelperKnob ? "Supporting text" : null,
                        leading: showLeadingKnob
                            ? const Icon(
                                MoonIcons.security_password_24_light,
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
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ),
                                  ),
                                  onTap: () => setState(
                                    () => _hidePassword = !_hidePassword,
                                  ),
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  MoonInput.form(
                    readOnly: true,
                    controller: _dateController,
                    enabled: enabledKnob,
                    inputSize: inputSizeKnob,
                    textColor: textColor,
                    hintTextColor: hintTextColor,
                    helperErrorTextStyle: TextStyle(color: helperTextColor),
                    backgroundColor: backgroundColor,
                    activeBorderColor: activeBorderColor,
                    inactiveBorderColor: inactiveBorderColor,
                    hoverColor: hoverColor,
                    errorColor: errorColor,
                    borderRadius: borderRadius,
                    validator: (String? value) =>
                        value != null && value.isEmpty ? "Pick a date." : null,
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      );

                      if (pickedDate != null) {
                        _dateController.text =
                            "${pickedDate.toLocal()}".split(" ")[0];
                      }
                    },
                    hintText: showHintKnob ? "Pick a date" : null,
                    helperText: showHelperKnob ? "Supporting text" : null,
                    leading: showLeadingKnob
                        ? const Icon(
                            MoonIcons.time_calendar_24_light,
                            size: 24,
                          )
                        : null,
                    trailing: showTrailingKnob
                        ? MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: const Icon(
                                MoonIcons.controls_close_small_24_light,
                                size: 24,
                              ),
                              onTap: () => _dateController.clear(),
                            ),
                          )
                        : null,
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
