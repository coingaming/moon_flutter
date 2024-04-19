import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/component_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class SearchWithListStory extends StatefulWidget {
  static const subdirectory = '/search';
  static const path = '/composites/search/search_with_list';

  const SearchWithListStory({super.key});

  @override
  State<SearchWithListStory> createState() => _SearchWithListStoryState();
}

class _SearchWithListStoryState extends State<SearchWithListStory> {
  final TextEditingController _searchController = TextEditingController();
  final List<ComponentOptions> _optionsList = ComponentOptions.values;

  List<ComponentOptions> _filteredOptionsList = [];
  bool _showSearchResults = false;

  String get _inputValue => _searchController.text.trim().toLowerCase();

  void _performSearch() {
    setState(() {
      _filteredOptionsList =
          _optionsList.where((ComponentOptions option) => option.name.toLowerCase().contains(_inputValue)).toList();

      _showSearchResults = true;
    });
  }

  void _handleClearButton() {
    setState(() {
      _searchController.clear();
      _filteredOptionsList = _optionsList;
    });
  }

  void _handleCloseButton() {
    setState(() {
      _searchController.clear();
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
    final textInputSizeKnob = context.knobs.nullable.options(
      label: "textInputSize",
      description: "Size variants for MoonTextInput.",
      enabled: false,
      initial: MoonTextInputSize.md,
      options: const [
        Option(label: "sm", value: MoonTextInputSize.sm),
        Option(label: "md", value: MoonTextInputSize.md),
        Option(label: "lg", value: MoonTextInputSize.lg),
        Option(label: "xl", value: MoonTextInputSize.xl),
      ],
    );

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
      description: "Border radius for MoonTextInput",
      enabled: false,
      initial: 8,
      max: 32,
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
      child: Stack(
        children: [
          Column(
            children: [
              MoonTextInput(
                enabled: enabledKnob,
                hasFloatingLabel: hasFloatingLabelKnob,
                activeBorderColor: activeBorderColor ?? context.moonColors!.beerus,
                inactiveBorderColor: inactiveBorderColor,
                backgroundColor: backgroundColor,
                hoverBorderColor: hoverBorderColor,
                borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                textInputSize: textInputSizeKnob,
                hintText: "Search components",
                controller: _searchController,
                onTap: () => _performSearch(),
                onChanged: (String _) => _performSearch(),
                leading: const Icon(MoonIcons.generic_search_24_light),
                trailing: Row(
                  children: [
                    MoonButton(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      hoverEffectColor: Colors.transparent,
                      onTap: () => _handleClearButton(),
                      label: Text(
                        'Clear',
                        style: TextStyle(color: context.moonColors!.trunks),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                      child: VerticalDivider(
                        width: 8,
                        color: context.moonColors!.beerus,
                      ),
                    ),
                    MoonButton.icon(
                      buttonSize: MoonButtonSize.xs,
                      hoverEffectColor: Colors.transparent,
                      onTap: () => _handleCloseButton(),
                      icon: const Icon(MoonIcons.controls_close_16_light),
                    ),
                  ],
                ),
              ),
              if (_showSearchResults && _filteredOptionsList.isNotEmpty && enabledKnob)
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(scrollbars: false),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 8.0),
                      itemCount: _filteredOptionsList.length,
                      itemBuilder: (BuildContext _, int index) {
                        if (index >= _filteredOptionsList.length) return const SizedBox.shrink();
                        final ComponentOptions option = _filteredOptionsList[index];

                        return MoonMenuItem(
                          hoverEffectColor: Colors.transparent,
                          onTap: () => {},
                          label: Text(option.name),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
          if (_showSearchResults && _filteredOptionsList.isEmpty && enabledKnob)
            const Align(
              child: Text('No results found.'),
            ),
          if (!_showSearchResults)
            const Align(
              child: Text('Search results displayed as a list.'),
            ),
        ],
      ),
    );
  }
}
