import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

const String _groupId = "dropdown";

class Dropdown extends StatefulWidget {
    const Dropdown({super.key});

    @override
    State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
    final Map<String, bool> _availableChoices = {
        "Choice #1": false,
        "Choice #2": false,
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
                //Dropdown with multiple choices
                MoonDropdown(
                    show: _showChoices,
                    constrainWidthToChild: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    onTapOutside: () => setState(() => _showChoices = false),
                    content: Column(
                        children: [
                            MoonCheckbox.withLabel(
                                context,
                                value: _availableChoices["Choice #1"],
                                label: "Choice #1",
                                onChanged: (bool? isSelected) => setState(
                                    () => _availableChoices["Choice #1"] = isSelected!,
                                ),
                            ),
                            MoonCheckbox.withLabel(
                                context,
                                value: _availableChoices["Choice #2"],
                                label: "Choice #2",
                                onChanged: (bool? isSelected) => setState(
                                    () => _availableChoices["Choice #2"] = isSelected!,
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
                                      onTap: () => setState(
                                          () => _availableChoices.updateAll((key, value) => false),
                                      ),
                                      child: MoonTag(
                                          tagSize: MoonTagSize.xs,
                                          label: Text(
                                              "${_availableChoices.values.where((element) => element == true).length}",
                                          ),
                                          trailing: const Icon(MoonIcons.controls_close_small_16_light),
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

                // Dropdown as menu
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
                                title: const Text("Piccolo"),
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
                                            title: const Text("Roshi"),
                                        ),
                                        MoonMenuItem(
                                            onTap: () => setState(() {
                                                _showMenu = false;
                                                _showMenuInner = false;
                                                _buttonName = "Roshi60";
                                                _buttonColor = context.moonColors!.roshi60;
                                            }),
                                            title: const Text("Roshi60"),
                                        ),
                                        MoonMenuItem(
                                            onTap: () => setState(() {
                                                _showMenu = false;
                                                _showMenuInner = false;
                                                _buttonName = "Roshi10";
                                                _buttonColor = context.moonColors!.roshi10;
                                            }),
                                            title: const Text("Roshi10"),
                                        ),
                                    ],
                                ),
                                child: MoonMenuItem(
                                    backgroundColor: _showMenuInner ? context.moonColors!.heles : null,
                                    onTap: () => setState(() => _showMenuInner = !_showMenuInner),
                                    title: const Text("Roshi"),
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