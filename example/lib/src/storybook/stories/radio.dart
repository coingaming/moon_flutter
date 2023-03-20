import 'package:example/src/storybook/common/options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum Choice { first, second }

Choice? value = Choice.first;

class RadioStory extends Story {
  RadioStory()
      : super(
          name: "Radio",
          builder: (context) {
            final switchSizesKnob = context.knobs.options(
              label: "MoonSwitchSize",
              description: "Switch size variants.",
              initial: MoonSwitchSize.xs,
              options: const [
                Option(label: "x2s", value: MoonSwitchSize.x2s),
                Option(label: "xs", value: MoonSwitchSize.xs),
                Option(label: "sm", value: MoonSwitchSize.sm),
              ],
            );

            final thumbColorsKnob = context.knobs.options(
              label: "thumbColor",
              description: "MoonColors variants for the Switch thumb.",
              initial: 7, // goten
              options: colorOptions,
            );

            final thumbColor = colorTable(context)[thumbColorsKnob];

            final activeTrackColorsKnob = context.knobs.options(
              label: "activeTrackColor",
              description: "MoonColors variants for the active Switch track.",
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeTrackColor = colorTable(context)[activeTrackColorsKnob];

            final inactiveTrackColorsKnob = context.knobs.options(
              label: "inactiveTrackColor",
              description: "MoonColors variants for the active Switch track.",
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
                        MoonRadio(
                          value: Choice.first,
                          groupValue: value,
                          onChanged: (choice) => setState(() => value = choice),
                        ),
                        const SizedBox(height: 32),
                        MoonRadio(
                          value: Choice.second,
                          groupValue: value,
                          onChanged: (choice) => setState(() => value = choice),
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
