import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool _show = false;
Color? _buttonColor;
String _buttonName = "Piccolo";

class DropdownStory extends Story {
  DropdownStory()
      : super(
          name: "Dropdown",
          builder: (BuildContext context) {
            final dropdownPositionKnob = context.knobs.nullable.options(
              label: "dropdownPosition",
              description: "Position variants for MoonDropdown.",
              enabled: false,
              initial: MoonDropdownPosition.bottom,
              options: const [
                Option(label: "top", value: MoonDropdownPosition.top),
                Option(label: "bottom", value: MoonDropdownPosition.bottom),
                Option(label: "auto", value: MoonDropdownPosition.auto),
              ],
            );

            final backgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonDropdown background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

            final borderColorKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonDropdown border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonDropdown.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final distanceToTargetKnob = context.knobs.nullable.slider(
              label: "distanceToTarget",
              description: "Set the distance to target child widget.",
              enabled: false,
              initial: 8,
              max: 100,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadow",
              description: "Show shadows under MoonDropdown.",
              initial: true,
            );

            final constrainWidthToChildKnob = context.knobs.boolean(
              label: "constrainWidthToChild",
              description: "Constrain the width of the MoonDropdown to be same as the child (target).",
              initial: true,
            );

            // Used to avoid the stale closure within callbacks
            final colorPiccolo = context.moonColors!.piccolo;
            final colorKrillin = context.moonColors!.krillin100;
            final colorRoshi = context.moonColors!.roshi100;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoonDropdown(
                          show: _show,
                          borderColor: borderColor ?? Colors.transparent,
                          backgroundColor: backgroundColor,
                          borderRadius:
                              borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                          constrainWidthToChild: constrainWidthToChildKnob,
                          distanceToTarget: distanceToTargetKnob,
                          dropdownPosition: dropdownPositionKnob ?? MoonDropdownPosition.bottom,
                          dropdownShadows: showShadowKnob == true ? null : [],
                          onTapOutside: () => setState(() => _show = false),
                          content: Column(
                            children: [
                              MoonMenuItem(
                                title: const Text("Piccolo"),
                                borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                                onTap: () => setState(() {
                                  _show = false;
                                  _buttonName = "Piccolo";
                                  _buttonColor = colorPiccolo;
                                }),
                              ),
                              MoonMenuItem(
                                title: const Text("Krillin"),
                                borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                                onTap: () => setState(() {
                                  _show = false;
                                  _buttonName = "Krillin";
                                  _buttonColor = colorKrillin;
                                }),
                              ),
                              MoonMenuItem(
                                title: const Text("Roshi"),
                                borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                                onTap: () => setState(() {
                                  _show = false;
                                  _buttonName = "Roshi";
                                  _buttonColor = colorRoshi;
                                }),
                              ),
                            ],
                          ),
                          child: MoonFilledButton(
                            width: 100,
                            label: Text(_buttonName),
                            backgroundColor: _buttonColor,
                            onTap: () => setState(() => _show = !_show),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
}
