import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool value = false;

class SwitchStory extends Story {
  SwitchStory()
      : super(
          name: "Switch",
          builder: (context) {
            final switchSizesKnob = context.knobs.nullable.options(
              label: "switchSize",
              description: "Switch size variants.",
              enabled: false,
              initial: MoonSwitchSize.xs,
              options: const [
                Option(label: "x2s", value: MoonSwitchSize.x2s),
                Option(label: "xs", value: MoonSwitchSize.xs),
                Option(label: "sm", value: MoonSwitchSize.sm),
              ],
            );

            final thumbColorsKnob = context.knobs.nullable.options(
              label: "thumbColor",
              description: "MoonColors variants for the Switch thumb.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final thumbColor = colorTable(context)[thumbColorsKnob ?? 40];

            final activeTrackColorsKnob = context.knobs.nullable.options(
              label: "activeTrackColor",
              description: "MoonColors variants for the active Switch track.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeTrackColor = colorTable(context)[activeTrackColorsKnob ?? 40];

            final inactiveTrackColorsKnob = context.knobs.nullable.options(
              label: "inactiveTrackColor",
              description: "MoonColors variants for the inactive Switch track.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final inactiveTrackColor = colorTable(context)[inactiveTrackColorsKnob ?? 40];

            final isDisabled = context.knobs.boolean(
              label: "Disabled",
              description: "onChanged() is null.",
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  const TextDivider(text: "Customisable Switch"),
                  const SizedBox(height: 32),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return MoonSwitch(
                        switchSize: switchSizesKnob,
                        thumbColor: thumbColor,
                        activeTrackColor: activeTrackColor,
                        inactiveTrackColor: inactiveTrackColor,
                        value: value,
                        onChanged: isDisabled ? null : (newValue) => setState(() => value = newValue),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  const TextDivider(text: "Switches with custom children"),
                  const SizedBox(height: 32),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return MoonSwitch(
                        activeThumbWidget: const Icon(
                          MoonIcons.check_alternative_16,
                          size: 14,
                        ),
                        inactiveThumbWidget: const Icon(
                          MoonIcons.close_16,
                          size: 12,
                        ),
                        activeTrackWidget: Text(
                          "ON",
                          style: MoonTextStyles.caption.text8.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
                          textAlign: TextAlign.center,
                        ),
                        inactiveTrackWidget: Text(
                          "OFF",
                          style: MoonTextStyles.caption.text8.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
                          textAlign: TextAlign.center,
                        ),
                        value: value,
                        onChanged: (newValue) => setState(() => value = newValue),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return MoonSwitch(
                        activeTrackWidget: const Icon(
                          MoonIcons.check_alternative_16,
                          size: 14,
                        ),
                        inactiveTrackWidget: const Icon(
                          MoonIcons.close_16,
                          size: 12,
                        ),
                        value: value,
                        onChanged: (newValue) => setState(() => value = newValue),
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
