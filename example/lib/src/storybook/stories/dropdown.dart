import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const String _groupId = "dropdown";

class DropdownStory extends StatefulWidget {
  static const path = '/dropdown';

  const DropdownStory({super.key});

  @override
  State<DropdownStory> createState() => _DropdownStoryState();
}

class _DropdownStoryState extends State<DropdownStory> {
  bool _show = false;
  bool _showInner = false;
  Color? _buttonColor;
  String _buttonName = "Piccolo";

  @override
  Widget build(BuildContext context) {
    final dropdownAnchorPositionKnob = context.knobs.nullable.options(
      label: "dropdownAnchorPosition",
      description: "Anchor position variants for MoonDropdown on the child (target).",
      enabled: false,
      initial: MoonDropdownAnchorPosition.bottom,
      options: const [
        Option(label: "top", value: MoonDropdownAnchorPosition.top),
        Option(label: "bottom", value: MoonDropdownAnchorPosition.bottom),
        Option(label: "left", value: MoonDropdownAnchorPosition.left),
        Option(label: "right", value: MoonDropdownAnchorPosition.right),
        Option(label: "topLeft", value: MoonDropdownAnchorPosition.topLeft),
        Option(label: "topRight", value: MoonDropdownAnchorPosition.topRight),
        Option(label: "bottomLeft", value: MoonDropdownAnchorPosition.bottomLeft),
        Option(label: "bottomRight", value: MoonDropdownAnchorPosition.bottomRight),
        Option(label: "vertical", value: MoonDropdownAnchorPosition.vertical),
        Option(label: "horizontal", value: MoonDropdownAnchorPosition.horizontal),
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

    // Used to avoid the stale closure within callbacks in Story
    final colorPiccolo = context.moonColors!.piccolo;
    final colorKrillin = context.moonColors!.krillin100;
    final colorRoshi100 = context.moonColors!.roshi100;
    final colorRoshi60 = context.moonColors!.roshi60;
    final colorRoshi10 = context.moonColors!.roshi10;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoonDropdown(
              show: _show,
              groupId: _groupId,
              maxWidth: 250,
              borderColor: borderColor ?? Colors.transparent,
              backgroundColor: backgroundColor,
              borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
              constrainWidthToChild: constrainWidthToChildKnob,
              distanceToTarget: distanceToTargetKnob,
              dropdownAnchorPosition: dropdownAnchorPositionKnob ?? MoonDropdownAnchorPosition.bottom,
              dropdownShadows: showShadowKnob == true ? null : [],
              onTapOutside: () => setState(() {
                _show = false;
                _showInner = false;
              }),
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
                  const SizedBox(height: 4),
                  MoonMenuItem(
                    title: const Text("Krillin"),
                    borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                    onTap: () => setState(() {
                      _show = false;
                      _buttonName = "Krillin";
                      _buttonColor = colorKrillin;
                    }),
                  ),
                  const SizedBox(height: 4),
                  MoonDropdown(
                    show: _showInner,
                    groupId: _groupId,
                    maxWidth: 100,
                    constrainWidthToChild: constrainWidthToChildKnob,
                    distanceToTarget: distanceToTargetKnob,
                    dropdownAnchorPosition: dropdownAnchorPositionKnob ?? MoonDropdownAnchorPosition.bottom,
                    followerAnchor: dropdownAnchorPositionKnob == null ? Alignment.topLeft : null,
                    targetAnchor: dropdownAnchorPositionKnob == null ? Alignment.topRight : null,
                    offset: dropdownAnchorPositionKnob == null ? const Offset(8, 0) : null,
                    content: Column(
                      children: [
                        MoonMenuItem(
                          title: const Text("Roshi100"),
                          borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                          onTap: () => setState(() {
                            _show = false;
                            _showInner = false;
                            _buttonName = "Roshi100";
                            _buttonColor = colorRoshi100;
                          }),
                        ),
                        const SizedBox(height: 4),
                        MoonMenuItem(
                          title: const Text("Roshi60"),
                          borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                          onTap: () => setState(() {
                            _show = false;
                            _showInner = false;
                            _buttonName = "Roshi60";
                            _buttonColor = colorRoshi60;
                          }),
                        ),
                        const SizedBox(height: 4),
                        MoonMenuItem(
                          title: const Text("Roshi10"),
                          borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                          onTap: () => setState(() {
                            _show = false;
                            _showInner = false;
                            _buttonName = "Roshi10";
                            _buttonColor = colorRoshi10;
                          }),
                        ),
                      ],
                    ),
                    child: MoonMenuItem(
                      backgroundColor: _showInner ? context.moonColors!.heles : null,
                      title: const Text("Roshi"),
                      borderRadius: const MoonSquircleBorderRadius.all(MoonSquircleRadius(cornerRadius: 12)),
                      onTap: () => setState(() {
                        _showInner = !_showInner;
                      }),
                      trailing: const Icon(
                        MoonIcons.controls_chevron_right_16_light,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              child: MoonFilledButton(
                width: 128,
                label: Text(_buttonName),
                backgroundColor: _buttonColor,
                onTap: () => setState(() => _show = !_show),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
