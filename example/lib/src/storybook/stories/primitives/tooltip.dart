import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TooltipStory extends StatefulWidget {
  static const path = '/primitives/tooltip';

  const TooltipStory({super.key});

  @override
  State<TooltipStory> createState() => _TooltipStoryState();
}

class _TooltipStoryState extends State<TooltipStory> {
  bool showOnTap = false;
  bool showOnLongPress = false;

  @override
  Widget build(BuildContext context) {
    final customLabelTextKnob = context.knobs.text(
      label: "Custom MoonTooltip text",
      initial: "Custom MoonTooltip text",
    );

    final tooltipPositionKnob = context.knobs.nullable.options(
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

    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonTooltip text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonTooltip background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final borderColorKnob = context.knobs.nullable.options(
      label: "borderColor",
      description: "MoonColors variants for MoonTooltip border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final borderColor = colorTable(context)[borderColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonTooltip.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final arrowOffsetKnob = context.knobs.nullable.slider(
      label: "arrowOffsetValue",
      description: "Offset for MoonTooltip arrow.",
      enabled: false,
      initial: 0,
      min: -100,
      max: 100,
    );

    final arrowTipDistanceKnob = context.knobs.nullable.slider(
      label: "arrowTipDistance",
      description: "Distance to target child widget.",
      enabled: false,
      initial: 8,
      max: 100,
    );

    final arrowBaseWidthKnob = context.knobs.nullable.slider(
      label: "arrowBaseWidth",
      description: "Base width for MoonTooltip arrow.",
      enabled: false,
      initial: 16,
      max: 100,
    );

    final arrowLengthKnob = context.knobs.nullable.slider(
      label: "arrowLength",
      description: "Length for MoonTooltip arrow.",
      enabled: false,
      initial: 8,
      max: 100,
    );

    final showShadowKnob = context.knobs.boolean(
      label: "tooltipShadows",
      description: "Show shadows for MoonTooltip.",
      initial: true,
    );

    final showArrowKnob = context.knobs.boolean(
      label: "hasArrow",
      description: "Show MoonTooltip with an arrow (tail).",
      initial: true,
    );

    final borderRadius = borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextDivider(
            text: "MoonTooltip",
            paddingTop: 0,
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return MoonTooltip(
                show: showOnTap,
                backgroundColor: backgroundColor,
                borderWidth: 1,
                borderColor: borderColor ?? Colors.transparent,
                borderRadius: borderRadius,
                tooltipPosition: tooltipPositionKnob ?? MoonTooltipPosition.top,
                hasArrow: showArrowKnob,
                arrowBaseWidth: arrowBaseWidthKnob,
                arrowLength: arrowLengthKnob,
                arrowOffsetValue: arrowOffsetKnob ?? 0,
                arrowTipDistance: arrowTipDistanceKnob,
                tooltipShadows: showShadowKnob == true ? null : [],
                content: Text(
                  customLabelTextKnob,
                  style: TextStyle(color: textColor),
                ),
                child: MoonFilledButton(
                  onTap: () => setState(() => showOnTap = true),
                  label: const Text("Tap me"),
                ),
              );
            },
          ),
          const TextDivider(text: "MoonTooltip is displayed on long-press"),
          MoonTooltip(
            show: showOnLongPress,
            backgroundColor: backgroundColor,
            borderWidth: 1,
            borderColor: borderColor ?? Colors.transparent,
            borderRadius: borderRadius,
            tooltipPosition: tooltipPositionKnob ?? MoonTooltipPosition.top,
            hasArrow: showArrowKnob,
            arrowBaseWidth: arrowBaseWidthKnob,
            arrowLength: arrowLengthKnob,
            arrowOffsetValue: arrowOffsetKnob ?? 0,
            arrowTipDistance: arrowTipDistanceKnob,
            tooltipShadows: showShadowKnob == true ? null : [],
            content: Text(
              customLabelTextKnob,
              style: TextStyle(color: textColor),
            ),
            child: MoonChip(
              borderRadius: BorderRadius.circular(20),
              backgroundColor: context.moonColors!.hit,
              leading: const Icon(MoonIcons.other_frame_24_light),
              textColor: context.moonColors!.goten,
              label: const Text("MoonChip"),
              onLongPress: () => setState(() => showOnLongPress = true),
            ),
          ),
        ],
      ),
    );
  }
}
