import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:example/src/storybook/common/icons_map.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

@RoutePage()
class IconsStory extends StatelessWidget {
  const IconsStory({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollBehavior scrollBehaviour = ScrollConfiguration.of(context).copyWith(
      scrollbars: false,
      overscroll: false,
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    );

    return CustomScrollView(
      scrollBehavior: scrollBehaviour,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
          sliver: _IconsGridWithTitle(
            title: "MoonIcons",
            iconsMap: iconsMap,
          ),
        ),
      ],
    );
  }
}

class _IconsGridWithTitle extends StatelessWidget {
  final String title;
  final Map<String, IconData> iconsMap;

  const _IconsGridWithTitle({
    required this.title,
    required this.iconsMap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: TextDivider(
            text: title,
            paddingTop: 0,
            paddingBottom: 0,
          ),
        ),
        SliverGrid.builder(
          itemCount: iconsMap.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisExtent: 104,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (iconsMap.keys.toList()[index].contains("16"))
                  MoonIcon(iconsMap.values.toList()[index], size: 16)
                else if (iconsMap.keys.toList()[index].contains("24"))
                  MoonIcon(iconsMap.values.toList()[index], size: 24)
                else
                  MoonIcon(iconsMap.values.toList()[index], size: 32),
                const SizedBox(height: 20),
                Text(
                  iconsMap.keys.toList()[index],
                  style: TextStyle(
                    fontSize: 10,
                    color: context.moonColors!.trunks,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
