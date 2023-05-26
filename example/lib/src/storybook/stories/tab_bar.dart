import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TabBarStory extends Story {
  TabBarStory()
      : super(
          name: "TabBar",
          builder: (context) {
            final tabsSizesKnob = context.knobs.nullable.options(
              label: "tabBarSize",
              description: "Size variants for MoonTabBar.",
              enabled: false,
              initial: MoonTabBarSize.md,
              options: const [
                Option(label: "sm", value: MoonTabBarSize.sm),
                Option(label: "md", value: MoonTabBarSize.md),
              ],
            );

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for default text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final selectedTextColorsKnob = context.knobs.nullable.options(
              label: "selectedTextColor",
              description: "MoonColors variants for selected tab text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final selectedTextColor = colorTable(context)[selectedTextColorsKnob ?? 40];

            final indicatorColorsKnob = context.knobs.nullable.options(
              label: "indicatorColor",
              description: "MoonColors variants for default MoonTabBar indicator.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final indicatorColor = colorTable(context)[indicatorColorsKnob ?? 40];

            final selectedTabColorsKnob = context.knobs.nullable.options(
              label: "selectedTabColor",
              description: "MoonColors variants for pill MoonTabBar selected tab.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final selectedTabColor = colorTable(context)[selectedTabColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for pill MoonTabBar.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final indicatorHeightKnob = context.knobs.nullable.sliderInt(
              label: "indicatorHeight",
              description: "Indicator height for default MoonTabBar.",
              enabled: false,
              initial: 2,
              max: 4,
            );

            final gapKnob = context.knobs.nullable.sliderInt(
              label: "gap",
              description: "Gap between MoonTabBar children.",
              enabled: false,
              initial: 4,
              max: 12,
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in MoonTabBar leading slot.",
            );

            final showLabelKnob = context.knobs.boolean(
              label: "label",
              description: "Show widget in MoonTabBar label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in MoonTabBar trailing slot.",
            );

            final isExpandedKnob = context.knobs.boolean(
              label: "isExpanded",
              description: "Expand MoonTabBar horizontally.",
            );

            final tabStyle = MoonTabStyle(
              textColor: textColor,
              selectedTextColor: selectedTextColor,
              indicatorColor: indicatorColor,
              indicatorHeight: indicatorHeightKnob?.toDouble(),
            );

            final pillTabStyle = MoonPillTabStyle(
              textColor: textColor,
              selectedTextColor: selectedTextColor,
              selectedTabColor: selectedTabColor,
              borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
            );

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Default MoonTabBar"),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        MoonTabBar(
                          tabBarSize: tabsSizesKnob,
                          isExpanded: isExpandedKnob,
                          gap: gapKnob?.toDouble(),
                          tabs: [
                            MoonTab(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab1') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              tabStyle: tabStyle,
                            ),
                            MoonTab(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab2') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              tabStyle: tabStyle,
                            ),
                            MoonTab(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab3') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              tabStyle: tabStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const TextDivider(text: "MoonTabBar with disabled tab"),
                        const SizedBox(height: 32),
                        MoonTabBar(
                          tabBarSize: tabsSizesKnob,
                          isExpanded: isExpandedKnob,
                          gap: gapKnob?.toDouble(),
                          tabs: [
                            MoonTab(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              tabStyle: tabStyle,
                            ),
                            MoonTab(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              tabStyle: tabStyle,
                              disabled: true,
                            ),
                            MoonTab(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              tabStyle: tabStyle,
                            ),
                            MoonTab(
                              trailing: const MoonIcon(MoonIcons.frame_24),
                              tabStyle: tabStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const TextDivider(text: "Pill MoonTabBar"),
                        const SizedBox(height: 32),
                        MoonTabBar.pill(
                          tabBarSize: tabsSizesKnob,
                          isExpanded: isExpandedKnob,
                          gap: gapKnob?.toDouble(),
                          pillTabs: [
                            MoonPillTab(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab1') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              tabStyle: pillTabStyle,
                            ),
                            MoonPillTab(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab2') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              tabStyle: pillTabStyle,
                            ),
                            MoonPillTab(
                              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              label: showLabelKnob ? const Text('Tab3') : null,
                              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
                              tabStyle: pillTabStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
