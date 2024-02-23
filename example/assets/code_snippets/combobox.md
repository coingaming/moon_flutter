import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum Options {
  accordion,
  alert,
  bottomSheet,
  button,
  carousel,
  chip,
  dropdown,
  menuItem,
  tag,
  tooltip,
}

extension OptionsX on Options {
  String get name {
    return switch (this) {
      Options.accordion => "Accordion",
      Options.alert => "Alert",
      Options.bottomSheet => "BottomSheet",
      Options.button => "Button",
      Options.carousel => "Carousel",
      Options.chip => "Chip",
      Options.dropdown => "Dropdown",
      Options.menuItem => "MenuItem",
      Options.tag => "Tag",
      Options.tooltip => "Tooltip"
    };
  }
}

class ComboboxStory extends StatefulWidget {
  const ComboboxStory({super.key});

  @override
  State<ComboboxStory> createState() => _ComboboxStoryState();
}

class _ComboboxStoryState extends State<ComboboxStory> {
  final Map<Options, bool> _optionsList = {
    Options.accordion: false,
    Options.alert: false,
    Options.bottomSheet: false,
    Options.button: false,
    Options.carousel: false,
    Options.chip: false,
    Options.dropdown: false,
    Options.menuItem: false,
    Options.tag: false,
    Options.tooltip: false,
  };

  final FocusNode _singleSelectFocusNode = FocusNode();
  final FocusNode _multiSelectFocusNode = FocusNode();

  final TextEditingController _singleSelectSearchController = TextEditingController();
  final TextEditingController _multiSelectSearchController = TextEditingController();

  final Map<Options, bool> _multiSelectedItems = {};

  Map<Options, bool> _singleSelectFilteredData = {};
  Map<Options, bool> _multiSelectFilteredData = {};

  bool _showSingleSelectDropdown = false;
  bool _showMultiSelectDropdown = false;

  String get _singleSelectInputValue => _singleSelectSearchController.text.trim().toLowerCase();

  String get _multiSelectInputValue => _multiSelectSearchController.text.trim().toLowerCase();

  // Single select.
  void _performSingleSelectSearch() {
    setState(() {
      _singleSelectFilteredData = Map.fromEntries(
        _optionsList.entries.where((entry) => entry.key.name.toLowerCase().contains(_singleSelectInputValue)).toList(),
      );
      _showSingleSelectDropdown = true;
    });
  }

  void _handleSingleSelect(Options item) {
    setState(() {
      _showSingleSelectDropdown = false;
      _singleSelectSearchController.text = item.name;
      _singleSelectFocusNode.unfocus();
    });
  }

  void _showSingleSelectAllOptionsList() {
    setState(() {
      _singleSelectFilteredData = _optionsList;
      _showSingleSelectDropdown = !_showSingleSelectDropdown;
    });
  }

  void _handleSingleSelectDropdownTapOutside() {
    final bool isOptionSelected =
        _optionsList.entries.any((item) => item.key.name.toLowerCase() == _singleSelectInputValue);

    setState(() {
      _showSingleSelectDropdown = false;
      if (!isOptionSelected) _singleSelectSearchController.clear();
      _singleSelectFocusNode.unfocus();
    });
  }

  void _handleSingleSelectInputTapOutside() {
    if (_singleSelectFocusNode.hasFocus && !_showSingleSelectDropdown) {
      _singleSelectSearchController.clear();
      _singleSelectFocusNode.unfocus();
    }
  }

  // Multi select.
  void _performMultiSelectSearch() {
    setState(() {
      _multiSelectFilteredData = Map.fromEntries(
        _optionsList.entries.where((entry) => entry.key.name.toLowerCase().contains(_multiSelectInputValue)).toList(),
      );
      _showMultiSelectDropdown = true;
    });
  }

  void _handleMultiSelect(Options item, bool isSelected) {
    setState(() => isSelected ? _multiSelectedItems[item] = true : _multiSelectedItems.remove(item));
  }

  void _showMultiSelectAllOptionsList() {
    setState(() {
      _multiSelectFilteredData = _optionsList;
      _showMultiSelectDropdown = !_showMultiSelectDropdown;
    });
  }

