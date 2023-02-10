import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AvatarStory extends Story {
  AvatarStory()
      : super(
          name: "Avatar",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
              initial: "MDS",
            );

            final avatarSizesKnob = context.knobs.options(
              label: "MoonAvatarSize",
              description: "MoonAvatar size variants.",
              initial: MoonAvatarSize.md,
              options: const [
                Option(label: "xs", value: MoonAvatarSize.xs),
                Option(label: "sm", value: MoonAvatarSize.sm),
                Option(label: "md", value: MoonAvatarSize.md),
                Option(label: "lg", value: MoonAvatarSize.lg),
                Option(label: "xl", value: MoonAvatarSize.xl),
                Option(label: "x2l", value: MoonAvatarSize.x2l),
              ],
            );

            final avatarBadgeAlignmentKnob = context.knobs.options(
              label: "Badge alignment",
              description: "MoonAvatar badge alignment.",
              initial: MoonBadgeAlignment.bottomRight,
              options: const [
                Option(label: "topLeft", value: MoonBadgeAlignment.topLeft),
                Option(label: "topRight", value: MoonBadgeAlignment.topRight),
                Option(label: "bottomLeft", value: MoonBadgeAlignment.bottomLeft),
                Option(label: "bottomRight", value: MoonBadgeAlignment.bottomRight),
              ],
            );

            final showPictureKnob = context.knobs.boolean(
              label: "Picture background",
              description: "Show a picture as MoonAvatar background.",
              initial: true,
            );

            final avatarBackgroundColorKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonAvatar background.",
              initial: 4, // gohan
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[avatarBackgroundColorKnob];

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MoonAvatar(
                    //borderRadius: BorderRadius.all(Radius.circular(32)),
                    backgroundColor: backgroundColor,
                    showBadge: true,
                    badgeAlignment: avatarBadgeAlignmentKnob,
                    avatarSize: avatarSizesKnob,
                    backgroundImage: showPictureKnob ? const AssetImage("images/placeholder-640x359.png") : null,
                    //child: Text(customLabelTextKnob),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        );
}
