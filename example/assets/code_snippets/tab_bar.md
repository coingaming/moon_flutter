import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class TabBar extends StatefulWidget {
  const TabBar({super.key});

  @override
  State<TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonTabBar(
          tabBarSize: MoonTabBarSize.sm,
          tabs: const [
            MoonTab(
              leading: Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab1'),
              trailing: Icon(MoonIcons.other_frame_24_light),
            ),
            MoonTab(
              leading: Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab2'),
              trailing: Icon(MoonIcons.other_frame_24_light),
            ),
            MoonTab(
              leading: Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab3'),
              trailing: Icon(MoonIcons.other_frame_24_light),
            ),
          ],
        ),
        MoonTabBar.pill(
          tabBarSize: MoonTabBarSize.sm,
          pillTabs: const [
            MoonPillTab(
              leading: Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab1'),
              trailing: Icon(MoonIcons.other_frame_24_light),
            ),
            MoonPillTab(
              leading: Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab2'),
              trailing: Icon(MoonIcons.other_frame_24_light),
            ),
            MoonPillTab(
              leading: Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab3'),
              trailing: Icon(MoonIcons.other_frame_24_light),
            ),
          ],
        ),

        // MoonTabBar with TabBarView
        MoonTabBar(
          isExpanded: true,
          tabController: tabController,
          tabs: const [
            MoonTab(
              label: const Text('Tab1'),
            ),
            MoonTab(
              label: const Text('Tab2'),
            ),
            MoonTab(
              label: const Text('Tab3'),
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
                        child: const Icon(MoonIcons.controls_chevron_right_24_light),
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
                      child: const Icon(MoonIcons.controls_chevron_left_24_light),
                    ),                    
                    const Text('Tab2'),
                    GestureDetector(
                      onTap: () => tabController.animateTo(2),
                      child: const Icon(MoonIcons.controls_chevron_right_24_light),
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
                          MoonIcons.controls_chevron_left_24_light,
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
    );
  }
}
