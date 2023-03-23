import 'package:example/src/storybook/common/options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
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
              initial: "Custom tooltip text",
            );

            final tooltipPositionsKnob = context.knobs.options(
              label: "tooltipPosition",
              description: "Tooltip position variants.",
              initial: MoonTooltipPosition.top,
              options: const [
                Option(label: "top", value: MoonTooltipPosition.top),
                Option(label: "bottom", value: MoonTooltipPosition.bottom),
                Option(label: "left", value: MoonTooltipPosition.left),
                Option(label: "right", value: MoonTooltipPosition.right),
                Option(label: "topLeft", value: MoonTooltipPosition.topLeft),
                Option(label: "topRight", value: MoonTooltipPosition.topRight),
                Option(label: "bottomLeft", value: MoonTooltipPosition.bottomLeft),
                Option(label: "bottomRight", value: MoonTooltipPosition.bottomRight),
                Option(label: "vertical", value: MoonTooltipPosition.vertical),
                Option(label: "horizontal", value: MoonTooltipPosition.horizontal),
              ],
            );

            final colorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Tooltip background.",
              initial: 4, // gohan
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 20,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for Tooltip.",
            );

            final arrowOffsetKnob = context.knobs.slider(
              label: "arrowOffsetValue",
              description: "Set the offset of the Tooltip arrow.",
              initial: 0,
              min: -100,
              max: 100,
            );

            final arrowTipDistanceKnob = context.knobs.slider(
              label: "arrowTipDistance",
              description: "Set the distance to target child widget.",
              initial: 8,
              max: 100,
            );

            final arrowBaseWidthKnob = context.knobs.slider(
              label: "arrowBaseWidth",
              description: "Set the base width of the Tooltip arrow.",
              initial: 16,
              max: 100,
            );

            final arrowLengthKnob = context.knobs.slider(
              label: "arrowLength",
              description: "Set the length of the Tooltip arrow.",
              initial: 8,
              max: 100,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadows",
              description: "Show shadows under the Tooltip.",
              initial: true,
            );

            final showArrowKnob = context.knobs.boolean(
              label: "hasArrow",
              description: "Does Tooltip have an arrow (tail).",
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
                    const TextDivider(text: "Customisable tooltip"),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonTooltip(
                          show: show,
                          backgroundColor: color,
                          borderRadiusValue: borderRadiusKnob.toDouble(),
                          tooltipPosition: tooltipPositionsKnob,
                          hasArrow: showArrowKnob,
                          arrowBaseWidth: arrowBaseWidthKnob,
                          arrowLength: arrowLengthKnob,
                          arrowOffsetValue: arrowOffsetKnob,
                          arrowTipDistance: arrowTipDistanceKnob,
                          tooltipShadows: showShadowKnob == true ? null : [],
                          content: Text(customLabelTextKnob),
                          child: MoonButton(
                            backgroundColor: context.moonColors!.bulma,
                            onTap: () {
                              setState(() => show = true);
                            },
                            label: const Text("MDS"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Default tooltip"),
                    const SizedBox(height: 32),
                    MoonFilledButton(
                      showTooltip: true,
                      tooltipMessage: customLabelTextKnob,
                      onTap: () {},
                      label: const Text("MoonFilledButton"),
                    ),
                    const SizedBox(height: 32),
                    MoonChip(
                      showTooltip: true,
                      tooltipMessage: customLabelTextKnob,
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
