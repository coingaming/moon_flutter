import 'package:flutter/src/widgets/basic.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AvatarStory extends Story {
  AvatarStory()
      : super(
          name: "Avatar",
          builder: (context) {
            return Center(child: MoonAvatar());
          },
        );
}
