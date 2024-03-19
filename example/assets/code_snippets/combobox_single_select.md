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

class ComboboxSingleSelect extends StatefulWidget {
  const ComboboxSingleSelect({super.key});

  @override
  State<ComboboxSingleSelect> createState() => _ComboboxSingleSelectState();
}

class _ComboboxSingleSelectState extends State<ComboboxSingleSelect> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final List<Options> _optionsList = Options.values;

  List<Options> _filteredOptionsList = [];
  Options? _selectedOption;
  bool _showDropdown = false;

  bool get _optionIsSelected => _selectedOption?.name == _searchController.text;
  
  String get _inputValue => _searchController.text.trim().toLowerCase();

  void _performSearch() {
    setState(() {
      if (!_optionIsSelected && _selectedOption != null) _selectedOption = null;

      _filteredOptionsList = 
          _optionsList.where((Options option) => option.name.toLowerCase().contains(_inputValue)).toList();
      _showDropdown = true;
    });
  }

  void _handleSelect(Options option) {
    setState(() {
      _showDropdown = false;
      _searchController.text = option.name;
      _selectedOption = option;
      _focusNode.unfocus();
    });
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
      if (!_optionIsSelected) _searchController.clear();
      _focusNode.unfocus();
    });
  }

  void _handleInputTapOutside() {
    if (_focusNode.hasFocus && !_showDropdown) {
      if (!_optionIsSelected) _searchController.clear();
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
                  label: Text('No results found.'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _filteredOptionsList.length,
                  itemBuilder: (BuildContext _, int index) {
                    if (index >= _filteredOptionsList.length) return const SizedBox.shrink();
                    final Options option = _filteredOptionsList[index];

                    return MoonMenuItem(
                      onTap: () => _handleSelect(option),
                      label: Text(option.name),
                    );
                  },
                ),
        ),
        child: MoonTextInput(
          focusNode: _focusNode,
          hintText: "Select single component",
          controller: _searchController,
          // The onTap() and onChanged() properties are used instead of a listener to initiate search on every input tap. 
          // Listener only triggers on input change.
          onTap: () => _performSearch(),
          onTapOutside: (PointerDownEvent _) => _handleInputTapOutside(),
          onChanged: (String _) => _performSearch(),
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