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

class SearchWithDropdown extends StatefulWidget {
  const SearchWithDropdown({super.key});

  @override
  State<SearchWithDropdown> createState() => _SearchWithDropdownState();
}

class _SearchWithDropdownState extends State<SearchWithDropdown> {
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
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
  
  void _handleClearButton() {
    setState(() {
      _searchController.clear();
      _filteredOptionsList = _optionsList;
    });
  }

  void _handleDropdownTapOutside() {
    setState(() {
      _showDropdown = false;
      if (!_optionIsSelected) _searchController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });  
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
        distanceToTarget: 0,
        constrainWidthToChild: true,
        decoration: BoxDecoration(
          color: context.moonColors!.goku,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8.0)),
          border: Border(
            left: BorderSide(color: context.moonColors!.beerus),
            right: BorderSide(color: context.moonColors!.beerus),
            bottom: BorderSide(color: context.moonColors!.beerus),
          ),
        ),
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
          hintText: "Search components",
          controller: _searchController,
          borderRadius: _showDropdown ? const BorderRadius.vertical(top: Radius.circular(8)) : null,
          // The onTap() and onChanged() properties are used instead of a listener to initiate search 
          // on every input tap. Listener only triggers on input change.          
          onTap: () => _performSearch(),
          onChanged: (String _) => _performSearch(),
          leading: const Icon(MoonIcons.generic_search_24_light),
          trailing: MoonButton(
            padding: EdgeInsets.zero,
            hoverEffectColor: Colors.transparent,
            onTap: () => _handleClearButton(),
            label: Text(
              'Clear',
              style: TextStyle(color: context.moonColors!.trunks),
            ),
          ),
        ),
      ),
    );
  }
}