  void _handleMultiSelectDropdownTapOutside() {
    setState(() {
      _showMultiSelectDropdown = false;
      _multiSelectSearchController.clear();
      _multiSelectFocusNode.unfocus();
    });
  }

  void _handleMultiSelectInputTapOutside() {
    if (_multiSelectFocusNode.hasFocus && !_showMultiSelectDropdown) {
      _multiSelectSearchController.clear();
      _multiSelectFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _singleSelectSearchController.dispose();
    _multiSelectSearchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Single select combobox.
        MoonDropdown(
          show: _showSingleSelectDropdown,
          constrainWidthToChild: true,
          onTapOutside: () => _handleSingleSelectDropdownTapOutside(),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: _singleSelectFilteredData.isEmpty
                ? const MoonMenuItem(
                    label: Text('Nothing found.'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _singleSelectFilteredData.length,
                    itemBuilder: (BuildContext _, int index) {
                      final List<Options> keys = _singleSelectFilteredData.keys.toList();
                      if (index >= keys.length) return const SizedBox.shrink();
                      final Options item = keys[index];

                      return MoonMenuItem(
                        onTap: () => _handleSingleSelect(item),
                        label: Text(item.name),
                      );
                    },
                  ),
          ),
          child: MoonTextInput(
            focusNode: _singleSelectFocusNode,
            hintText: "Select single component",
            controller: _singleSelectSearchController,
            // The onTap() and onChanged() properties are used instead of a listener to initiate search on every input tap. 
            // Listener only triggers on input change.
            onTap: () => _performSingleSelectSearch(),
            onTapOutside: (PointerDownEvent _) => _handleSingleSelectInputTapOutside(),
            onChanged: (String _) => _performSingleSelectSearch(),
            trailing: MoonButton.icon(
              hoverEffectColor: Colors.transparent,
              onTap: () => _showSingleSelectAllOptionsList(),
              icon: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _showSingleSelectDropdown ? -0.5 : 0,
                child: const Icon(MoonIcons.controls_chevron_down_small_24_light),
              ),
            ),
          ),
        ),

        // Multi select combobox.
        MoonDropdown(
          show: _showMultiSelectDropdown,
          constrainWidthToChild: true,
          onTapOutside: () => _handleMultiSelectDropdownTapOutside(),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: _multiSelectFilteredData.isEmpty
                ? const MoonMenuItem(
                    label: Text('Nothing found.'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _multiSelectFilteredData.length,
                    itemBuilder: (BuildContext _, int index) {
                      final List<Options> keys = _multiSelectFilteredData.keys.toList();
                      if (index >= keys.length) return const SizedBox.shrink();
                      final bool isSelected = _multiSelectedItems.containsKey(keys[index]);

                      return MoonMenuItem(
                        absorbGestures: true,
                        onTap: () => _handleMultiSelect(keys[index], !isSelected),
                        label: Text(keys[index].name),
                        trailing: MoonCheckbox(
                          value: isSelected,
                          tapAreaSizeValue: 0,
                          onChanged: (bool? _) {},
                        ),
                      );
                    },
                  ),
          ),
          child: MoonTextInput(
            focusNode: _multiSelectFocusNode,
            hintText: "Select multiple components",
            controller: _multiSelectSearchController,
            // The onTap() and onChanged() properties are used instead of a listener to initiate search on every input tap.
            // Listener only triggers on input change.            onTap: () => _performMultiSelectSearch(),
            onTapOutside: (PointerDownEvent _) => _handleMultiSelectInputTapOutside(),
            onChanged: (String _) => _performMultiSelectSearch(),
            leading: _multiSelectedItems.isNotEmpty
                ? Center(
                    child: GestureDetector(
                      onTap: () => setState(() => _multiSelectedItems.clear()),
                      child: MoonTag(
                        tagSize: MoonTagSize.xs,
                        backgroundColor: context.moonColors!.bulma,
                        label: Text(
                          "${_multiSelectedItems.keys.length}",
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
            trailing: MoonButton.icon(
              hoverEffectColor: Colors.transparent,
              onTap: () => _showMultiSelectAllOptionsList(),
              icon: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _showMultiSelectDropdown ? -0.5 : 0,
                child: const Icon(MoonIcons.controls_chevron_down_small_24_light),
              ),
            ),
          ),
        ),
      ],
    );
  }
}