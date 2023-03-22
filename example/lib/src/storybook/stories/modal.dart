import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ModalStory extends Story {
  ModalStory()
      : super(
          name: "Modal",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
              initial: "Custom modal text",
            );

            final popoverPositionsKnob = context.knobs.options(
              label: "popoverPosition",
              description: "Modal position variants.",
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
              description: "MoonColors variants for Modal background.",
              initial: 4, // gohan
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 20,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for Modal.",
            );

            final distanceToTargetKnob = context.knobs.slider(
              label: "distanceToTarget",
              description: "Set the distance to target child widget.",
              initial: 8,
              max: 100,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadow",
              description: "Show shadows under the Modal.",
              initial: true,
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            bool show = true;

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    MoonButton(
                      backgroundColor: context.moonColors!.bulma,
                      onTap: () {
                        showMoonModal<void>(
                          context: context,
                          pageBuilder: (context, _, __) => MoonModal(),
                        );
                      },
                      label: const Text("MDS"),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
