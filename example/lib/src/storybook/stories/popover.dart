import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool show = false;

class PopoverStory extends Story {
  PopoverStory()
      : super(
          name: "Popover",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
              initial: "Custom popover text",
            );

            final popoverPositionsKnob = context.knobs.options(
              label: "popoverPosition",
              description: "Popover position variants.",
              initial: MoonPopoverPosition.top,
              options: const [
                Option(label: "top", value: MoonPopoverPosition.top),
                Option(label: "bottom", value: MoonPopoverPosition.bottom),
                Option(label: "left", value: MoonPopoverPosition.left),
                Option(label: "right", value: MoonPopoverPosition.right),
                Option(label: "topLeft", value: MoonPopoverPosition.topLeft),
                Option(label: "topRight", value: MoonPopoverPosition.topRight),
                Option(label: "bottomLeft", value: MoonPopoverPosition.bottomLeft),
                Option(label: "bottomRight", value: MoonPopoverPosition.bottomRight),
                Option(label: "vertical", value: MoonPopoverPosition.vertical),
                Option(label: "horizontal", value: MoonPopoverPosition.horizontal),
              ],
            );

            final colorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Popover background.",
              initial: 4, // gohan
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 20,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for Popover.",
            );

            final distanceToTargetKnob = context.knobs.slider(
              label: "distanceToTarget",
              description: "Set the distance to target child widget.",
              initial: 8,
              max: 100,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadow",
              description: "Show shadows under the Popover.",
              initial: true,
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
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonPopover(
                          show: show,
                          backgroundColor: color,
                          borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                          distanceToTarget: distanceToTargetKnob,
                          popoverPosition: popoverPositionsKnob,
                          popoverShadows: showShadowKnob == true ? null : [],
                          content: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 190),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  textDirection: Directionality.of(context),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MoonAvatar(
                                      backgroundColor: context.moonColors?.heles,
                                      child: const Icon(MoonIcons.rocket_24),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(customLabelTextKnob)),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                MoonFilledButton(
                                  buttonSize: MoonButtonSize.sm,
                                  isFullWidth: true,
                                  onTap: () {
                                    setState(() => show = false);
                                  },
                                  label: const Text("Close"),
                                ),
                              ],
                            ),
                          ),
                          child: MoonFilledButton(
                            onTap: () {
                              setState(() => show = true);
                            },
                            label: const Text("Tap me"),
                          ),
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
