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
              label: "Custom label text",
              initial: "MoonButton",
            );

            final buttonSizesKnob = context.knobs.options(
              label: "MoonButtonSize",
              description: "Button size variants.",
              initial: MoonButtonSize.md,
              options: const [
                Option(label: "xs", value: MoonButtonSize.xs),
                Option(label: "sm", value: MoonButtonSize.sm),
                Option(label: "md", value: MoonButtonSize.md),
                Option(label: "lg", value: MoonButtonSize.lg),
                Option(label: "xl", value: MoonButtonSize.xl)
              ],
            );

            final colorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for base MoonButton.",
              initial: 5, // bulma
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 28,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for base MoonButton.",
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border for base MoonButton.",
              initial: true,
            );

            final showDisabledKnob = context.knobs.boolean(
              label: "Disabled",
              description: "onTap() or onLongPress() is null.",
            );

            final setFullWidthKnob = context.knobs.boolean(
              label: "isFullWidth",
              description: "Set Button to full width.",
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
              label: "Show leading",
              description: "Show widget in the leading slot.",
              initial: true,
            );

            final showLabelKnob = context.knobs.boolean(
              label: "Show label",
              description: "Show widget in the label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "Show trailing",
              description: "Show widget in the trailing slot.",
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            IconData resolveIconVariant(MoonButtonSize buttonSize) {
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

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      const TextDivider(text: "Base Button and Icon Button"),
                      const SizedBox(height: 32),
                      MoonButton(
                        onTap: showDisabledKnob ? null : () {},
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                        showBorder: showBorderKnob,
                        buttonSize: buttonSizesKnob,
                        isFullWidth: setFullWidthKnob,
                        backgroundColor: color,
                        showPulseEffect: showPulseEffectKnob,
                        showPulseEffectJiggle: showPulseEffectJiggleKnob,
                        leading: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                        label: showLabelKnob ? Text(customLabelTextKnob) : null,
                        trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                      ),
                      const SizedBox(height: 32),
                      MoonButton.icon(
                        onTap: showDisabledKnob ? null : () {},
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                        showBorder: showBorderKnob,
                        buttonSize: buttonSizesKnob,
                        backgroundColor: color,
                        showPulseEffect: showPulseEffectKnob,
                        showPulseEffectJiggle: showPulseEffectJiggleKnob,
                        icon: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                      ),
                      const SizedBox(height: 40),
                      const TextDivider(text: "Button variants"),
                      const SizedBox(height: 32),
                      MoonFilledButton(
                        onTap: showDisabledKnob ? null : () {},
                        buttonSize: buttonSizesKnob,
                        isFullWidth: setFullWidthKnob,
                        showPulseEffect: showPulseEffectKnob,
                        leading: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                        label: showLabelKnob ? const Text("MoonFilledButton") : null,
                        trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                      ),
                      const SizedBox(height: 32),
                      MoonOutlinedButton(
                        onTap: showDisabledKnob ? null : () {},
                        buttonSize: buttonSizesKnob,
                        isFullWidth: setFullWidthKnob,
                        showPulseEffect: showPulseEffectKnob,
                        leading: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                        label: showLabelKnob ? const Text("MoonOutlinedButton") : null,
                        trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                      ),
                      const SizedBox(height: 32),
                      MoonTextButton(
                        onTap: showDisabledKnob ? null : () {},
                        buttonSize: buttonSizesKnob,
                        isFullWidth: setFullWidthKnob,
                        showPulseEffect: showPulseEffectKnob,
                        leading: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                        label: showLabelKnob ? const Text("MoonTextButton") : null,
                        trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                      ),
                      const SizedBox(height: 40),
                      const TextDivider(text: "Button with non-standard children"),
                      const SizedBox(height: 32),
                      MoonButton(
                        onTap: showDisabledKnob ? null : () {},
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        borderRadius: BorderRadius.circular(20),
                        buttonSize: buttonSizesKnob,
                        isFullWidth: setFullWidthKnob,
                        backgroundColor: context.moonTheme!.colors.krillin100,
                        showPulseEffect: showPulseEffectKnob,
                        showPulseEffectJiggle: showPulseEffectJiggleKnob,
                        leading: showLeadingKnob
                            ? Container(
                                width: 24,
                                height: 24,
                                padding: const EdgeInsets.all(4),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                        label: showLabelKnob
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircleAvatar(
                                  backgroundColor: context.moonTheme!.colors.trunks,
                                  child: const Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : null,
                        trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}
