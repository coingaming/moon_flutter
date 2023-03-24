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
            final checkColorsKnob = context.knobs.options(
              label: "checkColor",
              description: "MoonColors variants for the Checkbox icon.",
              initial: 7, // goten
              options: colorOptions,
            );

            final checkColor = colorTable(context)[checkColorsKnob];

            final activeColorsKnob = context.knobs.options(
              label: "activeColor",
              description: "MoonColors variants for when Checkbox is checked.",
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeColor = colorTable(context)[activeColorsKnob];

            final inactiveColorsKnob = context.knobs.options(
              label: "inactiveColor",
              description: "MoonColors variants for when Checkbox is unchecked.",
              initial: 39, // transparent
              options: colorOptions,
            );

            final inactiveColor = colorTable(context)[inactiveColorsKnob];

            final borderColorsKnob = context.knobs.options(
              label: "borderColor",
              description: "MoonColors variants for Checkbox border.",
              initial: 6, // trunks
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob];

            final isDisabled = context.knobs.boolean(
              label: "Disabled",
              description: "onChanged() is null.",
            );

            final isTristate = context.knobs.boolean(
              label: "tristate",
              description: "Whether the Checkbox uses tristate.",
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
                    const TextDivider(text: "Customisable Checkbox"),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonCheckbox(
                          activeColor: activeColor,
                          borderColor: borderColor,
                          checkColor: checkColor,
                          inactiveColor: inactiveColor,
                          tristate: isTristate,
                          value: value,
                          onChanged: isDisabled ? null : (newValue) => setState(() => value = newValue),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Checkbox with clickable text"),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonCheckbox.withLabel(
                          context,
                          checkColor: checkColor,
                          activeColor: activeColor,
                          inactiveColor: inactiveColor,
                          tristate: isTristate,
                          value: value,
                          onChanged: isDisabled ? null : (newValue) => setState(() => value = newValue),
                          label: "With label",
                        );
                      },
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
