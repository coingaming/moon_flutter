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

            final avatarSizesKnob = context.knobs.nullable.options(
              label: "avatarSize",
              description: "Size variants for MoonAvatar.",
              enabled: false,
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

            final avatarTextColorKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonAvatar text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[avatarTextColorKnob ?? 40];

            final avatarBackgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonAvatar background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[avatarBackgroundColorKnob ?? 40];

            final badgeColorKnob = context.knobs.nullable.options(
              label: "badgeColor",
              description: "MoonColors variants for MoonAvatar badge.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final badgeColor = colorTable(context)[badgeColorKnob ?? 40];

            final avatarBadgeAlignmentKnob = context.knobs.nullable.options(
              label: "badgeAlignment",
              description: "Badge alignment for MoonAvatar.",
              enabled: false,
              initial: MoonBadgeAlignment.bottomRight,
              options: const [
                Option(label: "topLeft", value: MoonBadgeAlignment.topLeft),
                Option(label: "topRight", value: MoonBadgeAlignment.topRight),
                Option(label: "bottomLeft", value: MoonBadgeAlignment.bottomLeft),
                Option(label: "bottomRight", value: MoonBadgeAlignment.bottomRight),
              ],
            );

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonAvatar.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final badgeMarginKnob = context.knobs.nullable.sliderInt(
              label: "badgeMarginValue",
              description: "Badge margin value for MoonAvatar.",
              enabled: false,
              initial: 4,
              max: 8,
            );

            final badgeSizeKnob = context.knobs.nullable.sliderInt(
              label: "badgeSize",
              description: "Badge size for MoonAvatar.",
              enabled: false,
              initial: 8,
              max: 16,
            );

            final showBadgeKnob = context.knobs.boolean(
              label: "showBadge",
              description: "Show MoonAvatar badge.",
              initial: true,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  const TextDivider(text: "Customisable MoonAvatar"),
                  const SizedBox(height: 32),
                  MoonAvatar(
                    avatarSize: avatarSizesKnob,
                    badgeSize: badgeSizeKnob?.toDouble(),
                    borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                    badgeMarginValue: badgeMarginKnob?.toDouble(),
                    backgroundColor: backgroundColor,
                    showBadge: showBadgeKnob,
                    badgeColor: badgeColor,
                    badgeAlignment: avatarBadgeAlignmentKnob ?? MoonBadgeAlignment.bottomRight,
                    content: Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Text(
                        customLabelTextKnob,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const TextDivider(text: "Preset MoonAvatar with image background"),
                  const SizedBox(height: 32),
                  MoonAvatar(
                    avatarSize: avatarSizesKnob,
                    badgeSize: badgeSizeKnob?.toDouble(),
                    borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                    badgeMarginValue: badgeMarginKnob?.toDouble(),
                    backgroundColor: backgroundColor,
                    showBadge: showBadgeKnob,
                    badgeColor: badgeColor,
                    badgeAlignment: avatarBadgeAlignmentKnob ?? MoonBadgeAlignment.bottomRight,
                    backgroundImage: const AssetImage("assets/images/placeholder-640x359.png"),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
