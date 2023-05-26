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
              initial: "Custom MoonTooltip text",
            );

            final tooltipPositionsKnob = context.knobs.nullable.options(
              label: "tooltipPosition",
              description: "Position variants for MoonTooltip.",
              enabled: false,
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

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonTooltip background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonTooltip border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonTooltip.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final arrowOffsetKnob = context.knobs.nullable.slider(
              label: "arrowOffsetValue",
              description: "Set the offset of MoonTooltip arrow.",
              enabled: false,
              initial: 0,
              min: -100,
              max: 100,
            );

            final arrowTipDistanceKnob = context.knobs.nullable.slider(
              label: "arrowTipDistance",
              description: "Set the distance to target child widget.",
              enabled: false,
              initial: 8,
              max: 100,
            );

            final arrowBaseWidthKnob = context.knobs.nullable.slider(
              label: "arrowBaseWidth",
              description: "Set the base width of MoonTooltip arrow.",
              enabled: false,
              initial: 16,
              max: 100,
            );

            final arrowLengthKnob = context.knobs.nullable.slider(
              description: "Set the length of MoonTooltip arrow.",
              label: "arrowLength",
              enabled: false,
              initial: 8,
              max: 100,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "tooltipShadows",
              description: "Show shadows under MoonTooltip.",
              initial: true,
            );

            final showArrowKnob = context.knobs.boolean(
              label: "hasArrow",
              description: "Show MoonTooltip with an arrow (tail).",
              initial: true,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  const TextDivider(text: "Customisable MoonTooltip"),
                  const SizedBox(height: 32),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return MoonTooltip(
                        show: show,
                        backgroundColor: backgroundColor,
                        borderWidth: 1,
                        borderColor: borderColor ?? Colors.transparent,
                        borderRadius:
                            borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                        tooltipPosition: tooltipPositionsKnob ?? MoonTooltipPosition.top,
                        hasArrow: showArrowKnob,
                        arrowBaseWidth: arrowBaseWidthKnob,
                        arrowLength: arrowLengthKnob,
                        arrowOffsetValue: arrowOffsetKnob ?? 0,
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
                  const TextDivider(text: "Default on hover MoonTooltip"),
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
                    leading: const MoonIcon(MoonIcons.frame_24),
                    textColor: context.moonTypography!.colors.controlPrimary,
                    label: const Text("MoonChip"),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
