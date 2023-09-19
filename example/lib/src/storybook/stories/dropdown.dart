import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

TextEditingController _dateController = TextEditingController();

bool _show = false;

class DropdownStory extends Story {
  DropdownStory()
      : super(
          name: "Dropdown",
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

            final hoverBorderColorKnob = context.knobs.nullable.options(
              label: "hoverBorderColor",
              description: "MoonColors variants for MoonTextInput hover border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final hoverBorderColor = colorTable(context)[hoverBorderColorKnob ?? 40];

            final errorColorKnob = context.knobs.nullable.options(
              label: "errorColor",
              description: "MoonColors variants for MoonTextInput error.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final errorColor = colorTable(context)[errorColorKnob ?? 40];

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
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MoonDropdown(
                            constrainWidthToChild: true,
                            show: _show,
                            transitionDuration: Duration.zero,
                            onTapOutside: () => setState(() => _show = false),
                            content: Column(
                              children: MoonMenuItem.divideMenuItems(
                                context: context,
                                menuItems: [
                                  MoonMenuItem(
                                    title: Text("Item 1"),
                                    onTap: () {},
                                  ),
                                  MoonMenuItem(title: Text("Item 1")),
                                ],
                              ).toList(),
                            ),
                            child: MoonFilledButton(
                              label: const Text("Dropdown"),
                              onTap: () => setState(() => _show = !_show),
                            ),
                          ),
                          const SizedBox(height: 32),
                          MoonFilledButton(
                            label: const Text("Submit"),
                            onTap: () => Form.of(context).validate(),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
}
