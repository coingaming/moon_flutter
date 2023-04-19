import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool show = false;

class TooltipStory extends Story {
  TooltipStory()
      : super(
          name: "Tooltip",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "label text",
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

            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Tooltip background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final borderColorsKnob = context.knobs.options(
              label: "borderColor",
              description: "MoonColors variants for Tooltip border.",
              initial: 40, // null
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 20,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for Tooltip.",
            );

            final arrowOffsetKnob = context.knobs.slider(
              max: 100,
              min: -100,
              initial: 0,
              label: "arrowOffsetValue",
              description: "Set the offset of the Tooltip arrow.",
            );

            final arrowTipDistanceKnob = context.knobs.slider(
              max: 100,
              initial: 8,
              label: "arrowTipDistance",
              description: "Set the distance to target child widget.",
            );

            final arrowBaseWidthKnob = context.knobs.slider(
              max: 100,
              initial: 16,
              label: "arrowBaseWidth",
              description: "Set the base width of the Tooltip arrow.",
            );

            final arrowLengthKnob = context.knobs.slider(
              max: 100,
              initial: 8,
              label: "arrowLength",
              description: "Set the length of the Tooltip arrow.",
            );

            final showShadowKnob = context.knobs.boolean(
              label: "tooltipShadows",
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
                          backgroundColor: backgroundColor,
                          borderWidth: 1,
                          borderColor: borderColor ?? Colors.transparent,
                          borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                          tooltipPosition: tooltipPositionsKnob,
                          hasArrow: showArrowKnob,
                          arrowBaseWidth: arrowBaseWidthKnob,
                          arrowLength: arrowLengthKnob,
                          arrowOffsetValue: arrowOffsetKnob,
                          arrowTipDistance: arrowTipDistanceKnob,
                          tooltipShadows: showShadowKnob == true ? null : [],
                          content: Text(customLabelTextKnob),
                          child: MoonFilledButton(
                            onTap: () {
                              setState(() => show = true);
                            },
                            label: const Text("Tap me"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Default on hover tooltip"),
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
                      leading: const Icon(MoonIcons.frame_24),
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
