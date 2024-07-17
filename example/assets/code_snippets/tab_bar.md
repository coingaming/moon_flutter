import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class TabBar extends StatefulWidget {
  const TabBar({super.key});

  @override
  State<TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonTabBar(
          tabBarSize: MoonTabBarSize.sm,
          tabs: List.generate(
            3,
            (int index) => MoonTab(
              leading: const Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab${index + 1}'),
              trailing: const Icon(MoonIcons.other_frame_24_light),
            ),
          ),
        ),
        MoonTabBar.pill(
          tabBarSize: MoonTabBarSize.sm,
          pillTabs: List.generate(
            3,
            (int index) => MoonPillTab(
              leading: const Icon(MoonIcons.other_frame_24_light),
              label: Text('Tab${index + 1}'),
              trailing: const Icon(MoonIcons.other_frame_24_light),
            ),
          ),
        ),

        // MoonTabBar with TabBarView.
        MoonTabBar(
          isExpanded: true,
          tabController: _tabController,
          tabs: List.generate(
            3,
            (int index) => MoonTab(
              label: Text('Tab${index + 1}'),
            ),
          ),
        ),
        SizedBox(
          height: 112,
          child: TabBarView(
            controller: _tabController,
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
                      child: MoonButton.icon(
                        onTap: () => _tabController.animateTo(1),
                        icon: const Icon(MoonIcons.controls_chevron_right_24_light),
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
                    MoonButton.icon(
                      onTap: () => _tabController.animateTo(0),
                      icon: const Icon(MoonIcons.controls_chevron_left_24_light),
                    ),                    
                    const Text('Tab2'),
                    MoonButton.icon(
                      onTap: () => _tabController.animateTo(2),
                      icon: const Icon(MoonIcons.controls_chevron_right_24_light),
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
                      child: MoonButton.icon(
                        onTap: () => _tabController.animateTo(1),
                        icon: const Icon(
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
