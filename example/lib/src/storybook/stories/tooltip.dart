import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TooltipStory extends Story {
  TooltipStory()
      : super(
          name: "Tooltip",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
              initial: "This",
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
                    MoonChip(
                      showTooltip: true,
                      tooltipMessage: customLabelTextKnob,
                      borderRadius: BorderRadius.circular(20),
                      backgroundColor: context.moonColors!.hit,
                      leftIcon: const Icon(MoonIcons.frame24),
                      label: const Text("Moo"),
                    ),
                    const SizedBox(height: 32),
                    MoonButton(
                      showTooltip: true,
                      tooltipMessage: customLabelTextKnob,
                      label: const Text("Moo"),
                      onTap: () {},
                    ),

                    /* MoonTooltip(
                      show: true,
                      tooltipPosition: MoonTooltipPosition.bottom,
                      hasArrow: false,
                      arrowLength: 24,
                      arrowBaseWidth: 4,
                      content: Text(customLabelTextKnob),
                      child: MoonChip(
                        borderRadius: BorderRadius.circular(20),
                        backgroundColor: context.moonColors!.hit,
                        leftIcon: const Icon(MoonIcons.frame24),
                        label: const Text("Moo"),
                      ),
                    ), */
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
