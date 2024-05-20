import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/component_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ComboboxMultiSelectStory extends StatefulWidget {
  static const path = '/composites/combobox/multi_select';

  const ComboboxMultiSelectStory({super.key});

  @override
  State<ComboboxMultiSelectStory> createState() => _ComboboxMultiSelectStoryState();
}

class _ComboboxMultiSelectStoryState extends State<ComboboxMultiSelectStory> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final Map<Component, bool> _selectedOptions = {};
  final List<Component> _optionsList = Component.values;

  List<Component> _filteredOptionsList = [];
  bool _showDropdown = false;

  String get _inputValue => _searchController.text.trim().toLowerCase();

  void _performSearch() {
    setState(() {
      _filteredOptionsList =
          _optionsList.where((Component option) => option.name.toLowerCase().contains(_inputValue)).toList();
      _showDropdown = true;
    });
  }

  void _handleSelect(Component option, bool isSelected) {
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
      description: "MoonColors variants for MoonTextInput and MoonDropdown background.",
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

    final BorderRadiusGeometry? borderRadius =
        borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: MoonDropdown(
          show: _showDropdown && enabledKnob,
          constrainWidthToChild: true,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          distanceToTarget: distanceToTargetKnob,
          dropdownShadows: showShadowKnob == true ? null : [],
          onTapOutside: () => _handleDropdownTapOutside(),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(scrollbars: false),
              child: _filteredOptionsList.isEmpty
                  ? const MoonMenuItem(
                      label: Text('Nothing found.'),
                    )
                  : ClipRRect(
                      borderRadius: borderRadius ?? BorderRadius.zero,
                      child: ListView.builder(
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.zero,
                        itemCount: _filteredOptionsList.length,
                        itemBuilder: (BuildContext _, int index) {
                          if (index >= _filteredOptionsList.length) return const SizedBox.shrink();
                          final Component currentOption = _filteredOptionsList[index];
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
            ),
          ),
          child: MoonTextInput(
            enabled: enabledKnob,
            hasFloatingLabel: hasFloatingLabelKnob,
            width: 270,
            focusNode: _focusNode,
            textInputSize: textInputSizeKnob,
            activeBorderColor: activeBorderColor,
            inactiveBorderColor: inactiveBorderColor,
            backgroundColor: backgroundColor,
            hoverBorderColor: hoverBorderColor,
            borderRadius: borderRadius,
            hintText: "Select multiple components",
            controller: _searchController,
            onTap: () => _performSearch(),
            onTapOutside: (PointerDownEvent _) => _handleInputTapOutside(),
            onChanged: (String _) => _performSearch(),
            leading: _selectedOptions.isNotEmpty
                ? Center(
                    child: MoonTag(
                      tagSize: MoonTagSize.xs,
                      backgroundColor: context.moonColors!.bulma,
                      onTap: () => setState(() => _selectedOptions.clear()),
                      label: Text(
                        "${_selectedOptions.keys.length}",
                        style: TextStyle(color: context.moonColors!.gohan),
                      ),
                      trailing: Icon(
                        MoonIcons.controls_close_small_16_light,
                        color: context.moonColors!.gohan,
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
      ),
    );
  }
}
