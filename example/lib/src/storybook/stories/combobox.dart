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
  static const path = '/composites/combobox';

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
    final comboboxInputSizeKnob = context.knobs.nullable.options(
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

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextDivider(
                text: "Single select combobox",
                paddingTop: 0,
              ),
              MoonDropdown(
                show: _showSingleSelectDropdown && enabledKnob,
                constrainWidthToChild: true,
                backgroundColor: backgroundColor,
                borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                distanceToTarget: distanceToTargetKnob,
                dropdownShadows: showShadowKnob == true ? null : [],
                onTapOutside: () => _handleSingleSelectDropdownTapOutside(),
                content: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(scrollbars: false),
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
                ),
                child: MoonTextInput(
                  enabled: enabledKnob,
                  hasFloatingLabel: hasFloatingLabelKnob,
                  width: 270,
                  focusNode: _singleSelectFocusNode,
                  activeBorderColor: activeBorderColor,
                  inactiveBorderColor: inactiveBorderColor,
                  backgroundColor: backgroundColor,
                  hoverBorderColor: hoverBorderColor,
                  borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                  textInputSize: comboboxInputSizeKnob,
                  hintText: "Select single component",
                  controller: _singleSelectSearchController,
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
              const TextDivider(text: "Multi select combobox"),
              MoonDropdown(
                show: _showMultiSelectDropdown && enabledKnob,
                constrainWidthToChild: true,
                backgroundColor: backgroundColor,
                borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                distanceToTarget: distanceToTargetKnob,
                dropdownShadows: showShadowKnob == true ? null : [],
                onTapOutside: () => _handleMultiSelectDropdownTapOutside(),
                content: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(scrollbars: false),
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
                                  onChanged: (_) {},
                                ),
                              );
                            },
                          ),
                  ),
                ),
                child: MoonTextInput(
                  enabled: enabledKnob,
                  hasFloatingLabel: hasFloatingLabelKnob,
                  width: 270,
                  focusNode: _multiSelectFocusNode,
                  textInputSize: comboboxInputSizeKnob,
                  activeBorderColor: activeBorderColor,
                  inactiveBorderColor: inactiveBorderColor,
                  backgroundColor: backgroundColor,
                  hoverBorderColor: hoverBorderColor,
                  borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                  hintText: "Select multiple components",
                  controller: _multiSelectSearchController,
                  onTap: () => _performMultiSelectSearch(),
                  onTapOutside: (PointerDownEvent _) => _handleMultiSelectInputTapOutside(),
                  onChanged: (String _) => _performMultiSelectSearch(),
                  leading: _multiSelectedItems.isNotEmpty
                      ? Center(
                          child: MoonTag(
                            tagSize: MoonTagSize.xs,
                            backgroundColor: context.moonColors!.bulma,
                            onTap: () => setState(() => _multiSelectedItems.clear()),
                            label: Text(
                              "${_multiSelectedItems.keys.length}",
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
          ),
        ),
      ),
    );
  }
}
