import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

const String _groupId = "dropdown";

enum Choices { first, second }

extension ChoicesX on Choices {
  String get name {
    switch (this) {
      case Choices.first:
        return "Choice #1";
      case Choices.second:
        return "Choice #2";
    }
  }
}

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final Map<Choices, bool> _availableChoices = {
    Choices.first: false,
    Choices.second: false,
  };

  bool _showChoices = false;
  bool _showMenu = false;
  bool _showMenuInner = false;
  Color? _buttonColor;
  String _buttonName = "Piccolo";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // MoonDropdown with multiple choices.
        MoonDropdown(
          show: _showChoices,
          constrainWidthToChild: true,
          onTapOutside: () => setState(() => _showChoices = false),
          content: Column(
            children: [
              MoonMenuItem(
                label: Text(Choices.first.name),
                onTap: () => setState(() => _availableChoices[Choices.first] = !_availableChoices[Choices.first]!),
                trailing: MoonCheckbox(
                  value: _availableChoices[Choices.first],
                  tapAreaSizeValue: 0,
                  onChanged: (_) {},
                ),
              ),
              MoonMenuItem(
                label: Text(Choices.second.name),
                onTap: () => setState(() => _availableChoices[Choices.second] = !_availableChoices[Choices.second]!),
                trailing: MoonCheckbox(
                  value: _availableChoices[Choices.second],
                  tapAreaSizeValue: 0,
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          child: MoonTextInput(
            mouseCursor: MouseCursor.defer,
            readOnly: true,
            width: 250,
            hintText: "Choose an option",
            onTap: () => setState(() => _showChoices = !_showChoices),
            leading: _availableChoices.values.any((element) => element == true)
                ? Center(
                    child: GestureDetector(
                      onTap: () => setState(() => _availableChoices.updateAll((key, value) => false)),
                      child: MoonTag(
                        tagSize: MoonTagSize.xs,
                        backgroundColor: context.moonColors!.bulma,
                        label: Text(
                          "${_availableChoices.values.where((element) => element == true).length}",
                          style: TextStyle(color: context.moonColors!.gohan),
                        ),
                        trailing: Icon(
                          MoonIcons.controls_close_small_16_light,
                          color: context.moonColors!.gohan,
                        ),
                      ),
                    ),
                  )
                : null,
            trailing: Center(
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _showChoices ? -0.5 : 0,
                child: const Icon(MoonIcons.controls_chevron_down_small_16_light),
              ),
            ),
          ),
        ),

        // MoonDropdown as a menu.
        MoonDropdown(
          show: _showMenu,
          groupId: _groupId,
          constrainWidthToChild: true,
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
                  _buttonColor = context.moonColors!.piccolo;
                }),
                label: const Text("Piccolo"),
              ),
              MoonDropdown(
                show: _showMenuInner,
                groupId: _groupId,
                constrainWidthToChild: true,
                followerAnchor: Alignment.topLeft,
                targetAnchor: Alignment.topRight,
                offset: const Offset(8, 0),
                content: Column(
                  children: [
                    MoonMenuItem(
                      onTap: () => setState(() {
                        _showMenu = false;
                        _showMenuInner = false;
                        _buttonName = "Roshi";
                        _buttonColor = context.moonColors!.roshi;
                      }),
                      label: const Text("Roshi"),
                    ),
                    MoonMenuItem(
                      onTap: () => setState(() {
                        _showMenu = false;
                        _showMenuInner = false;
                        _buttonName = "Roshi60";
                        _buttonColor = context.moonColors!.roshi60;
                      }),
                      label: const Text("Roshi60"),
                    ),
                    MoonMenuItem(
                      onTap: () => setState(() {
                        _showMenu = false;
                        _showMenuInner = false;
                        _buttonName = "Roshi10";
                        _buttonColor = context.moonColors!.roshi10;
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
            width: 120,
            backgroundColor: _buttonColor,
            onTap: () => setState(() => _showMenu = !_showMenu),
            label: Text(_buttonName),
          ),
        ),
      ],
    );
  }
}