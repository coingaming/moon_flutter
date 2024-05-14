import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

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
  tooltip;

  String get name {
    final String rawName = toString().split('.').last;
    return rawName[0].toUpperCase() + rawName.substring(1);
  }
}

class ComboboxMultiSelect extends StatefulWidget {
  const ComboboxMultiSelect({super.key});

  @override
  State<ComboboxMultiSelect> createState() => _ComboboxMultiSelectState();
}

class _ComboboxMultiSelectState extends State<ComboboxMultiSelect> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final Map<Options, bool> _selectedOptions = {};
  final List<Options> _optionsList = Options.values;

  List<Options> _filteredOptionsList = [];
  bool _showDropdown = false;

  String get _inputValue => _searchController.text.trim().toLowerCase();

  void _performSearch() {
    setState(() {
      _filteredOptionsList = _
          optionsList.where((Options option) => option.name.toLowerCase().contains(_inputValue)).toList();
      _showDropdown = true;
    });
  }

  void _handleSelect(Options option, bool isSelected) {
    setState(() => isSelected ? _selectedOptions[option] = true : _selectedOptions.remove(option));
  }

  void _showAllOptionsList() {
    setState(() {
      _filteredOptionsList = _optionsList;
      _showDropdown = !_showDropdown;
    });
  }

  void _handleDropdownTapOutside() {
    setState(() {
      _showDropdown = false;
      _searchController.clear();
      _focusNode.unfocus();
    });
  }

  void _handleInputTapOutside() {
    if (_focusNode.hasFocus && !_showDropdown) {
      _searchController.clear();
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MoonDropdown(
        show: _showDropdown,
        constrainWidthToChild: true,
        onTapOutside: () => _handleDropdownTapOutside(),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: _filteredOptionsList.isEmpty
              ? const MoonMenuItem(
                  label: Text('Nothing found.'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _filteredOptionsList.length,
                  itemBuilder: (BuildContext _, int index) {
                    if (index >= _filteredOptionsList.length) return const SizedBox.shrink();
                    final Options currentOption = _filteredOptionsList[index];
                    final bool isSelected = _selectedOptions.containsKey(currentOption);

                    return MoonMenuItem(
                      absorbGestures: true,
                      onTap: () => _handleSelect(currentOption, !isSelected),
                      label: Text(currentOption.name),
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
          focusNode: _focusNode,
          hintText: "Select multiple components",
          controller: _searchController,
          // The onTap() and onChanged() properties are used instead of a listener to initiate search on every input tap.
          // Listener only triggers on input change.            
          onTap: () => _performSearch(),
          onTapOutside: (PointerDownEvent _) => _handleInputTapOutside(),
          onChanged: (String _) => _performSearch(),
          leading: _selectedOptions.isNotEmpty
              ? Center(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedOptions.clear()),
                    child: MoonTag(
                      tagSize: MoonTagSize.xs,
                      backgroundColor: context.moonColors!.bulma,
                      label: Text(
                        "${_selectedOptions.keys.length}",
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
            buttonSize: MoonButtonSize.xs,
            hoverEffectColor: Colors.transparent,
            onTap: () => _showAllOptionsList(),
            icon: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _showDropdown ? -0.5 : 0,
              child: const Icon(MoonIcons.controls_chevron_down_16_light),
            ),
          ),
        ),
      ),
    );
  }
}