import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ButtonStory extends Story {
  ButtonStory()
      : super(
          name: "Button",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "label text",
              initial: "MoonButton",
            );

            final buttonSizesKnob = context.knobs.nullable.options(
              label: "buttonSize",
              description: "Size variants for MoonButton.",
              enabled: false,
              initial: MoonButtonSize.md,
              options: const [
                Option(label: "xs", value: MoonButtonSize.xs),
                Option(label: "sm", value: MoonButtonSize.sm),
                Option(label: "md", value: MoonButtonSize.md),
                Option(label: "lg", value: MoonButtonSize.lg),
                Option(label: "xl", value: MoonButtonSize.xl)
              ],
            );

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for base MoonButton background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonButton border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonButton text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for base MoonButton.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border for base MoonButton.",
              initial: true,
            );

            final showTooltipKnob = context.knobs.boolean(
              label: "showTooltip",
              description: "Show MoonTooltip for MoonButton.",
            );

            final showPulseEffectKnob = context.knobs.boolean(
              label: "showPulseEffect",
              description: "Show pulse animation.",
            );

            final showPulseEffectJiggleKnob = context.knobs.boolean(
              label: "showPulseEffectJiggle",
              description: "Show jiggling with pulse animation.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in MoonButton leading slot.",
              initial: true,
            );

            final showLabelKnob = context.knobs.boolean(
              label: "label",
              description: "Show widget in MoonButton label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in MoonButton trailing slot.",
            );

            final setFullWidthKnob = context.knobs.boolean(
              label: "isFullWidth",
              description: "Set MoonButton to full width.",
            );

            final showDisabledKnob = context.knobs.boolean(
              label: "Disabled",
              description: "onTap() or onLongPress() is null.",
            );

            IconData resolveIconVariant(MoonButtonSize? buttonSize) {
              switch (buttonSize) {
                case MoonButtonSize.xs:
                  return MoonIcons.frame_16;
                case MoonButtonSize.sm:
                  return MoonIcons.frame_24;
                case MoonButtonSize.md:
                  return MoonIcons.frame_24;
                case MoonButtonSize.lg:
                  return MoonIcons.frame_24;
                case MoonButtonSize.xl:
                  return MoonIcons.frame_24;
                default:
                  return MoonIcons.frame_24;
              }
            }

            final resolvedIconVariant = resolveIconVariant(buttonSizesKnob);

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Base and MoonIcon MoonButton"),
                    const SizedBox(height: 32),
                    MoonButton(
                      onTap: showDisabledKnob ? null : () {},
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      showTooltip: showTooltipKnob,
                      tooltipMessage: 'This is MoonTooltip',
                      buttonSize: buttonSizesKnob,
                      isFullWidth: setFullWidthKnob,
                      backgroundColor: backgroundColor,
                      borderColor: borderColor,
                      textColor: textColor,
                      showPulseEffect: showPulseEffectKnob,
                      showPulseEffectJiggle: showPulseEffectJiggleKnob,
                      leading: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                      label: showLabelKnob ? Text(customLabelTextKnob) : null,
                      trailing: showTrailingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 32),
                    MoonButton.icon(
                      onTap: showDisabledKnob ? null : () {},
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      showTooltip: showTooltipKnob,
                      tooltipMessage: 'This is MoonTooltip',
                      buttonSize: buttonSizesKnob,
                      backgroundColor: backgroundColor,
                      iconColor: textColor,
                      borderColor: borderColor,
                      showPulseEffect: showPulseEffectKnob,
                      showPulseEffectJiggle: showPulseEffectJiggleKnob,
                      icon: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "MoonButton variants"),
                    const SizedBox(height: 32),
                    MoonFilledButton(
                      onTap: showDisabledKnob ? null : () {},
                      buttonSize: buttonSizesKnob,
                      isFullWidth: setFullWidthKnob,
                      showTooltip: showTooltipKnob,
                      tooltipMessage: 'This is MoonTooltip',
                      showPulseEffect: showPulseEffectKnob,
                      leading: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                      label: showLabelKnob ? const Text("MoonFilledButton") : null,
                      trailing: showTrailingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 32),
                    MoonOutlinedButton(
                      onTap: showDisabledKnob ? null : () {},
                      buttonSize: buttonSizesKnob,
                      isFullWidth: setFullWidthKnob,
                      showTooltip: showTooltipKnob,
                      tooltipMessage: 'This is MoonTooltip',
                      showPulseEffect: showPulseEffectKnob,
                      borderColor: borderColor,
                      leading: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                      label: showLabelKnob ? const Text("MoonOutlinedButton") : null,
                      trailing: showTrailingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 32),
                    MoonTextButton(
                      onTap: showDisabledKnob ? null : () {},
                      buttonSize: buttonSizesKnob,
                      isFullWidth: setFullWidthKnob,
                      showTooltip: showTooltipKnob,
                      tooltipMessage: 'This is MoonTooltip',
                      showPulseEffect: showPulseEffectKnob,
                      leading: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                      label: showLabelKnob ? const Text("MoonTextButton") : null,
                      trailing: showTrailingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Custom MoonButtons with non-standard children"),
                    const SizedBox(height: 32),
                    MoonButton(
                      onTap: showDisabledKnob ? null : () {},
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      showTooltip: showTooltipKnob,
                      tooltipMessage: 'This is MoonTooltip',
                      showFocusEffect: false,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/placeholder-640x359.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      leading: Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.moonColors!.popo,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    MoonButton(
                      onTap: showDisabledKnob ? null : () {},
                      height: 72,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      showTooltip: showTooltipKnob,
                      tooltipMessage: 'This is MoonTooltip',
                      showFocusEffect: false,
                      decoration: ShapeDecorationWithPremultipliedAlpha(
                        shadows: const [
                          BoxShadow(
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.moonColors!.krillin100,
                            context.moonColors!.dodoria100,
                          ],
                        ),
                        shape: const StarBorder(pointRounding: 0.5, valleyRounding: 0.5),
                      ),
                      label: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircleAvatar(
                          backgroundColor: context.moonColors!.frieza60,
                          child: const MoonIcon(
                            MoonIcons.rocket_24,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
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
