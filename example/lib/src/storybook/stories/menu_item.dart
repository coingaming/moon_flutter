import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum MenuItem { first, second }

class MenuItemStory extends StatefulWidget {
  static const path = '/menu_item';

  const MenuItemStory({super.key});

  @override
  State<MenuItemStory> createState() => _MenuItemStoryState();
}

class _MenuItemStoryState extends State<MenuItemStory> {
  MenuItem currentlySelectedMenuItem = MenuItem.first;

  bool? checkboxIsSelected = false;
  bool switchIsSelected = false;

  @override
  Widget build(BuildContext context) {
    final leadingColorKnob = context.knobs.nullable.options(
      label: "Leading color",
      description: "MoonColors variants for MoonMenuItem leading slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final leadingColor = colorTable(context)[leadingColorKnob ?? 40];

    final labelColorKnob = context.knobs.nullable.options(
      label: "Label color",
      description: "MoonColors variants for MoonMenuItem label slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final labelTextColor = colorTable(context)[labelColorKnob ?? 40];

    final contentTextColorKnob = context.knobs.nullable.options(
      label: "Content color",
      description: "MoonColors variants for MoonMenuItem content slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final contentTextColor = colorTable(context)[contentTextColorKnob ?? 40];

    final trailingColorKnob = context.knobs.nullable.options(
      label: "Trailing color",
      description: "MoonColors variants for MoonMenuItem trailing slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final trailingColor = colorTable(context)[trailingColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonMenuItem background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final menuItemCrossAxisAlignmentKnob = context.knobs.nullable.options(
      label: "menuItemCrossAxisAlignment",
      description: "CrossAxisAlignment variants for MoonMenuItem.",
      enabled: false,
      initial: CrossAxisAlignment.center,
      options: [
        Option(label: CrossAxisAlignment.start.name, value: CrossAxisAlignment.start),
        Option(label: CrossAxisAlignment.center.name, value: CrossAxisAlignment.center),
        Option(label: CrossAxisAlignment.end.name, value: CrossAxisAlignment.end),
      ],
    );

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonMenuItem.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final showLeadingKnob = context.knobs.boolean(
      label: "leading",
      description: "Show widget in MoonMenuItem leading slot.",
      initial: true,
    );

    final showContentKnob = context.knobs.boolean(
      label: "content",
      description: "Show widget in MoonMenuItem content slot.",
      initial: true,
    );

    final showTrailingKnob = context.knobs.boolean(
      label: "trailing",
      description: "Show widget in MoonMenuItem trailing slot.",
      initial: true,
    );

    final isDisabledKnob = context.knobs.boolean(
      label: "Disabled",
      description: "MoonMenuItem onTap() is null.",
    );

    final BorderRadiusGeometry? borderRadius =
        borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextDivider(
              text: "MoonMenuItem",
              paddingTop: 0,
            ),
            MoonMenuItem(
              borderRadius: borderRadius,
              backgroundColor: backgroundColor,
              menuItemCrossAxisAlignment: menuItemCrossAxisAlignmentKnob,
              onTap: isDisabledKnob ? null : () {},
              label: Text(
                "Multi-line menu item",
                style: TextStyle(color: labelTextColor),
              ),
              content: showContentKnob
                  ? Text(
                      "Multi-line default content field as an example for MoonMenuItem component.",
                      style: TextStyle(color: contentTextColor),
                    )
                  : null,
              leading: showLeadingKnob
                  ? MoonAvatar(
                      borderRadius: borderRadius,
                      backgroundColor: context.moonColors!.jiren,
                      avatarSize: MoonAvatarSize.lg,
                      content: const Icon(MoonIcons.travel_airplane_32_regular, size: 32),
                    )
                  : null,
              trailing: showTrailingKnob
                  ? Icon(
                      MoonIcons.controls_chevron_right_24_regular,
                      color: trailingColor,
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            MoonMenuItem(
              backgroundColor: backgroundColor,
              borderRadius: borderRadius,
              menuItemCrossAxisAlignment: menuItemCrossAxisAlignmentKnob,
              onTap: isDisabledKnob ? null : () {},
              label: Text(
                "One-line menu item",
                style: TextStyle(color: labelTextColor),
              ),
              content: showContentKnob
                  ? Text(
                      'One-line content field example',
                      style: TextStyle(color: contentTextColor),
                    )
                  : null,
              leading: showLeadingKnob
                  ? MoonAvatar(
                      borderRadius: borderRadius,
                      backgroundColor: context.moonColors!.jiren,
                      avatarSize: MoonAvatarSize.md,
                      content: const Icon(MoonIcons.notifications_activity_32_regular, size: 24),
                    )
                  : null,
              trailing: showTrailingKnob
                  ? Icon(
                      MoonIcons.controls_chevron_right_24_regular,
                      color: trailingColor,
                    )
                  : null,
            ),
            const TextDivider(text: "MoonMenuItem with selection control"),
            MoonMenuItem(
              borderRadius: borderRadius,
              backgroundColor: backgroundColor,
              menuItemCrossAxisAlignment: menuItemCrossAxisAlignmentKnob,
              onTap: isDisabledKnob ? null : () => setState(() => checkboxIsSelected = !checkboxIsSelected!),
              label: Text(
                "Menu item with MoonCheckbox",
                style: TextStyle(color: labelTextColor),
              ),
              leading: showLeadingKnob
                  ? Icon(
                      MoonIcons.other_frame_24_regular,
                      color: leadingColor,
                    )
                  : null,
              trailing: showTrailingKnob
                  ? MoonCheckbox(
                      value: checkboxIsSelected,
                      tapAreaSizeValue: 24,
                      onChanged: (bool? isSelected) => setState(() => checkboxIsSelected = isSelected),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            MoonMenuItem(
              borderRadius: borderRadius,
              backgroundColor: backgroundColor,
              menuItemCrossAxisAlignment: menuItemCrossAxisAlignmentKnob,
              onTap: isDisabledKnob ? null : () => setState(() => switchIsSelected = !switchIsSelected),
              label: Text(
                "Menu item with MoonSwitch",
                style: TextStyle(color: labelTextColor),
              ),
              leading: showLeadingKnob
                  ? Icon(
                      MoonIcons.other_frame_24_regular,
                      color: leadingColor,
                    )
                  : null,
              trailing: showTrailingKnob
                  ? MoonSwitch(
                      switchSize: MoonSwitchSize.x2s,
                      value: switchIsSelected,
                      onChanged: (bool isSelected) => setState(() => switchIsSelected = isSelected),
                    )
                  : null,
            ),
            const TextDivider(text: "Expandable MoonMenuItem with divider"),
            MoonAccordion<MoonMenuItem>(
              shadows: const [],
              isDisabled: isDisabledKnob,
              hasContentOutside: true,
              borderRadius: borderRadius,
              accordionSize: MoonAccordionSize.md,
              iconColor: trailingColor,
              backgroundColor: backgroundColor ?? Colors.transparent,
              expandedBackgroundColor: backgroundColor ?? context.moonColors!.heles,
              label: Text(
                'Expandable menu item',
                style: context.moonTypography!.body.textDefault.copyWith(
                  color: labelTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              leading: showLeadingKnob
                  ? Icon(
                      MoonIcons.other_frame_24_regular,
                      color: leadingColor ?? context.moonColors!.iconPrimary,
                    )
                  : null,
              childrenPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 24),
              children: MoonMenuItem.divideMenuItems(
                context: context,
                menuItems: [
                  MoonMenuItem(
                    backgroundColor: backgroundColor,
                    borderRadius: borderRadius,
                    menuItemCrossAxisAlignment: menuItemCrossAxisAlignmentKnob,
                    onTap: () => setState(() => currentlySelectedMenuItem = MenuItem.first),
                    label: Text(
                      "Menu item 1 with MoonRadio",
                      style: TextStyle(color: labelTextColor),
                    ),
                    leading: showLeadingKnob
                        ? MoonRadio<MenuItem>(
                            value: MenuItem.first,
                            groupValue: currentlySelectedMenuItem,
                            tapAreaSizeValue: 24,
                            onChanged: (MenuItem? selectedMenuItem) => setState(
                              () => currentlySelectedMenuItem = selectedMenuItem!,
                            ),
                          )
                        : null,
                    trailing: showTrailingKnob
                        ? Icon(
                            MoonIcons.other_frame_24_regular,
                            color: trailingColor,
                          )
                        : null,
                  ),
                  MoonMenuItem(
                    backgroundColor: backgroundColor,
                    borderRadius: borderRadius,
                    menuItemCrossAxisAlignment: menuItemCrossAxisAlignmentKnob,
                    onTap: () => setState(() => currentlySelectedMenuItem = MenuItem.second),
                    label: Text(
                      "Menu item 2 with MoonRadio",
                      style: TextStyle(color: labelTextColor),
                    ),
                    leading: showLeadingKnob
                        ? MoonRadio(
                            value: MenuItem.second,
                            groupValue: currentlySelectedMenuItem,
                            tapAreaSizeValue: 24,
                            onChanged: (MenuItem? selectedMenuItem) => setState(
                              () => currentlySelectedMenuItem = selectedMenuItem!,
                            ),
                          )
                        : null,
                    trailing: showTrailingKnob
                        ? Icon(
                            MoonIcons.other_frame_24_regular,
                            color: trailingColor,
                          )
                        : null,
                  ),
                ],
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
