import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool? value = false;

class CheckboxStory extends Story {
  CheckboxStory()
      : super(
          name: "Checkbox",
          builder: (context) {
            final textColorsKnob = context.knobs.nullable.options(
              label: "Text color",
              description: "MoonColors variants for MoonCheckbox with label text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final checkColorsKnob = context.knobs.nullable.options(
              label: "checkColor",
              description: "MoonColors variants for MoonCheckbox icon.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final checkColor = colorTable(context)[checkColorsKnob ?? 40];

            final activeColorsKnob = context.knobs.nullable.options(
              label: "activeColor",
              description: "MoonColors variants for checked MoonCheckbox.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final activeColor = colorTable(context)[activeColorsKnob ?? 40];

            final inactiveColorsKnob = context.knobs.nullable.options(
              label: "inactiveColor",
              description: "MoonColors variants for unchecked MoonCheckbox.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final inactiveColor = colorTable(context)[inactiveColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonCheckbox border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final isTristate = context.knobs.boolean(
              label: "tristate",
              description: "Whether MoonCheckbox uses tristate.",
            );

            final isDisabled = context.knobs.boolean(
              label: "Disabled",
              description: "onChanged() is null.",
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  const TextDivider(text: "Customisable MoonCheckbox"),
                  const SizedBox(height: 32),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return MoonCheckbox(
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        checkColor: checkColor,
                        borderColor: borderColor,
                        tristate: isTristate,
                        value: value,
                        onChanged: isDisabled ? null : (newValue) => setState(() => value = newValue),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  const TextDivider(text: "MoonCheckbox with clickable text"),
                  const SizedBox(height: 32),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return MoonCheckbox.withLabel(
                        context,
                        label: "With label",
                        textStyle: TextStyle(color: textColor),
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        checkColor: checkColor,
                        tristate: isTristate,
                        value: value,
                        onChanged: isDisabled ? null : (newValue) => setState(() => value = newValue),
                      );
                    },
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
