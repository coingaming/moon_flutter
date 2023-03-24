import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum ChoiceCustom { first, second }

enum ChoiceLabel { first, second }

ChoiceCustom? valueCustom = ChoiceCustom.first;
ChoiceLabel? valueLabel = ChoiceLabel.first;

class RadioStory extends Story {
  RadioStory()
      : super(
          name: "Radio",
          builder: (context) {
            final activeColorsKnob = context.knobs.options(
              label: "activeColor",
              description: "MoonColors variants for when Radio is checked.",
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeColor = colorTable(context)[activeColorsKnob];

            final inactiveColorsKnob = context.knobs.options(
              label: "inactiveColor",
              description: "MoonColors variants for when Radio is unchecked.",
              initial: 6, // trunks
              options: colorOptions,
            );

            final inactiveColor = colorTable(context)[inactiveColorsKnob];

            final isToggleable = context.knobs.boolean(
              label: "toggleable",
              description: "Whether the selected Radio can be unselected.",
            );

            final isDisabled = context.knobs.boolean(
              label: "Disabled",
              description: "onChanged() is null.",
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 64),
                        const TextDivider(text: "Customisable Radio buttons"),
                        const SizedBox(height: 32),
                        MoonRadio(
                          value: ChoiceCustom.first,
                          groupValue: valueCustom,
                          onChanged: isDisabled ? null : (ChoiceCustom? choice) => setState(() => valueCustom = choice),
                          activeColor: activeColor,
                          inactiveColor: inactiveColor,
                          toggleable: isToggleable,
                        ),
                        const SizedBox(height: 8),
                        MoonRadio(
                          value: ChoiceCustom.second,
                          groupValue: valueCustom,
                          onChanged: isDisabled ? null : (ChoiceCustom? choice) => setState(() => valueCustom = choice),
                          activeColor: activeColor,
                          inactiveColor: inactiveColor,
                          toggleable: isToggleable,
                        ),
                        const SizedBox(height: 40),
                        const TextDivider(text: "Radios with clickable text"),
                        const SizedBox(height: 32),
                        MoonRadio.withLabel(
                          context,
                          value: ChoiceLabel.first,
                          groupValue: valueLabel,
                          label: "With label #1",
                          onChanged: isDisabled ? null : (ChoiceLabel? choice) => setState(() => valueLabel = choice),
                        ),
                        const SizedBox(height: 8),
                        MoonRadio.withLabel(
                          context,
                          value: ChoiceLabel.second,
                          groupValue: valueLabel,
                          label: "With label #2",
                          onChanged: isDisabled ? null : (ChoiceLabel? choice) => setState(() => valueLabel = choice),
                        ),
                        const SizedBox(height: 64),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
}
