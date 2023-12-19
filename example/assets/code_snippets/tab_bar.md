import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class TabBar extends StatelessWidget {
    const TabBar({super.key});

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
            ],
        );
    }
}
