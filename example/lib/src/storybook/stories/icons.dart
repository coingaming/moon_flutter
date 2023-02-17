import 'package:example/src/storybook/common/icons_list.dart';
import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class IconsStory extends Story {
  IconsStory()
      : super(
          name: "Icons",
          builder: (context) {
            return GridView.builder(
              itemCount: iconsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconsList[index],
                    const SizedBox(height: 16),
                    Text(
                      iconsNameList[index],
                      style: TextStyle(fontSize: 10, color: context.moonColors!.trunks),
                    ),
                  ],
                );
              },
            );
          },
        );
}
