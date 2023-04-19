import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AvatarStory extends Story {
  AvatarStory()
      : super(
          name: "Avatar",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "content",
              initial: "MD",
            );

            final avatarSizesKnob = context.knobs.options(
              label: "avatarSize",
              description: "Avatar size variants.",
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

            final avatarTextColorKnob = context.knobs.options(
              label: "textColor",
              description: "MoonColors variants for Avatar text.",
              initial: 40, // null
              options: colorOptions,
            );

            final textColor = colorTable(context)[avatarTextColorKnob];

            final avatarBackgroundColorKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Avatar background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[avatarBackgroundColorKnob];

            final badgeColorKnob = context.knobs.options(
              label: "badgeColor",
              description: "MoonColors variants for the Avatar badge.",
              initial: 40, // null
              options: colorOptions,
            );

            final badgeColor = colorTable(context)[badgeColorKnob];

            final avatarBadgeAlignmentKnob = context.knobs.options(
              label: "badgeAlignment",
              description: "Avatar badge alignment.",
              initial: MoonBadgeAlignment.bottomRight,
              options: const [
                Option(label: "topLeft", value: MoonBadgeAlignment.topLeft),
                Option(label: "topRight", value: MoonBadgeAlignment.topRight),
                Option(label: "bottomLeft", value: MoonBadgeAlignment.bottomLeft),
                Option(label: "bottomRight", value: MoonBadgeAlignment.bottomRight),
              ],
            );

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 32,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for the Avatar.",
            );

            final badgeMarginKnob = context.knobs.sliderInt(
              max: 8,
              initial: 4,
              label: "badgeMarginValue",
              description: "Badge margin value for the Avatar.",
            );

            final badgeSizeKnob = context.knobs.sliderInt(
              max: 16,
              initial: 8,
              label: "badgeSize",
              description: "Badge Size for the Avatar.",
            );

            final showBadgeKnob = context.knobs.boolean(
              label: "showBadge",
              description: "Show Avatar badge.",
              initial: true,
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Customisable Avatar"),
                    const SizedBox(height: 32),
                    MoonAvatar(
                      textColor: textColor,
                      avatarSize: avatarSizesKnob,
                      badgeSize: badgeSizeKnob.toDouble(),
                      borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                      badgeMarginValue: badgeMarginKnob.toDouble(),
                      backgroundColor: backgroundColor,
                      showBadge: showBadgeKnob,
                      badgeColor: badgeColor,
                      badgeAlignment: avatarBadgeAlignmentKnob,
                      content: Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(customLabelTextKnob),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Preset Avatar with picture background"),
                    const SizedBox(height: 32),
                    MoonAvatar(
                      avatarSize: avatarSizesKnob,
                      badgeSize: badgeSizeKnob.toDouble(),
                      borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                      badgeMarginValue: badgeMarginKnob.toDouble(),
                      backgroundColor: backgroundColor,
                      showBadge: showBadgeKnob,
                      badgeColor: badgeColor,
                      badgeAlignment: avatarBadgeAlignmentKnob,
                      backgroundImage: const AssetImage(
                        "assets/images/placeholder-640x359.png",
                      ),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
