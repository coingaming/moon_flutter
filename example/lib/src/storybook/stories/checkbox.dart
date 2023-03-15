import 'package:example/src/storybook/common/options.dart';
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
            final thumbColorsKnob = context.knobs.options(
              label: "thumbColor",
              description: "MoonColors variants for the Checkbox thumb.",
              initial: 7, // goten
              options: colorOptions,
            );

            final thumbColor = colorTable(context)[thumbColorsKnob];

            final activeTrackColorsKnob = context.knobs.options(
              label: "activeTrackColor",
              description: "MoonColors variants for the active Checkbox track.",
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeTrackColor = colorTable(context)[activeTrackColorsKnob];

            final inactiveTrackColorsKnob = context.knobs.options(
              label: "inactiveTrackColor",
              description: "MoonColors variants for the active Checkbox track.",
              initial: 2, // beerus
              options: colorOptions,
            );

            final inactiveTrackColor = colorTable(context)[inactiveTrackColorsKnob];

            final isDisabled = context.knobs.boolean(
              label: "Disabled",
              description: "onChanged() is null.",
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Checkbox between LTR and RTL modes.",
            );

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonCheckbox(
                          value: value,
                          onChanged: isDisabled ? null : (newValue) => setState(() => value = newValue),
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
