import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class PopoverStory extends StatefulWidget {
  static const path = '/primitives/popover';

  const PopoverStory({super.key});

  @override
  State<PopoverStory> createState() => _PopoverStoryState();
}

class _PopoverStoryState extends State<PopoverStory> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final customLabelTextKnob = context.knobs.text(
      label: "Label text",
      initial: "Custom MoonPopover text",
    );

    final popoverPositionKnob = context.knobs.nullable.options(
      label: "popoverPosition",
      description: "Position variants for MoonPopover.",
      enabled: false,
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

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonPopover background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final borderColorKnob = context.knobs.nullable.options(
      label: "borderColor",
      description: "MoonColors variants for MoonPopover border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final borderColor = colorTable(context)[borderColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonPopover.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final distanceToTargetKnob = context.knobs.nullable.slider(
      label: "distanceToTarget",
      description: "Distance to target child widget.",
      enabled: false,
      initial: 8,
      max: 100,
    );

    final showShadowKnob = context.knobs.boolean(
      label: "Show shadow",
      description: "Show shadows for MoonPopover.",
      initial: true,
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoonPopover(
              show: show,
              borderColor: borderColor ?? Colors.transparent,
              backgroundColor: backgroundColor,
              borderRadius: borderRadiusKnob != null
                  ? BorderRadius.circular(borderRadiusKnob.toDouble())
                  : null,
              distanceToTarget: distanceToTargetKnob,
              popoverPosition: popoverPositionKnob ?? MoonPopoverPosition.top,
              popoverShadows: showShadowKnob == true ? null : [],
              onTapOutside: () => setState(() => show = false),
              content: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 190),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MoonAvatar(
                          backgroundColor: context.moonColors?.heles,
                          content: const Icon(MoonIcons.other_rocket_24_light),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(customLabelTextKnob),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MoonFilledButton(
                      buttonSize: MoonButtonSize.sm,
                      isFullWidth: true,
                      onTap: () => setState(() => show = false),
                      label: const Text("Close"),
                    ),
                  ],
                ),
              ),
              child: MoonFilledButton(
                onTap: () => setState(() => show = !show),
                label: const Text("Tap me"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
