import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const String _groupId = "dropdown";

enum Choices { first, second, third }

extension ChoicesX on Choices {
  String get name {
    return switch (this) {
      Choices.first => "Choice #1",
      Choices.second => "Choice #2",
      Choices.third => "Choice #3",
    };
  }
}

class DropdownStory extends StatefulWidget {
  static const path = '/primitives/dropdown';

  const DropdownStory({super.key});

  @override
  State<DropdownStory> createState() => _DropdownStoryState();
}

class _DropdownStoryState extends State<DropdownStory> {
  final Map<Choices, bool> _availableChoices = {
    Choices.first: false,
    Choices.second: false,
    Choices.third: false,
  };

  bool _showChoices = false;
  bool _showMenu = false;
  bool _showMenuInner = false;
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
      description: "Distance to target child widget.",
      enabled: false,
      initial: 8,
      max: 100,
    );

    final showShadowKnob = context.knobs.boolean(
      label: "Show shadow",
      description: "Show shadows for MoonDropdown.",
      initial: true,
    );

    final constrainWidthToChildKnob = context.knobs.boolean(
      label: "constrainWidthToChild",
      description: "Constrain the width of MoonDropdown to be the same as the child (target).",
      initial: true,
    );

    // Used to avoid the stale closure within callbacks in Story.
    final colorPiccolo = context.moonColors!.piccolo;
    final colorKrillin = context.moonColors!.krillin;
    final colorRoshi100 = context.moonColors!.roshi;
    final colorRoshi60 = context.moonColors!.roshi60;
    final colorRoshi10 = context.moonColors!.roshi10;

    final BorderRadiusGeometry? borderRadius =
        borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextDivider(
                text: "MoonDropdown with multiple choices",
                paddingTop: 0,
              ),
              MoonDropdown(
                show: _showChoices,
                minWidth: 250,
                borderColor: borderColor ?? Colors.transparent,
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                constrainWidthToChild: constrainWidthToChildKnob,
                distanceToTarget: distanceToTargetKnob,
                dropdownAnchorPosition: dropdownAnchorPositionKnob ?? MoonDropdownAnchorPosition.bottom,
                dropdownShadows: showShadowKnob == true ? null : [],
                onTapOutside: () => setState(() => _showChoices = false),
                content: ClipRRect(
                  borderRadius: borderRadius ?? BorderRadius.zero,
                  child: Column(
                    children: [
                      MoonMenuItem(
                        absorbGestures: true,
                        onTap: () =>
                            setState(() => _availableChoices[Choices.first] = !_availableChoices[Choices.first]!),
                        label: Text(Choices.first.name),
                        trailing: MoonCheckbox(
                          value: _availableChoices[Choices.first],
                          tapAreaSizeValue: 0,
                          onChanged: (_) {},
                        ),
                      ),
                      MoonMenuItem(
                        absorbGestures: true,
                        onTap: () =>
                            setState(() => _availableChoices[Choices.second] = !_availableChoices[Choices.second]!),
                        label: Text(Choices.second.name),
                        trailing: MoonCheckbox(
                          value: _availableChoices[Choices.second],
                          tapAreaSizeValue: 0,
                          onChanged: (_) {},
                        ),
                      ),
                      MoonMenuItem(
                        absorbGestures: true,
                        onTap: () =>
                            setState(() => _availableChoices[Choices.third] = !_availableChoices[Choices.third]!),
                        label: Text(Choices.third.name),
                        trailing: MoonCheckbox(
                          value: _availableChoices[Choices.third],
                          tapAreaSizeValue: 0,
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),
                child: MoonTextInput(
                  width: 270,
                  readOnly: true,
                  canRequestFocus: false,
                  mouseCursor: MouseCursor.defer,
                  hintText: "Choose an option",
                  onTap: () => setState(() => _showChoices = !_showChoices),
                  onTapOutside: (PointerDownEvent _) => FocusManager.instance.primaryFocus?.unfocus(),
                  leading: _availableChoices.values.any((element) => element == true)
                      ? Center(
                          child: MoonTag(
                            tagSize: MoonTagSize.xs,
                            backgroundColor: context.moonColors!.bulma,
                            onTap: () => setState(() => _availableChoices.updateAll((key, value) => false)),
                            label: Text(
                              "${_availableChoices.values.where((element) => element == true).length}",
                              style: TextStyle(color: context.moonColors!.gohan),
                            ),
                            trailing: Icon(
                              MoonIcons.controls_close_small_16_light,
                              color: context.moonColors!.gohan,
                            ),
                          ),
                        )
                      : null,
                  trailing: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Center(
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 200),
                        turns: _showChoices ? -0.5 : 0,
                        child: const Icon(
                          MoonIcons.controls_chevron_down_16_light,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const TextDivider(text: "MoonDropdown as a menu"),
              MoonDropdown(
                show: _showMenu,
                groupId: _groupId,
                maxWidth: 250,
                borderColor: borderColor ?? Colors.transparent,
                backgroundColor: backgroundColor,
                constrainWidthToChild: constrainWidthToChildKnob,
                distanceToTarget: distanceToTargetKnob,
                dropdownAnchorPosition: dropdownAnchorPositionKnob ?? MoonDropdownAnchorPosition.bottom,
                dropdownShadows: showShadowKnob == true ? null : [],
                onTapOutside: () => setState(() {
                  _showMenu = false;
                  _showMenuInner = false;
                }),
                content: Column(
                  children: [
                    MoonMenuItem(
                      onTap: () => setState(() {
                        _showMenu = false;
                        _buttonName = "Piccolo";
                        _buttonColor = colorPiccolo;
                      }),
                      label: const Text("Piccolo"),
                    ),
                    const SizedBox(height: 4),
                    MoonMenuItem(
                      onTap: () => setState(() {
                        _showMenu = false;
                        _buttonName = "Krillin";
                        _buttonColor = colorKrillin;
                      }),
                      label: const Text("Krillin"),
                    ),
                    const SizedBox(height: 4),
                    MoonDropdown(
                      show: _showMenuInner,
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
                            onTap: () => setState(() {
                              _showMenu = false;
                              _showMenuInner = false;
                              _buttonName = "Roshi100";
                              _buttonColor = colorRoshi100;
                            }),
                            label: const Text("Roshi100"),
                          ),
                          const SizedBox(height: 4),
                          MoonMenuItem(
                            onTap: () => setState(() {
                              _showMenu = false;
                              _showMenuInner = false;
                              _buttonName = "Roshi60";
                              _buttonColor = colorRoshi60;
                            }),
                            label: const Text("Roshi60"),
                          ),
                          const SizedBox(height: 4),
                          MoonMenuItem(
                            onTap: () => setState(() {
                              _showMenu = false;
                              _showMenuInner = false;
                              _buttonName = "Roshi10";
                              _buttonColor = colorRoshi10;
                            }),
                            label: const Text("Roshi10"),
                          ),
                        ],
                      ),
                      child: MoonMenuItem(
                        backgroundColor: _showMenuInner ? context.moonColors!.heles : null,
                        onTap: () => setState(() => _showMenuInner = !_showMenuInner),
                        label: const Text("Roshi"),
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
                  onTap: () => setState(() => _showMenu = !_showMenu),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
