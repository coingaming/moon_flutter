import 'package:example/src/storybook/common/icons/icons_list.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class IconsStory extends Story {
  IconsStory()
      : super(
          name: "Icons",
          builder: (context) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                _IconsGridWithTitle(
                  title: "MoonIcons",
                  iconsList: iconsList,
                  iconsNameList: iconsNameList,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
              ],
            );
          },
        );
}

class _IconsGridWithTitle extends StatelessWidget {
  final String title;
  final List<IconData> iconsList;
  final List<String> iconsNameList;

  const _IconsGridWithTitle({
    required this.title,
    required this.iconsList,
    required this.iconsNameList,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 40, bottom: 16),
          sliver: SliverToBoxAdapter(
            child: TextDivider(text: title),
          ),
        ),
        SliverGrid.builder(
          itemCount: iconsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconsNameList[index].contains("16"))
                  MoonIcon(iconsList[index], size: 16)
                else if (iconsNameList[index].contains("24"))
                  MoonIcon(iconsList[index], size: 24)
                else
                  MoonIcon(iconsList[index], size: 32),
                const SizedBox(height: 20),
                Text(
                  iconsNameList[index],
                  style: TextStyle(fontSize: 10, color: context.moonColors!.trunks),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
