import 'package:example/src/storybook/common/options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

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
              description: "MoonColors variants for base MoonButton.",
              initial: 4, // gohan
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final arrowOffsetKnob = context.knobs.slider(
              label: "arrowOffsetValue",
              description: "Set the offset of the popover arrow.",
              initial: 0,
              min: -100,
              max: 100,
            );

            final arrowBaseWidthKnob = context.knobs.slider(
              label: "arrowBaseWidth",
              description: "Set the base width of the popover arrow.",
              initial: 16,
              max: 100,
            );

            final arrowLengthKnob = context.knobs.slider(
              label: "arrowLength",
              description: "Set the length of the popover arrow.",
              initial: 8,
              max: 100,
            );

            final showPopoverKnob = context.knobs.boolean(
              label: "show",
              description: "Show the popover.",
              initial: true,
            );

            final showArrowKnob = context.knobs.boolean(
              label: "hasArrow",
              description: "Does popover have an arrow (tail).",
              initial: true,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadow",
              description: "Show shadows under the popover.",
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
                    const TextDivider(text: "Customisable popover"),
                    const SizedBox(height: 32),
                    MoonPopover(
                      arrowBaseWidth: arrowBaseWidthKnob,
                      arrowLength: arrowLengthKnob,
                      arrowOffsetValue: arrowOffsetKnob,
                      show: showPopoverKnob,
                      popoverPosition: popoverPositionsKnob,
                      hasArrow: showArrowKnob,
                      backgroundColor: color,
                      popoverShadows: showShadowKnob == true ? null : [],
                      content: Text(customLabelTextKnob),
                      child: MoonButton(
                        backgroundColor: context.moonColors!.bulma,
                        onTap: () {},
                        label: const Text("MDS"),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Default popover"),
                    const SizedBox(height: 32),
                    MoonPrimaryButton(
                      onTap: () {},
                      label: const Text("MoonPrimaryButton"),
                    ),
                    const SizedBox(height: 32),
                    MoonChip(
                      borderRadius: BorderRadius.circular(20),
                      backgroundColor: context.moonColors!.hit,
                      leftIcon: const Icon(MoonIconsOther.frame24),
                      label: const Text("MoonChip"),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
