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

class SearchWithList extends StatefulWidget {
  const SearchWithList({super.key});

  @override
  State<SearchWithList> createState() => _SearchWithListState();
}

class _SearchWithListState extends State<SearchWithList> {
  final TextEditingController _searchController = TextEditingController();
  final List<Options> _optionsList = Options.values;

  List<Options> _filteredOptionsList = [];
  bool _showSearchResults = false;
  
  String get _inputValue => _searchController.text.trim().toLowerCase();

  void _performSearch() {
    setState(() {
      _filteredOptionsList = 
          _optionsList.where((Options option) => option.name.toLowerCase().contains(_inputValue)).toList();
      _showSearchResults = true;
    });
  }
  
  void _handleCloseButton() {
    setState(() {
      _searchController.clear();
      _filteredOptionsList = _optionsList;
      _showSearchResults = false;
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
    return Stack(
      children: [
        Column(
          children: [
            MoonTextInput(
              hintText: "Search components",
              controller: _searchController,
              // The onTap() and onChanged() properties are used instead of a listener to initiate search on every input tap.
              // Listener only triggers on input change.
              onTap: () => _performSearch(),
              onChanged: (String _) => _performSearch(),
              leading: const Icon(MoonIcons.generic_search_24_light),
              trailing: MoonButton.icon(
                buttonSize: MoonButtonSize.xs,
                hoverEffectColor: Colors.transparent,
                onTap: () => _handleCloseButton(),
                icon: const Icon(MoonIcons.controls_close_16_light),
              ),
            ),
            if (_showSearchResults && _filteredOptionsList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 8.0),
                  itemCount: _filteredOptionsList.length,
                  itemBuilder: (BuildContext _, int index) {
                    if (index >= _filteredOptionsList.length) return const SizedBox.shrink();
                    final Options option = _filteredOptionsList[index];
  
                    return MoonMenuItem(
                      onTap: () => {},
                      label: Text(option.name),
                    );
                  },
                ),
              ),
          ],
        ),
        if (_showSearchResults && _filteredOptionsList.isEmpty)
          const Align(
            child: Text('No results found.'),
          ),
      ],
    );
  }
}