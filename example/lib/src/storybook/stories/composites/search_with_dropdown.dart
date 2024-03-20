import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/component_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum Component { input, dropdown }

class SearchWithDropdownStory extends StatefulWidget {
  static const path = '/composites/search/dropdown';

  const SearchWithDropdownStory({super.key});

  @override
  State<SearchWithDropdownStory> createState() => _SearchWithDropdownStoryState();
}

class _SearchWithDropdownStoryState extends State<SearchWithDropdownStory> {
  final TextEditingController _searchController = TextEditingController();
  final List<ComponentOptions> _optionsList = ComponentOptions.values;

  List<ComponentOptions> _filteredOptionsList = [];
  ComponentOptions? _selectedOption;
  bool _showDropdown = false;

  bool get _optionIsSelected => _selectedOption?.name == _searchController.text;

  String get _inputValue => _searchController.text.trim().toLowerCase();

  void _performSearch() {
    setState(() {
      if (!_optionIsSelected && _selectedOption != null) _selectedOption = null;

      _filteredOptionsList =
          _optionsList.where((ComponentOptions option) => option.name.toLowerCase().contains(_inputValue)).toList();
      _showDropdown = true;
    });
  }

  void _handleSelect(ComponentOptions option) {
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
    final activeBorderColorKnob = context.knobs.nullable.options(
      label: "activeBorderColor",
      description: "MoonColors variants for MoonTextInput active border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeBorderColor = colorTable(context)[activeBorderColorKnob ?? 40];

    final inactiveBorderColorKnob = context.knobs.nullable.options(
      label: "inactiveBorderColor",
      description: "MoonColors variants for MoonTextInput inactive border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveBorderColor = colorTable(context)[inactiveBorderColorKnob ?? 40];

    final hoverBorderColorKnob = context.knobs.nullable.options(
      label: "hoverBorderColor",
      description: "MoonColors variants for MoonTextInput border on hover.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hoverBorderColor = colorTable(context)[hoverBorderColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonTextInput background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonTextInput and MoonDropdown",
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

    final enabledKnob = context.knobs.boolean(
      label: "enabled",
      description: "Switch between MoonTextInput enabled and disabled states.",
      initial: true,
    );

    final hasFloatingLabelKnob = context.knobs.boolean(
      label: "hasFloatingLabel",
      description: "Whether MoonTextInput has floating label.",
    );

    BorderRadiusGeometry? getBorderRadius(Component component) {
      final double borderRadiusValue = borderRadiusKnob != null ? borderRadiusKnob.toDouble() : 8;

      return (distanceToTargetKnob == null || distanceToTargetKnob == 0) && _showDropdown && enabledKnob
          ? BorderRadius.vertical(
              top: Radius.circular(component == Component.input ? borderRadiusValue : 0),
              bottom: Radius.circular(component == Component.dropdown ? borderRadiusValue : 0),
            )
          : BorderRadius.circular(borderRadiusValue);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return MoonDropdown(
                show: _showDropdown && enabledKnob,
                constrainWidthToChild: true,
                distanceToTarget: distanceToTargetKnob ?? 0,
                backgroundColor: backgroundColor,
                borderRadius: getBorderRadius(Component.dropdown),
                decoration: BoxDecoration(
                  color: context.moonColors!.goku,
                  borderRadius: getBorderRadius(Component.dropdown),
                  boxShadow: showShadowKnob == true
                      ? const [
                          BoxShadow(
                            color: Color(0x28000000),
                            blurRadius: 6,
                            offset: Offset(0, 6),
                            spreadRadius: -6,
                          ),
                        ]
                      : [],
                  border: Border(
                    left: BorderSide(color: context.moonColors!.beerus),
                    right: BorderSide(color: context.moonColors!.beerus),
                    bottom: BorderSide(color: context.moonColors!.beerus),
                    top: distanceToTargetKnob == null || distanceToTargetKnob == 0
                        ? BorderSide.none
                        : BorderSide(color: context.moonColors!.beerus),
                  ),
                ),
                onTapOutside: () => _handleDropdownTapOutside(),
                content: LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(scrollbars: false),
                        child: _filteredOptionsList.isEmpty
                            ? const MoonMenuItem(
                                label: Text('No results found.'),
                              )
                            : ClipRRect(
                                borderRadius: getBorderRadius(Component.dropdown) ?? BorderRadius.zero,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  clipBehavior: Clip.none,
                                  padding: EdgeInsets.zero,
                                  itemCount: _filteredOptionsList.length,
                                  itemBuilder: (BuildContext _, int index) {
                                    if (index >= _filteredOptionsList.length) return const SizedBox.shrink();
                                    final ComponentOptions option = _filteredOptionsList[index];

                                    return MoonMenuItem(
                                      onTap: () => _handleSelect(option),
                                      label: Text(option.name),
                                    );
                                  },
                                ),
                              ),
                      ),
                    );
                  },
                ),
                child: MoonTextInput(
                  enabled: enabledKnob,
                  width: constraints.maxWidth,
                  hasFloatingLabel: hasFloatingLabelKnob,
                  activeBorderColor: activeBorderColor ?? context.moonColors!.beerus,
                  inactiveBorderColor: inactiveBorderColor,
                  backgroundColor: backgroundColor,
                  hoverBorderColor: hoverBorderColor,
                  borderRadius: getBorderRadius(Component.input),
                  hintText: "Search components",
                  controller: _searchController,
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
              );
            },
          ),
          if (!_showDropdown)
            const Align(
              child: Text('Search results displayed within MoonDropdown.'),
            ),
        ],
      ),
    );
  }
}
