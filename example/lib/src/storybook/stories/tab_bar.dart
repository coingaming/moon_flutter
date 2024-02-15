import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TabBarStory extends StatefulWidget {
  static const path = '/tab_bar';

  const TabBarStory({super.key});

  @override
  State<TabBarStory> createState() => _TabBarStoryState();
}

class _TabBarStoryState extends State<TabBarStory> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final tabsSizeKnob = context.knobs.nullable.options(
      label: "tabBarSize",
      description: "Size variants for MoonTabBar.",
      enabled: false,
      initial: MoonTabBarSize.md,
      options: const [
        Option(label: "sm", value: MoonTabBarSize.sm),
        Option(label: "md", value: MoonTabBarSize.md),
      ],
    );

    final textColorKnob = context.knobs.nullable.options(
      label: "textColor",
      description: "MoonColors variants for MoonTabBar default text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final selectedTextColorKnob = context.knobs.nullable.options(
      label: "selectedTextColor",
      description: "MoonColors variants for MoonTabBar selected tab text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final selectedTextColor = colorTable(context)[selectedTextColorKnob ?? 40];

    final indicatorColorKnob = context.knobs.nullable.options(
      label: "indicatorColor",
      description: "MoonColors variants for MoonTabBar indicator.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final indicatorColor = colorTable(context)[indicatorColorKnob ?? 40];

    final selectedTabColorKnob = context.knobs.nullable.options(
      label: "selectedTabColor",
      description: "MoonColors variants for pill MoonTabBar selected tab.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final selectedTabColor = colorTable(context)[selectedTabColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for pill MoonTabBar.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final indicatorHeightKnob = context.knobs.nullable.sliderInt(
      label: "indicatorHeight",
      description: "Indicator height for MoonTabBar.",
      enabled: false,
      initial: 2,
      max: 4,
    );

    final gapKnob = context.knobs.nullable.sliderInt(
      label: "gap",
      description: "Gap between MoonTabBar tabs.",
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
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            const TextDivider(
              text: "MoonTabBar",
              paddingTop: 0,
            ),
            Column(
              children: [
                MoonTabBar(
                  tabBarSize: tabsSizeKnob,
                  isExpanded: isExpandedKnob,
                  gap: gapKnob?.toDouble(),
                  tabs: [
                    MoonTab(
                      leading: showLeadingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      label: showLabelKnob ? const Text('Tab1') : null,
                      trailing: showTrailingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      tabStyle: tabStyle,
                    ),
                    MoonTab(
                      leading: showLeadingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      label: showLabelKnob ? const Text('Tab2') : null,
                      trailing: showTrailingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      tabStyle: tabStyle,
                    ),
                    MoonTab(
                      leading: showLeadingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      label: showLabelKnob ? const Text('Tab3') : null,
                      trailing: showTrailingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      tabStyle: tabStyle,
                    ),
                  ],
                ),
                const TextDivider(text: "MoonTabBar with disabled tab"),
                MoonTabBar(
                  tabBarSize: tabsSizeKnob,
                  isExpanded: isExpandedKnob,
                  gap: gapKnob?.toDouble(),
                  tabs: [
                    MoonTab(
                      trailing: const Icon(MoonIcons.other_frame_24_regular),
                      tabStyle: tabStyle,
                    ),
                    MoonTab(
                      trailing: const Icon(MoonIcons.other_frame_24_regular),
                      tabStyle: tabStyle,
                      disabled: true,
                    ),
                    MoonTab(
                      trailing: const Icon(MoonIcons.other_frame_24_regular),
                      tabStyle: tabStyle,
                    ),
                    MoonTab(
                      trailing: const Icon(MoonIcons.other_frame_24_regular),
                      tabStyle: tabStyle,
                    ),
                  ],
                ),
                const TextDivider(text: "Pill MoonTabBar"),
                MoonTabBar.pill(
                  tabBarSize: tabsSizeKnob,
                  isExpanded: isExpandedKnob,
                  gap: gapKnob?.toDouble(),
                  pillTabs: [
                    MoonPillTab(
                      leading: showLeadingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      label: showLabelKnob ? const Text('Tab1') : null,
                      trailing: showTrailingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      tabStyle: pillTabStyle,
                    ),
                    MoonPillTab(
                      leading: showLeadingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      label: showLabelKnob ? const Text('Tab2') : null,
                      trailing: showTrailingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      tabStyle: pillTabStyle,
                    ),
                    MoonPillTab(
                      leading: showLeadingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      label: showLabelKnob ? const Text('Tab3') : null,
                      trailing: showTrailingKnob ? const Icon(MoonIcons.other_frame_24_regular) : null,
                      tabStyle: pillTabStyle,
                    ),
                  ],
                ),
                const TextDivider(text: "Customized MoonTabBar with TabBarView"),
                MoonTabBar(
                  isExpanded: true,
                  tabController: tabController,
                  tabs: [
                    MoonTab(
                      label: const Text('Tab1'),
                      tabStyle: tabStyle,
                    ),
                    MoonTab(
                      label: const Text('Tab2'),
                      tabStyle: tabStyle,
                    ),
                    MoonTab(
                      label: const Text('Tab3'),
                      tabStyle: tabStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 112,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        color: context.moonColors!.whis60,
                        padding: const EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            const Align(
                              child: Text('Tab1'),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => tabController.animateTo(1),
                                child: const Icon(MoonIcons.controls_chevron_right_24_regular),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: context.moonColors!.frieza60,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => tabController.animateTo(0),
                              child: const Icon(MoonIcons.controls_chevron_left_24_regular),
                            ),
                            const Text('Tab2'),
                            GestureDetector(
                              onTap: () => tabController.animateTo(2),
                              child: const Icon(MoonIcons.controls_chevron_right_24_regular),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: context.moonColors!.whis60,
                        padding: const EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            const Align(
                              child: Text('Tab3'),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => tabController.animateTo(1),
                                child: const Icon(
                                  MoonIcons.controls_chevron_left_24_regular,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
