import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool? checkboxIsSelected = false;
bool switchIsSelected = false;

enum MenuItem { first, second }

MenuItem currentlySelectedMenuItem = MenuItem.first;

class MenuItemStory extends Story {
  MenuItemStory()
      : super(
          name: "MenuItem",
          builder: (BuildContext context) {
            final leadingColorKnob = context.knobs.nullable.options(
              label: "Leading color",
              description: "MoonColors variants for MoonMenuItem leading slot.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final leadingColor = colorTable(context)[leadingColorKnob ?? 40];

            final titleColorKnob = context.knobs.nullable.options(
              label: "Title color",
              description: "MoonColors variants for MoonMenuItem title slot.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final titleTextColor = colorTable(context)[titleColorKnob ?? 40];

            final descriptionTextColorKnob = context.knobs.nullable.options(
              label: "Description color",
              description: "MoonColors variants for MoonMenuItem description slot.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final descriptionTextColor = colorTable(context)[descriptionTextColorKnob ?? 40];

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

            final showDescriptionKnob = context.knobs.boolean(
              label: "description",
              description: "Show widget in MoonMenuItem description slot.",
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

            return StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 64),
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
                          title: Text(
                            "Multi-line menu item",
                            style: TextStyle(color: titleTextColor),
                          ),
                          description: showDescriptionKnob
                              ? Text(
                                  "Multi-line default description field as an example for menu item component.",
                                  style: TextStyle(color: descriptionTextColor),
                                )
                              : null,
                          leading: showLeadingKnob
                              ? MoonAvatar(
                                  borderRadius: borderRadius,
                                  backgroundColor: context.moonColors!.jiren,
                                  avatarSize: MoonAvatarSize.lg,
                                  content: const MoonIcon(MoonIcons.airplane_32, size: 32),
                                )
                              : null,
                          trailing: showTrailingKnob
                              ? MoonIcon(
                                  MoonIcons.chevron_right_24,
                                  color: trailingColor,
                                )
                              : null,
                          onTap: isDisabledKnob ? null : () {},
                        ),
                        const SizedBox(height: 16),
                        MoonMenuItem(
                          backgroundColor: backgroundColor,
                          borderRadius: borderRadius,
                          title: Text(
                            "One-line menu item",
                            style: TextStyle(color: titleTextColor),
                          ),
                          description: showDescriptionKnob
                              ? Text(
                                  'One-line description field example',
                                  style: TextStyle(color: descriptionTextColor),
                                )
                              : null,
                          leading: showLeadingKnob
                              ? MoonAvatar(
                                  borderRadius: borderRadius,
                                  backgroundColor: context.moonColors!.jiren,
                                  avatarSize: MoonAvatarSize.md,
                                  content: const MoonIcon(MoonIcons.activity_32, size: 24),
                                )
                              : null,
                          trailing: showTrailingKnob
                              ? MoonIcon(
                                  MoonIcons.chevron_right_24,
                                  color: trailingColor,
                                )
                              : null,
                          onTap: isDisabledKnob ? null : () {},
                        ),
                        const TextDivider(text: "MoonMenuItem with selection control"),
                        MoonMenuItem(
                          borderRadius: borderRadius,
                          backgroundColor: backgroundColor,
                          title: Text(
                            "Menu item with MoonCheckbox",
                            style: TextStyle(color: titleTextColor),
                          ),
                          leading: showLeadingKnob
                              ? MoonIcon(
                                  MoonIcons.frame_24,
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
                          onTap:
                              isDisabledKnob ? null : () => setState(() => checkboxIsSelected = !checkboxIsSelected!),
                        ),
                        const SizedBox(height: 16),
                        MoonMenuItem(
                          borderRadius: borderRadius,
                          backgroundColor: backgroundColor,
                          title: Text(
                            "Menu item with MoonSwitch",
                            style: TextStyle(color: titleTextColor),
                          ),
                          leading: showLeadingKnob
                              ? MoonIcon(
                                  MoonIcons.frame_24,
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
                          onTap: isDisabledKnob ? null : () => setState(() => switchIsSelected = !switchIsSelected),
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
                          title: Text(
                            'Expandable menu item',
                            style: context.moonTypography!.body.textDefault.copyWith(
                              color: titleTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          leading: showLeadingKnob
                              ? MoonIcon(
                                  MoonIcons.frame_24,
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
                                title: Text(
                                  "Menu item 1 with MoonRadio",
                                  style: TextStyle(color: titleTextColor),
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
                                    ? MoonIcon(
                                        MoonIcons.frame_24,
                                        color: trailingColor,
                                      )
                                    : null,
                                onTap: () => setState(() => currentlySelectedMenuItem = MenuItem.first),
                              ),
                              MoonMenuItem(
                                backgroundColor: backgroundColor,
                                borderRadius: borderRadius,
                                title: Text(
                                  "Menu item 2 with MoonRadio",
                                  style: TextStyle(color: titleTextColor),
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
                                    ? MoonIcon(
                                        MoonIcons.frame_24,
                                        color: trailingColor,
                                      )
                                    : null,
                                onTap: () => setState(() => currentlySelectedMenuItem = MenuItem.second),
                              ),
                            ],
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
}
